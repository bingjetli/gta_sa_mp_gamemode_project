/*
 * Buildings Module
 * 
 ****
 * max buildings = 100
 * constant array of buildings:
 *	static - invisible to other files except this one
 *	virtual world = id+1; used to determine current building
 *	entrance_pickup_x
 *	entrance_pickup_y
 *	entrance_pickup_z
 * 	entrance_destination_x
 * 	entrance_destination_y
 * 	entrance_destination_z
 * 	entrance_destination_facing_angle
 * 	entrance_destination_interior_id
 * 	exit_pickup_x
 * 	exit_pickup_y
 * 	exit_pickup_z
 * 	exit_destination_x
 * 	exit_destination_y
 * 	exit_destination_z
 * 	exit_destination_facing_angle
 *
 * constant array of pickups:
 *	static - invisible to other files except this one
 * 	caching all possible pickupids to link to buildings array
 * 	size 4096 (max pickups)
*/
#define MAX_BUILDINGS 100
#define MAX_CACHED_PICKUPS 4096
#define ENEX_MARKER_MODEL_ID 19607
#define ENEX_TELEPORT_COOLDOWN 3000 //miliseconds

enum ENUM_BUILDINGS_DATA {
	Float:ENTRY_PICKUP_X,
	Float:ENTRY_PICKUP_Y,
	Float:ENTRY_PICKUP_Z,
	Float:ENTRY_TARGET_X,
	Float:ENTRY_TARGET_Y,
	Float:ENTRY_TARGET_Z,
	Float:ENTRY_TARGET_FACING_ANGLE,
	ENTRY_TARGET_INTERIOR_ID,
	Float:EXIT_PICKUP_X,
	Float:EXIT_PICKUP_Y,
	Float:EXIT_PICKUP_Z,
	Float:EXIT_TARGET_X,
	Float:EXIT_TARGET_Y,
	Float:EXIT_TARGET_Z,
	Float:EXIT_TARGET_FACING_ANGLE,
	EXIT_TARGET_INTERIOR_ID,
	NAME[8]
};

stock static const buildings_data[][ENUM_BUILDINGS_DATA] = {
	{-1883.20000,	865.47300,	34.26010,	161.39100,	-95.28560,	1000.81000,	0.00000,	18,	161.39100,	-96.68560,	1000.81000,	-1886.20000,	862.47300,	34.26010,	129.00000,	0,	"CLOTHGP"},
	{-1808.69000,	945.86300,	23.86480,	372.35200,	-131.65100,	1000.45000,	-0.10001,	5,	372.35200,	-133.55100,	1000.45000,	-1805.79000,	943.22100,	23.91480,	3824.59000,	0,	"FDPIZA"},
//	{-2099.68000,	897.48500,	75.96610,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-2103.76000,	901.73400,	75.71610,	4374.68000,	0,	"SVSFBG"},
//	{-2213.54000,	720.84500,	48.42620,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-2214.06000,	725.03600,	48.42620,	36.00000,	0,	"SVSFSM"},
//	{-1673.01000,	1337.93000,	6.18842,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-1689.35000,	1335.56000,	16.00000,	-48.00000,	0,	"P69_ENT"},
//	{-1690.75000,	1334.37000,	15.31800,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-1675.09000,	1335.00000,	6.31796,	-222.00000,	0,	"P69_ENT"},
	{-1700.01000,	1380.49000,	6.20434,	459.35100,	-110.10500,	998.71800,	0.00000,	5,	459.35100,	-111.00500,	998.71800,	-1701.83000,	1378.97000,	6.20434,	3729.57000,	0,	"DINER2"},
	{-1721.13000,	1359.01000,	6.19634,	372.35200,	-131.65100,	1000.45000,	-0.10001,	5,	372.35200,	-133.55100,	1000.45000,	-1725.89000,	1359.34000,	6.19634,	96.00000,	0,	"FDPIZA"},
	{-1912.27000,	828.02500,	34.56150,	363.41300,	-74.57870,	1000.55000,	-45.30000,	10,	363.11300,	-74.87870,	1000.55000,	-1910.26000,	830.59800,	34.22150,	334.00000,	0,	"FDBURG"},
	{-1694.76000,	951.59900,	24.27060,	226.29400,	-7.43153,	1001.26000,	90.00000,	5,	227.29400,	-7.43153,	1001.26000,	-1699.27000,	950.59900,	24.27060,	92.00000,	0,	"CSDESGN"},
//	{-1749.35000,	869.27900,	24.05930,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-1753.85000,	885.67900,	295.05900,	-65.00000,	0,	""},
//	{-1753.75000,	883.96500,	294.64500,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-1749.38000,	865.15800,	24.14550,	4152.66000,	0,	""},
	{-1815.84000,	618.67800,	34.29890,	365.67300,	-10.71320,	1000.87000,	-0.10001,	9,	365.67300,	-11.61320,	1000.87000,	-1814.64000,	615.40200,	34.29890,	208.00000,	0,	"FDCHICK"},
	{-1887.43000,	749.59200,	44.46580,	441.98200,	-52.21990,	998.68900,	180.00000,	6,	441.98200,	-49.91990,	998.68900,	-1890.11000,	749.59200,	44.46580,	3691.82000,	0,	"REST2"},
	{-2270.46000,	-155.95700,	34.35730,	774.21400,	-48.92430,	999.68800,	0.00000,	6,	774.21400,	-50.02430,	999.68800,	-2269.46000,	-155.95700,	34.35730,	270.00000,	0,	"GYM2"},
	{-2625.85000,	208.34500,	3.98935,	286.14900,	-40.64440,	1000.57000,	-0.10001,	1,	286.14900,	-41.54440,	1000.57000,	-2625.85000,	209.14300,	3.98935,	5400.06000,	0,	"AMMUN1"},
	{-2671.53000,	258.34400,	3.64932,	365.67300,	-10.71320,	1000.87000,	-0.10001,	9,	365.67300,	-11.61320,	1000.87000,	-2671.53000,	259.14100,	3.64932,	5400.06000,	0,	"FDCHICK"},
//	{-2454.44000,	-135.87900,	25.22230,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-2455.44000,	-135.87900,	25.22230,	90.00000,	0,	"SVSFMD"},
//	{-2425.94000,	337.87000,	35.99700,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-2424.94000,	337.37000,	35.99700,	-118.00000,	0,	"SVHOT1"},
	{-2571.18000,	246.69800,	9.64213,	418.65300,	-82.63980,	1000.96000,	0.00000,	3,	418.65300,	-84.13980,	1000.96000,	-2570.18000,	245.49800,	9.34213,	-138.00000,	0,	"BARBER2"},
	{-2463.06000,	132.28700,	34.19800,	452.49000,	-18.17970,	1000.18000,	90.00000,	1,	452.89000,	-18.17970,	1000.18000,	-2462.06000,	133.28700,	34.19800,	5359.06000,	0,	"FDREST1"},
	{-2551.79000,	193.77800,	5.21905,	493.39100,	-22.72280,	999.68700,	0.00000,	17,	493.39100,	-24.92280,	999.68700,	-2553.79000,	193.77800,	5.21905,	105.00000,	0,	"BAR1"},
	{-2336.95000,	-166.64600,	34.35730,	363.41300,	-74.57870,	1000.55000,	-45.30000,	10,	363.11300,	-74.87870,	1000.55000,	-2335.95000,	-166.64600,	34.35730,	270.00000,	0,	"FDBURG"},
	{-2491.98000,	-29.10650,	24.81700,	203.77800,	-48.49240,	1000.80000,	0.00000,	1,	203.77800,	-49.89240,	1000.80000,	-2494.48000,	-29.10650,	24.81700,	90.00000,	0,	"LACS1"},
	{-2491.98000,	-38.95870,	24.81700,	-204.44000,	-8.46960,	1001.30000,	0.00000,	17,	-204.44000,	-9.16960,	1001.30000,	-2494.48000,	-38.95870,	24.81700,	90.00000,	0,	"TATTO2"},
//	{-2027.73000,	-40.54880,	37.82630,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-2027.83000,	-44.04540,	37.02630,	4139.70000,	0,	"SVSFBG"},
	{-2242.69000,	-88.25580,	34.35780,	501.98100,	-69.15020,	997.83500,	180.00000,	11,	501.98100,	-67.75020,	997.83500,	-2245.38000,	-88.25580,	34.35780,	3691.82000,	0,	"BAR2"},
//	{-2700.32000,	820.30800,	48.99900,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-2700.32000,	818.68600,	48.99900,	-180.00000,	0,	"SVSFSM"},
	{-2375.32000,	910.29300,	44.45780,	207.73800,	-109.02000,	1004.27000,	0.00000,	15,	207.73800,	-111.42000,	1004.27000,	-2377.32000,	909.29300,	44.45780,	5507.58000,	0,	"CSCHP"},
	{-2356.48000,	1008.01000,	49.90360,	363.41300,	-74.57870,	1000.55000,	-45.30000,	10,	363.11300,	-74.87870,	1000.55000,	-2356.48000,	1005.14000,	49.90360,	-180.00000,	0,	"FDBURG"},
	{-2524.11000,	1216.16000,	36.44960,	459.35100,	-110.10500,	998.71800,	0.00000,	5,	459.35100,	-111.00500,	998.71800,	-2521.86000,	1216.16000,	36.44960,	-90.00000,	0,	"DINER2"}
};

stock static buildings_cached_pickups[MAX_CACHED_PICKUPS];
stock static bool:buildings_player_enex_cooldowns[MAX_PLAYERS];

forward buildings_SetPlayerEnExCooldown(playerid);

stock buildings_OnGameModeInit(){
	DisableInteriorEnterExits();

	for(new i; i < sizeof(buildings_data); i++){
		/*
		 * creates two pickups and caches their pickup id to reference the current enex marker in buildings_data, entry and exit pickup respectively
		*/
		buildings_cached_pickups[CreatePickup(ENEX_MARKER_MODEL_ID, 1, buildings_data[i][ENTRY_PICKUP_X], buildings_data[i][ENTRY_PICKUP_Y], buildings_data[i][ENTRY_PICKUP_Z], 0)] = i;
		buildings_cached_pickups[CreatePickup(ENEX_MARKER_MODEL_ID, 1, buildings_data[i][EXIT_PICKUP_X], buildings_data[i][EXIT_PICKUP_Y], buildings_data[i][EXIT_PICKUP_Z], i+1)] = i; //last argument is the pickup's virtual world, offset by 1;
	}
	return 1;
}

stock buildings_OnGameModeExit(){
	for(new i; i < sizeof(buildings_cached_pickups); i++){
		DestroyPickup(i);
	}
	return 1;
}

stock buildings_OnPlayerConnect(playerid){
	for(new i; i < sizeof(buildings_data); i++){
		SetPlayerMapIcon(playerid, i, buildings_data[i][ENTRY_PICKUP_X], buildings_data[i][ENTRY_PICKUP_Y], buildings_data[i][ENTRY_PICKUP_Z], 37, 0, MAPICON_LOCAL);
	}
	buildings_player_enex_cooldowns[playerid] = false;
	return 1;
}

stock buildings_OnPlayerPickUpPickup(playerid, pickupid){
	if(buildings_player_enex_cooldowns[playerid] == false){
		/*
		 * due to the way enex markers are/will be scripted, players will be teleported immediately upon picking up the enex pickup
		 * buildings_player_enex_cooldowns is then used to store whether or not a player can be teleported again when inside an enex marker
		 * this prevents cases where a player will be continuously teleported while inside an enex marker
		*/
		buildings_player_enex_cooldowns[playerid] = true;
		SetTimerEx("buildings_SetPlayerEnExCooldown", ENEX_TELEPORT_COOLDOWN, false, "i", playerid);

		if(GetPlayerVirtualWorld(playerid) == 0){
			SetPlayerPos(playerid, buildings_data[buildings_cached_pickups[pickupid]][ENTRY_TARGET_X], buildings_data[buildings_cached_pickups[pickupid]][ENTRY_TARGET_Y], buildings_data[buildings_cached_pickups[pickupid]][ENTRY_TARGET_Z] + 1.5);
			SetPlayerFacingAngle(playerid, buildings_data[buildings_cached_pickups[pickupid]][ENTRY_TARGET_FACING_ANGLE]);
			SetPlayerInterior(playerid, buildings_data[buildings_cached_pickups[pickupid]][ENTRY_TARGET_INTERIOR_ID]);
			SetPlayerVirtualWorld(playerid, buildings_cached_pickups[pickupid]+1); //virtual world is equal to the index of the building + 1 since the default virtual world is 0, so building 0' virtual world is 1
		}
		else {
			SetPlayerPos(playerid, buildings_data[buildings_cached_pickups[pickupid]][EXIT_TARGET_X], buildings_data[buildings_cached_pickups[pickupid]][EXIT_TARGET_Y], buildings_data[buildings_cached_pickups[pickupid]][EXIT_TARGET_Z] + 1.5);
			SetPlayerFacingAngle(playerid, buildings_data[buildings_cached_pickups[pickupid]][EXIT_TARGET_FACING_ANGLE]);
			SetPlayerInterior(playerid, buildings_data[buildings_cached_pickups[pickupid]][EXIT_TARGET_INTERIOR_ID]);
			SetPlayerVirtualWorld(playerid, 0); 
		}
		SetCameraBehindPlayer(playerid);
	}
	return 1;
}

public buildings_SetPlayerEnExCooldown(playerid){
	buildings_player_enex_cooldowns[playerid] = false;
}
