#define ClientPrintEx(%0,%1,%2,%3) format(clientPrint_string, sizeof(clientPrint_string), %2, %3); SendClientMessage(%0, %1, clientPrint_string)
#define ClientPrint(%0,%1,%2) \
if(IsValidPlayerID(%0) == 1) SendClientMessage(%0, %1, %2); \
else SendClientMessageToAll(%1, %2)

new clientPrint_string[128];

stock IsValidPlayerID(playerid){
	if(playerid != -1) return 1;
	else return 0;
}
