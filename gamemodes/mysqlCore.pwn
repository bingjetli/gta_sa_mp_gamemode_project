#define MYSQL_HOST        "localhost"
#define MYSQL_USER        "server" 
#define MYSQL_PASS        "H&131{}h" 
#define MYSQL_DATABASE    "samp" 

new MySQL:database, corrupt_check[MAX_PLAYERS];

stock MySQLInit(){
    new MySQLOpt:option_id = mysql_init_options();
    mysql_set_option(option_id, AUTO_RECONNECT, true);
    database = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DATABASE, option_id);
	if(database == MYSQL_INVALID_HANDLE || mysql_errno(Database) != 0){ // Checking if the database connection is invalid to shutdown.
		print("I couldn't connect to the MySQL server, closing."); // Printing a message to the log.
		SendRconCommand("exit"); // Sending console command to shut down server.s
		return 1;
	}
    print("MySQL connection established.");
	new query[1024] = "CREATE TABLE IF NOT EXISTS `pdata` (`db_id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,";
	strins("`name` varchar(24) NOT NULL,`pwhash` char(65) NOT NULL,`ip` char(16) NOT NULL,`pwsalt` char(11) NOT NULL,",query,strlen(query));
	strins("`deaths` smallint UNSIGNED NOT NULL DEFAULT '0', `kills` smallint UNSIGNED NOT NULL DEFAULT '0', `cash` smallint NOT NULL UNSIGNED DEFAULT '0',",query,strlen(query));
	strins("`bankmoney` int UNSIGNED NOT NULL DEFAULT '0',`shadowbanned` bool NOT NULL DEFAULT '0',`autologin` bool NOT NULL DEFAULT '0',",query,strlen(query));
	strins("`health` tinyint UNSIGNED NOT NULL DEFAULT '50',`armor` tinyint UNSIGNED NOT NULL DEFAULT '0',`timezone` tinyint SIGNED NOT NULL DEFAULT '0',",query,strlen(query));
	strins("`adminlevel` tinyint UNSIGNED NOT NULL DEFAULT '0', UNIQUE KEY `name` (`name`))",query,strlen(query));
	//strins("",query,strlen(query));
    mysql_tquery(database, query);

}

stock MySQLExit(){
	foreach(new i: Player){
		if(IsPlayerConnected(i)){
			OnPlayerDisconnect(i, 1);
		}
	}
	mysql_close(database);
}
