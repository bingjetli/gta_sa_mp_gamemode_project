#include <a_samp>
//========================================|
#include <Pawn.CMD>
#include <sscanf2>
#include <a_mysql>
#include <easyDialog>
#include <foreach>
#include <fixes2>
//#include <streamer>
//#include <>
//========================================|
#include "./players.pwn"
#include "./helper.pwn"
#include "./buildings.pwn"
#include "./commands.pwn"
#include "./sequel.pwn"
#include "./dialogs.pwn"
#include "./world.pwn"
#include "./combat.pwn"
#include "./zones.pwn"
//#include "./.pwn"
//#include "./.pwn"
//#include "./.pwn"
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
new sdata[server_data_enum];
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

public OnPlayerPickUpPickup(playerid, pickupid){
	buildings_OnPlayerPickUpPickup(playerid, pickupid);
	return 1;
}
