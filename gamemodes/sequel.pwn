#define MYSQL_HOST        "localhost"
#define MYSQL_USER        "server" 
#define MYSQL_PASS        "H&131{}h" 
#define MYSQL_DATABASE    "samp" 

new MySQL:database;

sequel_Init(){
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

sequel_Exit(){
	foreach(new i: Player){
		if(IsPlayerConnected(i)){
			OnPlayerDisconnect(i, 1);
		}
	}
	mysql_close(database);
}


sequel_QueryPlayerData(playerid){ //query time & login time - login time is time it take pawn to process (ms)
	new query[200];
	pdata[playerid][loggedin]=false;
	pdata[playerid][pwfails]=0;
	
	GetPlayerName(playerid, pdata[playerid][name], MAX_PLAYER_NAME); // Getting the player's name.
	new stringss[69];
	format(stringss, 69, "id: %i ....corrupt b4 incre %i pdata", playerid, pdata[playerid][corrupt_check]);
 	SendClientMessageToAll(-1,stringss);
	
	pdata[playerid][corrupt_check]+=1;

	mysql_format(database, query, sizeof(query), "SELECT * FROM `pdata` WHERE `name` = '%e' LIMIT 1", pdata[playerid][name]);
	mysql_tquery(database, query, "OnPlayerDataCheck", "ii", playerid, pdata[playerid][corrupt_check]);
	SendClientMessageToAll(-1,"tquery sent!");
}

forward OnPlayerDataCheck(playerid, corrupt_checker);
public OnPlayerDataCheck(playerid, corrupt_checker){

    //if (corrupt_checker != pdata[playerid][corrupt_check]) return SendClientMessage(playerid,-1,"================>>>>ur ID is corrupt!!");
    if (corrupt_checker != pdata[playerid][corrupt_check]){
        new stringsss[169];
        format(stringsss, 169, "query corrupted, discarding... id: (%i)  pdata:(%i) checker:(%i)", playerid, pdata[playerid][corrupt_check], corrupt_checker);
        SendClientMessageToAll(-1,stringsss);
        return 1;
    }
	new String[150],strings3[169];
 	format(strings3, 169, "query clean, accepting... id: (%i)  pdata:(%i) checker:(%i)", playerid, pdata[playerid][corrupt_check], corrupt_checker);
 	SendClientMessageToAll(-1,strings3);
	if(cache_num_rows() > 0){
		cache_get_value(0, "pwhash", pdata[playerid][pwhash], 65);
		cache_get_value(0, "pwsalt", pdata[playerid][pwsalt], 11);
		
		pdata[playerid][player_cache] = cache_save();

		format(String, sizeof(String), "{FFFFFF}Welcome back, %s.\n\n{0099FF}This name is already registered.\n\
		{0099FF}Please login below, or proceed with a different name.\n\n", pdata[playerid][name]);
		Dialog_Show(playerid, login_dialog, DIALOG_STYLE_PASSWORD, "Login System", String, "Login", "Change Name");
	}
	else {
		format(String, sizeof(String), "{FFFFFF}Welcome %s.\n\n{0099FF}This account is not registered.\n\
		{0099FF}Please input a password to register, or play as a guest.\n\n", pdata[playerid][name]);
		Dialog_Show(playerid, register_dialog, DIALOG_STYLE_PASSWORD, "Registration System", String, "Register", "Guest");
	}
	return 1;
}

forward OnPlayerRegister(playerid);
public OnPlayerRegister(playerid){
	SendClientMessage(playerid, 0x00FF00FF, "You are now registered and has been logged in.");
    pdata[playerid][loggedin] = true;
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
