/* 


							++ ZONE ++

			CREDITs TO

			Ragnarok
*/



#include <a_samp> // main SA-MP include
#include <crashdetect> // crash detect to disable long callback warnings

// Plugins
#include <a_mysql> // Currently its R41-4.
#include <samp_bcrypt> // Bcrypt is the best way of encrypting passwords.
#include <streamer> // streamer objects, areas and more
#include <sscanf2> // make it easier to detect params

// Extras
#include <izcmd> // I-ZCMD
#include <strlib> // String Fuctions
#include <float> 
#include <string>


//Defining MySQL stuff here
#define DB_HOST ""
#define DB_NAME ""
#define DB_USER ""
#define DB_PASS ""

new MySQL:handle; // This connection handle of data type MySQL is required to carry out Mysql operations.

// [===SERVER===]

// public and local variables
#include "./modular/server/variable.pwn"

// server functions
#include "./modular/server/functions.pwn"

// dialogs
#include "./modular/server/dialog.pwn"


// ======[ Player ]=========

// account (load/register/save)
#include "./modular/player/account.pwn"

