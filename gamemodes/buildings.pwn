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
	EXIT_TARGET_INTERIOR_ID
};

stock static const buildings_data[][ENUM_BUILDINGS_DATA] = {
	{0.0, 0.0, 0.0, 0.9, 0.9, 0.9, 0.9, 11, 1.1, 1.1, 1.1, 0.1, 0.1, 0.1, 0.1, 0}
};

stock static buildings_cached_pickups[MAX_CACHED_PICKUPS];

stock buildings_OnPlayerConnect(playerid){
	SendClientMessage(playerid, 0xffffffff, "Sucessfully hooked on player connect!");
	return 1;
}
