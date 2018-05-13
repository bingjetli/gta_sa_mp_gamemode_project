#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS 50

#include <core>
#include <float>
#include <Pawn.CMD>

//this is where you includae your modules
#include "./testModule.pwn"
#include "./buildings.pwn"
#include "./pdataArray.pwn"
#include "./commands.pwn"

main()
{
	print("gamemode initialized");
}

public OnPlayerConnect(playerid)
{
	testModule_OnPlayerConnect(playerid);       //here's how we hook callbacks to be used in your module
	buildings_OnPlayerConnect(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerInterior(playerid,0);
	TogglePlayerClock(playerid,0);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
   	return 1;
}

SetupPlayerForClassSelection(playerid)
{
 	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	return 1;
}

public OnGameModeInit()
{
	SetGameModeText("sfrpg");
	ShowPlayerMarkers(1);
	ShowNameTags(1);
	AllowAdminTeleport(1);

	AddPlayerClass(265,1958.3783,1343.1572,15.3746,270.1425,0,0,0,0,-1,-1);

	return 1;
}
