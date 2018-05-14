enum player_data_enum {
	db_id,
	name[25],
	pwhash[65],
	pwsalt[11],
	pwfails,
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
	adminlevel,
	corrupt_check,
	cache:sequel_caches
};

new pdata[MAX_PLAYERS][player_data_enum];

