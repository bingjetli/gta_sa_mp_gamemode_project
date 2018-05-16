#define ClientPrint(%0,%1,%2) format(clientPrint_string, sizeof(clientPrint_string), %2, %3); SendClientMessage(%0, %1, %2)

