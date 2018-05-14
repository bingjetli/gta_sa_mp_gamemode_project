enum player_data_enum {
	db_id,
	name[25],
	pwhash[65],
	pwsalt[11],
	pwattempts,
	kills,
	deaths,
	bool:loggedin,
	bool:registered,
	bool:shadowbanned,
	cash,
	bankmoney,
	health,
	armor,
	timezone,
	ip[16],
	autologin,
	adminlevel
};

new pdata[MAX_PLAYERS][player_data_enum];

