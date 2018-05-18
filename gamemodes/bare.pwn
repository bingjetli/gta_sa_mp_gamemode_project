#include <a_samp>
#include <fixes>
//========================================|
#include <a_mysql>
#include <sscanf2>
#include <foreach>
#include <Pawn.CMD>
#include <easyDialog>
#include <timerfix>
//========================================|
#undef MAX_PLAYERS
#define MAX_PLAYERS 50
//#define
//#define
//========================================|
enum server_data_enum{
	server_timezone,
	robbers_over_cops,
	player_connect_count,
	debug_general
};
enum player_data_enum{
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
	Cache:player_cache,
	Text3D:nametag,
	nametagtimer,
	afktime
};

new pdata[MAX_PLAYERS][player_data_enum];
new sdata[server_data_enum];
//========================================|
/*
#include "./players.pwn"
*/
#include "./helper.pwn"
#include "./sequel.pwn"
#include "./buildings.pwn"
#include "./commands.pwn"
#include "./dialogs.pwn"
#include "./world.pwn"
#include "./combat.pwn"
#include "./zones.pwn"
#include "./statusfx.pwn"

#if !defined HELPER_PWN
	#error helper.pwn is not included
#endif
#if !defined BUILDINGS_PWN
	#error buildings.pwn is not included
#endif
#if !defined COMMANDS_PWN
	#error commands.pwn is not included
#endif
#if !defined SEQUEL_PWN
	#error sequel.pwn is not included
#endif
#if !defined DIALOGS_PWN
	#error dialogs.pwn is not included
#endif
#if !defined WORLD_PWN
	#error world.pwn is not included
#endif
#if !defined COMBAT_PWN
	#error combat.pwn is not included
#endif
#if !defined ZONES_PWN
	#error zones.pwn is not included
#endif
/*
#if !defined STATUSFX_PWN
	#error statusfx.pwn is not included
#endif
*/
//#include "./.pwn"
//#include "./.pwn"
//#include "./.pwn"
//========================================|
main(){}
/*
|-----------------------------------------|
|-----------------------------------------|
*/
public OnGameModeInit(){
	weapons_AssignName();
	weapons_AssignDamage();
 	sdata[debug_general]=1;
	sdata[player_connect_count] = 0;
	sequel_Init();
	buildings_OnGameModeInit();
	world_OnGameModeInit();
	zones_OnGameModeInit();
    
    UsePlayerPedAnims();
    ShowNameTags(0);
	SetGameModeText("sfrpg");
	ShowPlayerMarkers(1);

	AddPlayerClass(265,1958.3783,1343.1572,15.3746,270.1425,0,0,0,0,-1,-1);

	return 1; //return 0 to prevent filterscripts from receiving the callback
}

public OnGameModeExit(){
	buildings_OnGameModeExit();
	world_OnGameModeExit();
	ClientPrint(-1, COLOR_MSG_SERVER, "Gamemode Exited...");
	return 1; //return 0 to prevent filterscripts from receiving the callback
}

public OnPlayerConnect(playerid){
	sdata[player_connect_count]++;
	DebugPrintEx(-1, sdata[debug_general], "OnPlayerConnect was called %d times!", sdata[player_connect_count]);

	sequel_QueryPlayerData(playerid);
	buildings_OnPlayerConnect(playerid);
//	statusfx_OnPlayerConnect(playerid);
	zones_OnPlayerConnect(playerid);
    combat_OnPlayerConnect(playerid);
    
	ClientPrintEx(-1, COLOR_MSG_NETWORK, "%s connected to the server!", pdata[playerid][name]);
	return 1;
}

public OnPlayerDisconnect(playerid, reason){
	switch(reason){
		case 0: {
			ClientPrintEx(-1, COLOR_MSG_NETWORK, "%s lost connection to the server!", pdata[playerid][name]);
		}
		case 1: {
			ClientPrintEx(-1, COLOR_MSG_NETWORK, "%s left the server!", pdata[playerid][name]);
		}
		case 2: {
			ClientPrintEx(-1, COLOR_MSG_NETWORK, "%s was kicked/banned by the server!", pdata[playerid][name]);
		}
	}

	combat_OnPlayerDisconnect(playerid);
//	statusfx_OnPlayerDisconnect(playerid);
	
	return 1;
}

public OnPlayerSpawn(playerid){
	world_OnPlayerSpawn(playerid);
	SetPlayerPos(playerid, -1753.7196, 884.7693, 295.8750);
	SetPlayerFacingAngle(playerid, 6.6817);
	SetCameraBehindPlayer(playerid);
	//GivePlayerWeapon(playerid, 46, 1);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason){
//	statusfx_OnPlayerDeath(playerid, killerid, reason);
	world_OnPlayerDeath(playerid, killerid, reason);
   	return 1;
}

SetupPlayerForClassSelection(playerid){
	SetPlayerPos(playerid, -1753.7196, 884.7693, 295.8750);
	SetPlayerFacingAngle(playerid, 6.6817);
	SetPlayerCameraPos(playerid, -1754.3840, 890.7601, 296.6267);
	SetPlayerCameraLookAt(playerid, -1753.7196, 884.7693, 295.8750);
	SetPlayerTime(playerid, 0, 0);
	SetPlayerWeather(playerid, 18);
}

public OnPlayerRequestClass(playerid, classid){
	SetupPlayerForClassSelection(playerid);
	return 1;
}

public OnPlayerUpdate(playerid){
	pdata[playerid][afktime]=0;
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid){
	buildings_OnPlayerPickUpPickup(playerid, pickupid);
	return 1;
}
