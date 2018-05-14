Dialog:WeaponMenu(playerid, response, listitem, inputtext[]){
    if (response){
        new str[64];
        format(str, 64, "You have selected the '%s'.", inputtext);

        GivePlayerWeapon(playerid, listitem + 22, 500);
        SendClientMessage(playerid, -1, str);
    }
    return 1;
}

public OnDialogPerformed(playerid, dialog[], response, success){
    if (!strcmp(dialog, "WeaponMenu") && IsPlayerInAnyVehicle(playerid)){
        SendClientMessage(playerid, -1, "You must be on-foot to spawn a weapon.");
        return 0;
    }
    return 1;
}


/*for more on dialog processor:
https://github.com/Awsomedude/easyDialog
http://forum.sa-mp.com/showthread.php?t=475838
*/
