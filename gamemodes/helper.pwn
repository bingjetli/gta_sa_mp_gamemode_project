/*
* Helper Functions Module 
* 
* Functions:
*	ClientPrint(playerid, color, message[]);
*		-outputs a message to chat
*	ClientPrintEx(playerid, color, message[], {Float,_}:...);
*		-formats a message and outputs to chat
*		-using -1 as the playerid sends it to all players instead
*	IsValidPlayerID(playerid);
*		- returns 1 if playerid is not -1
*	DebugPrint(playerid, debugvariable, message[]);
*		-outputs a debug message to chat
*		-to turn on debug messages, set debugvariable to 1
*		-debugvariable can be any variable so long as it's set to 1, the messages will show
*		-e.g static const debug_sql = 0;
*			DebugPrint(-1, debug_sql, "this is a debug message");
*			//the above message will only print if debug_sql is set to 1
*			//this allows you to have unique debug messages that can be turned on and off
*	DebugPrintEx(playerid, debugvariable, message[], {Float,_}:...);
*		-outputs a formatted debug message
*/

#define COLOR_MSG_DEBUG 0x5a8f99ff
#define ClientPrintEx(%0,%1,%2,%3) format(clientPrint_string, sizeof(clientPrint_string), %2, %3); if(IsValidPlayerID(%0) == 1) SendClientMessage(%0, %1, clientPrint_string); else SendClientMessageToAll(%1, clientPrint_string)
#define ClientPrint(%0,%1,%2) if(IsValidPlayerID(%0) == 1) SendClientMessage(%0, %1, %2); else SendClientMessageToAll(%1, %2)
#define DebugPrint(%0,%1,%2) if(%1 == 1) ClientPrint(%0, COLOR_MSG_DEBUG, %2)
//#define DebugPrintEx(%0,%1,%2,%3) if(%1 == 1) ClientPrintEx(%0, COLOR_MSG_DEBUG, %2, %3); else gettime()
#define DebugPrintEx(%0,%1,%2,%3); \
if(%1 == 1){ \
format(clientPrint_string, sizeof(clientPrint_string), %2, %3); \
if(IsValidPlayerID(%0) == 1) SendClientMessage(%0, COLOR_MSG_DEBUG, clientPrint_string); \
else SendClientMessageToAll(COLOR_MSG_DEBUG, clientPrint_string); \
}

new clientPrint_string[128];

stock IsValidPlayerID(playerid){
	if(playerid != -1) return 1;
	else return 0;
}
