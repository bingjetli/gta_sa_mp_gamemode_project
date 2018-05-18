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
* statusfx_hud:
*	maximum 10 visible at any given time
*	10 player textdraws
*	fifo model, queue
*
*/
#define MAX_VISIBLE_STATUSFX 10

enum ENUM_STATUSFX {
	BUFF_HP_REGEN,
	DEBUFF_POISON,
	ENUM_MAX_STATUSFX
};

enum ENUM_STATUSFX_DATA {
	DURATION,
	bool:PERSIST
};

static player_statusfx[MAX_PLAYERS][ENUM_STATUSFX][ENUM_STATUSFX_DATA];
static timer_statusfx[MAX_PLAYERS];
static debug_statusfx = 1;
static PlayerText:textdraw_active_statusfx[MAX_PLAYERS][MAX_VISIBLE_STATUSFX];

forward statusfx_OnPlayerStatusFXTick(playerid);

stock statusfx_OnPlayerConnect(playerid){
	timer_statusfx[playerid] = SetTimerEx("statusfx_OnPlayerStatusFXTick", 1000, true, "i", playerid);
	for(new i; i < MAX_VISIBLE_STATUSFX; i++){
		textdraw_active_statusfx[playerid][i] = CreatePlayerTextDraw(playerid, 630.0, 425.0 - (i*20.0), "statusfx    :99s");
		PlayerTextDrawFont(playerid, textdraw_active_statusfx[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, textdraw_active_statusfx[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, textdraw_active_statusfx[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, textdraw_active_statusfx[playerid][i], 0.3, 1.5);
		PlayerTextDrawAlignment(playerid, textdraw_active_statusfx[playerid][i], 3);
		PlayerTextDrawUseBox(playerid, textdraw_active_statusfx[playerid][i], 1);
		PlayerTextDrawBoxColor(playerid, textdraw_active_statusfx[playerid][i], 0x00000066);
		PlayerTextDrawTextSize(playerid, textdraw_active_statusfx[playerid][i], -300.0, 5.0);
		PlayerTextDrawShow(playerid, textdraw_active_statusfx[playerid][i]);
	}
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
	for(new ENUM_STATUSFX:i; i < ENUM_MAX_STATUSFX; i++){ //loop through all existing status effects
		if(player_statusfx[playerid][i][DURATION] > 0){ //if the status effect has a duration greater than 0
			//apply status effect tick
			switch(i){
				case BUFF_HP_REGEN: {
					new Float:player_health;
					GetPlayerHealth(playerid, player_health);
					if(player_health < 100.0) SetPlayerHealth(playerid, player_health+5.0);
					DebugPrintEx(playerid, debug_statusfx, "BUFF_HP_REGEN: +5HP - %ds remaining (HP: %.1f)", player_statusfx[playerid][i][DURATION], player_health+5.0);
				}
				case DEBUFF_POISON: {
					if(GetPlayerState(playerid) != PLAYER_STATE_WASTED){
						new Float:player_health;
						GetPlayerHealth(playerid, player_health);
						if(player_health > 0.0) SetPlayerHealth(playerid, player_health-2.0);
						DebugPrintEx(playerid, debug_statusfx, "DEBUFF_POISON: -2HP - %ds remaining (HP: %.1f)", player_statusfx[playerid][i][DURATION], player_health-2.0);
					}
				}
			}
			//reduce duration after applying tick effect
			player_statusfx[playerid][i][DURATION]--;
		}
	}
}

cmd:hpregen(playerid, params[]){
	DebugPrint(playerid, debug_statusfx, "You have been given the HP_REGEN buff for 60 seconds!");
	statusfx_GivePlayerStatusFX(playerid, BUFF_HP_REGEN, 60, false);
	return 1;
}
cmd:poison(playerid, params[]){
	DebugPrint(playerid, debug_statusfx, "You have been given the POISON debuff for 60 seconds!");
	statusfx_GivePlayerStatusFX(playerid, DEBUFF_POISON, 60, true);
	return 1;
}
cmd:cure(playerid, params[]){
	DebugPrint(playerid, debug_statusfx, "You have been cured of your POISON debuff!");
	statusfx_RemovePlayerStatusFX(playerid, DEBUFF_POISON);
	return 1;
}
