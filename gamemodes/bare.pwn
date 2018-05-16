#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS 50
#define WORLD_TIME_TICK_RATE 10000 //ms

#include <Pawn.CMD>
#include <sscanf2>
#include <a_mysql>
#include <easyDialog>
#include <foreach>
#include <fixes2>


enum player_data_enum {
	db_id,                      //db
	name[25],                   //db
	pwhash[65],                 //db
	pwsalt[11],                 //db
	pwfails,
	kills,                      //db
	deaths,                     //db
	bool:loggedin,
	bool:shadowbanned,          //db
	cash,                       //db
	bankmoney,                  //db
	health,                     //db
	armor,                      //db
	timezone,                   //db
	ip[16],                     //db
	autologin,                  //db
	adminlevel,                 //db
	corrupt_check,
	Cache:player_cache
};

/*
* global variables
*/
new pdata[MAX_PLAYERS][player_data_enum];
new timer_worldtime;

/*
* function forwards
*/
forward OnWorldTimeTick();

/*
* load modules
*/
#include "./clientprint.pwn"
#include "./buildings.pwn"
#include "./commands.pwn"
#include "./sequel.pwn"
#include "./dialogs.pwn"

main(){
	print("gamemode started...");
}

/*
* server callbacks
*/
public OnPlayerConnect(playerid){
	sequel_QueryPlayerData(playerid);
	buildings_OnPlayerConnect(playerid);
	//deprecated: clientPrint_OnPlayerConnect(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason){

	return 1;
}

public OnPlayerSpawn(playerid){
	SetPlayerPos(playerid, -1753.7196, 884.7693, 295.8750);
	SetPlayerFacingAngle(playerid, 6.6817);
	SetCameraBehindPlayer(playerid);
	//GivePlayerWeapon(playerid, 46, 1);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason){
   	return 1;
}

SetupPlayerForClassSelection(playerid){
	SetPlayerPos(playerid, -1753.7196, 884.7693, 295.8750);
	SetPlayerFacingAngle(playerid, 6.6817);
	SetPlayerCameraPos(playerid, -1754.3840, 890.7601, 296.6267);
	SetPlayerCameraLookAt(playerid, -1753.7196, 884.7693, 295.8750);
	SetPlayerTime(playerid, 0, 0);
	SetPlayerWeather(playerid, 3);
}

public OnPlayerRequestClass(playerid, classid){
	SetupPlayerForClassSelection(playerid);
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid){
	buildings_OnPlayerPickUpPickup(playerid, pickupid);
	return 1;
}

public OnGameModeInit(){
	sequel_Init();
	buildings_OnGameModeInit();

    UsePlayerPedAnims();
	SetGameModeText("sfrpg");
	ShowPlayerMarkers(1);
	timer_worldtime = SetTimer("OnWorldTimeTick", WORLD_TIME_TICK_RATE, true);

	AddPlayerClass(265,1958.3783,1343.1572,15.3746,270.1425,0,0,0,0,-1,-1);

	return 1; //return 0 to prevent filterscripts from receiving the callback
}

public OnGameModeExit(){
	
	buildings_OnGameModeExit();
	//set timer for 5 seconds to see if it waits for gamemodeexit to finish calling
	KillTimer(timer_worldtime);
	SendClientMessageToAll(-1, "gamemode exit successfully called");
	return 1; //return 0 to prevent filterscripts from receiving the callback
}

public OnWorldTimeTick(){
	new string[25];
	for(new i; i < MAX_PLAYERS; i++){
		if(IsPlayerConnected(i)){
			format(string, sizeof(string), "current world time: %2d:%2d", (gettime()/600)%24, (gettime()/10)%60);
			SetPlayerTime(i, (gettime()/600)%24, (gettime()/10)%60);
			GameTextForPlayer(i, string, 1000, 3);
		}
	}
}
