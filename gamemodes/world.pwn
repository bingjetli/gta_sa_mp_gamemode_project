/*
* Time & Weather Module
*/
#define WORLD_TICK_RATE 10000 //ms

static const debug_world = 1;
static timer_worldtime;

forward world_OnTick();

stock world_OnGameModeInit(){
	timer_worldtime = SetTimer("world_OnTick", WORLD_TICK_RATE, true);
}

stock world_OnGameModeExit(){
	//KillTimer(timer_worldtime);
}

public world_OnTick(){
	DebugPrint(-1, debug_world, "world tick");
	for(new i; i<MAX_PLAYERS; i++){
		if(IsPlayerConnected(i) && GetPlayerState(i) != PLAYER_STATE_WASTED){
			SetPlayerTime(i, (gettime()/600)%24, (gettime()/10)%60);
			DebugPrintEx(i, debug_world, "current time: %2d:%2d", (gettime()/600)%24, (gettime()/10)%60);
		}
	}
}
