#define nametag_render_distance 25.0

combat_OnPlayerConnect(playerid){
	pdata[playerid][nametag]=Create3DTextLabel("Namgtag Error", 0xFFFFFFFF, 0.0, 0.0, 0.0, nametag_render_distance, 0, 1);
	Attach3DTextLabelToPlayer(pdata[playerid][nametag], playerid, 0.0, 0.0, 0.1);
	//pdata[playerid][nametagtimer]=SetTimerEx("UpdateNametag",1000,true,"i",playerid);
}

combat_OnPlayerDisconnect(playerid){
	Delete3DTextLabel(pdata[playerid][nametag]);
	//KillTimer(pdata[playerid][nametagtimer]);
}

combat_OnPlayerSpawn(playerid){
	UpdateNametag(playerid, -2);
}

//forward UpdateNametag(playerid,healthp,armorp,afk);
UpdateNametag(playerid,healthp=-1,armorp=-1,afk=-1){
	new ntstring[150],tname[50], hpbar[40], arbar[40];
	format(tname, 50, "%s (%i) {FFFF00}AFK: {FFFFFF}%i{FFFF00}s", pdata[playerid][name],playerid,pdata[playerid][afktime]);
	if(healthp!=-1){
		switch (healthp){
			case 96..100: hpbar="{FF0000}";
            case 91..95: hpbar="{FF0000}{800000}";
            case 86..90: hpbar="{FF0000}{800000}";
            case 81..85: hpbar="{FF0000}{800000}";
            case 76..80: hpbar="{FF0000}{800000}";
            case 71..75: hpbar="{FF0000}{800000}";
            case 66..70: hpbar="{FF0000}{800000}";
            case 61..65: hpbar="{FF0000}{800000}";
            case 56..60: hpbar="{FF0000}{800000}";
            case 51..55: hpbar="{FF0000}{800000}";
            case 46..50: hpbar="{FF0000}{800000}";
            case 41..45: hpbar="{FF0000}{800000}";
            case 36..40: hpbar="{FF0000}{800000}";
            case 31..35: hpbar="{FF0000}{800000}";
            case 26..30: hpbar="{FF0000}{800000}";
            case 21..25: hpbar="{FF0000}{800000}";
            case 16..20: hpbar="{FF0000}{800000}";
            case 11..15: hpbar="{FF0000}{800000}";
            case 6..10: hpbar="{FF0000}{800000}";
            case 1..5: hpbar="{FF0000}{800000}";
            case 0: hpbar="{800000}";
            case -2: hpbar="{FF0000}";
		}
		if(healthp!=-2)SetPlayerHealth(playerid, healthp);
	}
	arbar="armor goes here";
	format(ntstring,150,"%s\n%s\n%s",tname,hpbar,arbar);
	Update3DTextLabelText(pdata[playerid][nametag],GetPlayerColor(playerid),ntstring);
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


