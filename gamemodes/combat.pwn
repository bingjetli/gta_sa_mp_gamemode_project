#define nametag_render_distance 25.0

combat_OnPlayerConnect(playerid){
	pdata[playerid][nametag]=CreateDynamic3DTextLabel("Namgtag Error", 0xFFFFFFFF, 0.0, 0.0, 0.1, nametag_render_distance, playerid, 1);
	SetTimerEx("UpdateNametag",200,true,"%d",playerid);
}

combat_OnPlayerDisconnect(playerid){
    if(IsValidDynamic3DTextLabel(pdata[playerid][nametag])){
    	DestroyDynamic3DTextLabel(pdata[playerid][nametag]);
	}
	KillTimer(pdata[playerid][nametagtimer]);
}

forward UpdateNametag(playerid);
public UpdateNametag(playerid){

	UpdateDynamic3DTextLabelText(pdata[playerid][nametag], 0xFFFFFFFF, "bigdick");
}



enum weapons_id_enum{
	minigun,
	flamethrower
};

enum weapons_data_enum{
	damage,
	name[25],
	hitstun

};

new wdata[weapons_id_enum][weapons_data_enum];


weapons_AssignName(){
	strins(wdata[minigun][name], "Minigun", 0);
	
}

weapons_AssignDamage(){
    wdata[minigun][damage]=1; //per bullet

}


