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

stock buildings_OnPlayerConnect(playerid){
	SendClientMessage(playerid, 0xffffffff, "Sucessfully hooked on player connect!");
	return 1;
}
