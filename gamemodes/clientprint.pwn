/*
* Client Print Module
*
* crash course: http://forum.sa-mp.com/showthread.php?t=77000
* 
* messsage type prefix maximum length: 8 + x; where x is extra symbols used to  format the message type
* sends client message to all if playerid not specified
* overflow detection - automatically print another line if client message has reached it's limit
* 
* module development halted due to no way to write the function efficiently
*/

#define CLIENT_PRINT

stock ClientPrint(const message[], {Float,_}:...){
}

stock clientPrint_OnPlayerConnect(playerid){
}
