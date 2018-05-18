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

combat_OnPlayerDeath(playerid, killerid, reason){
	pdata[playerid][helmet]=0;
	UpdateNametag(playerid, 0, 0);
}


// forward UpdateNametag(playerid,healthp,armorp,afk);
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
	if(armorp!=-1){
		if(armorp==-2) pdata[playerid][helmet]=1;
 		if(pdata[playerid][helmet]) switch (armorp){
			case 96..100: arbar="{FFFFFF}\n";
            case 91..95: arbar="{FFFFFF}{808080}\n";
            case 86..90: arbar="{FFFFFF}{808080}\n";
            case 81..85: arbar="{FFFFFF}{808080}\n";
            case 76..80: arbar="{FFFFFF}{808080}\n";
            case 71..75: arbar="{FFFFFF}{808080}\n";
            case 66..70: arbar="{FFFFFF}{808080}\n";
            case 61..65: arbar="{FFFFFF}{808080}\n";
            case 56..60: arbar="{FFFFFF}{808080}\n";
            case 51..55: arbar="{FFFFFF}{808080}\n";
            case 46..50: arbar="{FFFFFF}{808080}\n";
            case 41..45: arbar="{FFFFFF}{808080}\n";
            case 36..40: arbar="{FFFFFF}{808080}\n";
            case 31..35: arbar="{FFFFFF}{808080}\n";
            case 26..30: arbar="{FFFFFF}{808080}\n";
            case 21..25: arbar="{FFFFFF}{808080}\n";
            case 16..20: arbar="{FFFFFF}{808080}\n";
            case 11..15: arbar="{FFFFFF}{808080}\n";
            case 6..10: arbar="{FFFFFF}{808080}\n";
            case 1..5: arbar="{FFFFFF}{808080}\n";
            case 0: arbar="";
            case -2: arbar="{FFFFFF}\n";
		}
		else switch (armorp){
			case 96..100: arbar="{D3D3D3}\n";
            case 91..95: arbar="{D3D3D3}{808080}\n";
            case 86..90: arbar="{D3D3D3}{808080}\n";
            case 81..85: arbar="{D3D3D3}{808080}\n";
            case 76..80: arbar="{D3D3D3}{808080}\n";
            case 71..75: arbar="{D3D3D3}{808080}\n";
            case 66..70: arbar="{D3D3D3}{808080}\n";
            case 61..65: arbar="{D3D3D3}{808080}\n";
            case 56..60: arbar="{D3D3D3}{808080}\n";
            case 51..55: arbar="{D3D3D3}{808080}\n";
            case 46..50: arbar="{D3D3D3}{808080}\n";
            case 41..45: arbar="{D3D3D3}{808080}\n";
            case 36..40: arbar="{D3D3D3}{808080}\n";
            case 31..35: arbar="{D3D3D3}{808080}\n";
            case 26..30: arbar="{D3D3D3}{808080}\n";
            case 21..25: arbar="{D3D3D3}{808080}\n";
            case 16..20: arbar="{D3D3D3}{808080}\n";
            case 11..15: arbar="{D3D3D3}{808080}\n";
            case 6..10: arbar="{D3D3D3}{808080}\n";
            case 1..5: arbar="{D3D3D3}{808080}\n";
            case 0: arbar="";
		}
		if(armorp!=-2)SetPlayerArmour(playerid, armorp);
	}
	format(ntstring,150,"%s\n%s%s",tname,arbar,hpbar);
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


