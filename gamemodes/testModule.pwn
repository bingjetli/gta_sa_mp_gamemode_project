//testModule

stock testModule_OnPlayerConnect(playerid){
	SendClientMessage(playerid, 0xffffffff, "Sucessfully hooked on player connect!");
	return 1;
}
