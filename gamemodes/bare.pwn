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

new pdata[MAX_PLAYERS][player_data_enum];
new testvar;
new strr[10];




//this is where you includae your modules
#include "./mapIcons.pwn"
#include "./buildings.pwn"
#include "./commands.pwn"
#include "./sequel.pwn"
#include "./dialogs.pwn"





main();

public OnPlayerConnect(playerid){
    valstr(strr,testvar);
	SendClientMessageToAll(-1,strr);
	sequel_QueryPlayerData(playerid);
	mapIcons_OnPlayerConnect(playerid);
	buildings_OnPlayerConnect(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason){

	return 1;
}

public OnPlayerSpawn(playerid){
	SetPlayerPos(playerid, -1753.7196, 884.7693, 295.8750);
	SetPlayerFacingAngle(playerid, 6.6817);
	SetCameraBehindPlayer(playerid);
	GivePlayerWeapon(playerid, 46, 1);
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
    UsePlayerPedAnims();
	SetGameModeText("sfrpg");
	ShowPlayerMarkers(1);

	AddPlayerClass(265,1958.3783,1343.1572,15.3746,270.1425,0,0,0,0,-1,-1);

	return 1; //return 0 to prevent filterscripts from receiving the callback
}

public OnGameModeExit(){
	sequel_Exit();
	buildings_OnGameModeExit();
	//set timer for 5 seconds to see if it waits for gamemodeexit to finish calling
	SendClientMessageToAll(0xFFFFFF, "server calls exit before being killed");
	return 1; //return 0 to prevent filterscripts from receiving the callback
}


