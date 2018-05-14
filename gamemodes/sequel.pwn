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
