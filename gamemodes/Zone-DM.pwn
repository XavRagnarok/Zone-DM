#include <a_samp> // main SA-MP include
#include <crashdetect> // crash detect to disable long callback warnings

// Configuration
#define SSCANF_NO_NICE_FEATURES
#define YSI_NO_HEAP_MALLOC

// YSI
#include <YSI_Coding\y_timers>
#include <YSI_Coding\y_hooks>
#include <foreach> // standalone compiles quicker



// GeoIP
#include <geolocation> // gets player country | Edited the include to fit the needs for this server

// Plugins
#include <a_mysql> // Currently its R41-4.
#include <bcrypt> // Bcrypt is the best way of encrypting passwords.
#include <streamer> // streamer objects, areas and more
#include <sscanf2> // make it easier to detect params
#include <chrono>


// Extras
#include <izcmd> // I-ZCMD

#pragma warning disable 239 // disable non-const string passed on a const parameter
#pragma dynamic 6000 // increasing stack/heap size


//Defining MySQL stuff here
#define DB_HOST "localhost"
#define DB_NAME "savlinerpg"
#define DB_USER "root"
#define DB_PASS ""

new MySQL:handle; // This connection handle of data type MySQL is required to carry out Mysql operations.