Dialog:weaponsmenu(playerid, response, listitem, inputtext[]){
    if (response){
        new str[64];
        format(str, 64, "You have selected the '%s'.", inputtext);

        GivePlayerWeapon(playerid, listitem + 22, 500);
        SendClientMessage(playerid, -1, str);
    }
    return 1;
}

Dialog:changenamedialog(playerid, response, listitem, inputtext[]){
}


Dialog:login_dialog(playerid, response, listitem, inputtext[]){
	if(!response) return Dialog_Show(playerid, changenamedialog, DIALOG_STYLE_INPUT, "Change Name", "Please input your new name.", "Change", "Close");
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
		SendClientMessage(playerid, 0x00FF00FF, "Logged in to the account.");
		return 1;
	}
	new String[150];

	pdata[playerid][pwfails]++;
	printf("%s has been failed to login. (%d)", pdata[playerid][name], pdata[playerid][pwfails]);
	if (pdata[playerid][pwfails] >= 3){ // If the fails exceeded the limit we kick the player.
		format(String, sizeof(String), "%s has been kicked Reason: {FF0000}(%d/3) Login fails.", pdata[playerid][name], pdata[playerid][pwfails]);
		SendClientMessageToAll(0x969696FF, String);
		Kick(playerid);
	}
	else{
		format(String, sizeof(String), "Wrong password, you have %d out of 3 tries.", pdata[playerid][pwfails]);
		SendClientMessage(playerid, 0xFF0000FF, String);
		format(String, sizeof(String), "{FFFFFF}Welcome back, %s.\n\n{0099FF}This name is already registered.\n\
		{0099FF}Please login below, or proceed with a different name.\n\n", pdata[playerid][name]);
		Dialog_Show(playerid, login_dialog, DIALOG_STYLE_PASSWORD, "Login System", String, "Login", "Change Name");
	}
	return 1;
}

Dialog:register_dialog(playerid, response, listitem, inputtext[]){
	if(!response) return SendClientMessage(playerid,-1,"Warning: You are now playing as a 'guest'. Your in-game progress will not be saved if you leave the game without registering!");
	if(strlen(inputtext) <= 5 || strlen(inputtext) > 60){
		SendClientMessage(playerid, 0x969696FF, "Invalid password length, should be 5 - 60.");

		new String[150];

		format(String, sizeof(String), "{FFFFFF}Welcome %s.\n\n{0099FF}This account is not registered.\n\
		{0099FF}Please input a password to register, or play as a guest.\n\n", pdata[playerid][name]);
		Dialog_Show(playerid, register_dialog, DIALOG_STYLE_PASSWORD, "Registration System", String, "Register", "Guest");
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


public OnDialogPerformed(playerid, dialog[], response, success){
    if (!strcmp(dialog, "WeaponMenu") && IsPlayerInAnyVehicle(playerid)){
        SendClientMessage(playerid, -1, "You must be on-foot to spawn a weapon.");
        return 0;
    }
    return 1;
}


/*for more on dialog processor:
https://github.com/Awsomedude/easyDialog
http://forum.sa-mp.com/showthread.php?t=475838
*/
