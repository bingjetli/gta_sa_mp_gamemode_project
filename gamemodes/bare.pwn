#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS 50

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

new const debug_general = 0;
new pdata[MAX_PLAYERS][player_data_enum];
new player_connect_count;

//this is where you includae your modules
#include "./helper.pwn"
#include "./buildings.pwn"
#include "./commands.pwn"
#include "./sequel.pwn"
#include "./dialogs.pwn"
#include "./world.pwn"

main(){
	print("gamemode started...");
}

public OnGameModeInit(){
	player_connect_count = 0;
	sequel_Init();
	buildings_OnGameModeInit();
	world_OnGameModeInit();

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
	player_connect_count++;
	DebugPrintEx(-1, debug_general, "OnPlayerConnect was called %d times!", player_connect_count);

	sequel_QueryPlayerData(playerid);
	buildings_OnPlayerConnect(playerid);

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

