#define MYSQL_HOST        "localhost"
#define MYSQL_USER        "server" 
#define MYSQL_PASS        "H&131{}h" 
#define MYSQL_DATABASE    "samp" 

new MySQL:database;
/*
* set debug_sql to 1 to enable debug text
* static makes this debug variable only visible within this file
* this interaction only works with global static variables
* static normally makes a variable retain it's value within a function
*/
static const debug_sql = 0; 

accounts_OnGameModeInit(){
	mysql_log(ALL);
    new MySQLOpt:option_id = mysql_init_options();
    mysql_set_option(option_id, AUTO_RECONNECT, true);
    database = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DATABASE, option_id);
	if(database == MYSQL_INVALID_HANDLE || mysql_errno(database) != 0){ // Checking if the database connection is invalid to shutdown.
		print("I couldn't connect to the MySQL server, closing."); // Printing a message to the log.
		SendRconCommand("exit"); // Sending console command to shut down server.
	}
	else print("MySQL connection established.");
}

//strins("",query,strlen(query));

accounts_Exit(){
	foreach(new i: Player){
		if(IsPlayerConnected(i)){
			OnPlayerDisconnect(i, 1);
		}
	}
	mysql_close(database);
}


accounts_OnPlayerConnect(playerid){ //query time & login time - login time is time it take pawn to process (ms)
	new query[200];
	pdata[playerid][loggedin]=false;
	pdata[playerid][pwfails]=0;
	
	GetPlayerName(playerid, pdata[playerid][name], MAX_PLAYER_NAME); // Getting the player's name.
	/* deprecated
	new stringss[69];
	format(stringss, 69, "id: %i ....corrupt b4 incre %i pdata", playerid, pdata[playerid][corrupt_check]);
 	SendClientMessageToAll(-1,stringss);
	*/
	DebugPrintEx(-1, debug_sql, "pdata[%d][corrupt_check] = %d", playerid, pdata[playerid][corrupt_check]);
	
	pdata[playerid][corrupt_check]+=1;

	mysql_format(database, query, sizeof(query), "SELECT * FROM `pdata` WHERE `name` = '%e' LIMIT 1", pdata[playerid][name]);
	/*
	if(mysql_tquery(database, query, "OnPlayerDataCheck", "ii", playerid, pdata[playerid][corrupt_check])) SendClientMessageToAll(-1,"tquery was successful!");
	else SendClientMessageToAll(-1,"tquery was unsuccessful!");
	*/
	if(mysql_tquery(database, query, "OnPlayerDataCheck", "ii", playerid, pdata[playerid][corrupt_check])) DebugPrint(-1, debug_sql, "mysql_tquery was successful");
	else DebugPrint(-1, debug_sql, "mysql_tquery was unsuccessful");
}

forward OnPlayerDataCheck(playerid, corrupt_checker);
public OnPlayerDataCheck(playerid, corrupt_checker){

    //if (corrupt_checker != pdata[playerid][corrupt_check]) return SendClientMessage(playerid,-1,"================>>>>ur ID is corrupt!!");
    if (corrupt_checker != pdata[playerid][corrupt_check]){
		/*
        new stringsss[169];
        format(stringsss, 169, "query corrupted, discarding... id: (%i)  pdata:(%i) checker:(%i)", playerid, pdata[playerid][corrupt_check], corrupt_checker);
        SendClientMessageToAll(-1,stringsss);
		*/
		DebugPrintEx(-1, debug_sql, "query was corrupted, pdata[%d][corrupt_check] = %d, corrupt_checker = %d", playerid, pdata[playerid][corrupt_check], corrupt_checker);
        return 1;
    }
	new String[150];
	/*
	new String[150],strings3[169];
 	format(strings3, 169, "query clean, accepting... id: (%i)  pdata:(%i) checker:(%i)", playerid, pdata[playerid][corrupt_check], corrupt_checker);
 	SendClientMessageToAll(-1,strings3);
	*/
	DebugPrintEx(-1, debug_sql, "query was clean, pdata[%d][corrupt_check] = %d, corrupt_checker = %d", playerid, pdata[playerid][corrupt_check], corrupt_checker);
	if(cache_num_rows() > 0){
		cache_get_value(0, "pwhash", pdata[playerid][pwhash], 65);
		cache_get_value(0, "pwsalt", pdata[playerid][pwsalt], 11);
		
		pdata[playerid][player_cache] = cache_save();

		format(String, sizeof(String), "\n{FFFFFF}Welcome back, %s.\n\n{0099FF}This name is already registered.\n\
		{0099FF}Please login below, or proceed by changing to a different name.\n\n", pdata[playerid][name]);
		Dialog_Show(playerid, login_dialog, DIALOG_STYLE_PASSWORD, "Accounts System", String, "Login", "Change");
	}
	else {
		format(String, sizeof(String), "{FFFFFF}Welcome %s.\n\n{0099FF}This account is not registered.\n\
		{0099FF}Please input a password to register, or play as a guest.\n\n", pdata[playerid][name]);
		Dialog_Show(playerid, register_dialog, DIALOG_STYLE_PASSWORD, "Accounts System", String, "Register", "Guest");
	}
	return 1;
}

forward OnPlayerRegister(playerid);
public OnPlayerRegister(playerid){
	/*
	SendClientMessage(playerid, 0x00FF00FF, "You are now registered and has been logged in.");
	*/
	ClientPrint(playerid, COLOR_MSG_SERVER, "You are now registered and logged in.");
    pdata[playerid][loggedin] = true;
    return 1;
}


Dialog:login_dialog(playerid, response, listitem, inputtext[]){
	if(!response) return Dialog_Show(playerid, changenamedialog, DIALOG_STYLE_INPUT, "Accounts System", "Please input your new name.", "Change", "Close");
	new saltedhash[65];
	SHA256_PassHash(inputtext, pdata[playerid][pwsalt], saltedhash, 65);

	if(strcmp(saltedhash, pdata[playerid][pwhash]) == 0){

		cache_set_active(pdata[playerid][player_cache]);

		cache_get_value_int(0, "db_id", pdata[playerid][db_id]);
		cache_get_value_int(0, "kills", pdata[playerid][kills]);
		cache_get_value_int(0, "deaths", pdata[playerid][deaths]);
		cache_get_value_int(0, "bankmoney", pdata[playerid][bankmoney]);
		cache_get_value_int(0, "cash", pdata[playerid][cash]);
		cache_get_value_int(0, "health", pdata[playerid][health]);
		cache_get_value_int(0, "armor", pdata[playerid][armor]);
		cache_get_value_int(0, "timezone", pdata[playerid][timezone]);
		cache_get_value_int(0, "adminlevel", pdata[playerid][adminlevel]);

		//change this scoring system
		SetPlayerScore(playerid, pdata[playerid][kills]);

		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, pdata[playerid][cash]);


		cache_delete(pdata[playerid][player_cache]);
		pdata[playerid][player_cache] = MYSQL_INVALID_CACHE;

		pdata[playerid][loggedin] = true;
		/*
		SendClientMessage(playerid, 0x00FF00FF, "Logged in to the account.");
		*/
		ClientPrint(playerid, COLOR_MSG_SERVER, "Logged in to the account.");
		return 1;
	}
	new String[150];

	pdata[playerid][pwfails]++;
	printf("%s has been failed to login. (%d)", pdata[playerid][name], pdata[playerid][pwfails]);
	if (pdata[playerid][pwfails] >= 3){ // If the fails exceeded the limit we kick the player.
		/*
		format(String, sizeof(String), "%s has been kicked Reason: {FF0000}(%d/3) Login fails.", pdata[playerid][name], pdata[playerid][pwfails]);
		SendClientMessageToAll(0x969696FF, String);
		*/
		ClientPrintEx(-1, COLOR_MSG_SERVER, "%s has been kicked for exceeding their login attempts.", pdata[playerid][name]);
		Kick(playerid);
	}
	else{
		/*
		format(String, sizeof(String), "Wrong password, you have %d out of 3 tries.", pdata[playerid][pwfails]);
		SendClientMessage(playerid, 0xFF0000FF, String);
		*/
		ClientPrintEx(playerid, COLOR_MSG_SERVER, "Incorrect password, you have %d attempts remaining.", pdata[playerid][pwfails]);

		format(String, sizeof(String), "\n{FFFFFF}Welcome back, %s.\n\n{0099FF}This name is already registered.\n\
		{0099FF}Please login below, or proceed by changing to a different name.\n\n", pdata[playerid][name]);
		Dialog_Show(playerid, login_dialog, DIALOG_STYLE_PASSWORD, "Accounts System", String, "Login", "Change");
	}
	return 1;
}
Dialog:changenamedialog(playerid, response, listitem, inputtext[]){
	return 1;
}



Dialog:register_dialog(playerid, response, listitem, inputtext[]){
	/*
	if(!response) return SendClientMessage(playerid,-1,"Warning: You are now playing as a 'guest'. Your in-game progress will not be saved if you leave the game without registering!");
	*/
	if(!response){
		ClientPrint(playerid, COLOR_MSG_SERVER, "You are now playing as a guest, your in-game progress will not be saved if you leave the game without registering.");
		return 1;
	}
	if(strlen(inputtext) <= 5 || strlen(inputtext) > 60){
		/*
		SendClientMessage(playerid, 0x969696FF, "Invalid password length, should be 5 - 60.");
		*/
		ClientPrint(playerid, COLOR_MSG_SERVER, "Your password should be 5 to 60 characters long.");

		new String[150];

		format(String, sizeof(String), "{FFFFFF}Welcome %s.\n\n{0099FF}This account is not registered.\n\
		{0099FF}Please input a password to register, or play as a guest.\n\n", pdata[playerid][name]);
		Dialog_Show(playerid, register_dialog, DIALOG_STYLE_PASSWORD, "Accounts System", String, "Register", "Guest");
		return 1;
	}
	for (new i = 0; i < 10; i++){
		pdata[playerid][pwsalt][i] = random(79) + 47;
	}
	pdata[playerid][pwsalt][10] = 0;
	SHA256_PassHash(inputtext, pdata[playerid][pwsalt], pdata[playerid][pwhash], 65);

	new query[225];

	mysql_format(database, query, sizeof(query), "INSERT INTO `pdata` (`name`, `pwhash`, `pwsalt`, `ip`, `KILLS`, `CASH`, `DEATHS`)\
	VALUES ('%e', '%s', '%e', '%e', '0', '0', '0')", pdata[playerid][name], pdata[playerid][pwhash], pdata[playerid][pwsalt],pdata[playerid][ip]);
	mysql_tquery(database, query, "OnPlayerRegister", "d", playerid);
	return 1;
}



/* Current working query

CREATE TABLE `pdata` (
  `db_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(24) NOT NULL,
  `pwhash` char(65) NOT NULL,
  `ip` char(16) NOT NULL,
  `pwsalt` char(11) NOT NULL,
  `deaths` smallint(5) unsigned NOT NULL DEFAULT '0',
  `kills` smallint(5) unsigned NOT NULL DEFAULT '0',
  `cash` smallint(5) unsigned NOT NULL DEFAULT '0',
  `bankmoney` int(10) unsigned NOT NULL DEFAULT '0',
  `shadowbanned` tinyint(1) NOT NULL DEFAULT '0',
  `autologin` tinyint(1) NOT NULL DEFAULT '0',
  `health` tinyint(3) unsigned NOT NULL DEFAULT '50',
  `armor` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `timezone` tinyint(4) NOT NULL DEFAULT '0',
  `adminlevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`db_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1

*/
