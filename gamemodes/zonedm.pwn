//#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>
#include <sscanf2>
#include <a_mysql>






main()
{
	print("\n----------------------------------");
	print("-----Zone dm script journey---------");
	print("----------------------------------\n");
}

//Database establisher:
new ourConnection;

#define SCRIPT_VERSION "Script Adventure 1.0.1.1"

//================MySQL Connection:=========================
 
#define SQL_HOSTNAME "{Fill in}"
#define SQL_USERNAME "{Fill in}"
#define SQL_DATABASE "{Fill in}"
#define SQL_PASSWORD "{Fill in}"
 
//==========================================================


// ========================================================[Modulars]=========================================================

// =======[server]=========

// variables
#include "./modular/server/variable.pwn"

// event.pwn
#include "./modular/server/event.pwn"

// dialogs
#include "./modular/server/dialog.pwn"

// functions
#include "./modular/server/function.pwn"

// =======[player]==========

// event.pwn
#include "./modular/player/event.pwn"

// login/register
#include "./modular/player/account.pwn"
