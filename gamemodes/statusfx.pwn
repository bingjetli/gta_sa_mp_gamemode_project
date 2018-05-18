/*
* Status Effects Module
* manages various buffs and debuffs in the game
*
* method of action:
*	1. global timer:
*		timer loops through all connected players
*		loops through all active status effects on that player
*		apply individual effects
*		faster with little amounts of players & status fx
*	2. per-player timer: **
*		timer is started on player connect
*		killed on player disconnect
*		loops through all active status effects on that player
*		apply individual effects
*		faster when players < statusfx
*	3. per-statusfx timer:
*		timer is started on buff/debuff application
*		loops through all affected players
*		applies effects to all affected players
*		timer is killed when the last player's queued buff/debuff expires
*		faster when statusfx < players
*
* statusfx_data
*	statusfx_id - index
*	statusfx_type (buff or debuff)
*	statusfx_duration
*	statusfx_persist
*
* timer_statusfx[MAX_PLAYERS]
*
* functions:
*	giveplayerbuff(playerid, Buff:buff, duration, bool:persist)
*		- persist determines whether or not the buff persists after death/disconnect
*	giveplayerdebuff(playerid, Debuff:debuff, duration, bool:persist)
*/
#if defined STATUSFX_PWN
	#endinput
#endif
#define STATUSFX_PWN

enum ENUM_STATUSFX {
	BUFF_HP_REGEN,
	BUFF_CURE_POISON,
	DEBUFF_POISON,
	ENUM_MAX_STATUSFX
};

enum ENUM_STATUSFX_DATA {
	DURATION,
	bool:PERSIST
};

static player_statusfx[MAX_PLAYERS][ENUM_STATUSFX][ENUM_STATUSFX_DATA];
static timer_statusfx[MAX_PLAYERS];

forward statusfx_OnPlayerStatusFXTick(playerid);

stock statusfx_OnPlayerConnect(playerid){
	timer_statusfx[playerid] = SetTimerEx("statusfx_OnPlayerStatusFXTick", 1000, true, "i", playerid);
	return 1;
}

stock statusfx_OnPlayerDisconnect(playerid){
	KillTimer(timer_statusfx[playerid]);
	return 1;
}

stock statusfx_OnPlayerDeath(playerid, killerid, reason){
	#pragma unused killerid
	#pragma unused reason
	/*
	* remove all non-persisting status effects on death
	*/
	for(new ENUM_STATUSFX:i; i < ENUM_MAX_STATUSFX; i++){
		if(player_statusfx[playerid][i][PERSIST] != true) player_statusfx[playerid][i][DURATION] = 0;
	}
}

stock statusfx_GivePlayerStatusFX(playerid, ENUM_STATUSFX:statusfx, duration, bool:persist){
	player_statusfx[playerid][statusfx][DURATION] = duration;
	player_statusfx[playerid][statusfx][PERSIST] = persist;
}

stock statusfx_RemovePlayerStatusFX(playerid, ENUM_STATUSFX:statusfx){
	player_statusfx[playerid][statusfx][DURATION] = 0;
	player_statusfx[playerid][statusfx][PERSIST] = false;
}

public statusfx_OnPlayerStatusFXTick(playerid){
	for(new i; i < 2; i++){ //loop through all existing status effects
		if(player_statusfx[playerid][i][DURATION] > 0){ //if the status effect has a duration greater than 0
			//apply status effect tick
			switch(i){
				case BUFF_HP_REGEN: {
					static Float:player_health;
					GetPlayerHealth(playerid, player_health);
					if(player_health < 100.0) SetPlayerHealth(playerid, player_health+2.0);
				}
				case BUFF_CURE_POISON: {
					player_statusfx[playerid][DEBUFF_POISON][DURATION] = 0;
				}
				case DEBUFF_POISON: {
					static Float:player_health;
					GetPlayerHealth(playerid, player_health);
					if(player_health > 0.0) SetPlayerHealth(playerid, player_health-1.0);
				}
			}
			//reduce duration after applying tick effect
			player_statusfx[playerid][i][DURATION]--;
		}
	}
}
