/*
 * Buildings Module
 * 
 ****
 * max buildings = 100
 * constant array of buildings:
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
*/

stock buildings_OnPlayerConnect(playerid){
	new string[32];
	for(new i; i < 10; i++){
		format(string, sizeof(string), "%x", CreatePickup(1242, 1, 0.0, 0.0, 0.0, -1));
		SendClientMessage(playerid, 0xffffffff, string);
	}
	SendClientMessage(playerid, 0xffffffff, "Sucessfully hooked on player connect!");
	return 1;
}
