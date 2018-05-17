#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS 50

#include <Pawn.CMD>
#include <sscanf2>
#include <a_mysql>
#include <easyDialog>
#include <foreach>
#include <fixes2>

enum server_data_enum{
	server_timezone,
	robbers_over_cops

};

new const debug_general = 0;

#include "./players.pwn"
#include "./helper.pwn"
#include "./buildings.pwn"
#include "./commands.pwn"
#include "./sequel.pwn"
#include "./dialogs.pwn"
#include "./world.pwn"
#include "./healthbar.pwn"
#include "./weapons.pwn"
//#include "./.pwn"
//#include "./.pwn"
//#include "./.pwn"


main(){
	print("gamemode started...");
}
