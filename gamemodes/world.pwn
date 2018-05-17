/*
* Time & Weather Module
*
* time is based on gettime() unix time stamp
* game time is accelerated to give the players a sense of a living world
* time is accelerated as follows: 
*	1 game minute = 10 seconds
*	1 game hour = 600 seconds  (10 minutes)
*   1 game day = 14400 seconds (4 hours)
* weather changes randomly and can last for up to 24 game hours
*/
#define WORLD_TICK_RATE 10000 //ms
#define WORLD_MINUTE 10 //seconds
#define WORLD_HOUR 600 //seconds

static const debug_world = 0;
//static timer_worldtime;
static const world_weatherids[] = {0,2,3,7,8,9,11,12,13,17,18,19};
static world_weather = 0;

forward world_OnTick();

stock world_OnGameModeInit(){
//	timer_worldtime = SetTimer("world_OnTick", WORLD_TICK_RATE, true);
	SetTimer("world_OnTick", WORLD_TICK_RATE, true);
}

stock world_OnGameModeExit(){
	/*
	* apparently, this statement causes the gamemode to crash
	* perhaps timers are automatically killed on gmx?
	*/
	//KillTimer(timer_worldtime);
}

stock world_OnPlayerSpawn(playerid){
	SetPlayerTime(playerid, (gettime()/WORLD_HOUR)%24, (gettime()/WORLD_MINUTE)%60);
	SetPlayerWeather(playerid, world_weather);
	DebugPrintEx(playerid, debug_world, "current time: %2d:%2d", (gettime()/WORLD_HOUR)%24, (gettime()/WORLD_MINUTE)%60);
}

stock world_OnPlayerDeath(playerid, killerid, reason){
	SetPlayerWeather(playerid, 21);
	SetPlayerTime(playerid, 7, 0);
}

public world_OnTick(){
	static time_next_weather;
	if((gettime()/WORLD_HOUR)%24 == time_next_weather){
		world_weather = world_weatherids[random(sizeof(world_weatherids))];
		time_next_weather = random(24);
		DebugPrintEx(-1, debug_world, "current weatherid: %d, next weather: %2d:00", world_weather, time_next_weather);
	}
	for(new i; i<MAX_PLAYERS; i++){
		if(IsPlayerConnected(i) && GetPlayerState(i) != PLAYER_STATE_WASTED){
			SetPlayerTime(i, (gettime()/WORLD_HOUR)%24, (gettime()/WORLD_MINUTE)%60);
			SetPlayerWeather(i, world_weather);
			DebugPrintEx(i, debug_world, "current time: %2d:%2d", (gettime()/WORLD_HOUR)%24, (gettime()/WORLD_MINUTE)%60);
		}
	}
}
