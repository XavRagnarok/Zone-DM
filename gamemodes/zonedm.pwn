//#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>




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

