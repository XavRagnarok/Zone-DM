//#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>
#include <sscanf2>

#define COLOR_WHITE "FFFFFF"
#define COLOR_PINK "a80ec7"






main()
{
	print("\n----------------------------------");
	print("-----Zone dm script journey---------");
	print("----------------------------------\n");
}

#define mysql_host 	"localhost"
#define mysql_user 	"root"
#define mysql_pass 	""
#define mysql_database 	"test_database"


// ========================================================[Modulars]=========================================================

// =======[server]=========

// event.pwn
#include "./modular/server/event.pwn"

// dialogs
#include "./modular/server/dialog.pwn"

// =======[player]==========

// event.pwn
#include "./modular/player/event.pwn"

// login/register
#include "./modular/player/account.pwn"


CMD:jetpack(playerid, params[])
{
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
	{
		return
		SendClientMessage(playerid, COLOR_PINK, "REMOVED YOUR JETPACK")
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	}
	SendClientMessage(playerid, COLOR_PINK, "Enjoy prick and fuck luppino")
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	return 1;
}