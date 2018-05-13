cmd:bigdick(playerid, params[]){
	SendClientMessageToAll(0xFFFFFF,"bigdick");
    return 1;
}
cmd:tp(playerid, params[]){
	new Float:x, Float:y, Float:z;
	if(playerid == 0){
        GetPlayerPos(1, x, y, z);
		SetPlayerPos(0, x,y,z+2);
	}
	GetPlayerPos(0, x, y, z);
	SetPlayerPos(1, x,y,z+2);
	return 1;
}

//alias:bigdick("dickbig", "biggus", "dickus");

cmd:weapons(playerid, params[]){
    //Dialog_Show(playerid, WeaponMenu, DIALOG_STYLE_LIST, "Weapon Menu", "9mm\nSilenced 9mm\nDesert Eagle\nShotgun\nSawn-off Shotgun\nCombat Shotgun", "Select", "Cancel");
    return 1;
}

//command permissions
//https://github.com/urShadow/Pawn.CMD
//summarized below

/*enum (<<= 1)
{
    CMD_ADMIN = 1, // 0b00000000000000000000000000000001
    CMD_MODER,     // 0b00000000000000000000000000000010
    CMD_JR_MODER   // 0b00000000000000000000000000000100
};

new pPermissions[MAX_PLAYERS];

flags:ban(CMD_ADMIN);
cmd:ban(playerid, params[])
{
    // code here
    return 1;
}
alias:ban("block");

flags:kick(CMD_ADMIN | CMD_MODER);
cmd:kick(playerid, params[])
{
    // code here
    return 1;
}

flags:jail(CMD_ADMIN | CMD_MODER | CMD_JR_MODER);
cmd:jail(playerid, params[])
{
    // code here
    return 1;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
    if (!(flags & pPermissions[playerid]))
    {
        printf("player %d doesn’t have access to command '%s'", playerid, cmd);

        return 0;
    }

    return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if(result == -1)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Unknown command.");

        return 0;
    }

    return 1;
}

public PC_OnInit()
{
    const testAdminPlayerId = 1, testModerPlayerId = 2, testJrModerPlayerId = 3, testSimplePlayerId = 4;

    pPermissions[testAdminPlayerId] = CMD_ADMIN | CMD_MODER | CMD_JR_MODER;
    pPermissions[testModerPlayerId] = CMD_MODER | CMD_JR_MODER;
    pPermissions[testJrModerPlayerId] = CMD_JR_MODER;
    pPermissions[testSimplePlayerId] = 0;

    PC_EmulateCommand(testAdminPlayerId, "/ban 4 some reason"); // ok
    PC_EmulateCommand(testModerPlayerId, "/ban 8 some reason"); // not ok, moder doesn’t have access to 'ban'
    PC_EmulateCommand(testModerPlayerId, "/kick 15 some reason"); // ok
    PC_EmulateCommand(testModerPlayerId, "/jail 16 some reason"); // ok, moder can use commands of junior moderator
    PC_EmulateCommand(testJrModerPlayerId, "/jail 23 some reason"); // ok
    PC_EmulateCommand(testSimplePlayerId, "/ban 42 some reason"); // not ok
}*/
