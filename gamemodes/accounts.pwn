accounts_QueryPlayerData(playerid){
//Resetting player information.
	new query[200];
	pdata[playerid][kills] = 0;
	pdata[playerid][deaths] = 0;
	pdata[playerid][pwfails] = 0;

	GetPlayerName(playerid, pdata[playerid][name], MAX_PLAYER_NAME); // Getting the player's name.
	pdata[playerid][corrupt_check]++;

	mysql_format(database, query, sizeof(query), "SELECT * FROM `pdata` WHERE `name` = '%e' LIMIT 1", pdata[playerid][name]);
	//mysql_tquery(database, query, "OnPlayerDataCheck", "ii", playerid, pdata[playerid][corrupt_check]);
	return 1;
}
