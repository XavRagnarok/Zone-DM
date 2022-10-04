
/*
================================================================================================================================
  													 SCRIPTER AND OWNER : Mouiz (aka) MG.K0P
	 _     _       _              _     ______             _                _______              ______
	| |   | |     (_)_           | |   / _____)           (_)              (_______)            (_____ \
	| |   | |____  _| |_  ____ _ | |  | /  ___  ____ ____  _ ____   ____    _____ ____ ____ ____ _____) ) ___   ____ ____
	| |   | |  _ \| |  _)/ _  ) || |  | | (___)/ _  |    \| |  _ \ / _  |  |  ___) ___) _  ) _  |_____ ( / _ \ / _  |    \
	| |___| | | | | | |_( (/ ( (_| |  | \____/( ( | | | | | | | | ( ( | |  | |  | |  ( (/ ( (/ /      | | |_| ( ( | | | | |
	 \______|_| |_|_|\___)____)____|   \_____/ \_||_|_|_|_|_|_| |_|\_|| |  |_|  |_|   \____)____)     |_|\___/ \_||_|_|_|_|
	                                                              (_____|
                                                              
                                                    		Skype: mouizghouri25
================================================================================================================================
*/

//==============================================================================
//================================(INCLUDES)====================================
//==============================================================================
#include <a_samp>
#include <YSI\y_ini>
#include <y_ini>
#include <a_mysql>
#include <streamer>
#include <sscanf2>
#include <foreach>
#include <mSelection>
#include <crashdetect>
#include <zcmd>
#include <a_players>
#include <a_vehicles>
#include <float>

/////////////////////////////// OTHERS /////////////////////////////////////////
#include <core>
#include <GetVehicleColor>
#include <vehicleutil>
#include <dini>
#include <strlib>
#include <gl_common>
////////////////////////////////////////////////////////////////////////////////
native WP_Hash(buffer[],len,const str[]);
//==============================================================================
//================================(DEFINES)=====================================
//==============================================================================
//------------------------------------------------------------------------------
#define YSI_IS_SERVER
//------------------------------------------------------------------------------
#define WEAPON_BODY_PART_TORSO 3
#define WEAPON_BODY_PART_CHEST 4
#define WEAPON_BODY_PART_LEFT_ARM 5
#define WEAPON_BODY_PART_RIGHT_ARM 6
#define WEAPON_BODY_PART_LEFT_LEG 7
#define WEAPON_BODY_PART_RIGHT_LEG 8
#define WEAPON_BODY_PART_HEAD 9
//------------------------------------------------------------------------------
#define DIALOG_REGISTER 1
#define DIALOG_LOGIN 2
#define DIALOG_SUCCESS_1 3
#define DIALOG_SUCCESS_2 4
#define DIALOGID 1337
#define DIALOG_VID        	4
#define neondialog 8131
#define DIALOG_WELCOME 2
#define DIALOG_REPORTS 5
//------------------------------------------------------------------------------
#define COL_WHITE "{FFFFFF}"
#define COL_YELLOW "{FFFF00}"
#define COL_RED "{F81414}"
#define COL_GREEN "{00FF00}"
#define COL_AQUA "{00FFFF}"
#define COL_LIGHTBLUE "{00CED1}"
//------------------------------------------------------------------------------
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xFF0000FF
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_FADE1 0xE6E6E6E6
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_FADE5 0x6E6E6E6E
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_DARKBLUE 0x2641FEAA
#define COLOR_ALLDEPT 0xFF8282AA
#define COLOR_LIME 0x10F441AA
#define COLOR_GREENZ 0x30F114FF
#define COLOR_BLUE 0x0000BBAA
#define White 0xFFFFFFFF
#define Red 0xFF0000FF
#define Blue 0x0000FFFF
#define Yellow 0xFFFF00FF
#define Green 0x00FF00
#define Black 0x000000FF
#define Orange 0xFF9900FF
#define Gray 0xA1A1A1FF
#define Pink 0xFF33CCFF
#define ECHO_COLOR 0xEEEEEEFF
#define COLOR_AQUA 0x00FFFFFF
#define GREEN 0x33ff33ff
#define BAN 0xFF9562FF
#define dred 0xA00000FF
#define ECHO_COLOR 0xEEEEEEFF
#define LightCoral 0xF08080FF
#define LightYellow 0xFFFFE0FF
#define GreenYellow 0xADFF2FFF
//------------------------------------------------------------------------------
#define ACTION_COLOR 0xEE66EEFF
#define MESSAGE_COLOR 0xEEEEEEFF
#define COLOR_MESSAGE_YELLOW 0xFFDD00AA
#define CONNECT_MESSAGES_COLOR 0x00FF00
//------------------------------------------------------------------------------
#define ReadCommandsColor 0x33ff33ff
#define ReadPmsColor 0x33ff33ff
//------------------------------------------------------------------------------
#define RespawnVehicle();
//------------------------------------------------------------------------------
#if !defined IGNORE_VEHICLE_DELETION
new bool:gDialogCreated[ MAX_VEHICLES ] = { false, ... };
#endif
//------------------------------------------------------------------------------
#define VipChatKey 			 '*'
#define AdminChatKey         '#'
#define LevelAdminChatKey    '@'
//------------------------------------------------------------------------------
#define MAX_REPORTS 15
#define COUNTRANGE 30
#define MAX_OBJECT_DESTROY_DISTANCE 100
//------------------------------------------------------------------------------
#define DEFAULT_RESPAWN_TIME   700
#define MAX_COUNTDOWN_TIME     30
//------------------------------------------------------------------------------
#define ANNOUNCES_TIME      6000
//------------------------------------------------------------------------------
#define DialogColors 1
#define GAMETEXT_COLOR 2
//------------------------------------------------------------------------------
#define NUM_SI_VEHICLES             6
//------------------------------------------------------------------------------
#define TUBE		(0)
#define COVER		(1)
#define LIGHT		(2)
#define SUPPORT		(3)

#define TBR_RED		(0)
#define TBR_GREEN	(1)
#define TBR_BLUE	(2)
#define TBR_YELLOW	(3)
#define TBR_PURPLE	(4)
//------------------------------------------------------------------------------
#pragma tabsize 0
//------------------------------------------------------------------------------
#define FStrcat(%0,%1,%2) format(String, sizeof(String),%1,%2) && strcat(%0, String)
//------------------------------------------------------------------------------
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
//------------------------------------------------------------------------------
#define HOLDING(%0) \
    ((newkeys & (%0)) == (%0))

#define RELEASED(%0) \
    (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
//------------------------------------------------------------------------------
#define ADMIN_SPEC_TYPE_NONE 0
#define ADMIN_SPEC_TYPE_PLAYER 1
#define ADMIN_SPEC_TYPE_VEHICLE 2

//------------------------------------------------------------------------------
// [IMPORTANT] Enter the MySQL database details
#define    MYSQL_HOST        ""
#define    MYSQL_USER        ""
#define    MYSQL_DATABASE    ""
#define    MYSQL_PASSWORD    ""

//------------------------------------------------------------------------------
// Enter website details (if any) otherwise leave 'empty'.
#define    FORUM_URL         "yourforum.com"
#define    WEBSITE_URL       "yourwebsite.com"

//------------------------------------------------------------------------------
// Set SECOND_RCON to '0' if you want to disable it.
#define SECOND_RCON                      1
#define SECOND_RCON_PASSWORD     "YourSecondRCON"

//------------------------------------------------------------------------------
// Set the values '0' or '1' to customize
// These will change the server configuration.
#define SET_RCON             1
#define SET_MAPNAME          1
#define SET_HOSTNAME         1
#define SET_LANGUAGE         1
#define SET_GAMEMODETEXT     1

//------------------------------------------------------------------------------
// If the server configuration for the certain value is true, it will replace
// its value with the specified value from the script.
#define HOSTNAME             "UGF - United Gaming FreeRoam"
#define HOSTNAME_TWO         "UGF - FreeRoam/Stunt/DM/Race/Derby"
#define MAPNAME              "UGF Build 14"
#define RCON_PASSWORD        "YourRCON"
#define LANGUAGE             "English"
#define GAMEMODETEXT         "FreeRoam/DM/Race/Derby"

//------------------------------------------------------------------------------
// Just an automatic method to add a tag (may be helpful in some cases).
#define AUTO_HOSTNAME        1
#define HOSTNAME_TAG         "[Anytag.com]"
#define HOSTNAME_DELAY       0

////////////////////////////////////////////////////////////////////////////////

//==============================================================================
//================================(FORWARDS)====================================
//==============================================================================

forward SetHostName();
forward Hostname();
forward KickPlayer(playerid);
forward JumpTimer(playerid);
forward DuelRequestTimer(playerid);
forward MinigunFightStart();
forward MinigunFightEnd();
forward Dialog(playerid);
forward ServerRestart();
forward IsSIInfernus(vehicleid);
forward ShowVehicleNameForPlayer(playerid);
forward Counting(playerid);
forward SendMSG();
forward JumpTimer(playerid);
forward superman(playerid);
forward DestroyMe(objectid);
forward Jav(playerid);
forward Float:SetPlayerToFacePos(playerid, Float:X, Float:Y);
forward GetClosestPlayer(p1);
forward Float:GetDistanceBetweenPlayers(p1, p2);
forward LoadUser_data(playerid);
forward ColorChanger(playerid);
forward CountDown();
forward Unjail(playerid);
forward muteTimer(playerid);
forward jailTimer(playerid);
forward ProxDetector(Float:radi, playerid, str[], col1, col2, col3, col4, col5);
forward MoveObjectUp(playerid); MoveObjectDown(playerid); MoveObjectForward(playerid); MoveObjectBack(playerid); MoveObjectRight(playerid); MoveObjectLeft(playerid);
forward SendMSG();
forward ServerIn(name[], value[]);
forward AutoFix();
forward Respawn(playerid);
forward AFKReset(playerid);

////////////////////////////////////////////////////////////////////////////////

//==============================================================================
//================================(ENUMS)=======================================
//==============================================================================

enum ReportData
{
	Reason[128],
	ReportedID,
	InUse,
	ReportTime
}

enum Duel
{
	InDuel,
	DuelID,
	WeaponOne,
	WeaponTwo,
	WeaponThree,
	Float: Health,
	Float: Armour,
	Rounds,
	TotalRounds,
	Float:DuelPos_X,
    Float:DuelPos_Y,
    Float:DuelPos_Z,
    Float:DuelPos_Angle,
	RoundsWon
};

enum WInfo
{
	WeaponName[800],
	WeaponID
};

enum pInfo
{
    pPass[129],
    pAdmin,
    pVip,
    pScore,
    pSkin,
    pBan,
    pIP[16],
    pKills,
    pDeaths,
    pWeather,
    pMuted,
    MuteTime,
    pPm,
    Jail,
    Freeze,
	Banned,
	Invisible,
	Warn,
	Gos,
	Pms,
	pLogged,
	pDeathmatchScore,
	Accountid,
	Hide,
	MuteC,
	JailC,
	BanC,
	SlapC,
	ExplodeC,
	KickC,
	WeaponRC,
	DisarmC,
	FreezeC,
	Usingskin,
	pColor,
	MW,
	FightStyles,
	CMS,
	mBan,
	FailedLog,
	New,
	MinigunFight,
	Float: posX,
	Float: posY,
	Float: posZ,
	Float: posAngle,
	Spawn,
	SpawnInterior,
	DuelScore,
	Time,
	Weather,
	VW,
	TotalScore,
	Rms,
	JFR,
	JDM,
	JailTime,
	aCMS
};

enum sAcc
{
    Announce,
	ReadPms,
	MaxPing,
	ReadCmds,
	AutoLog,
	sLocked,
	sPass[129],
	Chat,
	ReporterName[MAX_PLAYER_NAME],
	TargetName[MAX_PLAYER_NAME],
	Reason[128],
	Accountid,
	MinigunFight,
	Locked
};

enum ColorsVars
{
        ColorName[16],
        ColorID[7]
};

enum PlayerB
{
	BalloonPlayer
};

////////////////////////////////////////////////////////////////////////////////
//==============================================================================
//================================(NEWS)========================================
//==============================================================================

new
MySQL:mysql,
counts,
Camera,
General,
vehicle,
CFCTimer,
HostName,
CountTimer,
LastReport,
PirateShip,
PirateRopes,
String[160],
PirateFence,
PirateObject,
AutoFixTimer,
CountDownTimer,
mysqlconnected,
fr[MAX_PLAYERS],
AFK[MAX_PLAYERS],
rpg[MAX_PLAYERS],
ServerInfo[sAcc],
God[MAX_PLAYERS],
CountDownVar = 4,
rvc[MAX_PLAYERS],
indm[MAX_PLAYERS],
Anim[MAX_PLAYERS],
Text:InfoTextdraw,
Count[MAX_PLAYERS],
Siren[MAX_VEHICLES],
Jumped[MAX_PLAYERS],
JTimer[MAX_PLAYERS],
Text:ChangeColor[66],
minigun[MAX_PLAYERS],
CheckID[MAX_PLAYERS],
headshot[MAX_PLAYERS],
pweather[MAX_PLAYERS],
MegaJump[MAX_PLAYERS],
MuteTimer[MAX_PLAYERS],
IsJumping[MAX_PLAYERS],
Javelin[MAX_PLAYERS][2],
loggedcash[MAX_PLAYERS],
DDM2Pickup[MAX_PLAYERS],
bool:inJail[MAX_PLAYERS],
RVColorTimer[MAX_PLAYERS],
SirenObject[MAX_VEHICLES],
VehicleModel[MAX_PLAYERS],
AFKCheckTimer[MAX_PLAYERS],
PlayerVehicle[MAX_PLAYERS],
SIInfernus[NUM_SI_VEHICLES],
DuelInfo[MAX_PLAYERS][Duel],
Float:JavPos[MAX_PLAYERS][3],
ControllingShip[MAX_PLAYERS],
Text3D:MostWanted[MAX_PLAYERS],
PlayerInfo[MAX_PLAYERS][pInfo],
PlayerIn[MAX_PLAYERS][PlayerB],
ReportInfo[MAX_REPORTS][ReportData],

Text:Press,

Boats = mS_INVALID_LISTID,////////
Bikes = mS_INVALID_LISTID,////////
OffRoad = mS_INVALID_LISTID,//////
Saloons = mS_INVALID_LISTID,//////
Trailers = mS_INVALID_LISTID,/////
Lowriders = mS_INVALID_LISTID,////
Airplanes = mS_INVALID_LISTID,////
Industrial = mS_INVALID_LISTID,///
RCVehicles = mS_INVALID_LISTID,///
Helicopters = mS_INVALID_LISTID,//
PublicService = mS_INVALID_LISTID,
SportsVehicles = mS_INVALID_LISTID,
UniqueVehicles = mS_INVALID_LISTID,

Nam[MAX_PLAYER_NAME],pname[MAX_PLAYER_NAME],
Balloon[MAX_PLAYERS], TimerUP[MAX_PLAYERS], TimerDown[MAX_PLAYERS], TimerForward[MAX_PLAYERS], TimerBack[MAX_PLAYERS], TimerRight[MAX_PLAYERS], TimerLeft[MAX_PLAYERS],

gSpectateID[MAX_PLAYERS],
gSpectateType[MAX_PLAYERS],
Spectating[MAX_PLAYERS],
BeingSpectated[MAX_PLAYERS],
Spectator[MAX_PLAYERS],

ColorsTag[][ColorsVars] =
{
        {"Green",  "00FF00"},
        {"Red",    "FF0000"},
        {"White",  "FFFFFF"},
        {"Blue",   "0000FF"},
        {"Yellow", "FFFB00"},
        {"Orange", "FFA600"},
        {"Grey",   "B8B8B8"},
        {"Purple", "7340DB"},
        {"Pink",   "FF00EE"}
},

Float:FreeRoamSpawns[][4] =
{
    {-1680.1483,706.0532,30.6016, 90.9011},
    {2326.8718,1418.8845,46.5000,361.5000},
    {414.2667,2532.2817,19.1503, 57.8441},
    {380.3011,2541.5667,19.0441,180.0454},
    {-1244.9955,38.8172,16.0978,136.3519},
    {1614.3766,1163.5206,15.2188,4.0223}
},

Float:DDMRandomSpawn[][4] =
{
    {1279.0927,-21.1429,1001.0156,0.8441},
    {1286.0604,-50.5790,1002.4958,87.9750},
    {1260.7362,-34.2639,1001.0234,356.1908},
    {1250.9199,5.9872,1008.2578,268.7701},
    {1251.7133,-13.4610,1001.0342,266.8900}
},

Float:SDMRandomSpawn[][4] =
{
    {2227.2725,-1150.5098,1029.7969,357.4864},
    {2236.0046,-1158.0759,1029.7969,269.7291},
    {2247.8481,-1181.2086,1031.7969,177.2949},
    {2235.8110,-1168.4479,1029.7969,269.3925},
    {2243.9026,-1189.0018,1029.7969,85.4641}
},

Float:SOSRandomSpawn[][4] =
{
    {1412.6399,-1.7875,1000.9244,92.5395},
    {1413.1160,-44.3621,1000.9224,88.4661},
    {1361.5558,-44.6068,1000.9238,271.7444},
    {1361.5341,-0.1599,1000.9219,265.7913},
    {1384.5267,-16.1584,1000.9227,263.9111}
},

Float:DDM2RandomSpawn[][4] =
{
    {1412.6399,-1.7875,1000.9244,95.5046},
    {1412.7356,-42.7349,1000.9214,89.5512},
    {1363.8529,-42.1017,1000.9207,270.9495},
    {1367.4900,-1.9307,1000.9219,268.4427},
    {1376.3285,5.5885,1008.1563,180.7087},
    {1360.5225,5.7252,1008.1563,270.0095},
    {1417.4778,5.5200,1007.8883,94.5413},
    {1417.4141,-43.9291,1007.8929,358.3470}
},

Float:SCRRandomSpawn[][4] =
{
    {-1806.7660,518.9991,234.8906,359.2636},
    {-1771.9962,577.7325,234.8906,116.7647},
    {-1841.7378,578.5939,234.8874,237.6891},
    {-1825.8666,548.8973,234.8874,296.5963},
    {-1788.4109,549.1257,234.8874,61.6175},
    {-1810.0249,579.8763,234.8906,186.3254}
},

Float:JailRandomSpawn[][4] =
{
    {197.9902,161.8680,1003.0300,182.1862},
    {198.0847,174.6620,1003.0234,359.1744},
    {193.8888,174.6461,1003.0234,359.4645}
},

Weapon[][WInfo] =
{
	{"None/Fist", 0},
	{"Brass Knuckle", 1},
	{"Golf Club", 2},
	{"Nigtstick", 3},
	{"Knife", 4},
	{"Baseball Bat", 5},
	{"Shovel", 6},
	{"Pool Cue", 7},
	{"Katana", 8},
	{"Chainsaw", 9},
	{"Purple Dildo", 10},
	{"Dildo", 11},
	{"Vibrator", 12},
	{"Silver Vibrator", 13},
	{"Flowers", 14},
	{"Cane", 15},
	{"Grenade", 16},
	{"Tear Gas", 17},
	{"Molotov Cocktail", 18},
	{"9mm", 22},
	{"Silenced 9mm", 23},
	{"Desert Eagle", 24},
	{"Shotgun", 25},
	{"Sawnoff Shotgun", 26},
	{"Combat Shotgun", 27},
	{"Micro SMG/Uzi", 28},
	{"MP5", 29},
	{"AK-47", 30},
	{"M4", 31},
	{"Tec-9", 32},
	{"Country Rifle", 33},
	{"Sniper Rifle", 34},
	{"RPG", 35},
	{"HS Rocket", 36},
	{"Flametower", 37},
	{"Minigun", 38},
	{"Spraycan", 41},
	{"Fire Extinguisher", 42}

},

WeaponsOne[][2] =
{
	{1,1},
	{2,1},
	{3,1},
	{4,1},
	{5,1},
	{6,1},
	{7,1},
	{8,1},
	{9,1},
	{10,1},
	{11,1},
	{12,1},
	{13,1},
	{14,1},
	{15,1}
},

WeaponsTwo[][2] =
{
	{22,999999},
	{23,999999},
	{24,999999},
	{22,999999}
},

WeaponsThree[][2] =
{
	{25,999999},
	{26,999999},
	{27,999999}
},

WeaponsFour[][2] =
{
	{28,999999},
	{29,999999},
	{32,999999}
},

WeaponsFive[][2] =
{
	{30,999999},
	{31,999999},
	{33,999999},
	{34,999999}
},

RandomMSG[][] =
{
	""COL_WHITE"Currently Updated To "COL_GREEN"UGF Build 14 "COL_WHITE"(0.3.7)",
	""COL_WHITE"Want to get more features? "COL_GREEN"Donate To Become VIP "COL_AQUA"At "COL_RED""FORUM_URL"",
	""COL_AQUA"Join our community forum,stay updated. "COL_WHITE"Visit "COL_RED""FORUM_URL"",
	""COL_AQUA"Use "COL_RED"(/new) "COL_AQUA"command to see the new updates of Build 14",
	""COL_WHITE"Visit "COL_RED""FORUM_URL" "COL_AQUA"for more information about "COL_GREEN"Very Important Player (VIP)"
},

ColorsAvailable[66] = {
        1, 0, 2, 3, 4, 6, 8, 12, 13, 16, 17, 20, 24, 28, 44, 43, 46, 51, 52, 55, 57, 79, 93, 86, 87, 65, 97, 112, 117, 118, 126, 111, 103, 102, 128, 145, 136, 139, 143, 158, 175, 170, 171, 154, 176, 179, 182, 191, 194, 195, 196, 198, 215, 224, 225, 237, 241, 244, 245, 248, 251, 252, 253, 254
},

VehicleNames[212][] = {
		{"Landstalker"},{"Bravura"},{"Buffalo"},{"Linerunner"},{"Perrenial"},{"Sentinel"},{"Dumper"},
		{"Firetruck"},{"Trashmaster"},{"Stretch"},{"Manana"},{"Infernus"},{"Voodoo"},{"Pony"},{"Mule"},
		{"Cheetah"},{"Ambulance"},{"Leviathan"},{"Moonbeam"},{"Esperanto"},{"Taxi"},{"Washington"},
		{"Bobcat"},{"Mr Whoopee"},{"BF Injection"},{"Hunter"},{"Premier"},{"Enforcer"},{"Securicar"},
		{"Banshee"},{"Predator"},{"Bus"},{"Rhino"},{"Barracks"},{"Hotknife"},{"Trailer 1"},{"Previon"},
		{"Coach"},{"Cabbie"},{"Stallion"},{"Rumpo"},{"RC Bandit"},{"Romero"},{"Packer"},{"Monster Truck"},
		{"Admiral"},{"Squalo"},{"Seasparrow"},{"Pizzaboy"},{"Tram"},{"Trailer 2"},{"Turismo"},
		{"Speeder"},{"Reefer"},{"Tropic"},{"Flatbed"},{"Yankee"},{"Caddy"},{"Solair"},{"Berkley's RC Van"},
		{"Skimmer"},{"PCJ-600"},{"Faggio"},{"Freeway"},{"RC Baron"},{"RC Raider"},{"Glendale"},{"Oceanic"},
		{"Sanchez"},{"Sparrow"},{"Patriot"},{"Quad"},{"Coastguard"},{"Dinghy"},{"Hermes"},{"Sabre"},
		{"Rustler"},{"ZR-350"},{"Walton"},{"Regina"},{"Comet"},{"BMX"},{"Burrito"},{"Camper"},{"Marquis"},
		{"Baggage"},{"Dozer"},{"Maverick"},{"News Chopper"},{"Rancher"},{"FBI Rancher"},{"Virgo"},{"Greenwood"},
		{"Jetmax"},{"Hotring"},{"Sandking"},{"Blista Compact"},{"Police Maverick"},{"Boxville"},{"Benson"},
		{"Mesa"},{"RC Goblin"},{"Hotring Racer A"},{"Hotring Racer B"},{"Bloodring Banger"},{"Rancher"},
		{"Super GT"},{"Elegant"},{"Journey"},{"Bike"},{"Mountain Bike"},{"Beagle"},{"Cropdust"},{"Stunt Plane"},
		{"Tanker"}, {"Roadtrain"},{"Nebula"},{"Majestic"},{"Buccaneer"},{"Shamal"},{"Hydra"},{"FCR-900"},
		{"NRG-500"},{"HPV1000"},{"Cement Truck"},{"Tow Truck"},{"Fortune"},{"Cadrona"},{"FBI Truck"},
		{"Willard"},{"Forklift"},{"Tractor"},{"Combine"},{"Feltzer"},{"Remington"},{"Slamvan"},
		{"Blade"},{"Freight"},{"Streak"},{"Vortex"},{"Vincent"},{"Bullet"},{"Clover"},{"Sadler"},
		{"Firetruck LA"},{"Hustler"},{"Intruder"},{"Primo"},{"Cargobob"},{"Tampa"},{"Sunrise"},{"Merit"},
		{"Utility"},{"Nevada"},{"Yosemite"},{"Windsor"},{"Monster Truck A"},{"Monster Truck B"},{"Uranus"},{"Jester"},
		{"Sultan"},{"Stratum"},{"Elegy"},{"Raindance"},{"RC Tiger"},{"Flash"},{"Tahoma"},{"Savanna"},
		{"Bandito"},{"Freight Flat"},{"Streak Carriage"},{"Kart"},{"Mower"},{"Duneride"},{"Sweeper"},
		{"Broadway"},{"Tornado"},{"AT-400"},{"DFT-30"},{"Huntley"},{"Stafford"},{"BF-400"},{"Newsvan"},
		{"Tug"},{"Trailer 3"},{"Emperor"},{"Wayfarer"},{"Euros"},{"Hotdog"},{"Club"},{"Freight Carriage"},
		{"Trailer 3"},{"Andromada"},{"Dodo"},{"RC Cam"},{"Launch"},{"Police Car (LSPD)"},{"Police Car (SFPD)"},
		{"Police Car (LVPD)"},{"Police Ranger"},{"Picador"},{"S.W.A.T. Van"},{"Alpha"},{"Phoenix"},{"Glendale"},
		{"Sadler"},{"Luggage Trailer A"},{"Luggage Trailer B"},{"Stair Trailer"},{"Boxville"},{"Farm Plow"},
		{"Utility Trailer"}
},

AllCarColors[256] = {
        0x000000FF,0xFFFFFFFF,0x55aaa7FF,0xce575bFF,0x58685dFF,0xb06c77FF,0xf8ad38FF,0x7a96acFF,0xdfdec9FF,0x81897aFF,
        0x677776FF,0x93948eFF,0x7e9689FF,0x807c70FF,0xe8eac3FF,0xbab9a5FF,0x73996aFF,0xa54549FF,0xc55063FF,0xd8d5b2FF,
        0x86979eFF,0xa66b67FF,0x8e4556FF,0xcfc3a9FF,0x6c6d65FF,0x5b5a55FF,0xafb295FF,0x77705eFF,0x5a6466FF,0xa89f82FF,
        0x64433aFF,0x73423dFF,0xb5bcb4FF,0xa1a58aFF,0x96947fFF,0x918a6cFF,0x5a5b53FF,0x5b6656FF,0xa8b186FF,0x8d9389FF,
        0x3f3c35FF,0x80765dFF,0x873b3bFF,0x7d3334FF,0x3b5741FF,0x71413dFF,0xaaa176FF,0x89815dFF,0xc2b894FF,0xd6d0b0FF,
        0xa9a98fFF,0x647d67FF,0x849283FF,0x495261FF,0x565b61FF,0x9d846eFF,0xb0af90FF,0xa19273FF,0x7a3138FF,0x5c6c69FF,
        0x9e9c83FF,0x887554FF,0x803c3dFF,0x928f7cFF,0xcfcda7FF,0xd4d27fFF,0x6f534fFF,0xa7ada1FF,0xe1dd9eFF,0xd9b79bFF,
        0xa84645FF,0x96a097FF,0x6f725dFF,0xb6bd93FF,0x764040FF,0x434842FF,0xb0ac89FF,0xb5a778FF,0x8a473fFF,0x375369FF,
        0x9a555aFF,0xaa9c75FF,0xac5359FF,0x56665bFF,0x786151FF,0x995061FF,0x60843cFF,0x72858bFF,0x7c454aFF,0xa7a373FF,
        0xb8b29aFF,0x585e5cFF,0x827f6eFF,0x388a85FF,0x4b6566FF,0x4c5858FF,0xc3c0a1FF,0x97a79aFF,0x80a999FF,0xe1c99dFF,
        0x6e8c8aFF,0x57585cFF,0xd6b98dFF,0x426d80FF,0xa29368FF,0x818274FF,0x3d717fFF,0xb6ab7eFF,0x587482FF,0x696a62FF,
        0x8f7d59FF,0xa3a091FF,0x80948bFF,0x786954FF,0x72866aFF,0xaa4553FF,0x53616aFF,0x8f4f4fFF,0xbfc1b6FF,0x938369FF,
        0xb5a180FF,0x763b41FF,0x747567FF,0x846c50FF,0x914b4dFF,0x38526bFF,0xef87a2FF,0x3c3d38FF,0x6cb85dFF,0x725a4eFF,
        0x78acaaFF,0x987e59FF,0x9b675aFF,0x545d4cFF,0x706c83FF,0x7dc6bdFF,0xcb90c6FF,0x7fca6fFF,0xf7ebc3FF,0x9697abFF,
        0xc3bda3FF,0xbdaf88FF,0xcdbf67FF,0xab8e90FF,0xa28796FF,0xd2ee99FF,0xbd8a93FF,0xaa6a85FF,0x72715cFF,0x665b45FF,
        0x656952FF,0x7e926fFF,0x7398b5FF,0x7da477FF,0x6bcf79FF,0x65c8a9FF,0xe0d59dFF,0xc8c5b4FF,0xde7c5fFF,0x77694cFF,
        0x5d6d49FF,0xd17f74FF,0x6f93b3FF,0x62b79aFF,0x667264FF,0x6aa998FF,0x6daaa5FF,0xaa7faaFF,0x875e4aFF,0xbfb1b0FF,
        0xb4a8acFF,0x987f9dFF,0x686947FF,0x80604bFF,0x8e6c50FF,0xd8685aFF,0xd294a9FF,0xbf9899FF,0xbb839cFF,0x826168FF,
        0xbd825aFF,0xba6254FF,0xd28865FF,0xcf7958FF,0xc88c84FF,0xbba899FF,0x4f5847FF,0x516b48FF,0x6c825bFF,0x677c5bFF,
        0xaa757dFF,0x8dca85FF,0xd4c7a4FF,0xc0bfaaFF,0xdfd249FF,0xbac775FF,0xbdc2a2FF,0xbabb5eFF,0x717caaFF,0x7d7b4aFF,
        0xc1aa74FF,0x536370FF,0x79936cFF,0x606f6cFF,0x798f8dFF,0x515459FF,0x4d585aFF,0x677a76FF,0x7d99a7FF,0x5d7b7dFF,
        0x6f8b8cFF,0x72668aFF,0xac6c53FF,0xd3caadFF,0x98a053FF,0x545945FF,0xcc996eFF,0xa3caafFF,0xd29779FF,0xcc9054FF,
        0xdd888fFF,0xd6c377FF,0xd07151FF,0x596271FF,0x936556FF,0x89864fFF,0x9cd665FF,0x5a765dFF,0xd0b858FF,0x66b758FF,
        0x83605aFF,0xb79153FF,0xc37d9fFF,0xbf6791FF,0x5b7f51FF,0x71894fFF,0x5d7166FF,0xc3919dFF,0xcca470FF,0xaf6c52FF,
        0x77c4a4FF,0x99c556FF,0x9b616fFF,0x63bd63FF,0x7c5d49FF,0x57694fFF,0x809ea8FF,0x748080FF,0x935d5bFF,0x90575eFF,
        0xaaa184FF,0x7d7e70FF,0x716d62FF,0xc9c3a3FF,0x9b907aFF,0x838786FF
},

PlayerColors[200] = {
		0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,
		0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,
		0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,
		0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,0x3D0A4FFF,
		0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,0x057F94FF,
		0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,
		0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,
		0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,
		0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,
		0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,0xDCDE3DFF,
		0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
		0xD8C762FF,0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,
		0xF4A460FF,0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,
		0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,
		0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,
		0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
		0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,
		0x18F71FFF,0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,
		0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,
		0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,
		0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,
		0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,
		0xD8C762FF,0xD8C762FF
};

//==============================================================================
//==============================(FUNCTIONS)=====================================
//==============================================================================

Func_TubeConnector(index, direction, tubetype, tubecolor, modelid, Float:X, Float:Y, Float:Z, Float:RX, Float:RY, Float:RZ, Float:distance, support_dir=0)
{
	#pragma unused distance
	new tube = CreateDynamicObject(modelid, X, Y, Z, RX, RY, RZ);
	switch(tubecolor)
	{
		case 0: SetObjectMaterial(tube, 0, 19659, "MatTubes", "RedDirt1");
		case 1: SetObjectMaterial(tube, 0, 19659, "MatTubes", "GreenDirt1");
		case 2: SetObjectMaterial(tube, 0, 19659, "MatTubes", "BlueDirt1");
		case 3: SetObjectMaterial(tube, 0, 19659, "MatTubes", "YellowDirt1");
		case 4: SetObjectMaterial(tube, 0, 19659, "MatTubes", "PurpleDirt1");
	}
	CallRemoteFunction("OnTubeImported", "ddddddffffffd", tube, index, direction, tubetype, tubecolor, modelid, X, Y, Z, RX, RY, RZ, support_dir); //DELETE THIS LINE ON YOUR SCRIPT, KEEP IN THIS FILE
	return tube;
}

CreatePlayerVehicle(playerid, modelid)
{
	if(GetPlayerInterior(playerid) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				DestroyVehicle(GetPlayerVehicleID(playerid));
			}
		}
		
		if(PlayerVehicle[playerid] != -1)
		{
			DestroyVehicle(PlayerVehicle[playerid]);
		}
	
		new Float:x, Float:y, Float:z, Float:a;
		new vehicleid;
		
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
		vehicleid = CreateVehicle(modelid, x, y, z + 4, a, -1, -1, DEFAULT_RESPAWN_TIME);
		SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
		LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
		PutPlayerInVehicle(playerid, vehicleid, 0);
		PlayerVehicle[playerid] = GetPlayerVehicleID(playerid);
	}
    
    //Vehicle name text
    VehicleModel[playerid] = GetVehicleModel(vehicle);
    ShowVehicleNameForPlayer(playerid);
    gDialogCreated[vehicle] = true;
	return 1;
}

//==============================================================================
//==============================(STATICS)=======================================
//==============================================================================

//==============================================================================
//================================(STOCKS)======================================
//==============================================================================


//===============================(TELEPORTS)====================================

/*
Make A Teleport

stock Teleport(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Teleport (/tele)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Teleport", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
        {
			SetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, x, y, z, angle);
            SetCameraBehindPlayer(playerid);
		}
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

*/

stock Shamal(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Shamal (/shamal)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Shamal", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
        {
			DestroyVehicle(GetPlayerVehicleID(playerid));
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 1);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, 1.6849,25.6091,1199.5938,0.0000);
            SetCameraBehindPlayer(playerid);
		}
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock Andromada(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Andromada (/andromada)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Andromada", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
        {
			DestroyVehicle(GetPlayerVehicleID(playerid));
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 9);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			SetPlayerInterior(playerid, 9);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, 315.745086,984.969299,1958.919067,0.0000);
            SetCameraBehindPlayer(playerid);
		}
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock Ammunation(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Ammunation (/ammunation)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Ammunation", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
        {
			DestroyVehicle(GetPlayerVehicleID(playerid));
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 9);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			SetPlayerInterior(playerid, 9);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, 286.148986,-40.644397,1001.515625,0.0000);
            SetCameraBehindPlayer(playerid);
		}
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}


stock Ammunation2(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Ammunation 2 (/ammunation2)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Ammunation 2", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
        {
			DestroyVehicle(GetPlayerVehicleID(playerid));
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 4);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			SetPlayerInterior(playerid, 4);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, 286.800994,-82.547599,1001.515625);
            SetCameraBehindPlayer(playerid);
		}
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock Ammunation3(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Ammunation 3 (/ammunation3)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Ammunation 3", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
        {
			DestroyVehicle(GetPlayerVehicleID(playerid));
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 6);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			SetPlayerInterior(playerid, 6);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, 296.919982,-108.071998,1001.515625,0.0000);
            SetCameraBehindPlayer(playerid);
		}
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock Ammunation4(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Ammunation 4 (/ammunation4)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Ammunation 4", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
        {
			DestroyVehicle(GetPlayerVehicleID(playerid));
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 7);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			SetPlayerInterior(playerid, 7);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, 314.820983,-141.431991,999.601562,0.0000);
            SetCameraBehindPlayer(playerid);
		}
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock Ammunation5(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Ammunation 5 (/ammunation5)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Ammunation 4", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
        {
			DestroyVehicle(GetPlayerVehicleID(playerid));
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 6);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			SetPlayerInterior(playerid, 6);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, 316.524993,-167.706985,999.593750,0.0000);
            SetCameraBehindPlayer(playerid);
		}
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock AmmunationBooths(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Ammunation Booths (/ammubooth)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Ammunation Booths", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
        {
			DestroyVehicle(GetPlayerVehicleID(playerid));
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 7);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			SetPlayerInterior(playerid, 7);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPos(playerid, 302.292877,-143.139099,1004.062500);
            SetCameraBehindPlayer(playerid);
		}
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock AmmunationRange(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Ammunation Range (/ammurange)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Ammunation Range", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
        {
			DestroyVehicle(GetPlayerVehicleID(playerid));
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 7);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			SetPlayerInterior(playerid, 7);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPos(playerid, 298.507934,-141.647048,1004.054748);
            SetCameraBehindPlayer(playerid);
		}
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock SexShop(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Sex Shop (/ss)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Sex Shop", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
        {
			DestroyVehicle(GetPlayerVehicleID(playerid));
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 3);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			SetPlayerInterior(playerid, 3);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPos(playerid, -103.559165,-24.225606,1000.718750);
            SetCameraBehindPlayer(playerid);
		}
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock MeatFactory(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Meat Factory (/mfactory)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Meat Factory", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
        {
			DestroyVehicle(GetPlayerVehicleID(playerid));
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 1);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPos(playerid, 963.418762,2108.292480,1011.030273);
            SetCameraBehindPlayer(playerid);
		}
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}


stock ToyShop(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Toy Shop (/toyshop)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Toy Shop", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
        {
			DestroyVehicle(GetPlayerVehicleID(playerid));
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 6);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			SetPlayerInterior(playerid, 6);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPos(playerid, -2240.468505,137.060440,1035.414062);
            SetCameraBehindPlayer(playerid);
		}
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock Binco(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Binco (/binco)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Toy Shop", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
        {
			DestroyVehicle(GetPlayerVehicleID(playerid));
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 15);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			SetPlayerInterior(playerid, 15);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPos(playerid, 207.737991,-109.019996,1005.132812);
            SetCameraBehindPlayer(playerid);
		}
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock Army(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Army (/army)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Army", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
        {
			SetVehiclePos(GetPlayerVehicleID(playerid), 364.7011,1925.4058,17.3677);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 94.0860);
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, 295.4167,1820.9354,17.6406,269.0329);
            SetCameraBehindPlayer(playerid);
		}
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock SP(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Stunt Park (/sp)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Stunt Park", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), 2304.6365, 1417.8292, 43.0000);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 356.7083);
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
        else
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, 2326.8718,1418.8845,46.5000 + 3,362.5000);
			SetCameraBehindPlayer(playerid);
		}
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock A51(playerid)
{
		if(PlayerInfo[playerid][Freeze] == 1) return 0;
	    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	    if(fr[playerid] == 1)
	    {
	        if(GetPlayerState(playerid) == 2)
	        {
		        SetVehiclePos(GetPlayerVehicleID(playerid), 135.20, 1948.51, 19.74);
		        SetVehicleZAngle(GetPlayerVehicleID(playerid), 180);
	            LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
		        SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
	        }
	        else
	        {
			    SetPlayerInterior(playerid, 0);
			    SetPlayerPos(playerid, 135.20, 1948.51, 19.74);
			    SetPlayerFacingAngle(playerid, 180);
			    SetCameraBehindPlayer(playerid);
			    GameTextForPlayer(playerid, "~b~~h~Area 51 (69) Base!", 3000, 3);
		    }
	    }
	    else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	    return 1;
}

stock StuntIsland(playerid)
{
        new str[128];
		if(PlayerInfo[playerid][Freeze] == 1) return 0;
	    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	    if(fr[playerid] == 1)
	    {
			SetPlayerInterior(playerid, 0);
	        format(str, sizeof(str), "%s has teleported to Stunt Island (/si)", GetName(playerid));
	        SendClientMessageToAll(GREEN, str);
			if(GetPlayerState(playerid) == 2)
			{
			    SetVehiclePos(GetPlayerVehicleID(playerid), 27.24 + random(2), 3422.45, 6.2);
			    SetVehicleZAngle(GetPlayerVehicleID(playerid), 270);
				LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
				SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
				SetCameraBehindPlayer(playerid);
			}
			else
			{
				SetPlayerPos(playerid, 27.24 + random(2), 3422.45, 6.2);
				SetPlayerFacingAngle(playerid, 270);
				SetPlayerVirtualWorld(playerid, 1);
				SetCameraBehindPlayer(playerid);
			}
			SetCameraBehindPlayer(playerid);
			GameTextForPlayer(playerid, "~b~~h~Stunt Island!", 3000, 3);
		}
		else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	    return 1;
}

stock LSA(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Los Santos Airport (/lsa)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Los Santos Airport", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), 2123.5483,-2455.8967,13.5469);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 94.7889);
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, 2123.5483,-2455.8967,13.5469 + 3,94.7889);
			SetCameraBehindPlayer(playerid);
		}
		SetCameraBehindPlayer(playerid);
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock SFA(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to San Fierro Airport (/sfa)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "San Fierro Airport", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), -1286.5564,67.7631,14.2596);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 44.3686);
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
		}
		else
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, -1244.7754,39.0477,15.2346 + 3,136.3519);
		}
		SetCameraBehindPlayer(playerid);
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock LVA(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Las Venturas Airport(/lva)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Las Venturas Airport", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), 1614.3766,1163.5206,14.2188);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 4.0223);
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
		}
		else
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, 1614.3766,1163.5206,14.2188 + 3,4.0223);
		}
		SetCameraBehindPlayer(playerid);
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock AA(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Abandoned Airport (/aa)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Abandoned Airport", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), 403.8303,2532.9431,16.1163);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 177.8961);
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
		}
		else
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, 380.3011,2541.5667,20.0000 + 3
			,180.0454);
		}
		SetCameraBehindPlayer(playerid);
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock LS(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Los Santos (/ls)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Los Santos", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), 2492.4502,-1666.7139,13.3438);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 92.9679);
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
		}
		else
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, 2492.4502,-1666.7139,13.3438,92.9679);
		}
		SetCameraBehindPlayer(playerid);
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock SF(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to San Fierro (/sf)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "San Fierro", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), -2026.8687,156.8204,29.0391);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 272.9159);
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
		}
		else
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, -2026.8687,156.8204,29.0391,272.9159);
		}
		SetCameraBehindPlayer(playerid);
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock LV(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Las Venturas (/lv)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Las Venturas", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), 2057.9512,842.7324,6.7031);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 3.3427);
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
		}
		else
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, 2057.9512,842.7324,6.7031,3.3427);
		}
		SetCameraBehindPlayer(playerid);
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock CJ(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to CJ's House (/cj)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "CJ's House", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		SetPlayerInterior(playerid, 3);
		SetPlayerVirtualWorld(playerid, 1);
		SetPlayerPosEx(playerid, 2496.0420,-1709.0581,1014.7422,359.5417);
		SetCameraBehindPlayer(playerid);
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock ATD(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Airport Ticket Desk (/atd)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Airpor ticket desk", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		SetPlayerInterior(playerid, 14);
		SetPlayerVirtualWorld(playerid, 1);
		SetPlayerPos(playerid, -1827.147338,7.207417,1061.143554);
		SetCameraBehindPlayer(playerid);
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock WH2(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Warehouse 2 (/wh2)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Warehouse 2", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		SetPlayerInterior(playerid, 1);
		SetPlayerVirtualWorld(playerid, 1);
		SetPlayerPos(playerid,1412.639892,-1.787510,1000.924377);
		SetCameraBehindPlayer(playerid);
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock WH(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Warehouse (/wh)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Warehouse", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		SetPlayerInterior(playerid, 18);
		SetPlayerVirtualWorld(playerid, 1);
		SetPlayerPos(playerid,1302.519897,-1.787510,1001.028259);
		SetCameraBehindPlayer(playerid);
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock Arch(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Arch Angels (/arch)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "Arch Angels", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), -2705.9417,217.3055,3.8848);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 90.5349);
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
		}
		else
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, -2705.9417,217.3055,3.8848,90.5349);
		}
		SetCameraBehindPlayer(playerid);
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock TF(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
		format(str, sizeof(str), "%s has teleported to TransFender (/tf)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "TransFender", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), 2386.9290,1031.2759,10.5923);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 359.8214);
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
		}
		else
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, 2386.9290,1031.2759,10.5923,359.8214);
		}
		SetCameraBehindPlayer(playerid);
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

stock Loco(playerid)
{
	new str[128];
	if(PlayerInfo[playerid][Freeze] == 1) return 0;
	if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	    format(str, sizeof(str), "%s has teleported to Loco Low Co (/loco)", GetName(playerid));
		SendClientMessageToAll(COLOR_GREENZ, str);
		GameTextForPlayer(playerid, "~Loco Low Co", 2300, 6);
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		if(GetPlayerState(playerid) == 2)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), 2645.0000,-2025.0000,13.2720);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 179.6293);
		    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 1);
		}
		else
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerPosEx(playerid, 2644.8276,-2024.9874,13.2715,179.6293);
		}
		SetCameraBehindPlayer(playerid);
	}
	else GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
	return 1;
}

//==============================================================================
//==========================(OTHER STOCKS)======================================
//===============================(&)============================================
//==========================(FUNCTIONS)=========================================

IsBulletWeapon(weaponid)
	return (WEAPON_COLT45 <= weaponid <= WEAPON_SNIPER) || weaponid == WEAPON_MINIGUN;

GetWeaponSlot(weaponid)
{
    switch(weaponid)
    {
        case 1: return 0;
        case 2..9: return 1;
        case 22..24: return 2;
        case 25..27: return 3;
        case 28, 29, 32: return 4;
        case 30, 31: return 5;
        case 33, 34: return 6;
        case 35..38: return 7;
        case 16..18, 39: return 8;
        case 41..43: return 9;
        case 10..15: return 10;
        case 44..46: return 11;
        case 40: return 12;
    }

    return -1;
}

SetPlayerArmedWeaponEx(playerid, weaponid)
{
	SetPVarInt(playerid, "switch_WeaponID", weaponid);
	PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
	return SetPlayerArmedWeapon(playerid, weaponid);
}

stock GetAvailableReport()
{
	for(new i = 0; i < MAX_REPORTS; i++)
	{
	    if(ReportInfo[i][InUse] == 0)
	    {
	        return i;
		}
	}
	
	if(LastReport > MAX_REPORTS)
	{
		new reportid;
        ReportInfo[1][InUse] = 0;
        LastReport = 0;
        
		for(new i = 0; i < MAX_REPORTS; i++)
		{
		    if(ReportInfo[i][InUse] == 0)
		    {
                reportid = i;
			}
		}
		return reportid;
	}
	else return LastReport++;
}

stock Stats(playerid)
{
   	new string2[1024],string[1024],str[1024],
	FightName[30],
	FightStyle = GetPlayerFightingStyle(playerid);
	
	if(FightStyle == FIGHT_STYLE_ELBOW) 	FightName = "Elbow";
	if(FightStyle == FIGHT_STYLE_BOXING) 	FightName = "Boxing";
	if(FightStyle == FIGHT_STYLE_GRABKICK) 	FightName = "Grabkick";
	if(FightStyle == FIGHT_STYLE_KNEEHEAD) 	FightName = "Kneehead";
	if(FightStyle == FIGHT_STYLE_KUNGFU) 	FightName = "Kungfu";
	if(FightStyle == FIGHT_STYLE_NORMAL) 	FightName = "Normal";
	
	format(string, sizeof(string),"\n"COL_GREEN"%s(%d)\n\n",GetName(playerid), playerid);
	strcat(string2,string);
	format(string, sizeof(string),""COL_GREEN"General Info\n");
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Account ID: %d\n", PlayerInfo[playerid][Accountid]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Logged In: %d\n", PlayerInfo[playerid][pLogged]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Admin: %d\n", PlayerInfo[playerid][pAdmin]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- VIP: %d\n\n", PlayerInfo[playerid][pVip]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_GREEN"Scores\n");
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- FreeRoam Score: %d\n", PlayerInfo[playerid][pKills]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Deathmatch Score: %d\n", PlayerInfo[playerid][pDeathmatchScore]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Duel Score: %d\n", PlayerInfo[playerid][DuelScore]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Total Score: %d\n\n", PlayerInfo[playerid][TotalScore]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_GREEN"Game\n");
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Ping: %i\n", GetPlayerPing(playerid));
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Godmode: %d\n", God[playerid]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Fighting Style: %s\n", FightName);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Skin: %d\n", GetPlayerSkin(playerid));
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Duel: %d\n\n", DuelInfo[playerid][InDuel]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_GREEN"Mode\n");
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Freeroam: %d\n", fr[playerid]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Deathmatch: %d\n", indm[playerid]);
	strcat(string2,string);
	format(str,sizeof(str),""COL_GREEN"Stats");
	ShowPlayerDialog(playerid, 2002, DIALOG_STYLE_MSGBOX, str, string2, "OK","");
	return 1;
}

stock StatsEx(playerid)
{
   	new string2[1024],string[1024],str[1024],
	FightName[30],
	FightStyle = GetPlayerFightingStyle(playerid);

	if(FightStyle == FIGHT_STYLE_ELBOW) 	FightName = "Elbow";
	if(FightStyle == FIGHT_STYLE_BOXING) 	FightName = "Boxing";
	if(FightStyle == FIGHT_STYLE_GRABKICK) 	FightName = "Grabkick";
	if(FightStyle == FIGHT_STYLE_KNEEHEAD) 	FightName = "Kneehead";
	if(FightStyle == FIGHT_STYLE_KUNGFU) 	FightName = "Kungfu";
	if(FightStyle == FIGHT_STYLE_NORMAL) 	FightName = "Normal";

	format(string, sizeof(string),"\n"COL_GREEN"%s(%d)\n\n",GetName(playerid), playerid);
	strcat(string2,string);
	format(string, sizeof(string),""COL_GREEN"General Info\n");
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Account ID: %d\n", PlayerInfo[playerid][Accountid]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Logged In: %d\n", PlayerInfo[playerid][pLogged]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Admin: %d\n", PlayerInfo[playerid][pAdmin]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- VIP: %d\n\n", PlayerInfo[playerid][pVip]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_GREEN"Scores\n");
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- FreeRoam Score: %d\n", PlayerInfo[playerid][pKills]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Deathmatch Score: %d\n", PlayerInfo[playerid][pDeathmatchScore]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Duel Score: %d\n", PlayerInfo[playerid][DuelScore]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Total Score: %d\n\n", PlayerInfo[playerid][TotalScore]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_GREEN"Game\n");
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- IP: %s\n", GetIp(playerid));
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Ping: %i\n", GetPlayerPing(playerid));
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Godmode: %d\n", God[playerid]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Fighting Style: %s\n", FightName);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Skin: %d\n", GetPlayerSkin(playerid));
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Duel: %d\n\n", DuelInfo[playerid][InDuel]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_GREEN"Mode\n");
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Freeroam: %d\n", fr[playerid]);
	strcat(string2,string);
	format(string, sizeof(string),""COL_WHITE"- Deathmatch: %d\n", indm[playerid]);
	strcat(string2,string);
	format(str,sizeof(str),""COL_GREEN"Stats");
	ShowPlayerDialog(playerid, 2002, DIALOG_STYLE_MSGBOX, str, string2, "OK","");
	return 1;
}

stock HexToInt(string[])
{
  	if (string[0]==0) return 0;
 	new i;
  	new cur=1;
  	new res=0;
  	for (i=strlen(string);i>0;i--) {
  	  	if (string[i-1]<58) res=res+cur*(string[i-1]-48); else res=res+cur*(string[i-1]-65+10);
    	cur=cur*16;
  	}
  	return res;
}

stock ClearDuel(playerid)
{
	DuelInfo[playerid][InDuel] = 0;
	DuelInfo[playerid][DuelID] = -1;
	DuelInfo[playerid][Rounds] = 0;
	DuelInfo[playerid][RoundsWon] = 0;
	DuelInfo[playerid][TotalRounds] = 0;
	DuelInfo[playerid][Health] = 0;
	DuelInfo[playerid][Armour] = 0;
	DuelInfo[playerid][WeaponOne] = -1;
	DuelInfo[playerid][WeaponTwo] = -1;
	DuelInfo[playerid][WeaponThree] = -1;
	DuelInfo[playerid][DuelPos_X] = 0;
	DuelInfo[playerid][DuelPos_Y] = 0;
	DuelInfo[playerid][DuelPos_Z] = 0;
	DuelInfo[playerid][DuelPos_Angle] = 0;
	return 1;
}

stock SetDuel(playerid)
{
    SetPlayerVirtualWorld(playerid, 1001);
    ResetPlayerWeapons(playerid);
	SetPlayerPos(playerid, DuelInfo[playerid][DuelPos_X],DuelInfo[playerid][DuelPos_Y],DuelInfo[playerid][DuelPos_Z]);
	SetPlayerFacingAngle(playerid, DuelInfo[playerid][DuelPos_Angle]);
	GivePlayerWeapon(playerid, DuelInfo[playerid][WeaponOne], 999999);
	GivePlayerWeapon(playerid, DuelInfo[playerid][WeaponTwo], 999999);
	GivePlayerWeapon(playerid, DuelInfo[playerid][WeaponThree], 999999);
	SetPlayerHealth(playerid, DuelInfo[playerid][Health]);
	SetPlayerArmour(playerid, DuelInfo[playerid][Armour]);
	
	God[playerid] = 0;
	MegaJump[playerid] = 0;
	return 1;
}

stock FR(playerid)
{
    new rand = random(sizeof(FreeRoamSpawns));
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(ServerInfo[MinigunFight] == 1) GivePlayerWeapon(playerid, 38, 999999);
    if(DuelInfo[playerid][InDuel] == 1) DuelInfo[playerid][InDuel] = 0;
    if(minigun[playerid] == 1) GivePlayerWeapon(playerid, 38, 999999);
    if(indm[playerid] >= 1)
    {
        if(indm[playerid] == 2) DestroyDynamicPickup(DDM2Pickup[playerid]);
        indm[playerid] = 0;
	}
    SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 1);
    SetPlayerPos(playerid, FreeRoamSpawns[rand][0], FreeRoamSpawns[rand][1],FreeRoamSpawns[rand][2]);
    SetPlayerFacingAngle(playerid, FreeRoamSpawns[rand][3]);
    SetCameraBehindPlayer(playerid);
    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
    ResetPlayerWeapons(playerid);
    fr[playerid] = 1;
    GameTextForPlayer(playerid,"~g~type ~w~/dm ~g~to change the mode",5000,1);
	return 1;
}

stock GFR(playerid)
{
    if(PlayerInfo[playerid][Jail] == 1) return 0;
    if(ServerInfo[MinigunFight] == 1) GivePlayerWeapon(playerid, 38, 999999);
    if(DuelInfo[playerid][InDuel] == 1) DuelInfo[playerid][InDuel] = 0;
    if(minigun[playerid] == 1) GivePlayerWeapon(playerid, 38, 999999);
    if(indm[playerid] >= 1)
    {
        if(indm[playerid] == 2) DestroyDynamicPickup(DDM2Pickup[playerid]);
        indm[playerid] = 0;
	}
    SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 1);
    fr[playerid] = 1;
	return 1;
}

stock SOS(playerid)
{
					{
                        if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
                        if(PlayerInfo[playerid][Freeze] == 1) return 0;
                        new rand = random(sizeof(SOSRandomSpawn));
						indm[playerid] = 3;
                        fr[playerid] = 0;
                        MegaJump[playerid] = 0;
	        	        SetPlayerHealth(playerid, 100);
	        	        God[playerid] = 0;
	        	        DuelInfo[playerid][InDuel] = 0;
                        SetPlayerArmour(playerid, 0);
				        SetPlayerPos(playerid, SOSRandomSpawn[rand][0], SOSRandomSpawn[rand][1],SOSRandomSpawn[rand][2]);
				        SetPlayerFacingAngle(playerid, SOSRandomSpawn[rand][3]);
				        SetCameraBehindPlayer(playerid);
	        	        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	        	        SetPlayerInterior(playerid, 1);
	        	        SetPlayerVirtualWorld(playerid, 4);
	        	        ResetPlayerWeapons(playerid);
						GivePlayerWeapon(playerid, 26, 999999);
	    				GameTextForPlayer(playerid,"~g~type ~w~/fr ~g~to exit",5000,1);
					}
	                if(minigun[playerid] == 1) return GivePlayerWeapon(playerid, 38, 999999);
                    return 1;
}

stock GSOS(playerid)
{
					{
                        if(PlayerInfo[playerid][Jail] == 1) return 0;
                        if(PlayerInfo[playerid][Freeze] == 1) return 0;
						indm[playerid] = 3;
                        fr[playerid] = 0;
                        MegaJump[playerid] = 0;
	        	        SetPlayerHealth(playerid, 100);
	        	        God[playerid] = 0;
                        SetPlayerArmour(playerid, 0);
	        	        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	        	        SetPlayerInterior(playerid, 1);
	        	        SetPlayerVirtualWorld(playerid, 4);
	        	        ResetPlayerWeapons(playerid);
						GivePlayerWeapon(playerid, 26, 999999);
	    				GameTextForPlayer(playerid,"~g~type ~w~/fr ~g~to exit",5000,1);
					}
                    return 1;
}

stock DDM2(playerid)
{
					{
                        if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
                        if(PlayerInfo[playerid][Freeze] == 1) return 0;
                        new rand = random(sizeof(DDM2RandomSpawn));
						indm[playerid] = 4;
                        fr[playerid] = 0;
                        MegaJump[playerid] = 0;
                        DuelInfo[playerid][InDuel] = 0;
	        	        SetPlayerHealth(playerid, 100);
	        	        God[playerid] = 0;
                        SetPlayerArmour(playerid, 0);
				        SetPlayerPos(playerid, DDM2RandomSpawn[rand][0], DDM2RandomSpawn[rand][1],DDM2RandomSpawn[rand][2]);
				        SetPlayerFacingAngle(playerid, DDM2RandomSpawn[rand][3]);
				        SetCameraBehindPlayer(playerid);
	        	        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	        	        SetPlayerInterior(playerid, 1);
	        	        SetPlayerVirtualWorld(playerid, 5);
	        	        ResetPlayerWeapons(playerid);
						GivePlayerWeapon(playerid, 24, 999999);
	    				GameTextForPlayer(playerid,"~g~type ~w~/fr ~g~to exit",5000,1);
	    				DDM2Pickup[playerid] = CreateDynamicPickup(1240, 3, 1384.1360, -18.3994, 1000.9229, 5, 1, playerid);
					}
	                if(minigun[playerid] == 1) return GivePlayerWeapon(playerid, 38, 999999);
                    return 1;
}


stock GDDM2(playerid)
{
					{
                        if(PlayerInfo[playerid][Jail] == 1) return 0;
                        if(PlayerInfo[playerid][Freeze] == 1) return 0;
						indm[playerid] = 4;
                        fr[playerid] = 0;
                        MegaJump[playerid] = 0;
	        	        SetPlayerHealth(playerid, 100);
	        	        God[playerid] = 0;
                        SetPlayerArmour(playerid, 0);
	        	        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	        	        SetPlayerInterior(playerid, 1);
	        	        SetPlayerVirtualWorld(playerid, 5);
	        	        ResetPlayerWeapons(playerid);
						GivePlayerWeapon(playerid, 24, 999999);
	    				GameTextForPlayer(playerid,"~g~type ~w~/fr ~g~to exit",5000,1);
					}
                    return 1;
}

stock SCR(playerid)
{
					{
                        if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
                        if(PlayerInfo[playerid][Freeze] == 1) return 0;
                        new rand = random(sizeof(SCRRandomSpawn));
						indm[playerid] = 5;
                        fr[playerid] = 0;
                        MegaJump[playerid] = 0;
                        DuelInfo[playerid][InDuel] = 0;
	        	        SetPlayerHealth(playerid, 100);
	        	        God[playerid] = 0;
                        SetPlayerArmour(playerid, 0);
				        SetPlayerPos(playerid, SCRRandomSpawn[rand][0], SCRRandomSpawn[rand][1],SCRRandomSpawn[rand][2]);
				        SetPlayerFacingAngle(playerid, SCRRandomSpawn[rand][3]);
				        SetCameraBehindPlayer(playerid);
	        	        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	        	        SetPlayerInterior(playerid, 0);
	        	        SetPlayerVirtualWorld(playerid, 6);
	        	        ResetPlayerWeapons(playerid);
						GivePlayerWeapon(playerid, 29, 999999);
	    				GameTextForPlayer(playerid,"~g~type ~w~/fr ~g~to exit",5000,1);
					}
	                if(minigun[playerid] == 1) return GivePlayerWeapon(playerid, 38, 999999);
                    return 1;
}

stock GSCR(playerid)
{
					{
                        if(PlayerInfo[playerid][Jail] == 1) return 0;
                        if(PlayerInfo[playerid][Freeze] == 1) return 0;
						indm[playerid] = 6;
                        fr[playerid] = 0;
                        MegaJump[playerid] = 0;
	        	        SetPlayerHealth(playerid, 100);
	        	        God[playerid] = 0;
                        SetPlayerArmour(playerid, 0);
	        	        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	        	        SetPlayerInterior(playerid, 0);
	        	        SetPlayerVirtualWorld(playerid, 6);
	        	        ResetPlayerWeapons(playerid);
						GivePlayerWeapon(playerid, 29, 999999);
	    				GameTextForPlayer(playerid,"~g~type ~w~/fr ~g~to exit",5000,1);
					}
                    return 1;
}

stock SDM(playerid)
{
					{
                        if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",500,3);
                        if(PlayerInfo[playerid][Freeze] == 1) return GameTextForPlayer(playerid, "~g~you cant use commands while being ~n~~g~frozen",2500,3);
                        new rand = random(sizeof(SDMRandomSpawn));
						indm[playerid] = 2;
						fr[playerid] = 0;
						MegaJump[playerid] = 0;
						DuelInfo[playerid][InDuel] = 0;
	        	        SetPlayerHealth(playerid, 100);
	        	        God[playerid] = 0;
                        SetPlayerArmour(playerid, 0);
				        SetPlayerPos(playerid, SDMRandomSpawn[rand][0], SDMRandomSpawn[rand][1],SDMRandomSpawn[rand][2]);
				        SetPlayerFacingAngle(playerid, SDMRandomSpawn[rand][3]);
				        SetCameraBehindPlayer(playerid);
	        	        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	        	        SetPlayerInterior(playerid, 15);
	        	        SetPlayerVirtualWorld(playerid, 3);
	        	        ResetPlayerWeapons(playerid);
	        	        minigun[playerid] = 0;
						GivePlayerWeapon(playerid, 34, 999999);
	    				GameTextForPlayer(playerid,"~g~type ~w~/fr ~g~to exit",5000,1);
					}
				    return 1;
}

stock GSDM(playerid)
{
					{
                        if(PlayerInfo[playerid][Jail] == 1) return 0;
                        if(PlayerInfo[playerid][Freeze] == 1) return 0;
						MegaJump[playerid] = 0;
	        	        SetPlayerHealth(playerid, 100);
	        	        God[playerid] = 0;
                        SetPlayerArmour(playerid, 0);
	        	        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	        	        SetPlayerInterior(playerid, 15);
	        	        SetPlayerVirtualWorld(playerid, 3);
	        	        ResetPlayerWeapons(playerid);
						GivePlayerWeapon(playerid, 34, 999999);
	    				GameTextForPlayer(playerid,"~g~type ~w~/fr ~g~to exit",5000,1);
					}
				    return 1;
}

stock DDM(playerid)
{
					{
                        if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
                        if(PlayerInfo[playerid][Freeze] == 1) return 0;
                        new rand = random(sizeof(DDMRandomSpawn));
						indm[playerid] = 1;
                        fr[playerid] = 0;
                        MegaJump[playerid] = 0;
                        DuelInfo[playerid][InDuel] = 0;
	        	        SetPlayerHealth(playerid, 100);
	        	        God[playerid] = 0;
                        SetPlayerArmour(playerid, 0);
				        SetPlayerPos(playerid, DDMRandomSpawn[rand][0], DDMRandomSpawn[rand][1],DDMRandomSpawn[rand][2]);
				        SetPlayerFacingAngle(playerid, DDMRandomSpawn[rand][3]);
				        SetCameraBehindPlayer(playerid);
	        	        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	        	        SetPlayerInterior(playerid, 18);
	        	        SetPlayerVirtualWorld(playerid, 2);
	        	        ResetPlayerWeapons(playerid);
						GivePlayerWeapon(playerid, 24, 999999);
	    				GameTextForPlayer(playerid,"~g~type ~w~/fr ~g~to exit",5000,1);
					}
	                if(minigun[playerid] == 1) return GivePlayerWeapon(playerid, 38, 999999);
                    return 1;
}

stock GDDM(playerid)
{
					{
                        if(PlayerInfo[playerid][Jail] == 1) return 0;
                        if(PlayerInfo[playerid][Freeze] == 1) return 0;
                        MegaJump[playerid] = 0;
	        	        SetPlayerHealth(playerid, 100);
	        	        God[playerid] = 0;
                        SetPlayerArmour(playerid, 0);
	        	        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	        	        SetPlayerInterior(playerid, 18);
	        	        SetPlayerVirtualWorld(playerid, 2);
	        	        ResetPlayerWeapons(playerid);
						GivePlayerWeapon(playerid, 24, 999999);
	    				GameTextForPlayer(playerid,"~g~type ~w~/fr ~g~to exit",5000,1);
					}
                    return 1;
}

stock RemovePlayerWeapon(playerid, weaponid)
{
	new plyWeapons[12];
	new plyAmmo[12];

	for(new slot = 0; slot != 12; slot++)
	{
		new wep, ammo;
		GetPlayerWeaponData(playerid, slot, wep, ammo);

		if(wep != weaponid)
		{
			GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
		}
	}

	ResetPlayerWeapons(playerid);
	for(new slot = 0; slot != 12; slot++)
	{
		GivePlayerWeapon(playerid, plyWeapons[slot], 999999);
	}
}

stock JailLog(playerid, id, reason[])
{
	 new
	 File:lFile = fopen("FreeRoam/Database/Logs/Jail Log.txt", io_append),
	 logData[178],
	 fyear, fmonth, fday,
	 fhour, fminute, fsecond;

 	 getdate(fyear, fmonth, fday);
	 gettime(fhour, fminute, fsecond);

	 format(logData, sizeof(logData),"[%02d/%02d/%04d %02d:%02d:%02d] Admin %s(%d) has jailed %s(%d) (Reason:%s)\r\n", fday, fmonth, fyear, fhour, fminute, fsecond,  GetName(playerid), playerid, GetName(id), id, reason);
	 fwrite(lFile, logData);

	 fclose(lFile);
	 return 1;
}

stock MuteLog(playerid, id, reason[])
{
	 new
	 File:lFile = fopen("FreeRoam/Database/Logs/Mute Log.txt", io_append),
	 logData[178],
	 fyear, fmonth, fday,
	 fhour, fminute, fsecond;

 	 getdate(fyear, fmonth, fday);
	 gettime(fhour, fminute, fsecond);

	 format(logData, sizeof(logData),"[%02d/%02d/%04d %02d:%02d:%02d] %s(%d) has been muted by Administrator %s(%d) (Reason: %s)\r\n", fday, fmonth, fyear, fhour, fminute, fsecond, GetName(id), id, GetName(playerid), playerid, reason);
	 fwrite(lFile, logData);

	 fclose(lFile);
	 return 1;
}

stock ChatLog(playerid, text[])
{
	 new
	 File:lFile = fopen("FreeRoam/Database/Logs/Chat Log.txt", io_append),
	 logData[178],
	 fyear, fmonth, fday,
	 fhour, fminute, fsecond;

 	 getdate(fyear, fmonth, fday);
	 gettime(fhour, fminute, fsecond);

	 format(logData, sizeof(logData),"[%02d/%02d/%04d %02d:%02d:%02d] %s(%d): %s \r\n", fday, fmonth, fyear, fhour, fminute, fsecond, GetName(playerid), playerid, text);
	 fwrite(lFile, logData);

	 fclose(lFile);
	 return 1;
}

stock VipChatLog(playerid, text[])
{
	 new
	 File:lFile = fopen("FreeRoam/Database/Logs/VIP Chat Log.txt", io_append),
	 logData[178],
	 fyear, fmonth, fday,
	 fhour, fminute, fsecond;

 	 getdate(fyear, fmonth, fday);
	 gettime(fhour, fminute, fsecond);

	 format(logData, sizeof(logData),"[%02d/%02d/%04d %02d:%02d:%02d] %s(%d): %s \r\n", fday, fmonth, fyear, fhour, fminute, fsecond, GetName(playerid), playerid, text);
	 fwrite(lFile, logData);

	 fclose(lFile);
	 return 1;
}

stock AdminChatLog(playerid, text[])
{
	 new
	 File:lFile = fopen("FreeRoam/Database/Logs/Admin Chat Log.txt", io_append),
	 logData[178],
	 fyear, fmonth, fday,
	 fhour, fminute, fsecond;

 	 getdate(fyear, fmonth, fday);
	 gettime(fhour, fminute, fsecond);

	 format(logData, sizeof(logData),"[%02d/%02d/%04d %02d:%02d:%02d] (Admin Level: %d) %s(%d): %s \r\n", fday, fmonth, fyear, fhour, fminute, fsecond, PlayerInfo[playerid][pAdmin], GetName(playerid), playerid, text);
	 fwrite(lFile, logData);

	 fclose(lFile);
	 return 1;
}

stock SetPlayerWeatherEx(playerid, weatherid) {
  SetPlayerWeather(playerid, weatherid);
  pweather[playerid] = weatherid;
}

stock GetPlayerWeather(playerid) {
   return pweather[playerid];
}

stock GetIp(playerid)
{
    new Ip[MAX_PLAYER_NAME];
    GetPlayerIp(playerid, Ip, sizeof(Ip));
    return Ip;
}

stock NearbyMessage(playerid, color, text[])
{
	new Float: PlayerPosition[3];

	GetPlayerPos(playerid, PlayerPosition[0], PlayerPosition[1], PlayerPosition[2]);

	for(new i; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerInRangeOfPoint(i, 5, PlayerPosition[0], PlayerPosition[1], PlayerPosition[2]))
		{
			SendClientMessage(i, color, text);
		}
	}
}

stock GetName(playerid)
{
	new playerName[MAX_PLAYER_NAME];

	GetPlayerName(playerid, playerName, sizeof(playerName));

	return playerName;
}

stock GetNameEx(playerid)
{
	new playerName[MAX_PLAYER_NAME];

	GetPlayerName(playerid, playerName, sizeof(playerName));

	// str_replace("_", " ", playerName);

	return playerName;
}

stock SendToAdmins(playerid, text[])
{
	if(ServerInfo[ReadCmds] == 1)
	{
	    new str[250];
	    format(str,sizeof(str),"[COMMAND] %s(%d): %s",GetName(playerid), playerid, text);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(PlayerInfo[i][pAdmin] >= 1 && i != playerid)
			{
				if(PlayerInfo[i][pAdmin] > PlayerInfo[playerid][pAdmin])
				{
			        SendClientMessage(i, ReadCommandsColor, str);
			    }
			}
		}
	}
	return 1;
}

stock SendPMInfoToAdmins(playerid, id, text[])
{
	if(ServerInfo[ReadPms] == 1)
	{
	    new str[250];
	    format(str,sizeof(str),"[PM] PM from %s(%d) to %s(%d): %s",GetName(playerid), playerid, GetName(id), id, text);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(PlayerInfo[i][pAdmin] >= 1)
				{
					if(i != playerid && i != id)
					{
		                if(PlayerInfo[i][pAdmin] > PlayerInfo[playerid][pAdmin])
		                {
					        SendClientMessage(i, ReadPmsColor, str);
						}
					}
				}
			}
		}
	}
	return 1;
}

stock StringContainsIP(string[])
{
    new dotCount;
    for(new i; string[i] != EOS; ++i)
    {
        if(('0' <= string[i] <= '9') || string[i] == '.' || string[i] == ':')
        {
            if((string[i] == '.') && (string[i + 1] != '.') && ('0' <= string[i - 1] <= '9'))
            {
                ++dotCount;
            }
            continue;
        }
    }
    return (dotCount > 2);
}

stock SaveIn(filename[],text[])
{
	new File:file;
	new filepath[256];
	new string[256];
	new year, month, day;
	new hour, minute, second;

	getdate(year, month, day);
	gettime(hour, minute, second);
	format(filepath, sizeof(filepath), "Server/Logs/%s.txt", filename);
	file = fopen(filepath, io_append);
	format(string, sizeof(string),"[%02d/%02d/%02d | %02d:%02d:%02d] %s\r\n", day, month, year, hour, minute, second, text);
	fwrite(file, string);
	fclose(file);
	return 1;
}

stock GetVehicleModelIDFromName(const vname[])
{
    for(new i=0; i < sizeof(VehicleName); i++)
    {
        if (strfind(VehicleName[i], vname, true) != -1) return i + 400;
    }
    return -1;
}

stock ErrorMessages(playerid, errorID)
{
	if(errorID == 1)  return 0;
	if(errorID == 2)  return GameTextForPlayer(playerid,"~g~Player is not connected",4500,3);
	if(errorID == 3)  return 0;
	if(errorID == 5)  return GameTextForPlayer(playerid,"~g~You need to drive a vehicle",4500,3);
	if(errorID == 6)  return 0;
	if(errorID == 7)  return 0;
	if(errorID == 8)  return 0;
	if(errorID == 9)  return 0;
	if(errorID == 10) return GameTextForPlayer(playerid,"~g~You are not vip",4500,3);
	if(errorID == 11) return GameTextForPlayer(playerid,"~g~You are not vip",4500,3);
	if(errorID == 12) return GameTextForPlayer(playerid,"~g~You are not vip",4500,3);
	return 1;
}

stock PlayerName(playerid) {
  new name[255];
  GetPlayerName(playerid, name, 255);
  return name;
}

stock AngleInRangeOfAngle(Float:a1, Float:a2, Float:range)
{
        a1 -= a2;
        if((a1 < range) && (a1 > -range)) return true;

        return false;
}

stock SpawnCarForPlayer(playerid, vehicleid)
{
	new Float:pos[3], Float:angle, veh;
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	if(IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), angle), DestroyVehicle(GetPlayerVehicleID(playerid));
	else GetPlayerFacingAngle(playerid, angle);
	veh = CreateVehicle(vehicleid, pos[0], pos[1], pos[2], angle, -1, -1, 99999);
 	SetVehicleToRespawn(veh);
	PutPlayerInVehicle(playerid, veh, 0);
	return 1;
}

stock SetPlayerPosEx(playerid, Float:x ,Float:y,Float:z,Float:a)
{
    SetPlayerPos(playerid , x , y ,z);
    SetPlayerFacingAngle(playerid, a);
    return 1;
}

stock IsPlayerFacingPlayer(playerid, targetid, Float:dOffset)
{
        new
                Float:pX,
                Float:pY,
                Float:pZ,
                Float:pA,
                Float:X,
                Float:Y,
                Float:Z,
                Float:ang;

        if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return 0;

        GetPlayerPos(targetid, pX, pY, pZ);
        GetPlayerPos(playerid, X, Y, Z);
        GetPlayerFacingAngle(playerid, pA);

        if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
        else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
        else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

        return AngleInRangeOfAngle(-ang, pA, dOffset);
}

stock udb_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

stock GetPlayerNameEx(playerid)
{
     new pName[25];
     GetPlayerName(playerid, pName, sizeof(pName));
     return pName;
}

/*stock AddLabelsFromFile(LFileName[])
{
	if(!fexist(LFileName)) return 0;

	new File:LFile, Line[128], LabelInfo[128], Float:LX, Float:LY, Float:LZ, lTotal = 0;

	LFile = fopen(LFileName, io_read);
	while(fread(LFile, Line))
	{
	    if(Line[0] == '/' || isnull(Line)) continue;
	    unformat(Line, "p<,>s[128]fff", LabelInfo,LX,LY,LZ);
		CreateDynamic3DTextLabel(LabelInfo, COLOR_GREENZ, LX, LY, LZ, 100.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 100.0);
		lTotal++;
	}
	fclose(LFile);
	return lTotal;
}

stock AddLabelToFile(LFileName[], LabelInfo[], Float:LX, Float:LY, Float:LZ)
{
	new File:LFile, Line[128];
	format(Line, sizeof(Line), "%s,%.2f,%.2f,%.2f \r\n",LabelInfo, LX, LY, LZ);
	LFile = fopen(LFileName, io_append);
	fwrite(LFile, Line);
	fclose(LFile);
	return 1;
}*/

stock ColouredText(text[])
{
    new tString[16], I = -1;
    strmid(String, text, 0, 128, sizeof(String));
    for(new C = 0; C != sizeof(ColorsTag); C ++)
    {
        format(tString, sizeof(tString), "<%s>", ColorsTag[C][ColorName]);
        while((I = strfind(String, tString, true, (I + 1))) != -1)
        {
            new tLen = strlen(tString);
            format(tString, sizeof(tString), "{%s}", ColorsTag[C][ColorID]);
            if(tLen < 8) for(new C2 = 0; C2 != (8 - tLen); C2 ++) strins(String, " ", I);
            for(new tVar; ((String[I] != 0) && (tVar != 8)); I ++, tVar ++) String[I] = tString[tVar];
            if(tLen > 8) strdel(String, I, (I + (tLen - 8)));
        }
    }
    return String;
}

////////////////////////////////////////////////////////////////////////////////

IsSIInfernus(vehicleid)
{
	for (new i = 0; i < NUM_SI_VEHICLES; i++)
	{
	    if(SIInfernus[i] == vehicleid) return true;
	}
	return false;
}

////////////////////////////////////////////////////////////////////////////////
public SendMSG()
{
    new randMSG = random(sizeof(RandomMSG));
    SendClientMessageToAll(COLOR_WHITE, RandomMSG[randMSG]);
}
////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////(FREEROAM)////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print("          FreeRoam(0.3.7)"           );
	print("----------------------------------\n");
	WasteDeAMXersTime();
}

#endif

public OnGameModeInit()
{
		new GameModeText = SET_GAMEMODETEXT;
		new HName = SET_HOSTNAME;
		new AutoHostName = AUTO_HOSTNAME;
		new MapName = SET_MAPNAME;
		new Rcon = SET_RCON;
		new Language = SET_LANGUAGE;
		
		if(HName == 1)
		{
			new Delay = HOSTNAME_DELAY;
			if(Delay >= 1)
			{
	            SetTimer("SetHostName", HOSTNAME_DELAY*1000, false);
	        }
	        else
	        {
				new string[16];
				GetConsoleVarAsString("bind", string, sizeof(string));
				if(string[0] == EOS)
				{
                    SendRconCommand("hostname "HOSTNAME"");
				}
				else
				{
					if(!strcmp(string, "198.100.144.190", false))
					{
					    SendRconCommand("hostname "HOSTNAME" "HOSTNAME_TAG"");
					}
					else
					{
						SendRconCommand("hostname "HOSTNAME"");
					}
				}
	        }
		}
	    
		if(Rcon == 1) SendRconCommand("rcon_password "RCON_PASSWORD"");
		if(GameModeText == 1) SetGameModeText(GAMEMODETEXT);
		if(MapName == 1) SendRconCommand("mapname "MAPNAME"");
		if(Language == 1) SendRconCommand("language "LANGUAGE"");

		SetNameTagDrawDistance(40.0);
		EnableStuntBonusForAll(0);
		ShowPlayerMarkers(1);
	    UsePlayerPedAnims();
		ShowNameTags(1);

		//Hostname Changing
		if(AutoHostName == 1) { SetTimer("Hostname", 7000, true); HostName = 1; }
		
		//======================================================================
		// MySQL Connection Function
		//=====================================================================
	    
	    if(mysql_errno() != 0)
	    {
			mysqlconnected = 0;
	        printf("  [MySQL] The connection has failed");
	    }
	    else
	    {
			mysqlconnected = 0;
	        printf("  [MySQL] The connection was successful");
	    }
		//======================================================================
		// Creating Tables (If doesnt exits)
		new qstr[1000];
		new sstr[1000];
		
		strcat(qstr, "CREATE TABLE IF NOT EXISTS");
		strcat(qstr, "players(");
		strcat(qstr, "`Account_ID` INT(20) auto_increment PRIMARY KEY,");
		strcat(qstr, "`Name` VARCHAR(50),");
		strcat(qstr, "`Password` VARCHAR(30),");
		strcat(qstr, "`IP` VARCHAR(16),");
		strcat(qstr, "`Admin` INT(20),");
		strcat(qstr, "`VIP` INT(20),");
		strcat(qstr, "`FreeRoam_Score` INT(20),");
		strcat(qstr, "`Deathmatch_Score` INT(20),");
		strcat(qstr, "`Duel_Score` INT(20),");
		strcat(qstr, "`Deaths` INT(20),");
        strcat(qstr, "`Skin` INT(20),");
		strcat(qstr, "`Pms` INT(20),");
		strcat(qstr, "`Gos` INT(20),");
		strcat(qstr, "`God` INT(20),");
		strcat(qstr, "`Cms` INT(20),");
		strcat(qstr, "`aCMS`, INT(20),");
		strcat(qstr, "`MegaJump` INT(20),");
		strcat(qstr, "`Color` INT(20),");
		strcat(qstr, "`Fighting_Style` INT(20),");
		strcat(qstr, "`BanCount` INT(20),");
		strcat(qstr, "`JailCount` INT(20),");
		strcat(qstr, "`KickCount` INT(20),");
		strcat(qstr, "`MuteCount` INT(20),");
		strcat(qstr, "`ExplodeCount` INT(20),");
		strcat(qstr, "`SlapCount` INT(20),");
        strcat(qstr, "`WeaponRCount` INT(20),");
		strcat(qstr, "`Banned` INT(20),");
		strcat(qstr, "`Jailed` INT(20),");
		strcat(qstr, "`Muted` INT(20),");
		strcat(qstr, "`Frozen` INT(20),");
		strcat(qstr, "`JailTime` INT(20),");
		strcat(qstr, "`Time` INT(20),");
		strcat(qstr, "`Weather` INT(20),");
		strcat(qstr, "`Spawn` INT(20),");
		strcat(qstr, "`Spawn_Interior` INT(20),");
		strcat(qstr, "`Spawn_X` FLOAT(128),");
		strcat(qstr, "`Spawn_Y` FLOAT(128),");
		strcat(qstr, "`Spawn_Z` FLOAT(128),");
		strcat(qstr, "`Spawn_Angle` FLOAT(128))");
		
		
		strcat(sstr, "CREATE TABLE IF NOT EXIST ");
		strcat(sstr, "banlog(");
		strcat(sstr, "`Name` VARCHAT(30),");
		strcat(sstr, "`Account_ID` INT(20),");
		strcat(sstr, "`Banned_By` VARCHAR(30),");
		strcat(sstr, "`Type` INT(20),");
		strcat(sstr, "`Reason` VARCHAR(120),");
		strcat(sstr, "`Date` datetime)");

		//======================================================================


        new Hour; gettime(Hour);
		SetTimer("SendMSG", 60000, true);
		SetTimer("MinigunFightStart", 60000 * 30, true);
		ServerInfo[MinigunFight] = 0;
        AutoFixTimer = SetTimer("AutoFix", 1000, true);


		InfoTextdraw = TextDrawCreate(16.875000, 434.583343, "UGF Build 14 - "WEBSITE_URL" - /c = commands /w = weapons /v = vehicles /t = teleports");
		TextDrawLetterSize(InfoTextdraw, 0.291874, 1.203332);
		TextDrawAlignment(InfoTextdraw, 1);
		TextDrawColor(InfoTextdraw, -1);
		TextDrawSetShadow(InfoTextdraw, 0);
		TextDrawSetOutline(InfoTextdraw, 1);
		TextDrawBackgroundColor(InfoTextdraw, 51);
		TextDrawFont(InfoTextdraw, 3);
		TextDrawSetProportional(InfoTextdraw, 1);
		
		Press = TextDrawCreate(415.111206, 360.391052, "~w~PRESS ~g~ENTER ~w~TO STOP");
		TextDrawLetterSize(Press, 0.449999, 1.600000);
		TextDrawAlignment(Press, 1);
		TextDrawColor(Press, -1);
		TextDrawSetShadow(Press, 0);
		TextDrawSetOutline(Press, 1);
		TextDrawBackgroundColor(Press, 51);
		TextDrawFont(Press, 2);
		TextDrawSetProportional(Press, 1);

	    PirateObject = CreateObject(8493,0,0,-100,0,0,0);
	    PirateFence = CreateObject(9159,0,0,-100,0,0,0);
	    PirateRopes = CreateObject(8981,0,0,-100,0,0,0);
	    PirateShip = AddStaticVehicleEx(454, -2114.3896,-6898.1284,0.8931, 180.0000, -1, -1, 60);
	    AttachObjectToVehicle(PirateObject, PirateShip, 0.809999, 1.439998, 16.650209, 0.000000, 0.000000, 0.000000);
	    AttachObjectToVehicle(PirateRopes, PirateShip, 0.294999, -4.665059, 16.250276, 0.000000, 0.000000, 0.000000);
	    AttachObjectToVehicle(PirateFence, PirateShip, 0.784999, 1.439998, 16.655208, 0.000000, 0.000000, 0.000000);

		AddPlayerClass(299,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(1,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(2,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(3,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(4,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(5,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(6,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(7,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(8,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(9,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(10,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(11,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(12,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(13,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(14,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(15,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(16,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(17,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(18,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(19,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(20,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(21,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(22,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(23,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(24,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(25,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(26,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(27,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(28,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(29,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(30,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(31,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(32,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(33,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(34,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(35,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(36,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(37,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(38,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(39,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(40,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(41,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(42,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(43,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(44,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(45,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(46,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(47,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(48,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(49,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(50,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(51,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(52,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(53,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(54,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(55,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(56,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(57,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(58,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
	   	AddPlayerClass(68,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(69,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(70,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(71,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(72,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(73,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(74,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(75,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(76,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(78,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(79,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(80,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(81,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(82,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(83,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(84,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(85,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(87,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(88,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(89,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(91,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(92,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(93,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(95,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(96,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(97,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(98,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(99,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(100,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(201,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(202,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(203,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(204,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(205,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(206,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(207,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(208,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(209,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(210,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(211,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(212,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(213,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(214,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(215,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(216,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(217,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(218,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(219,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(220,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(221,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(222,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(223,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(224,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(225,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(226,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(227,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(228,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(229,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(230,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(231,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(232,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(233,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(234,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(235,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(236,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(237,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(238,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(239,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(240,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(241,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(242,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(243,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(244,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(245,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(246,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(247,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(248,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(249,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(250,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(251,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(252,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(253,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(254,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(255,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(256,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(257,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(258,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
	   	AddPlayerClass(268,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(269,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(270,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(271,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(272,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(273,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(274,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(275,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(276,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(278,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(279,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(280,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(281,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(282,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(283,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(284,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(285,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(287,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(288,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(289,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(291,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(292,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(293,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(295,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(296,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(297,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(298,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(301,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(302,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(303,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(304,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(305,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(306,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(307,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(308,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(309,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(310,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);
		AddPlayerClass(311,-1680.1483,706.0532,30.6016,90.9011,-1,-1,-1,-1,-1,-1);

	    Airplanes = LoadModelSelectionMenu("FreeRoam/Menu Resources/Airplanes.txt");
	    Helicopters = LoadModelSelectionMenu("FreeRoam/Menu Resources/Helicopters.txt");
	    Bikes = LoadModelSelectionMenu("FreeRoam/Menu Resources/Bikes.txt");
	    Industrial = LoadModelSelectionMenu("FreeRoam/Menu Resources/Industrial.txt");
	    Lowriders = LoadModelSelectionMenu("FreeRoam/Menu Resources/Lowriders.txt");
	    OffRoad = LoadModelSelectionMenu("FreeRoam/Menu Resources/Off Road.txt");
	    PublicService = LoadModelSelectionMenu("FreeRoam/Menu Resources/Public Service.txt");
	    Saloons = LoadModelSelectionMenu("FreeRoam/Menu Resources/Saloons.txt");
	    SportsVehicles = LoadModelSelectionMenu("FreeRoam/Menu Resources/Sports Vehicles.txt");
	    Boats = LoadModelSelectionMenu("FreeRoam/Menu Resources/Boats.txt");
	    Trailers = LoadModelSelectionMenu("FreeRoam/Menu Resources/Trailers.txt");
	    UniqueVehicles = LoadModelSelectionMenu("FreeRoam/Menu Resources/Unique Vehicles.txt");
	    RCVehicles = LoadModelSelectionMenu("FreeRoam/Menu Resources/RC Vehicles.txt");

		for (new i = 0; i < NUM_SI_VEHICLES; i++)
		{
		    SIInfernus[i] = CreateVehicle(411, 89.45, 3445.0 + (i * 6.0), 5.05, 90.0, -1, -1, 30);
		    if(SIInfernus[i] != INVALID_VEHICLE_ID)
			{
	        	AddVehicleComponent(SIInfernus[i], 1010);
			}
		}

        ChangeColor[0] = TextDrawCreate(17.0, 138.0, "box");
        TextDrawLetterSize(ChangeColor[0], 0.0, 17.0);
        TextDrawTextSize(ChangeColor[0], 171.0, 0.0);TextDrawAlignment(ChangeColor[0], 1);
        TextDrawColor(ChangeColor[0], -1);TextDrawUseBox(ChangeColor[0], 1);
        TextDrawBoxColor(ChangeColor[0], 102);TextDrawSetOutline(ChangeColor[0], 0);
        TextDrawBackgroundColor(ChangeColor[0], 255);TextDrawFont(ChangeColor[0], 1);
        TextDrawSetProportional(ChangeColor[0], 1);TextDrawSetShadow(ChangeColor[0], 0);

        ChangeColor[1] = TextDrawCreate(138.667617, 298.116699, "Close");
        TextDrawLetterSize(ChangeColor[1], 0.400000, 1.600000);
        TextDrawTextSize(ChangeColor[1], 17.0, 62.327926);TextDrawAlignment(ChangeColor[1], 2);
        TextDrawColor(ChangeColor[1], -1);TextDrawUseBox(ChangeColor[1], 1);
        TextDrawBoxColor(ChangeColor[1], 102);TextDrawSetOutline(ChangeColor[1], 0);
        TextDrawBackgroundColor(ChangeColor[1], 255);TextDrawFont(ChangeColor[1], 2);
        TextDrawSetProportional(ChangeColor[1], 1);TextDrawSetShadow(ChangeColor[1], 0);
        TextDrawSetSelectable(ChangeColor[1], 1);

        new Float:X=19.0,Float:Y=139.0,count = 1;
        for(new i=2; i < sizeof(ChangeColor); i++)
        {
                ChangeColor[i] = TextDrawCreate(X, Y, "box");
                TextDrawBackgroundColor(ChangeColor[i], AllCarColors[ColorsAvailable[i-2]]);
                TextDrawLetterSize(ChangeColor[i], 0.0, 18.0);TextDrawTextSize(ChangeColor[i], 18.0, 18.0);
                TextDrawAlignment(ChangeColor[i], 1);TextDrawColor(ChangeColor[i], -1);
                TextDrawUseBox(ChangeColor[i], 1);TextDrawBoxColor(ChangeColor[i], 0);
                TextDrawSetOutline(ChangeColor[i], 0);TextDrawFont(ChangeColor[i], 5);
                TextDrawSetProportional(ChangeColor[i], 1);TextDrawSetShadow(ChangeColor[i], 1);
                TextDrawSetPreviewModel(ChangeColor[i], 19349);
                TextDrawSetPreviewRot(ChangeColor[i], -16.0, 0.0, -180.0, 0.7);
                TextDrawSetSelectable(ChangeColor[i], 1);

                X+=19.0;
                count++;
                if(count == 9)
                {
                        Y+=19.0;
                        X = 19.0;
                        count = 1;
                }
        }
        
		AAMaps();
		Tube();
		Stunts();
		StuntPark();
		
		DerbyMapOne();
		DerbyMapTwo();
		DerbyMapThree();
		
		AntiDeAMX();
		WasteDeAMXersTime();
	    return 1;
}

public OnGameModeExit()
{
	new Hour; gettime(Hour);
    DestroyAllDynamic3DTextLabels();
    for(new i; i < sizeof(ChangeColor); i++)
    {
        TextDrawDestroy(ChangeColor[i]);
    }
    KillTimer(AutoFixTimer);
	if(mysqlconnected == 1) print("[MySQL] Successfully disconnected from the database");
	return 1;
}

public OnPlayerConnect(playerid)
{
	new str[150];
	format(str, sizeof(str), "%s(%d) has connected to the server (IP: %s) (PING: %i)", GetName(playerid), playerid, GetIp(playerid), GetPlayerPing(playerid));
	
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][pAdmin] >= 1)
			{
				if(PlayerInfo[i][aCMS] == 1)
				{
					SendClientMessage(i, CONNECT_MESSAGES_COLOR, str);
				}
			}
		}
	}

    CreateSIObjects(playerid);
    SetPlayerColor(playerid, PlayerColors[playerid]);
    PlayerPlaySound(playerid, 1185, 0.0, 0.0, 0.0);
	GameTextForPlayer(playerid, "~g~UGF - United Gaming Freeroam~n~~n~Freeroam ~r~Deathmatch~n~~n~~y~Build 14~n~~n~Build Date: 20/14/2015", 5000, 3);
	
	RemoveBuildingForPlayer(playerid, 10763, -1255.8984, 47.1797, 45.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 10884, -1255.8984, 47.1797, 45.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, -1244.9219, 5.1250, 25.3359, 0.25);
	
    fr[playerid] = 1;
    Jumped[playerid] = 0;
    God[playerid] = 0;
    rvc[playerid] = 0;
    MegaJump[playerid] = 0;
    PlayerVehicle[playerid] = 0;
	RVColorTimer[playerid] = -1;
	CheckID[playerid] = -1;
    Anim[playerid] = 0;
    
    PlayerInfo[playerid][Accountid] = -1;
    PlayerInfo[playerid][pAdmin] = 0;
    PlayerInfo[playerid][pVip] = 0;
    PlayerInfo[playerid][Pms] = 0;
    PlayerInfo[playerid][Gos] = 1;
    PlayerInfo[playerid][pDeaths] = 0;
    PlayerInfo[playerid][pKills] = 0;
    PlayerInfo[playerid][pDeathmatchScore] = 0;
    PlayerInfo[playerid][CMS] = 1;
    PlayerInfo[playerid][Usingskin] = 0;
    PlayerInfo[playerid][BanC] = 0;
    PlayerInfo[playerid][JailC] = 0;
    PlayerInfo[playerid][MuteC] = 0;
    PlayerInfo[playerid][ExplodeC] = 0;
    PlayerInfo[playerid][SlapC] = 0;
    PlayerInfo[playerid][WeaponRC] = 0;
    PlayerInfo[playerid][DisarmC] = 0;
    PlayerInfo[playerid][pMuted] = 0;
    PlayerInfo[playerid][Jail] = 0;
    PlayerInfo[playerid][Freeze] = 0;
    PlayerInfo[playerid][Banned] = 0;
    PlayerInfo[playerid][pBan] = 0;
    PlayerInfo[playerid][Invisible] = 0;
    PlayerInfo[playerid][pWeather] = 10;
    PlayerInfo[playerid][Time] = 12;
	PlayerInfo[playerid][MW] = 0;
	PlayerInfo[playerid][Hide] = 0;
	PlayerInfo[playerid][aCMS] = 0;

	PlayerInfo[playerid][BanC] = 0;
	PlayerInfo[playerid][KickC] = 0;
	PlayerInfo[playerid][WeaponRC] = 0;
	PlayerInfo[playerid][SlapC] = 0;
    PlayerInfo[playerid][ExplodeC] = 0;
	PlayerInfo[playerid][DisarmC] = 0;
	
	DuelInfo[playerid][DuelID] = -1;
	DuelInfo[playerid][InDuel] = 0;
	
	if(ServerInfo[MinigunFight] == 1)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 38, 999999);
		PlayerInfo[playerid][MinigunFight] = 1;
	}
	
    
    


    cache_get_row_count(rows);
    if(rows)
    {

        
        
       	ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, ""COL_GREEN"UGF - Login", str1, "Login", "");
    }
    else
    {
        format(str1, 150, "\n{FFFFFF}Welcome To FreeRoam Server\n\n{00FF00}Account Name:{FFFFFF} %s\n\nEnter A Password To Register This Account", GetName(playerid));
        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Register", str1, "Register", "");
        PlayerInfo[playerid][New] = 1;
    }
    
    AFKCheckTimer[playerid] = SetTimerEx("AFKReset", 1000, true, "i", playerid);
	return 1;
}


public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerVirtualWorld(playerid, 0);
    SetPlayerPos(playerid,-1753.6743,885.2703,295.8750);
    SetPlayerFacingAngle(playerid, 358.5159);
    SetPlayerCameraPos(playerid,-1753.6849,892.0016,295.8750);
    SetPlayerCameraLookAt(playerid,-1753.6743,885.2703,295.8750);
	return 1;
}

public SetHostName()
{
	new string[16];
	GetConsoleVarAsString("bind", string, sizeof(string));
	if(string[0] == EOS)
	{
	    SendRconCommand("hostname "HOSTNAME"");
	}
	else
	{
	    if(!strcmp(string, "198.100.144.190", false))
	    {
	        SendRconCommand("hostname "HOSTNAME" "HOSTNAME_TAG"");
	    }
	    else
	    {
	        SendRconCommand("hostname "HOSTNAME"");
	    }
    }
	return 1;
}

public Hostname()
{
	new Tag;
	new string[16];
	GetConsoleVarAsString("bind", string, sizeof(string));
	if(string[0] == EOS)
	{
	    SendRconCommand("hostname "HOSTNAME"");
	}
	else
	{
	    if(!strcmp(string, "198.100.144.190", false))
	    {
			Tag = 1;
	    }
	    else
	    {
			Tag = 0;
	    }
    }
	if(HostName == 1)
	{
    	if(Tag == 0) { SendRconCommand("hostname "HOSTNAME_TWO""); }
    	else if(Tag == 1) { SendRconCommand("hostname "HOSTNAME_TWO" "HOSTNAME_TAG""); }
		HostName++;
	}
	else if(HostName == 2)
	{
    	if(Tag == 0) { SendRconCommand("hostname "HOSTNAME""); }
    	else if(Tag == 1) { SendRconCommand("hostname "HOSTNAME" "HOSTNAME_TAG""); }
		HostName = 1;
	}
	return 1;
}

public KickPlayer(playerid)
{
	Kick(playerid);
	return 1;
}

public JumpTimer(playerid)
{
	Jumped[playerid] = 0;
	return 1;
}

public DuelRequestTimer(playerid)
{
	new id = DuelInfo[playerid][DuelID];
	DuelInfo[playerid][DuelID] = -1;
	DuelInfo[id][DuelID] = -1;
	ClearDuel(playerid);
	return 1;
}

public CountDown()
{
     CountDownVar--; //Thanks for the fix.
     new str[128];
     if(CountDownVar == 0)
     {
            KillTimer(CountDownTimer);
            CountDownVar = 4; //Edit thanks to Hiddos...i was sleepy :S
     }
     else
     {
           format(str, sizeof(str), "Count Down: %d", CountDownTimer);
           GameTextForAll(str, 1000, 1);
     }
     return 1;
}

public ServerRestart()
{
	foreach(Player, i)
	{
		Kick(i);
	}
    SendRconCommand("gmx");
}

public Counting(playerid)
{
    if(Count[playerid] == 0)
	{
        KillTimer(CountTimer);
    }
	else
	{
	    new Float:x,Float:y,Float:z;
	    GetPlayerPos(playerid, x, y, z);
		foreach(Player, i)
		{
			if(IsPlayerInRangeOfPoint(i, COUNTRANGE, x, y, z))
			{
	        	new string[20];
		        format(string,sizeof(string),"~g~%d",Count);
		        GameTextForPlayer(i, string, 1000, 3);
				PlayerPlaySound(i, 1056,0,0,0);
				Count[playerid] --;
		    }
		}
    }
    return 1;
}

public MinigunFightStart()
{
	if(ServerInfo[MinigunFight] == 0)
	{
		foreach(Player, i)
		{
			if(fr[i] == 1)
			{
				if(PlayerInfo[i][Jail] == 0)
				{
					if(God[i] == 0)
					{
					GameTextForPlayer(i,"~g~Minigun fight",4500,3);
					ResetPlayerWeapons(i);
					GivePlayerWeapon(i, 38, 999999);
					PlayerPlaySound(i, 1056,0,0,0);
					PlayerInfo[i][MinigunFight] = 1;
					}
				}
			}
		}
		ServerInfo[MinigunFight] = 1;
		SetTimer("MinigunFightEnd", 60000, false);
	}
	return 1;
}

public MinigunFightEnd()
{
	foreach(Player, i)
	{
		if(PlayerInfo[i][MinigunFight] == 1)
		{
			if(fr[i] == 1)
			{
				if(PlayerInfo[i][Jail] == 0)
				{
					if(God[i] == 0)
					{
					    RemovePlayerWeapon(i, 38);
					}
				}
			}
			PlayerInfo[i][MinigunFight] = 0;
		}
	}
	ServerInfo[MinigunFight] = 0;
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
        if (clickedid == ChangeColor[1] )
        {
                CancelSelectTextDraw(playerid);
                for(new i; i < sizeof(ChangeColor); i++)
                {
                        TextDrawHideForPlayer(playerid,ChangeColor[i]);
                }
        }
        for(new i=2; i < sizeof(ChangeColor); i++)
        {
                if(clickedid == ChangeColor[i])
                {
                        CancelSelectTextDraw(playerid);
                        ChangeVehicleColor(GetPlayerVehicleID(playerid),ColorsAvailable[i-2],ColorsAvailable[i-2]);
                        for(new j; j < sizeof(ChangeColor); j++)
                        {
                                TextDrawHideForPlayer(playerid,ChangeColor[j]);
                        }
                }
        }
        return 1 ;
}

public LoadUser_data(playerid)
{
    cache_get_value_name_int(0, "Account_ID", PlayerInfo[playerid][Accountid]);
    cache_get_value_name_int(0, "Admin", PlayerInfo[playerid][pAdmin]);
    cache_get_value_name_int(0, "VIP", PlayerInfo[playerid][pVip]);
    cache_get_value_name_int(0, "Pms", PlayerInfo[playerid][Pms]);
	cache_get_value_name_int(0, "Gos", PlayerInfo[playerid][Gos]);
	cache_get_value_name_int(0, "Cms", PlayerInfo[playerid][CMS]);
    cache_get_value_name_int(0, "God", God[playerid]);
    cache_get_value_name_int(0, "MegaJump", MegaJump[playerid]);
	cache_get_value_name_int(0, "Skin", PlayerInfo[playerid][pSkin]);
    cache_get_value_name_int(0, "Death", PlayerInfo[playerid][pDeaths]);
    cache_get_value_name_int(0, "Time", PlayerInfo[playerid][Time]);
    cache_get_value_name_int(0, "Weather", PlayerInfo[playerid][Weather]);
    cache_get_value_name_int(0, "Color", PlayerInfo[playerid][pColor]);
    cache_get_value_name_int(0, "Fighting_Style", PlayerInfo[playerid][FightStyles]);
    cache_get_value_name_int(0, "FreeRoam_Score", PlayerInfo[playerid][pKills]);
    cache_get_value_name_int(0, "Deathmatch_Score", PlayerInfo[playerid][pDeathmatchScore]);
    cache_get_value_name_int(0, "Duel_Score", PlayerInfo[playerid][DuelScore]);
    cache_get_value_name_int(0, "BanC", PlayerInfo[playerid][BanC]);
    cache_get_value_name_int(0, "JailC", PlayerInfo[playerid][JailC]);
    cache_get_value_name_int(0, "KickC", PlayerInfo[playerid][KickC]);
    cache_get_value_name_int(0, "MuteC", PlayerInfo[playerid][MuteC]);
    cache_get_value_name_int(0, "ExplodeC", PlayerInfo[playerid][ExplodeC]);
    cache_get_value_name_int(0, "SlapC", PlayerInfo[playerid][SlapC]);
    cache_get_value_name_int(0, "WeaponsRCount", PlayerInfo[playerid][WeaponRC]);
    cache_get_value_name_int(0, "Muted", PlayerInfo[playerid][pMuted]);
    cache_get_value_name_int(0, "Frozen", PlayerInfo[playerid][Freeze]);
    cache_get_value_name_int(0, "Jailed", PlayerInfo[playerid][Jail]);
    cache_get_value_name_int(0, "JailTime", PlayerInfo[playerid][JailTime]);
    cache_get_value_name_int(0, "Banned", PlayerInfo[playerid][Banned]);
    cache_get_value_name_int(0, "Spawn", PlayerInfo[playerid][Spawn]);
	cache_get_value_name_int(0, "Spawn_Interior", PlayerInfo[playerid][SpawnInterior]);
    cache_get_value_name_float(0, "Spawn_X", PlayerInfo[playerid][posX]);
    cache_get_value_name_float(0, "Spawn_Y", PlayerInfo[playerid][posY]);
	cache_get_value_name_float(0, "Spawn_Z", PlayerInfo[playerid][posZ]);
	cache_get_value_name_float(0, "Spawn_Angle", PlayerInfo[playerid][posAngle]);
    return 1;
}

public Unjail(playerid)
{
	if(PlayerInfo[playerid][JailTime] == 0)
	{
	    PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		PlayerInfo[playerid][Jail] = 0;
	    SetPlayerInterior(playerid, 0);
	    inJail[playerid] = false;
	    if(PlayerInfo[playerid][JFR] == 1)
	    {
			GFR(playerid);
			return 1;
	    }
	    if(PlayerInfo[playerid][JDM] == 1)
	    {
			GDDM(playerid);
			return 1;
	    }
	    if(PlayerInfo[playerid][JDM] == 2)
	    {
			GSDM(playerid);
			return 1;
	    }
	    if(PlayerInfo[playerid][JDM] == 3)
	    {
			GSOS(playerid);
			return 1;
	    }
	    if(PlayerInfo[playerid][JDM] == 4)
	    {
			GDDM2(playerid);
			return 1;
	    }
	    if(PlayerInfo[playerid][JDM] == 5)
	    {
			GSCR(playerid);
			return 1;
	    }
	    PlayerInfo[playerid][JDM] = -1;
	    PlayerInfo[playerid][JFR] = -1;
    }
    else
    {
		new str[150];
		PlayerInfo[playerid][JailTime]--;
		format(str, sizeof(str), "~g~Jailed~n~~w~%d Minutes Left", PlayerInfo[playerid][JailTime]);
		GameTextForPlayer(playerid, str, 5000, 3);
    }
    return 1;
}


public muteTimer(playerid)
{
    SetPVarInt( playerid, "Mutan", 0);
    return true;
}

public jailTimer(playerid)
{
	SetPVarInt( playerid, "Jailed", 0);
	return true;
}

public ProxDetector(Float:radi, playerid, str[],col1,col2,col3,col4,col5)
{
    if(IsPlayerConnected(playerid))
    {
        new Float:posx, Float:posy, Float:posz;
        new Float:oldposx, Float:oldposy, Float:oldposz;
        new Float:tempposx, Float:tempposy, Float:tempposz;
        GetPlayerPos(playerid, oldposx, oldposy, oldposz);
        for(new i = 0; i < MAX_PLAYERS; i++)
        {
            if(IsPlayerConnected(i))
            {

                GetPlayerPos(i, posx, posy, posz);
                tempposx = (oldposx -posx);
                tempposy = (oldposy -posy);
                tempposz = (oldposz -posz);
                if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
                {
                    SendClientMessage(i, col1, str);
                }
                else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
                {
                    SendClientMessage(i, col2, str);
                }
                else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
                {
                    SendClientMessage(i, col3, str);
                }
                else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
                {
                    SendClientMessage(i, col4, str);
                }
                else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
                {
                    SendClientMessage(i, col5, str);
                }
            }
        }
	}
    return 1;
}

public DestroyMe(objectid)
{
    return DestroyObject(objectid);
}

public Jav(playerid)
{
        if(!Javelin[playerid][1])
        {
                new
                        target = GetClosestPlayer(playerid);

                if(target != -1)
                {
                    GetPlayerPos(target, JavPos[playerid][0], JavPos[playerid][1], JavPos[playerid][2]);
					if(IsPlayerInRangeOfPoint(playerid, 500.0, JavPos[playerid][0], JavPos[playerid][1], JavPos[playerid][2]))
                        {
                                new Float:a;
                                GetPlayerPos(playerid, JavPos[playerid][0], JavPos[playerid][1], JavPos[playerid][2]);
                                GetPlayerFacingAngle(playerid, a);

                                Javelin[playerid][0] = CreateDynamicObject(354, JavPos[playerid][0], JavPos[playerid][1], JavPos[playerid][2], 0.0, 90.0, 0.0);
                                MoveObject(Javelin[playerid][0], JavPos[playerid][0], JavPos[playerid][1], JavPos[playerid][2] + 100.0, 45.0);

                                GetPlayerPos(target, JavPos[playerid][0], JavPos[playerid][1], JavPos[playerid][2]);

                                Javelin[playerid][1] = 1;
                        }
                }
        }

        return 0;
}

public Float:SetPlayerToFacePos(playerid, Float:X, Float:Y)
{
        new
                Float:pX,
                Float:pY,
                Float:pZ,
                Float:ang;

        if(!IsPlayerConnected(playerid)) return 0.0;

        GetPlayerPos(playerid, pX, pY, pZ);

        if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
        else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
        else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

        if(X > pX) ang = (floatabs(floatabs(ang) + 180.0));
        else ang = (floatabs(ang) - 180.0);

        ang += 180.0;

        SetPlayerFacingAngle(playerid, ang);

        return ang;
}

public GetClosestPlayer(p1)
{
        new
                x,
                Float:dis,
                Float:dis2,
                player;

        player = -1;
        dis = 99999.99;

        for (x=0;x<MAX_PLAYERS;x++)
                if(IsPlayerConnected(x))
                        if(x != p1)
                        {
                                dis2 = GetDistanceBetweenPlayers(x,p1);
                                if(dis2 < dis && dis2 != -1.00)
                                {
                                        dis = dis2;
                                        player = x;
                                }
                        }

        return player;
}

public Float:GetDistanceBetweenPlayers(p1, p2)
{
        new
                Float:x1,
                Float:y1,
                Float:z1,
                Float:x2,
                Float:y2,
                Float:z2;

        if(!IsPlayerConnected(p1) || !IsPlayerConnected(p2))
                return -1.00;

        GetPlayerPos(p1,x1,y1,z1);
        GetPlayerPos(p2,x2,y2,z2);

        return floatsqroot(
                floatpower(floatabs(floatsub(x2,x1)), 2)
                + floatpower(floatabs(floatsub(y2,y1)), 2)
                + floatpower(floatabs(floatsub(z2,z1)), 2));
}

public AutoFix()
{
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
		{
			if(IsPlayerInAnyVehicle(i))
			{
				if(GetPlayerState(i) == PLAYER_STATE_DRIVER)
				{
				    RepairVehicle(GetPlayerVehicleID(i));
				}
			}
		}
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{

	new string[150];
	
	switch(reason)
	{
		case 0: format(string, sizeof(string), "%s(%d) has disconnected from the server (Reason: Lost Connection) (Ping: %i) (IP: %s)", GetPlayerPing(playerid), GetIp(playerid));
		case 1: format(string, sizeof(string), "%s(%d) has disconnected from the server (Reason: Leaving) (Ping: %i) (IP: %s)",  GetPlayerPing(playerid), GetIp(playerid));
		case 2: format(string, sizeof(string), "%s(%d) has disconnected from the server (Reason: Kicked/Banned) (Ping: %i) (IP: %s)", GetPlayerPing(playerid), GetIp(playerid));
	}

	for(new i=0;i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][pAdmin] >= 1)
			{
				if(PlayerInfo[i][aCMS] == 1)
				{
					SendClientMessage(i, CONNECT_MESSAGES_COLOR, string);
				}
			}
		}
	}

	if(RVColorTimer[playerid] != -1) KillTimer(RVColorTimer[playerid]);

	DuelInfo[playerid][DuelID] = -1;
	DuelInfo[playerid][InDuel] = 0;

	if(BeingSpectated[playerid] == 1)
	{
		TogglePlayerSpectating(Spectator[playerid], 0);
		SpawnPlayer(Spectator[playerid]);
		gSpectateID[playerid] = -1;
		Spectating[playerid] = 0;
	}

	if(PlayerInfo[playerid][MW] == 1)
	{
        DestroyDynamic3DTextLabel(MostWanted[playerid]);
	}
	
	if(PlayerInfo[playerid][pLogged] == 1)
	{
		new ip[30],query[1000], qstr[1000];
	    PlayerInfo[playerid][Usingskin] = 1;
	    PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
	    PlayerInfo[playerid][pLogged] = 0;
		GetPlayerIp(playerid, ip, sizeof(ip));
		
		
        strcat(qstr, "UPDATE `players` SET ");
		strcat(qstr, "`Admin` = %d,");
		strcat(qstr, "`VIP` = %d,");
		strcat(qstr, "`FreeRoam_Score` = %d,");
		strcat(qstr, "`Deathmatch_Score` = %d,");
		strcat(qstr, "`Duel_Score` = %d,");
 		strcat(qstr, "`Total_Score` = %d,");
		strcat(qstr, "`Deaths` = %d,");
        strcat(qstr, "`Skin` = %d,");
		strcat(qstr, "`Pms` = %d,");
		strcat(qstr, "`Gos` = %d,");
		strcat(qstr, "`God` = %d,");
		strcat(qstr, "`Cms` = %d,");
		strcat(qstr, "`aCms` = %d,");
		strcat(qstr, "`MegaJump` = %d,");
		strcat(qstr, "`Color` = %d,");
		strcat(qstr, "`Fighting_Style` = %d,");
		strcat(qstr, "`BanCount` = %d,");
		strcat(qstr, "`JailCount` = %d,");
		strcat(qstr, "`KickCount` = %d,");
		strcat(qstr, "`MuteCount` = %d,");
		strcat(qstr, "`ExplodeCount` = %d,");
		strcat(qstr, "`SlapCount` = %d,");
  		strcat(qstr, "`WeaponRCount` = %d,");
		strcat(qstr, "`Banned` = %d,");
		strcat(qstr, "`Jailed` = %d,");
		strcat(qstr, "`Muted` = %d,");
		strcat(qstr, "`Frozen` = %d,");
		strcat(qstr, "`Time` = %d,");
		strcat(qstr, "`Weather` = %d");
		strcat(qstr, " WHERE ");
		strcat(qstr,"`Account_ID` = %d");
		
	    mysql_format(mysql, query, sizeof(query), qstr,
	    PlayerInfo[playerid][pAdmin],
		PlayerInfo[playerid][pVip],
		PlayerInfo[playerid][pKills],
		PlayerInfo[playerid][pDeathmatchScore],
		PlayerInfo[playerid][DuelScore],
		GetPlayerScore(playerid),
	    PlayerInfo[playerid][pDeaths],
		PlayerInfo[playerid][pSkin],
		PlayerInfo[playerid][Pms],
		PlayerInfo[playerid][Gos],
		God[playerid],
		PlayerInfo[playerid][CMS],
		PlayerInfo[playerid][aCMS],
		MegaJump[playerid],
		PlayerInfo[playerid][pColor],
		PlayerInfo[playerid][FightStyles],
		PlayerInfo[playerid][BanC],
		PlayerInfo[playerid][JailC],
		PlayerInfo[playerid][KickC],
		PlayerInfo[playerid][MuteC],
		PlayerInfo[playerid][ExplodeC],
		PlayerInfo[playerid][SlapC],
		PlayerInfo[playerid][WeaponRC],
		PlayerInfo[playerid][pBan],
		PlayerInfo[playerid][Jail],
		PlayerInfo[playerid][pMuted],
		PlayerInfo[playerid][Freeze],
		PlayerInfo[playerid][Time],
	    PlayerInfo[playerid][pWeather],
		PlayerInfo[playerid][Accountid]);
	    mysql_query(mysql, query);
	}

	if(PlayerInfo[playerid][FailedLog] == 1)
    {
		counts = counts - 1;
		PlayerInfo[playerid][FailedLog] = 0;
	}
	
	KillTimer(JTimer[playerid]);
	
	AFK[playerid] = 0;

	KillTimer(AFKCheckTimer[playerid]);

	AFKCheckTimer[playerid] = 0;
    return 1;
}

public OnPlayerSpawn(playerid)
{
	if(DuelInfo[playerid][InDuel] == 1)
	{
		if(DuelInfo[playerid][Rounds] >= 1)
		{
		    SetDuel(playerid);
		}
	    if(DuelInfo[playerid][Rounds] == 0)
	    {
	        ClearDuel(playerid);
	        FR(playerid);
        }
	}
	if(God[playerid] == 1)
	{
	    SetPlayerHealth(playerid, 99999);
	}
   	if(PlayerInfo[playerid][Jail] == 1)
	{
        new rand = random(sizeof(JailRandomSpawn));
	    SetPlayerInterior(playerid, 3);
        SetPlayerPos(playerid, JailRandomSpawn[rand][0], JailRandomSpawn[rand][1], JailRandomSpawn[rand][2]);
        SetPlayerFacingAngle(playerid, JailRandomSpawn[rand][3]);
	    SetCameraBehindPlayer(playerid);
		ResetPlayerWeapons(playerid);
	}
	if(indm[playerid] == 1)
	{
		DDM(playerid);
		return 1;
	}
	if(indm[playerid] == 2)
	{
		SDM(playerid);
		return 1;
	}
	if(indm[playerid] == 3)
	{
		SOS(playerid);
		return 1;
	}
	if(indm[playerid] == 4)
	{
		DDM2(playerid);
		return 1;
	}
	if(indm[playerid] == 5)
	{
		SCR(playerid);
		return 1;
	}
	if(fr[playerid] == 1 && PlayerInfo[playerid][Spawn] == 0)
	{
        new rand = random(sizeof(FreeRoamSpawns));
        SetPlayerVirtualWorld(playerid, 1);
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, FreeRoamSpawns[rand][0], FreeRoamSpawns[rand][1],FreeRoamSpawns[rand][2]);
        SetPlayerFacingAngle(playerid, FreeRoamSpawns[rand][3]);
        SetCameraBehindPlayer(playerid);
		if(God[playerid] == 0)
		{
            new RandOne = random(sizeof(WeaponsOne));
            GivePlayerWeapon(playerid,WeaponsOne[RandOne][0],WeaponsOne[RandOne][1]);

            new RandTwo = random(sizeof(WeaponsTwo));
            GivePlayerWeapon(playerid,WeaponsTwo[RandTwo][0],WeaponsTwo[RandTwo][1]);

            new RandThree = random(sizeof(WeaponsThree));
            GivePlayerWeapon(playerid,WeaponsThree[RandThree][0],WeaponsThree[RandThree][1]);

            new RandFour = random(sizeof(WeaponsFour));
            GivePlayerWeapon(playerid,WeaponsFour[RandFour][0],WeaponsFour[RandFour][1]);

            new RandFive = random(sizeof(WeaponsFive));
            GivePlayerWeapon(playerid,WeaponsFive[RandFive][0],WeaponsFive[RandFive][1]);
		}
    }
    else
    {
        SetPlayerVirtualWorld(playerid, 1);
        SetPlayerInterior(playerid, PlayerInfo[playerid][SpawnInterior]);
		SetPlayerPos(playerid, PlayerInfo[playerid][posX],PlayerInfo[playerid][posY],PlayerInfo[playerid][posZ]);
		SetCameraBehindPlayer(playerid);
		if(God[playerid] == 0)
		{
            new RandOne = random(sizeof(WeaponsOne));
            GivePlayerWeapon(playerid,WeaponsOne[RandOne][0],WeaponsOne[RandOne][1]);

            new RandTwo = random(sizeof(WeaponsTwo));
            GivePlayerWeapon(playerid,WeaponsTwo[RandTwo][0],WeaponsTwo[RandTwo][1]);

            new RandThree = random(sizeof(WeaponsThree));
            GivePlayerWeapon(playerid,WeaponsThree[RandThree][0],WeaponsThree[RandThree][1]);
		}
    }
	if(PlayerInfo[playerid][pVip] == 1)
	{
		if(fr[playerid] == 1)
		{
	        SetPlayerArmour(playerid, 100);
		}
	}
	if(loggedcash[playerid] == 1)
	{
		GivePlayerMoney(playerid, 500000);
		loggedcash[playerid] = 0;
	}
	if(minigun[playerid] == 1)
	{
		GivePlayerWeapon(playerid, 38, 999999);
	}
	if(PlayerInfo[playerid][New] == 1)
	{
		new str[1000],str2[1000];
		PlayerInfo[playerid][New] = 0;
		PlayerInfo[playerid][pKills]++;
		PlayerInfo[playerid][pDeathmatchScore]++;
		PlayerInfo[playerid][DuelScore]++;

		format(str2,sizeof(str2),""COL_GREEN"Welcome to UGF - United Gaming FreeRoam\n");
		strcat(str, str2);
        format(str2,sizeof(str2),""COL_GREEN"FreeRoam/Stunt/DM\n\n");
        strcat(str, str2);
        format(str2,sizeof(str2),""COL_GREEN"Info\n");
        strcat(str, str2);
        format(str2,sizeof(str2),""COL_WHITE"- You have been given 1 freeroam and 1 deathmatch score\n\n");
        strcat(str, str2);
        format(str2,sizeof(str2),""COL_GREEN"Basic Help\n");
        strcat(str, str2);
        format(str2,sizeof(str2),""COL_WHITE"- You can spawn a vehicle by using the command (/v)\n");
        strcat(str, str2);
        format(str2,sizeof(str2),""COL_WHITE"- You can enable/diable godmode using the command (/god)\n");
        strcat(str, str2);
        format(str2,sizeof(str2),""COL_WHITE"- You can see the list of teleports using the command (/t)\n");
        strcat(str, str2);
        format(str2,sizeof(str2),""COL_WHITE"- You can teleport to a player using the command (/go [id])\n");
        strcat(str, str2);
        format(str2,sizeof(str2),""COL_WHITE"- You can check the player stats using the command (/stats [id] (optional)])\n");
        strcat(str, str2);
        format(str2,sizeof(str2),""COL_WHITE"- You can spawn a gun while godmode is deactivated using  the command (/w)\n");
        strcat(str, str2);
        format(str2,sizeof(str2),""COL_WHITE"- You can send a personal message to another player using the command (/pm [id] [message])\n\n");
        strcat(str, str2);
        format(str2,sizeof(str2),""COL_GREEN"Gamemode Help\n");
        strcat(str, str2);
        format(str2,sizeof(str2),""COL_WHITE"- You are currently in freeroam mode\n");
        strcat(str, str2);
        format(str2,sizeof(str2),""COL_WHITE"- If you want to join deathmatch mode you can you can use this command (/dm)\n");
        strcat(str, str2);
        format(str2,sizeof(str2),""COL_WHITE"- If you want to join back to freeroam mode you can use this command (/fr)\n");
        strcat(str, str2);
        ShowPlayerDialog(playerid, 500, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - Info", str, "OK", "");
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	}
	if(PlayerInfo[playerid][MinigunFight] == 1)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 38, 999999);
	}
	IsJumping[playerid] = 0;
    PlayerPlaySound(playerid,1063,0.0,0.0,0.0);
	TextDrawShowForPlayer(playerid, InfoTextdraw);
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	return 1;

}

public OnPlayerDeath(playerid, killerid, reason)
{
        PlayerInfo[playerid][pDeaths]++;

        SendDeathMessage(killerid, playerid, reason);
        SetPlayerWantedLevel(playerid, 0);
        
		if(PlayerInfo[playerid][MW] == 1)
		{
			DestroyDynamic3DTextLabel(MostWanted[playerid]);
			PlayerInfo[playerid][MW] = 0;
		}

	    if(PlayerInfo[playerid][Jail] == 0)
	    {

			if(DuelInfo[playerid][InDuel] == 1)
			{
				new str[120];
				DuelInfo[killerid][RoundsWon]++;
				PlayerInfo[killerid][DuelScore]++;
				
				DuelInfo[killerid][Rounds]--;
				DuelInfo[playerid][Rounds]--;
				
				format(str, sizeof(str),"~w~%s(%d)~n~~g~won the round~n~(%d/%d)",GetName(killerid), killerid, DuelInfo[killerid][Rounds], DuelInfo[killerid][TotalRounds]);

				GameTextForPlayer(playerid, str, 6000, 3);
				GameTextForPlayer(killerid, str, 6000, 3);

				if(DuelInfo[killerid][Rounds] == 0)
				{
					new str2[100], Winner, Loser;
					if(DuelInfo[killerid][RoundsWon] > DuelInfo[playerid][RoundsWon])
					{
						Winner = killerid;
						Loser = playerid;
					}
					if(DuelInfo[playerid][RoundsWon] > DuelInfo[killerid][RoundsWon])
					{
						Winner = playerid;
						Loser = killerid;
					}
					format(str2, sizeof(str2),"[DUEL] %s(%d) won the duel against %s(%d) [%d:%d]",GetName(Winner), Winner, GetName(Loser), Loser, DuelInfo[Winner][RoundsWon], DuelInfo[Loser][RoundsWon]);
					foreach(Player, i)
					{
						if(PlayerInfo[i][CMS] == 1)
						{
							SendClientMessage(i, COLOR_GREEN, str2);
						}
					}
				}
				else
				{
				    DuelInfo[playerid][InDuel] = 1;
				    DuelInfo[killerid][InDuel] = 1;
				    SetDuel(killerid);
				}

			}

		    if(GetPlayerWantedLevel(killerid) < 6)
		    {
		       if(DuelInfo[killerid][InDuel] == 0) { SetPlayerWantedLevel(killerid, GetPlayerWantedLevel(killerid) + 1); }
		       if(DuelInfo[killerid][InDuel] == 1) { SetPlayerWantedLevel(killerid, 0); }
		    }

		    new message[258];
		    new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, sizeof(name));

			if(fr[killerid] == 1)
			{
				new score;
				
				if(PlayerInfo[playerid][MW] == 1) { score = 5; PlayerInfo[playerid][MW] = 0; }
				else if(PlayerInfo[playerid][MW] == 0) { score = 1; }
			
				format(message, sizeof(message), "~g~You Killed ~n~~w~%s ~n~~n~~g~%d Freeroam Score", name, score);
				GameTextForPlayer(killerid, message, 3000, 3);
			    PlayerInfo[killerid][pKills]++;
			}

			if(indm[killerid] >= 1)
			{
				new State[10];
				new score;
				
				if(headshot[playerid] == 1) { State = "Headshot"; headshot[playerid] = 0; score = 3; }
				else if(headshot[playerid] == 0) { State = ""; score = 1; }

				if(PlayerInfo[playerid][MW] == 1) { score = 5; PlayerInfo[playerid][MW] = 0; }
				else if(PlayerInfo[playerid][MW] == 0) { score = 1; }
			
				format(message, sizeof(message), "~g~You Killed ~n~~w~%s ~n~~n~~r~%d Deathmatch Score~n~~n~%s", name, score, State);
				GameTextForPlayer(killerid, message, 3000, 3);
				
				PlayerInfo[killerid][pDeathmatchScore] += score;
			}

		    if(IsPlayerConnected(killerid))
		    {
				if(killerid != INVALID_PLAYER_ID)
				{
					new str[258];
					new State[10];
					
					if(headshot[playerid] == 1) { State = "Headshot"; headshot[playerid] = 0; }
					else if(headshot[playerid] == 0) { State = ""; }
					
					format(str, sizeof(str),"~g~You Got Killed By ~n~~w~%s~n~~r~%s", GetName(killerid), State);
					GameTextForPlayer(playerid, str, 3000, 3);
				}
			}

	        new KillerName[MAX_PLAYER_NAME];
	        GetPlayerName(killerid, KillerName, sizeof(KillerName));
		    if(GetPlayerWantedLevel(killerid) == 6)
		    {
				if(PlayerInfo[killerid][MW] == 0)
				{
					new string[250];
					new mode[15];
					
					if(fr[killerid] == 1) { mode = "DEATHMATCH"; }
					if(indm[killerid] >= 1) { mode = "FREEROAM"; }
					
			        format(string,sizeof(string),"[%s] %s(%d) has killed %s(%d) and is now most wanted",mode,KillerName,killerid,GetName(playerid),playerid);
			        SendClientMessageToAll(COLOR_GREENZ, string);
			        SetPlayerArmour(killerid,100);
			        SetPlayerHealth(killerid,100);
			        PlayerInfo[killerid][MW] = 1;
			        MostWanted[killerid] = CreateDynamic3DTextLabel("{00FF00}[Most Wanted]", -1, 0.0, 0.0, -0.9, 20, killerid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 25.0);
				}
			}
		}
	    return 1;
}

public OnPlayerGiveDamage(playerid, damagedid)
{
	if(God[damagedid] == 1) return GameTextForPlayer(playerid,"~g~Player has god mode",4500,3);
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
    if(issuerid != INVALID_PLAYER_ID && weaponid == 34 && bodypart == 9)
    {
        SetPlayerHealth(playerid, 0);
        PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0);
        headshot[playerid] = 1;
    }
    return 1;
}

public OnVehicleSpawn( vehicleid )
{
	#if !defined IGNORE_VEHICLE_DELETION
    	if ( gDialogCreated[ vehicleid ] )
	    {
    	    DestroyVehicle( vehicleid );
        	gDialogCreated[ vehicleid ] = false;
	    }
	#endif
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}


public OnPlayerText(playerid, text[])
{
	            if(PlayerInfo[playerid][pMuted] == 0)
	            {

		            new ChatBubble[MAX_CHATBUBBLE_LENGTH+1];
					new Chats[MAX_CHATBUBBLE_LENGTH+1];

			        if(text[0] == VipChatKey && PlayerInfo[playerid][pVip] >= 1)
				    {
	                          new sText[128];

	                          
		                      format(sText, sizeof(sText), "*[VIP] %s(%d): %s", GetName(playerid), playerid, ColouredText(text[1]), playerid);
		                      format(ChatBubble,MAX_CHATBUBBLE_LENGTH,"%s",  ColouredText(text[1]));
		                      SetPlayerChatBubble(playerid,ChatBubble,MESSAGE_COLOR,35.0,10000);
		                      SendClientMessageToAll(COLOR_AQUA, sText);
		                      VipChatLog(playerid, text);
					          return 0;
				    }

			        if(text[0] == AdminChatKey && PlayerInfo[playerid][pAdmin] >= 1)
				    {
							new str[250];
							format(str,sizeof(str),"*[ADMIN] %s(%d): %s",GetName(playerid),playerid,text[1]);
                            for(new i = 0; i < MAX_PLAYERS; i++)
							{
								if(PlayerInfo[i][pAdmin] >= 1)
								{
								    SendClientMessage(i, COLOR_GREEN, str);
								}
							}
							AdminChatLog(playerid, text);
					        return 0;
				    }
				    
			        if(text[0] == LevelAdminChatKey && PlayerInfo[playerid][pAdmin] >= 1)
				    {
							new str[250];
							format(str,sizeof(str),"*[ADMIN] %s(%d): %s",GetName(playerid),playerid,text[1]);
                            for(new i = 0; i < MAX_PLAYERS; i++)
							{
								if(PlayerInfo[i][pAdmin] == PlayerInfo[playerid][pAdmin])
								{
								    SendClientMessage(i, COLOR_GREEN, str);
								}
							}
							AdminChatLog(playerid, text);
					        return 0;
				    }

					if(!StringContainsIP(text))
					{
					    format(ChatBubble,MAX_CHATBUBBLE_LENGTH,"%s",text);
					    format(Chats,MAX_CHATBUBBLE_LENGTH,"{%06x}%s(%d):{FFFFFF} %s",GetPlayerColor(playerid) >>> 8,GetName(playerid),playerid,text);
	                    SetPlayerChatBubble(playerid,ChatBubble,MESSAGE_COLOR,35.0,10000);
						ChatLog(playerid, text);
			            foreach(Player, i)
						{
						    if(PlayerInfo[i][CMS] == 1)
						    {
			                    SendClientMessage(i, 0xFFFFFFFF, Chats);
						    }
						}
					}
				}
                return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(GetPlayerVehicleSeat(playerid) == 0)
    {
        new engine, lights, alarm, doors, bonnet, boot, objective;
        GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	    if(doors == 1)
	    {
		    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		    SetVehicleParamsEx(vehicleid,engine,lights,alarm,false,bonnet,boot,objective);
		    return 1;
	    }
	    if(rvc[playerid] == 1)
	    {
			KillTimer(RVColorTimer[playerid]);
			rvc[playerid] = 0;
	    }
	}
    return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
    PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public AFKReset(playerid)
{
	AFK[playerid] = 1;
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(fr[playerid] == 1)
	{
	    if(GetPlayerState(playerid) == 2)
	    {
			new vehicleid = GetPlayerVehicleID(playerid);
			new Float:x, Float:y, Float:z, Float:a;
			GetPlayerPos(playerid, x, y, z);
			GetPlayerFacingAngle(playerid, a);
			SetVehiclePos(vehicleid, fX, fY, z+5);
			SetPlayerFacingAngle(playerid, a);
			PutPlayerInVehicle(playerid, vehicleid, 0);
		}
		SetPlayerPosFindZ(playerid, fX, fY, fZ+5);
	}
    return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public ColorChanger(playerid)
{
   new vehicleid = GetPlayerVehicleID(playerid);
   ChangeVehicleColor(vehicleid, -1, -1);
}


public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	new x = 0;
	while(x != MAX_PLAYERS) {
	    if( IsPlayerConnected(x) &&	GetPlayerState(x) == PLAYER_STATE_SPECTATING &&
			gSpectateID[x] == playerid && gSpectateType[x] == ADMIN_SPEC_TYPE_PLAYER )
   		{
   		    SetPlayerInterior(x,newinteriorid);
		}
		x++;
	}
	return 1;
}

public OnTextDrawDialogResponse(playerid, response, dialogid, listitem)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_SECONDARY_ATTACK)
	{
		if(Anim[playerid] == 1)
		{
			ClearAnimations(playerid);
			Anim[playerid] = 0;
		}
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER && IsBulletWeapon(GetPVarInt(playerid, "switch_WeaponID")))
	{
	    if(newkeys & KEY_LOOK_RIGHT)
	    {
			new curWeap = GetPVarInt(playerid, "switch_WeaponID"), weapSlot = GetWeaponSlot(curWeap), weapID, weapAmmo;

			for(new i = weapSlot + 1; i <= 7; i++)
			{
				GetPlayerWeaponData(playerid, i, weapID, weapAmmo);
				if(IsBulletWeapon(weapID) && weapID != curWeap)
			 	{
				 	SetPlayerArmedWeaponEx(playerid, weapID);
				 	break;
				}
			}
		}
        if(newkeys & KEY_LOOK_LEFT)
        {
            new curWeap = GetPVarInt(playerid, "switch_WeaponID"), weapSlot = GetWeaponSlot(curWeap), weapID, weapAmmo;

            for(new i = weapSlot - 1; i >= 2; i--)
            {
                GetPlayerWeaponData(playerid, i, weapID, weapAmmo);
                if(IsBulletWeapon(weapID) && weapID != curWeap)
                {
                    SetPlayerArmedWeaponEx(playerid, weapID);
                    break;
                }
            }
        }
	}
	if(newkeys == KEY_SECONDARY_ATTACK)
	{
		if(Spectating[playerid] == 1)
		{
			Spectating[playerid] = 0;
            TogglePlayerSpectating(playerid, 0);
            gSpectateType[playerid] = ADMIN_SPEC_TYPE_NONE;
            SpawnPlayer(playerid);
		    TextDrawHideForPlayer(playerid, Press);
		}
	}
	
    if(newkeys & KEY_SECONDARY_ATTACK)
    {
        if(ControllingShip[playerid] == 1)
        {
            new Float:X,Float:Y,Float:Z;
	        GetPlayerPos(playerid, X,Y,Z);
	        SetPlayerPos(playerid, X,Y+2,Z+6);
	        SetCameraBehindPlayer(playerid);
	        ControllingShip[playerid] = 0;
	        DestroyObject(Camera);
        }
    }
    
    if(newkeys & KEY_JUMP)
    {
   		if (MegaJump[playerid] == 1)
		{
			if(PlayerInfo[playerid][pVip] == 1)
			{
				if(Jumped[playerid] == 0)
				{
				   	new Float:Jump[3];
				   	Jumped[playerid] = 1;
				    GetPlayerVelocity(playerid, Jump[0], Jump[1], Jump[2]);
				    SetPlayerVelocity(playerid, Jump[0], Jump[1], Jump[2]+5);
				    SetTimerEx("JumpTimer", 1500, false, "i", playerid);
			    }
			}
		}
	}
	
	if(IsPlayerInAnyVehicle(playerid))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(PRESSED(KEY_FIRE))
			{
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
				new vehicleid = GetPlayerVehicleID(playerid);
				AddVehicleComponent(vehicleid, 1010); }
			}

			if(RELEASED(KEY_FIRE))
			{
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
				new vehicleid = GetPlayerVehicleID(playerid);
				RemoveVehicleComponent(vehicleid, 1010); }
			}

			if(newkeys & KEY_CROUCH)
			{
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
				new Float:x,Float:y,Float:z,Float:a,playervid = GetPlayerVehicleID(playerid);
				GetVehiclePos(playervid, x, y, z);
			    GetVehicleZAngle(playervid, a);
			    SetVehiclePos(playervid, x, y, z + 3);
			    SetVehicleZAngle(playervid, a); }
		    }

		    if(newkeys & KEY_YES)
		    {
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
			    new Float:x, Float:y, Float:z;
			    GetVehicleVelocity(GetPlayerVehicleID(playerid), x, y, z);
			   	SetVehicleVelocity(GetPlayerVehicleID(playerid), x, y, z + 0.2); }
		    }

		    if(newkeys & KEY_SUBMISSION)
		    {
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
				new Float:vx,Float:vy,Float:vz;
				GetVehicleVelocity(GetPlayerVehicleID(playerid),vx,vy,vz);
				SetVehicleVelocity(GetPlayerVehicleID(playerid), vx * 1.8, vy *1.8, vz * 1.8); }
		    }
	    }
    }

    if(PlayerIn[playerid][BalloonPlayer] == 1)
    {
			new Float:X,Float:Y,Float:Z;
			GetObjectPos(Balloon[playerid],X,Y,Z);
			if ((newkeys & KEY_SPRINT) && (newkeys & KEY_YES)) { TimerUP[playerid] = SetTimerEx("MoveObjectUp", 30, 0, "i", playerid);  GameTextForPlayer(playerid,"~g~moving up",2000,3); }

			if ((newkeys & KEY_SPRINT) && (newkeys & KEY_NO)) { TimerDown[playerid] = SetTimerEx("MoveObjectDown", 30, 0, "i", playerid); GameTextForPlayer(playerid,"~g~moving down",2000,3); }

			if ((newkeys & KEY_SECONDARY_ATTACK) && (newkeys & KEY_YES)) { TimerForward[playerid] = SetTimerEx("MoveObjectForward", 30, 0, "i", playerid); GameTextForPlayer(playerid,"~g~moving forward",2000,3); }

			if ((newkeys & KEY_SECONDARY_ATTACK) && (newkeys & KEY_NO)) { TimerBack[playerid] = SetTimerEx("MoveObjectBack", 30, 0, "i", playerid); GameTextForPlayer(playerid,"~g~moving backward",2000,3); }

			if ((newkeys & KEY_WALK) && (newkeys & KEY_YES)) { TimerRight[playerid] = SetTimerEx("MoveObjectRight", 30, 0, "i", playerid); GameTextForPlayer(playerid,"~g~moving right",2000,3); }

			if ((newkeys & KEY_WALK) && (newkeys & KEY_NO)) { TimerLeft[playerid] = SetTimerEx("MoveObjectLeft", 30, 0, "i", playerid); GameTextForPlayer(playerid,"~g~moving left",2000,3); }
    }
    return 1;
}

public MoveObjectUp(playerid)
{
	KillTimer(TimerUP[playerid]);
	KillTimer(TimerDown[playerid]);
	KillTimer(TimerForward[playerid]);
	KillTimer(TimerBack[playerid]);
	KillTimer(TimerLeft[playerid]);
	KillTimer(TimerRight[playerid]);
    new Float:X,Float:Y,Float:Z;
	GetObjectPos(Balloon[playerid],X,Y,Z);
	MoveDynamicObject(Balloon[playerid],X,Y,Z+0.5,10.0);
    TimerUP[playerid] = SetTimerEx("MoveObjectUp", 0, 0, "i", playerid);
	return 1;
}

public MoveObjectDown(playerid)
{
	KillTimer(TimerUP[playerid]);
	KillTimer(TimerDown[playerid]);
	KillTimer(TimerForward[playerid]);
	KillTimer(TimerBack[playerid]);
	KillTimer(TimerLeft[playerid]);
	KillTimer(TimerRight[playerid]);

    new Float:X,Float:Y,Float:Z;
	GetObjectPos(Balloon[playerid],X,Y,Z);
	MoveDynamicObject(Balloon[playerid],X,Y,Z-0.5,10.0);
    TimerDown[playerid] = SetTimerEx("MoveObjectDown", 0, 0, "i", playerid);
	return 1;
}
public MoveObjectForward(playerid)
{
	KillTimer(TimerUP[playerid]);
	KillTimer(TimerDown[playerid]);
	KillTimer(TimerForward[playerid]);
	KillTimer(TimerBack[playerid]);
	KillTimer(TimerLeft[playerid]);
	KillTimer(TimerRight[playerid]);

    new Float:X,Float:Y,Float:Z;
	GetObjectPos(Balloon[playerid],X,Y,Z);
	MoveDynamicObject(Balloon[playerid],X,Y+0.5,Z,10.0);
    TimerForward[playerid] = SetTimerEx("MoveObjectForward", 0, 0, "i", playerid);
	return 1;
}
public MoveObjectBack(playerid)
{
	KillTimer(TimerUP[playerid]);
	KillTimer(TimerDown[playerid]);
	KillTimer(TimerForward[playerid]);
	KillTimer(TimerBack[playerid]);
	KillTimer(TimerLeft[playerid]);
	KillTimer(TimerRight[playerid]);

    new Float:X,Float:Y,Float:Z;
	GetObjectPos(Balloon[playerid],X,Y,Z);
	MoveDynamicObject(Balloon[playerid],X,Y-0.5,Z,10.0);
    TimerBack[playerid] = SetTimerEx("MoveObjectBack", 0, 0, "i", playerid);
	return 1;
}
public MoveObjectRight(playerid)
{
	KillTimer(TimerUP[playerid]);
	KillTimer(TimerDown[playerid]);
	KillTimer(TimerForward[playerid]);
	KillTimer(TimerBack[playerid]);
	KillTimer(TimerLeft[playerid]);
	KillTimer(TimerRight[playerid]);

    new Float:X,Float:Y,Float:Z;
	GetObjectPos(Balloon[playerid],X,Y,Z);
	MoveDynamicObject(Balloon[playerid],X+0.5,Y,Z,10.0);
    TimerRight[playerid] = SetTimerEx("MoveObjectRight", 0, 0, "i", playerid);
	return 1;
}
public MoveObjectLeft(playerid)
{
	KillTimer(TimerUP[playerid]);
	KillTimer(TimerDown[playerid]);
	KillTimer(TimerForward[playerid]);
	KillTimer(TimerBack[playerid]);
	KillTimer(TimerLeft[playerid]);
	KillTimer(TimerRight[playerid]);
	
    new Float:X,Float:Y,Float:Z;
	GetObjectPos(Balloon[playerid],X,Y,Z);
	MoveDynamicObject(Balloon[playerid],X-0.5,Y,Z,10.0);
    TimerLeft[playerid] = SetTimerEx("MoveObjectLeft", 0, 0, "i", playerid);
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public ShowVehicleNameForPlayer(playerid)
{
        new string[32];
        switch(GAMETEXT_COLOR)
        {
            case 0: format(string,sizeof(string),"%s",VehicleNames[VehicleModel[playerid]-400]); //yellow
            case 1: format(string,sizeof(string),"~b~%s",VehicleNames[VehicleModel[playerid]-400]); //blue
            case 2: format(string,sizeof(string),"~g~%s",VehicleNames[VehicleModel[playerid]-400]); //green
            case 3: format(string,sizeof(string),"~r~%s",VehicleNames[VehicleModel[playerid]-400]); //red
            case 4: format(string,sizeof(string),"~p~%s",VehicleNames[VehicleModel[playerid]-400]); //purple
            case 5: format(string,sizeof(string),"~w~%s",VehicleNames[VehicleModel[playerid]-400]); //white
            case 6: format(string,sizeof(string),"%~|~s",VehicleNames[VehicleModel[playerid]-400]); //black
        }
        GameTextForPlayer(playerid,string,2000,1);
        return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_PASSENGER)
	{
	    new weapID = GetPlayerWeapon(playerid);
		SetPVarInt(playerid, "switch_WeaponID", weapID);
	}
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
	{
		if(BeingSpectated[playerid] == 1)
		{
			new id = Spectator[playerid];
			PlayerSpectateVehicle(id, GetPlayerVehicleID(playerid));
		    SetPlayerInterior(playerid,GetPlayerInterior(id));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
		}
	}
	if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT)
	{
		if(BeingSpectated[playerid] == 1)
		{
			new id = Spectator[playerid];
			PlayerSpectatePlayer(id, playerid);
			SetPlayerInterior(playerid,GetPlayerInterior(id));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
		}
		if(rvc[playerid] == 1)
		{
			KillTimer(RVColorTimer[playerid]);
			rvc[playerid] = 0;
		}
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
		new engine,lights,alarm,doors,bonnet,boot,objective, vehicleid;
		vehicleid = GetPlayerVehicleID(playerid);
        GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
        SetVehicleParamsEx(vehicleid,true,lights,alarm,doors,bonnet,boot,objective);
	}
    if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
        VehicleModel[playerid] = GetVehicleModel(GetPlayerVehicleID(playerid));
        ShowVehicleNameForPlayer(playerid);
        return 1;
    }
    if(newstate != PLAYER_STATE_DRIVER && (oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)) KillTimer(CFCTimer);
    if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
        // Get the players vehicle ID
        new player_vehicle = GetPlayerVehicleID(playerid);

        // Check if the player is driving one of the Infernuses created by this filterscript
        if (IsSIInfernus(player_vehicle))
		{
		    // Disable vehicle collisions and set PVar
            DisableRemoteVehicleCollisions(playerid, true);
            SetPVarInt(playerid, "SIVehicleCols", 1);
		}
	}
	else
	{
	    // Check if the PVar is set (player had vehicle collisions disabled)
	    if (GetPVarInt(playerid, "SIVehicleCols"))
		{
		    // Enable vehicle collisions and set PVar
		    DisableRemoteVehicleCollisions(playerid, false);
		    SetPVarInt(playerid, "SIVehicleCols", 0);
		}
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
    new playerip[16];
	if(success)
	{
        for(new i=0; i<MAX_PLAYERS; i++)
        {
            GetPlayerIp(i, playerip, sizeof(playerip));
            if(!strcmp(ip, playerip, true))
            {
				#if SECOND_RCON == 1
				
				    General = i;
				
					printf("[RCON] %s(%d) has logged in", i, GetName(i));
					printf("[RCON] Server RCON Confirmation Status: (On)");
					printf("[RCON] Showing confirmation dialog");
					
					ShowPlayerDialog(i, 3000, DIALOG_STYLE_INPUT, "UGF - RCON Confirmation", "Please enter the second RCON password to proceed.", "Login", "");

				#else

					printf("[RCON] %s(%d) has logged in", i, GetName(i));
					printf("[RCON] Server RCON Confirmation Status: (Off)");
			  		printf("[RCON] Player IP: %s", ip);
					printf("[RCON] Setting Player VIP Status To:  1");
					printf("[RCON] Setting Player Admin Level To: 7");
					PlayerInfo[i][pAdmin] = 7;
					PlayerInfo[i][pVip] = 1;
					GameTextForPlayer(i, "~g~~n~~n~~n~~n~~n~Welcome Administraitor", 4500, 3);
					
				#endif
		    }
		}
	}
	
    if(!success)
    {
        for(new i=0; i<MAX_PLAYERS; i++)
        {
            GetPlayerIp(i, playerip, sizeof(playerip));
            if(!strcmp(ip, playerip, true))
            {
				printf("[RCON] %s(%d) has failed to login");
		  		printf("[RCON] Player IP: %s", ip);
				printf("[RCON] Kicking Player");
                Kick(i);
            }
        }
    }
	return 1;
}

public OnPlayerUpdate(playerid)
{
	SetPlayerScore(playerid, PlayerInfo[playerid][pDeathmatchScore] + PlayerInfo[playerid][pKills] + PlayerInfo[playerid][DuelScore]);
	PlayerInfo[playerid][TotalScore] = GetPlayerScore(playerid);

    AFK[playerid] = 0;

	/*if(PlayerIn[playerid][BalloonPlayer] == 1)
	{
		new Float:x,Float:y,Float:z;
		GetObjectPos(Balloon[playerid], x, y, z);
		if(!IsPlayerInRangeOfPoint(playerid, MAX_OBJECT_DESTROY_DISTANCE, x, y, z))
		{
		    DestroyDynamicObject(Balloon[playerid]);
		    DestroyDynamicObject(Fire[playerid]);
		    DestroyDynamicObject(Fire1[playerid]);
		    PlayerIn[playerid][BalloonPlayer] = 0;
		    GameTextForPlayer(playerid,"~g~Destroyed controllable object",4500,3);
		}
	}*/
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
    return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	SendToAdmins(playerid, cmdtext);
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{

	if(dialogid == DIALOG_LOGIN)
	{
          new str1[256], InputPass[129], Password[129], query[100], ip[30];
          if(!response)
          {
              format(str1, 150, "{FFFFFF}This name is registered,enter a password for this account:\n");
              ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, ""COL_GREEN"UGF - Login", str1, "Login", "");
          }
          
          WP_Hash(InputPass, sizeof(InputPass), inputtext);
          WP_Hash(Password, sizeof(Password), PlayerInfo[playerid][pPass]);
          
          if(!strcmp(InputPass, Password))
          {
		              mysql_format(mysql, query, sizeof(query), "SELECT * FROM `players` WHERE `Name` = '%e' LIMIT 1", GetName(playerid));
		              mysql_tquery(mysql, query, "LoadUser_data", "i", playerid);
		              
	                  GetPlayerIp(playerid, ip, sizeof(ip));
                      mysql_format(mysql, query, sizeof(query), "UPDATE `players` SET `IP` = %e WHERE `Account_ID` = %d",ip, PlayerInfo[playerid][Accountid]);
                      mysql_query(mysql, query);
              
	                  SendClientMessage(playerid, COLOR_RED, "* You have logged in your account");
	                  PlayerInfo[playerid][pLogged] = 1;
	                  loggedcash[playerid] = 1;
	                  SetPlayerFightingStyle(playerid, PlayerInfo[playerid][FightStyles]);
	                  SetPlayerTime(playerid, PlayerInfo[playerid][Time], 0);
	                  SetPlayerWeather(playerid, PlayerInfo[playerid][Weather]);


					  if(PlayerInfo[playerid][pColor] != 0)
					  {
                          SetPlayerColor(playerid, PlayerInfo[playerid][pColor]);
					  }
					  if(PlayerInfo[playerid][pBan] == 1)
					  {
                           ShowPlayerDialog(playerid, 123, DIALOG_STYLE_MSGBOX, ""COL_GREEN"Banned", ""COL_WHITE"You are banned from this server and can request to be unbanned. \n Vist" ""COL_WHITE""WEBSITE_URL"" ""COL_GREEN"to make an unban appeal.""", "", "OK");
                           SetTimerEx("KickPlayer", 1000, false, "i", playerid);
					  }
          }
          else
          {
	            new string[50];
	            counts++;
	            if(counts == 1)
	            {
	                format(string, sizeof(string),"%s_tmp",GetName(playerid));
	            }
	            else
				{
                    format(string, sizeof(string),"%s_tmp%d",GetName(playerid),counts);
	            }
	            
	            SetPlayerName(playerid, string);
	            PlayerInfo[playerid][pLogged] = 0;
	            PlayerInfo[playerid][Accountid] = -1;
	            PlayerInfo[playerid][FailedLog] = 1;
			    God[playerid] = 0;
			    MegaJump[playerid] = 0;
			    PlayerInfo[playerid][pAdmin] = 0;
			    PlayerInfo[playerid][pVip] = 0;
			    PlayerInfo[playerid][Pms] = 0;
			    PlayerInfo[playerid][Gos] = 1;
			    PlayerInfo[playerid][pDeaths] = 0;
			    PlayerInfo[playerid][pKills] = 0;
			    PlayerInfo[playerid][pDeathmatchScore] = 0;
			    PlayerInfo[playerid][CMS] = 1;
			    PlayerInfo[playerid][Usingskin] = 0;
			    PlayerInfo[playerid][BanC] = 0;
			    PlayerInfo[playerid][JailC] = 0;
			    PlayerInfo[playerid][MuteC] = 0;
			    PlayerInfo[playerid][ExplodeC] = 0;
			    PlayerInfo[playerid][SlapC] = 0;
			    PlayerInfo[playerid][WeaponRC] = 0;
			    PlayerInfo[playerid][DisarmC] = 0;
			    PlayerInfo[playerid][pMuted] = 0;
			    PlayerInfo[playerid][Jail] = 0;
			    PlayerInfo[playerid][Freeze] = 0;
			    PlayerInfo[playerid][Banned] = 0;
			    PlayerInfo[playerid][pBan] = 0;
			    PlayerInfo[playerid][Invisible] = 0;
		  }
	}

    if(dialogid == DIALOG_REGISTER)
    {
		    new str[1000];
		    if(!response) return PlayerInfo[playerid][pLogged] = 0;
            if(response)
            {
                if(!strlen(inputtext) || strlen(inputtext) < 5 || strlen(inputtext) > 30)
                {
					format(str, 150, "\n{FFFFFF}Welcome To FreeRoam Server\n\n{00FF00}Account Name:{FFFFFF} %s\n\nEnter A Password To Register This Account\n"COL_RED"Password should be more can 5 letters long and less than 30 letters", GetName(playerid));
		            ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Register", str, "Register", "");
		            return 0;
                }
	            
	            new query[1000], qstr[1000], lastlogin[100], Year, Month, Day;
				getdate(Year, Month, Day);
	            format(lastlogin, sizeof(lastlogin),"%02d/%02d/%d",Day,Month,Year);
	            
				//================//*
				new ip[265];
				GetPlayerIp(playerid , ip,50);
				//================//*
				////////////////////////////////////////////////////////////////
                
			    strcat(qstr, "INSERT INTO `players`(");
				strcat(qstr, "`Account_ID`,");
				strcat(qstr, "`Name`,");
				strcat(qstr, "`Password`,");
				strcat(qstr, "`IP`,");
				strcat(qstr, "`Admin`,");
				strcat(qstr, "`VIP`,");
				strcat(qstr, "`FreeRoam_Score`,");
				strcat(qstr, "`Deathmatch_Score`,");
				strcat(qstr, "`Duel_Score`,");
				strcat(qstr, "`Deaths`,");
			    strcat(qstr, "`Skin`,");
				strcat(qstr, "`Pms`,");
				strcat(qstr, "`Gos`,");
				strcat(qstr, "`God`,");
				strcat(qstr, "`Cms`,");
				strcat(qstr, "`aCms`,");
				strcat(qstr, "`MegaJump`,");
				strcat(qstr, "`Color`,");
				strcat(qstr, "`Fighting_Style`,");
				strcat(qstr, "`BanCount`,");
				strcat(qstr, "`JailCount`,");
				strcat(qstr, "`KickCount`,");
				strcat(qstr, "`MuteCount`,");
				strcat(qstr, "`ExplodeCount`,");
				strcat(qstr, "`SlapCount`,");
			    strcat(qstr, "`WeaponRCount`,");
				strcat(qstr, "`Banned`,");
				strcat(qstr, "`Jailed`,");
				strcat(qstr, "`Muted`,");
				strcat(qstr, "`Frozen`,");
				strcat(qstr, "`JailTime`,");
				strcat(qstr, "`Time`,");
				strcat(qstr, "`Weather`,");
				strcat(qstr, "`Spawn`,");
				strcat(qstr, "`Spawn_Interior`,");
				strcat(qstr, "`Spawn_X`,");
				strcat(qstr, "`Spawn_Y`,");
				strcat(qstr, "`Spawn_Z`,");
				strcat(qstr, "`Spawn_Angle`)");
				strcat(qstr, " VALUES ");
				strcat(qstr, "('%d','%e','%e','%e', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, '%d', 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0)");

				mysql_format(mysql, query, sizeof(query), qstr, PlayerInfo[playerid][Accountid], GetName(playerid), inputtext, ip, PlayerInfo[playerid][pColor]);
	            mysql_query(mysql, query);

				PlayerInfo[playerid][Accountid] = cache_insert_id();
                PlayerInfo[playerid][Pms] = 0;
                PlayerInfo[playerid][Gos] = 1;
                PlayerInfo[playerid][Time] = 12;
                PlayerInfo[playerid][Weather] = 0;
				PlayerInfo[playerid][CMS] = 1;
				PlayerInfo[playerid][pColor] = GetPlayerColor(playerid);
				PlayerInfo[playerid][pLogged] = 1;
				loggedcash[playerid] = 1;
                SendClientMessage(playerid, COLOR_RED, "* Account Registered");
                SendClientMessage(playerid, COLOR_RED, "* You have logged in your account");
				ForceClassSelection(playerid);
            }
    }
    
    if(dialogid == 1015)
    {
		if(listitem == 0)
		{
            new id;
			CheckID[playerid] = id;
			TogglePlayerSpectating(playerid, 1);
			PlayerSpectatePlayer(playerid, id);
			SetPlayerInterior(playerid,GetPlayerInterior(id));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
			gSpectateID[playerid] = id;
			gSpectateType[playerid] = ADMIN_SPEC_TYPE_PLAYER;
			Spectating[playerid] = 1;
			BeingSpectated[id] = 1;
			Spectator[id] = playerid;
	        TextDrawShowForPlayer(playerid, Press);
	        new Float:x, Float:y, Float:z, Float:health;
			GetPlayerPos(id, x, y, z);
		    GetPlayerHealth(id, health);
		    SetPlayerHealth(id, health-25);
			SetPlayerPos(id, x, y, z+5);
			PlayerInfo[id][SlapC]++;
		    PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
		    PlayerPlaySound(id, 1190, 0.0, 0.0, 0.0);
			PlayerInfo[id][ExplodeC]++;
			CreateExplosion(x, y, z, 7, 1.00);
			
			new str[250];
			format(str, sizeof(str), "~g~You checked %s(%d) for health hack using meathod (1)", GetName(id), id);
			SendClientMessage(playerid, BAN, str);
		}
		if(listitem == 1)
		{
            new id;
			CheckID[playerid] = id;
			TogglePlayerSpectating(playerid, 1);
			PlayerSpectatePlayer(playerid, id);
			SetPlayerInterior(playerid,GetPlayerInterior(id));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
			gSpectateID[playerid] = id;
			gSpectateType[playerid] = ADMIN_SPEC_TYPE_PLAYER;
			Spectating[playerid] = 1;
			BeingSpectated[id] = 1;
			Spectator[id] = playerid;
	        TextDrawShowForPlayer(playerid, Press);
	        new Float:x, Float:y, Float:z, Float:health;
			GetPlayerPos(id, x, y, z);
		    GetPlayerHealth(id, health);
		    SetPlayerHealth(id, health-25);
			SetPlayerPos(id, x, y, z+5);
			PlayerInfo[id][SlapC]++;
		    PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
		    PlayerPlaySound(id, 1190, 0.0, 0.0, 0.0);
			PlayerInfo[id][ExplodeC]++;
			CreateExplosion(x, y, z, 7, 1.00);
			CreateExplosion(x, y, z, 0, 10.0);
			
			new str[250];
			format(str, sizeof(str), "~g~You checked %s(%d) for health hack using meathod (2)", GetName(id), id);
			SendClientMessage(playerid, BAN, str);
		}
    }
	if(dialogid == 141)
	{
		if(response)
		{
			if(listitem == 0)
			{
                ClearAnimations(playerid);
				GameTextForPlayer(playerid,"~g~Stopped Animation", 4500, 3);
			}
			if(listitem == 1)
			{
                SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
			}
			if(listitem == 2)
			{
                SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
			}
			if(listitem == 3)
			{
                SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
			}
			if(listitem == 4)
			{
                SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
			}
			if(listitem == 5)
			{
                ApplyAnimation(playerid,"PAULNMAC","wank_loop",4.0,1,1,1,1,0);
			}
			if(listitem == 6)
			{
                ApplyAnimation(playerid,"PED","SEAT_idle", 4.0, 1, 0, 0, 0, 0);
			}
			if(listitem == 7)
			{
			    ApplyAnimation(playerid,"SWEET","Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0);
			}
			if(listitem == 8)
			{
                ApplyAnimation(playerid,"SWEET","sweet_ass_slap",4.0,0,0,0,0,0);
			}
		}
    }
	
	if(dialogid == 140)
	{
		if(response)
		{
			if(listitem == 0)
			{
				SetPlayerDrunkLevel(playerid, 2000);
			}
			if(listitem == 1)
			{
				SetPlayerDrunkLevel(playerid, 4000);
			}
			if(listitem == 2)
			{
				SetPlayerDrunkLevel(playerid, 8000);
			}
			if(listitem == 3)
			{
				SetPlayerDrunkLevel(playerid, 12000);
			}
			if(listitem == 4)
			{
				SetPlayerDrunkLevel(playerid, 16000);
			}
			if(listitem == 5)
		   	{
				SetPlayerDrunkLevel(playerid, 50000);
			}
		}
	}
	if(dialogid == 130)
	{
		if(response)
		{
            new strings[50],string2[400];
			DuelInfo[playerid][WeaponOne] = Weapon[listitem][WeaponID];
		    for(new i;i<sizeof(Weapon);i++)
		    {
				format(strings,sizeof(strings),"%s\n",Weapon[i][WeaponName]);
				strcat(string2, strings);
		    }
		    ShowPlayerDialog(playerid, 131, DIALOG_STYLE_LIST, "Duel Weapon 2", string2, "Next", "Cancel");
		}
	}
	if(dialogid == 131)
	{
		if(!response)
		{
            new strings[50],string2[400];
			DuelInfo[playerid][WeaponOne] = Weapon[listitem][WeaponID];
		    for(new i;i<sizeof(Weapon);i++)
		    {
				format(strings,sizeof(strings),"%s\n",Weapon[i][WeaponName]);
				strcat(string2, strings);
		    }
		    ShowPlayerDialog(playerid, 131, DIALOG_STYLE_LIST, "Duel Weapon 2", string2, "Next", "Cancel");
		}
		if(response)
		{
            new strings[50],string2[400];
			DuelInfo[playerid][WeaponTwo] = Weapon[listitem][WeaponID];
		    for(new i;i<sizeof(Weapon);i++)
		    {
				format(strings,sizeof(strings),"%s\n",Weapon[i][WeaponName]);
				strcat(string2, strings);
		    }
		    ShowPlayerDialog(playerid, 132, DIALOG_STYLE_LIST, "Duel Weapon 3", string2, "Next", "Back");
		}
	}
	if(dialogid == 132)
	{
		if(!response)
		{
            new strings[50],string2[400];
			DuelInfo[playerid][WeaponTwo] = Weapon[listitem][WeaponID];
		    for(new i;i<sizeof(Weapon);i++)
		    {
				format(strings,sizeof(strings),"%s\n",Weapon[i][WeaponName]);
				strcat(string2, strings);
		    }
		    ShowPlayerDialog(playerid, 132, DIALOG_STYLE_LIST, "Duel Weapon 3", string2, "Next", "Back");
		}
		if(response)
		{
			DuelInfo[playerid][WeaponThree] = Weapon[listitem][WeaponID];
			ShowPlayerDialog(playerid, 133, DIALOG_STYLE_LIST, "Duel Health", "100\n90\n80\n70\n60\n50\n40\n30\n\n20\n10\n0", "Next", "Back");
		}
	}

	if(dialogid == 133)
	{
		if(!response)
		{
            ShowPlayerDialog(playerid, 133, DIALOG_STYLE_LIST, "Duel Health", "100\n90\n80\n70\n60\n50\n40\n30\n\n20\n10\n0", "Next", "Back");
		}
	    if(response)
		{
			if(listitem == 0)
			{
				DuelInfo[playerid][Health] = 100;
				ShowPlayerDialog(playerid, 134, DIALOG_STYLE_LIST, "Duel Armour", "100\n90\n80\n70\n60\n50\n40\n30\n\n20\n10\n0", "Next", "Back");
			}
			if(listitem == 1)
			{
				DuelInfo[playerid][Health] = 90;
				ShowPlayerDialog(playerid, 134, DIALOG_STYLE_LIST, "Duel Armour", "100\n90\n80\n70\n60\n50\n40\n30\n\n20\n10\n0", "Next", "Back");
			}
			if(listitem == 2)
			{
				DuelInfo[playerid][Health] = 80;
				ShowPlayerDialog(playerid, 134, DIALOG_STYLE_LIST, "Duel Armour", "100\n90\n80\n70\n60\n50\n40\n30\n\n20\n10\n0", "Next", "Back");
			}
			if(listitem == 3)
			{
				DuelInfo[playerid][Health] = 70;
				ShowPlayerDialog(playerid, 134, DIALOG_STYLE_LIST, "Duel Armour", "100\n90\n80\n70\n60\n50\n40\n30\n\n20\n10\n0", "Next", "Back");
			}
			if(listitem == 4)
			{
				DuelInfo[playerid][Health] = 60;
				ShowPlayerDialog(playerid, 134, DIALOG_STYLE_LIST, "Duel Armour", "100\n90\n80\n70\n60\n50\n40\n30\n\n20\n10\n0", "Next", "Back");
			}
			if(listitem == 5)
			{
				DuelInfo[playerid][Health] = 50;
				ShowPlayerDialog(playerid, 134, DIALOG_STYLE_LIST, "Duel Armour", "100\n90\n80\n70\n60\n50\n40\n30\n\n20\n10\n0", "Next", "Back");
			}
			if(listitem == 6)
			{
				DuelInfo[playerid][Health] = 40;
				ShowPlayerDialog(playerid, 134, DIALOG_STYLE_LIST, "Duel Armour", "100\n90\n80\n70\n60\n50\n40\n30\n\n20\n10\n0", "Next", "Back");
			}
			if(listitem == 7)
			{
				DuelInfo[playerid][Health] = 30;
				ShowPlayerDialog(playerid, 134, DIALOG_STYLE_LIST, "Duel Armour", "100\n90\n80\n70\n60\n50\n40\n30\n\n20\n10\n0", "Next", "Back");
			}
			if(listitem == 8)
			{
				DuelInfo[playerid][Health] = 20;
				ShowPlayerDialog(playerid, 134, DIALOG_STYLE_LIST, "Duel Armour", "100\n90\n80\n70\n60\n50\n40\n30\n\n20\n10\n0", "Next", "Back");
			}
			if(listitem == 9)
			{
				DuelInfo[playerid][Health] = 10;
				ShowPlayerDialog(playerid, 134, DIALOG_STYLE_LIST, "Duel Armour", "100\n90\n80\n70\n60\n50\n40\n30\n\n20\n10\n0", "Next", "Back");
			}
		}
	}
	if(dialogid == 134)
	{
		if(!response)
		{
            ShowPlayerDialog(playerid, 134, DIALOG_STYLE_LIST, "Duel Armour", "100\n90\n80\n70\n60\n50\n40\n30\n\n20\n10\n0", "Next", "Back");
		}
		if(response)
		{
			if(listitem == 0)
			{
				DuelInfo[playerid][Armour] = 100;
				ShowPlayerDialog(playerid, 135, DIALOG_STYLE_LIST, "Duel Rounds", "1\n2\n3\n4\n5\n6\n7\n8\n9\n10", "Next", "Back");
			}
			if(listitem == 1)
			{
				DuelInfo[playerid][Armour] = 90;
				ShowPlayerDialog(playerid, 135, DIALOG_STYLE_LIST, "Duel Rounds", "1\n2\n3\n4\n5\n6\n7\n8\n9\n10", "Next", "Back");
			}
			if(listitem == 2)
			{
				DuelInfo[playerid][Armour] = 80;
				ShowPlayerDialog(playerid, 135, DIALOG_STYLE_LIST, "Duel Rounds", "1\n2\n3\n4\n5\n6\n7\n8\n9\n10", "Next", "Back");
			}
			if(listitem == 3)
			{
				DuelInfo[playerid][Armour] = 70;
				ShowPlayerDialog(playerid, 135, DIALOG_STYLE_LIST, "Duel Rounds", "1\n2\n3\n4\n5\n6\n7\n8\n9\n10", "Next", "Back");
			}
			if(listitem == 4)
			{
				DuelInfo[playerid][Armour] = 60;
				ShowPlayerDialog(playerid, 135, DIALOG_STYLE_LIST, "Duel Rounds", "1\n2\n3\n4\n5\n6\n7\n8\n9\n10", "Next", "Back");
			}
			if(listitem == 5)
			{
				DuelInfo[playerid][Armour] = 50;
				ShowPlayerDialog(playerid, 135, DIALOG_STYLE_LIST, "Duel Rounds", "1\n2\n3\n4\n5\n6\n7\n8\n9\n10", "Next", "Back");
			}
			if(listitem == 6)
			{
				DuelInfo[playerid][Armour] = 40;
				ShowPlayerDialog(playerid, 135, DIALOG_STYLE_LIST, "Duel Rounds", "1\n2\n3\n4\n5\n6\n7\n8\n9\n10", "Next", "Back");
			}
			if(listitem == 7)
			{
				DuelInfo[playerid][Armour] = 30;
				ShowPlayerDialog(playerid, 135, DIALOG_STYLE_LIST, "Duel Rounds", "1\n2\n3\n4\n5\n6\n7\n8\n9\n10", "Next", "Back");
			}
			if(listitem == 8)
			{
				DuelInfo[playerid][Armour] = 20;
				ShowPlayerDialog(playerid, 135, DIALOG_STYLE_LIST, "Duel Rounds", "1\n2\n3\n4\n5\n6\n7\n8\n9\n10", "Next", "Back");
			}
			if(listitem == 9)
			{
				DuelInfo[playerid][Armour] = 10;
				ShowPlayerDialog(playerid, 135, DIALOG_STYLE_LIST, "Duel Rounds", "1\n2\n3\n4\n5\n6\n7\n8\n9\n10", "Next", "Back");
			}
			if(listitem == 10)
			{
				DuelInfo[playerid][Armour] = 0;
				ShowPlayerDialog(playerid, 135, DIALOG_STYLE_LIST, "Duel Rounds", "1\n2\n3\n4\n5\n6\n7\n8\n9\n10", "Next", "Back");
			}
		}
	}
	if(dialogid == 135)
	{
		if(!response)
		{
            ShowPlayerDialog(playerid, 135, DIALOG_STYLE_LIST, "Duel Rounds", "1\n2\n3\n4\n5\n6\n7\n8\n9\n10", "Next", "Back");
		}
		if(response)
		{
			if(listitem == 0)
			{
				DuelInfo[playerid][Rounds] = 1;
				DuelInfo[playerid][TotalRounds] = 1;
				ShowPlayerDialog(playerid, 136, DIALOG_STYLE_LIST, "Duel Place", "Custom Place", "OK", "");
			}
			if(listitem == 1)
			{
				DuelInfo[playerid][Rounds] = 2;
				DuelInfo[playerid][TotalRounds] = 2;
				ShowPlayerDialog(playerid, 136, DIALOG_STYLE_LIST, "Duel Place", "Custom Place", "OK", "");
			}
			if(listitem == 2)
			{
				DuelInfo[playerid][Rounds] = 3;
				DuelInfo[playerid][TotalRounds] = 3;
				ShowPlayerDialog(playerid, 136, DIALOG_STYLE_LIST, "Duel Place", "Custom Place", "OK", "");
			}
			if(listitem == 3)
			{
				DuelInfo[playerid][Rounds] = 4;
				DuelInfo[playerid][TotalRounds] = 4;
				ShowPlayerDialog(playerid, 136, DIALOG_STYLE_LIST, "Duel Place", "Custom Place", "OK", "");
			}
			if(listitem == 4)
			{
				DuelInfo[playerid][Rounds] = 5;
				DuelInfo[playerid][TotalRounds] = 5;
				ShowPlayerDialog(playerid, 136, DIALOG_STYLE_LIST, "Duel Place", "Custom Place", "OK", "");
			}
			if(listitem == 5)
			{
				DuelInfo[playerid][Rounds] = 6;
				DuelInfo[playerid][TotalRounds] = 6;
				ShowPlayerDialog(playerid, 135, DIALOG_STYLE_LIST, "Duel Place", "Custom Place", "OK", "");
			}
			if(listitem == 6)
			{
				DuelInfo[playerid][Rounds] = 7;
				DuelInfo[playerid][TotalRounds] = 7;
				ShowPlayerDialog(playerid, 136, DIALOG_STYLE_LIST, "Duel Place", "Custom Place", "OK", "");
			}
			if(listitem == 7)
			{
				DuelInfo[playerid][Rounds] = 8;
				DuelInfo[playerid][TotalRounds] = 8;
				ShowPlayerDialog(playerid, 136, DIALOG_STYLE_LIST, "Duel Place", "Custom Place", "OK", "");
			}
			if(listitem == 8)
			{
				DuelInfo[playerid][Rounds] = 9;
				DuelInfo[playerid][TotalRounds] = 9;
				ShowPlayerDialog(playerid, 136, DIALOG_STYLE_LIST, "Duel Place", "Custom Place", "OK", "");
			}
			if(listitem == 9)
			{
				DuelInfo[playerid][Rounds] = 10;
				DuelInfo[playerid][TotalRounds] = 10;
				ShowPlayerDialog(playerid, 136, DIALOG_STYLE_LIST, "Duel Place", "Custom Place", "OK", "");
			}
		}
	}

	if(dialogid == 136)
	{
		if(response)
		{
			if(listitem == 0)
			{
				new Float:Pos[3], id, Float:Angle, WeapOne[100],WeapTwo[100],WeapThree[100], str[500];
				GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
				GetPlayerFacingAngle(playerid, Angle);
				DuelInfo[playerid][DuelPos_X] = Pos[0];
				DuelInfo[playerid][DuelPos_Y] = Pos[1];
				DuelInfo[playerid][DuelPos_Z] = Pos[2];
				DuelInfo[playerid][DuelPos_Angle] = Angle;

				id = DuelInfo[playerid][DuelID];

				DuelInfo[id][DuelID] = playerid;
				DuelInfo[id][WeaponOne] = DuelInfo[playerid][WeaponOne];
				DuelInfo[id][WeaponTwo] = DuelInfo[playerid][WeaponTwo];
				DuelInfo[id][WeaponThree] = DuelInfo[playerid][WeaponThree];
				DuelInfo[id][WeaponOne] = DuelInfo[playerid][WeaponOne];
				DuelInfo[id][Health] = DuelInfo[playerid][Health];
				DuelInfo[id][Armour] = DuelInfo[playerid][Armour];
				DuelInfo[id][Rounds] = DuelInfo[playerid][Rounds];
				DuelInfo[id][TotalRounds] = DuelInfo[playerid][TotalRounds];
                DuelInfo[id][DuelPos_X] = DuelInfo[playerid][DuelPos_X];
                DuelInfo[id][DuelPos_Y] = DuelInfo[playerid][DuelPos_Y];
                DuelInfo[id][DuelPos_Z] = DuelInfo[playerid][DuelPos_Z];
                DuelInfo[id][DuelPos_Angle] = Angle;
                
				GetWeaponName(DuelInfo[playerid][WeaponOne], WeapOne, sizeof(WeapOne));
				GetWeaponName(DuelInfo[playerid][WeaponTwo], WeapTwo, sizeof(WeapTwo));
				GetWeaponName(DuelInfo[playerid][WeaponThree], WeapThree, sizeof(WeapThree));
				
				format(str, sizeof(str), "[DUEL] %s(%d) has requested a duel with you [First Weapon: %s] [Second Weapon: %s] [Third Weapon: %s] [Health: %d] [Armour: %d] [Rounds: %d] [Place: Custom]",WeapOne,WeapTwo,WeapThree,DuelInfo[playerid][Health],DuelInfo[playerid][Armour],DuelInfo[playerid][Rounds]);
				SendClientMessage(id, COLOR_RED, str);
				SendClientMessage(id, COLOR_RED, "[DUEL] Use (/duel2) command to accept the duel");
				
				GameTextForPlayer(playerid,"~g~Duel requested",4500,3);
				
				SetTimerEx("DuelRequestTimer", 30000, false, "i", playerid);
			}
		}
	}

    if(dialogid == 98) {
        if(response) {
			if(listitem == 0) {
				PlayerInfo[playerid][pColor] = 0;
			}
            if(listitem == 1) {
                SetPlayerColor(playerid, White);
            }
            if(listitem == 2) {
                SetPlayerColor(playerid, Green);
            }
            if(listitem == 3) {
                SetPlayerColor(playerid, Yellow);
            }
            if(listitem == 4) {
                SetPlayerColor(playerid, Orange);
            }
            if(listitem == 5) {
                SetPlayerColor(playerid, Red);
            }
            if(listitem == 6) {
                SetPlayerColor(playerid, Pink);
            }
            if(listitem == 7) {
                SetPlayerColor(playerid, Blue);
            }
            if(listitem == 8) {
                SetPlayerColor(playerid, Gray);
            }
        }
    }

    if(dialogid == DIALOGID)
    {
        if(response)
        {
            if(listitem == 0)
            {
                ShowPlayerDialog(playerid, DIALOGID+1, DIALOG_STYLE_LIST, "Weapon Menu", "9mm Pistol\nSilenced pistol\nDesert eagle", "Select", "Back");
            }
            if(listitem == 1)
            {
                ShowPlayerDialog(playerid, DIALOGID+3, DIALOG_STYLE_LIST, "Weapon Menu", "Uzi\nSMG\nTec9", "Select", "Back");
            }
            if(listitem == 3)
            {
                ShowPlayerDialog(playerid, DIALOGID+4, DIALOG_STYLE_LIST, "Weapon Menu", "AK-47\nM4\nCountry Rifle\nSniper Rifle", "Select", "Back");
            }
            if(listitem == 2)
            {
                ShowPlayerDialog(playerid, DIALOGID+2, DIALOG_STYLE_LIST, "Weapon Menu", "Shotgun\nSawnoff Shotgun\nCombat Shotgun", "Select", "Back");
            }
            if(listitem == 4)
            {
                ShowPlayerDialog(playerid, DIALOGID+5, DIALOG_STYLE_LIST, "Weapon Menu", "Brass knuckles\nGolf club\nNite stick\nKnife\nBaseball bat\nShovel\nPool cue\nKantana\nChainsaw\nPurple dildo\nShort vibrator\nLong vibrator\nWhite dildo\nFlowers\nCane\nSpray can\nFire extinguisher", "Select", "Back");
            }
        }
        return 1;
    }

    if(dialogid == DIALOGID+1)
    {
		if(!response) return ShowPlayerDialog(playerid, DIALOGID, DIALOG_STYLE_LIST, "Weapons List", "{FFFFFF}Pistols\n{FFFFFF}Sub-Machine Guns\n{FFFFFF}Shotguns\n{FFFFFF}Assault Rifles\n{FFFFFF}Melee Weapons", "Select", "Cancel");
        if(response)
        {
            if(listitem == 0)
            {
                GivePlayerWeapon(playerid, 22, 999999);
            }
            if(listitem == 1)
            {
                GivePlayerWeapon(playerid, 23, 999999);
            }
            if(listitem == 2)
            {
                GivePlayerWeapon(playerid, 24, 999999);
            }
        }
        return 1;
    }

    if(dialogid == DIALOGID+2)
    {
		if(!response) return ShowPlayerDialog(playerid, DIALOGID, DIALOG_STYLE_LIST, "Weapons List", "{FFFFFF}Pistols\n{FFFFFF}Sub-Machine Guns\n{FFFFFF}Shotguns\n{FFFFFF}Assault Rifles\n{FFFFFF}Melee Weapons", "Select", "Cancel");
        if(response)
        {
            if(listitem == 0)
            {
                GivePlayerWeapon(playerid, 25, 999999);
            }
            if(listitem == 1)
            {
                GivePlayerWeapon(playerid, 26, 999999);
            }
            if(listitem == 2)
            {
                GivePlayerWeapon(playerid, 27, 999999);
            }
        }
        return 1;
    }

    if(dialogid == DIALOGID+3)
    {
  		if(!response) return ShowPlayerDialog(playerid, DIALOGID, DIALOG_STYLE_LIST, "Weapons List", "{FFFFFF}Pistols\n{FFFFFF}Sub-Machine Guns\n{FFFFFF}Shotguns\n{FFFFFF}Assault Rifles\n{FFFFFF}Melee Weapons", "Select", "Cancel");
        if(response)
        {
            if(listitem == 0)
            {
                GivePlayerWeapon(playerid, 28, 999999);
            }
            if(listitem == 1)
            {
                GivePlayerWeapon(playerid, 29, 999999);
            }
            if(listitem == 2)
            {
                GivePlayerWeapon(playerid, 32, 999999);
            }
        }
        return 1;
    }
    
    if(dialogid == DIALOGID+4)
    {
    	if(!response) return ShowPlayerDialog(playerid, DIALOGID, DIALOG_STYLE_LIST, "Weapons List", "{FFFFFF}Pistols\n{FFFFFF}Sub-Machine Guns\n{FFFFFF}Shotguns\n{FFFFFF}Assault Rifles\n{FFFFFF}Melee Weapons", "Select", "Cancel");
        if(response)
        {
            if(listitem == 0)
            {
                GivePlayerWeapon(playerid, 30, 999999);
            }
            if(listitem == 1)
            {
                GivePlayerWeapon(playerid, 31, 999999);
            }
            if(listitem == 2)
            {
                GivePlayerWeapon(playerid, 33, 999999);
            }
            if(listitem == 3)
            {
                GivePlayerWeapon(playerid, 34, 999999);
            }
        }
        return 1;
    }

    if(dialogid == DIALOGID+5)
    {
        if(response)
        {
        	if(!response) return ShowPlayerDialog(playerid, DIALOGID, DIALOG_STYLE_LIST, "Weapons List", "{FFFFFF}Pistols\n{FFFFFF}Sub-Machine Guns\n{FFFFFF}Shotguns\n{FFFFFF}Assault Rifles\n{FFFFFF}Melee Weapons", "Select", "Cancel");
            if(listitem == 0)
            {
                GivePlayerWeapon(playerid, 1, 1);
            }
            if(listitem == 1)
            {
                GivePlayerWeapon(playerid, 2, 1);
            }
            if(listitem == 2)
            {
                GivePlayerWeapon(playerid, 3, 1);
            }
            if(listitem == 3)
            {
                GivePlayerWeapon(playerid, 4, 1);
            }
            if(listitem == 4)
            {
                GivePlayerWeapon(playerid, 5, 1);
            }
            if(listitem == 5)
            {
                GivePlayerWeapon(playerid, 6, 1);
            }
            if(listitem == 6)
            {
                GivePlayerWeapon(playerid, 7, 1);
            }
            if(listitem == 7)
            {
                GivePlayerWeapon(playerid, 8, 1);
            }
            if(listitem == 8)
            {
                GivePlayerWeapon(playerid, 9, 1);
            }
            if(listitem == 9)
            {
                GivePlayerWeapon(playerid, 10, 1);
            }
            if(listitem == 10)
            {
                GivePlayerWeapon(playerid, 11, 1);
            }
            if(listitem == 11)
            {
                GivePlayerWeapon(playerid, 12, 1);
            }
            if(listitem == 12)
            {
                GivePlayerWeapon(playerid, 13, 1);
            }
            if(listitem == 13)
            {
                GivePlayerWeapon(playerid, 14, 1);
            }
            if(listitem == 14)
            {
                GivePlayerWeapon(playerid, 15, 1);
            }
            if(listitem == 15)
            {
                GivePlayerWeapon(playerid, 41, 999999);
            }
            if(listitem == 16)
            {
                GivePlayerWeapon(playerid, 42, 999999);
            }
        }
        return 1;
    }

    if(dialogid == neondialog)
	{
		if(response)
		{
			if(listitem == 0)
			{
			    SetPVarInt(playerid, "Status", 1);
                SetPVarInt(playerid, "neon", CreateObject(18648,0,0,0,0,0,0));
                SetPVarInt(playerid, "neon1", CreateObject(18648,0,0,0,0,0,0));
                AttachObjectToVehicle(GetPVarInt(playerid, "neon"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
                AttachObjectToVehicle(GetPVarInt(playerid, "neon1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
                SendClientMessage(playerid, 0xFFFFFFAA, "Neon Installed");
   			}
			if(listitem == 1)
			{
				SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "neon2", CreateObject(18647,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon3", CreateObject(18647,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon2"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon3"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "Neon Installed");

            }
			if(listitem == 2)
			{
		   	    SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "neon4", CreateObject(18649,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon5", CreateObject(18649,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon4"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon5"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "Neon Installed");

	            }
			if(listitem == 3)
			{
		   	    SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "neon6", CreateObject(18652,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon7", CreateObject(18652,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon6"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon7"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "Neon Installed");

            }
			if(listitem == 4)
			{
		   	    SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "neon8", CreateObject(18651,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon9", CreateObject(18651,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon8"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon9"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "Neon Installed");

            }
			if(listitem == 5)
			{
  				SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "neon10", CreateObject(18650,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon11", CreateObject(18650,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon10"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon11"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "Neon Installed");

            }
            if(listitem == 6)
			{
  				SetPVarInt(playerid, "Status", 1);
                SetPVarInt(playerid, "neon12", CreateObject(18648,0,0,0,0,0,0));
                SetPVarInt(playerid, "neon13", CreateObject(18648,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon14", CreateObject(18649,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon15", CreateObject(18649,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon12"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon13"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon14"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon15"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "Neon Installed");

            }
            if(listitem == 7)
			{
  				SetPVarInt(playerid, "Status", 1);
                SetPVarInt(playerid, "neon16", CreateObject(18648,0,0,0,0,0,0));
                SetPVarInt(playerid, "neon17", CreateObject(18648,0,0,0,0,0,0));
                SetPVarInt(playerid, "neon18", CreateObject(18652,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon19", CreateObject(18652,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon16"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon17"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon18"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon19"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "Neon Installed");

            }
            if(listitem == 8)
			{
  				SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "neon20", CreateObject(18647,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon21", CreateObject(18647,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon22", CreateObject(18652,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon23", CreateObject(18652,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon20"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon21"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon22"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon23"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "Neon Installed");

            }
            if(listitem == 9)
			{
  				SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "neon24", CreateObject(18647,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon25", CreateObject(18647,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon26", CreateObject(18650,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon27", CreateObject(18650,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon24"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon25"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon26"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon27"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "Neon Installed");

            }
            if(listitem == 10)
			{
  				SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "neon28", CreateObject(18649,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon29", CreateObject(18649,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon30", CreateObject(18652,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon31", CreateObject(18652,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon28"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon29"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon30"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon31"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "Neon Installed");

            }
            if(listitem == 11)
			{
  				SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "neon32", CreateObject(18652,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon33", CreateObject(18652,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon34", CreateObject(18650,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon35", CreateObject(18650,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon32"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon33"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon34"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon35"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "Neon Installed");

            }
   			if(listitem == 12){
				DestroyObject(GetPVarInt(playerid, "neon")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon1")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon2")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon3"));
			    DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon4")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon5")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon6")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon7"));
				DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon8")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon9")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon10")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon11"));
	            DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon12")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon13")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon14")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon15"));
	            DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon16")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon17")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon18")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon19"));
	            DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon20")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon21")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon22")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon23"));
				DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon24")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon25")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon26")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon27"));
	            DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon28")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon29")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon30")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon31"));
	            DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon32")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon33")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon34")); DeletePVar(playerid, "Status"); DestroyObject(GetPVarInt(playerid, "neon35"));
	            SendClientMessage(playerid, 0xFFFFFFAA, "You removed the neon!");
	 	    }
		}
	}

    if(dialogid == 4)
	{
		if(response)
		{
            if(listitem == 0)
            {
			    SendClientMessage(playerid, COLOR_RED, "You Selected Normal Fighting Style");
		        SetPlayerFightingStyle(playerid, FIGHT_STYLE_NORMAL);
	        }
            else if(listitem == 1)
	        {
			    SendClientMessage(playerid, COLOR_RED, "You Selected Boxing Fighting Style");
		        SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING);
	        }
	        else if(listitem == 2)
	        {
			    SendClientMessage(playerid, COLOR_RED, "You Selected Kungfu Fighting Style");
			    SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU);
	        }
	        else if(listitem == 3)
	        {
			    SendClientMessage(playerid, COLOR_RED, "You Selected Kneehead Fighting Style");
			    SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD);
	        }
	        else if(listitem == 4)
	        {
			    SendClientMessage(playerid, COLOR_RED, "You Selected Grabkick Fighting Style");
			    SetPlayerFightingStyle(playerid, FIGHT_STYLE_GRABKICK);
	        }
	        else if(listitem == 5)
	        {
		        SendClientMessage(playerid, COLOR_RED, "You Selected Elbow Fighting Style");
			    SetPlayerFightingStyle(playerid, FIGHT_STYLE_ELBOW);
	        }
	    }
    }
    
    if(dialogid == 125)
	{
		if(response)
		{
            if(listitem == 0)
            {
				DDM(playerid);
	        }
            if(listitem == 1)
            {
				DDM2(playerid);
	        }
            if(listitem == 2)
            {
				SOS(playerid);
	        }
            if(listitem == 3)
            {
				SDM(playerid);
	        }
            if(listitem == 4)
            {
				SCR(playerid);
	        }
	    }
    }
    
    if(dialogid == 555)
    {
        if(response)
        {
			if(listitem == 0)
			{
                ShowModelSelectionMenu(playerid, Airplanes, "Airplanes", 0xFFFFFF99, 0xFFFFFFBB, 0xE6E6E6FF);
			}
			if(listitem == 1)
			{
                ShowModelSelectionMenu(playerid, Helicopters, "Helicopters", 0xFFFFFF99, 0xFFFFFFBB, 0xE6E6E6FF);
			}
			if(listitem == 2)
			{
                ShowModelSelectionMenu(playerid, Bikes, "Bikes", 0xFFFFFF99, 0xFFFFFFBB, 0xE6E6E6FF);
			}
			if(listitem == 3)
			{
                ShowModelSelectionMenu(playerid, Industrial, "Industrial", 0xFFFFFF99, 0xFFFFFFBB, 0xE6E6E6FF);
			}
			if(listitem == 4)
			{
                ShowModelSelectionMenu(playerid, Lowriders, "Lowriders", 0xFFFFFF99, 0xFFFFFFBB, 0xE6E6E6FF);
			}
			if(listitem == 5)
			{
			    ShowModelSelectionMenu(playerid, OffRoad, "Off Road", 0xFFFFFF99, 0xFFFFFFBB, 0xE6E6E6FF);
			}
			if(listitem == 6)
			{
			    ShowModelSelectionMenu(playerid, PublicService, "Public Service", 0xFFFFFF99, 0xFFFFFFBB, 0xE6E6E6FF);
			}
			if(listitem == 7)
			{
			    ShowModelSelectionMenu(playerid, Saloons, "Saloons", 0xFFFFFF99, 0xFFFFFFBB, 0xE6E6E6FF);
			}
			if(listitem == 8)
			{
			    ShowModelSelectionMenu(playerid, SportsVehicles, "Sports Vehicles", 0xFFFFFF99, 0xFFFFFFBB, 0xE6E6E6FF);
			}
			if(listitem == 9)
			{
			    ShowModelSelectionMenu(playerid, Boats, "Boats", 0xFFFFFF99, 0xFFFFFFBB, 0xE6E6E6FF);
			}
			if(listitem == 10)
			{
			    ShowModelSelectionMenu(playerid, Trailers, "Trailers", 0xFFFFFF99, 0xFFFFFFBB, 0xE6E6E6FF);
			}
			if(listitem == 11)
			{
			    ShowModelSelectionMenu(playerid, UniqueVehicles, "Unique Vehicles", 0xFFFFFF99, 0xFFFFFFBB, 0xE6E6E6FF);
			}
			if(listitem == 12)
			{
			    ShowModelSelectionMenu(playerid, RCVehicles, "RC Vehicles", 0xFFFFFF99, 0xFFFFFFBB, 0xE6E6E6FF);
			}
		}
	}
	
    if(dialogid == 987)
    {
        if(response)
        {
			if(listitem == 0)
			{
				foreach(Player, i)
				{
				    Kick(i);
				}
			}
			if(listitem == 1)
			{
				foreach(Player, i)
				{
					if(i != playerid)
					{
					    Kick(i);
					}
				}
			}
			if(listitem == 2)
			{
				foreach(Player, i)
				{
					if(PlayerInfo[i][pAdmin] == 0)
					{
					    Kick(i);
					}
				}
			}
	    }
	}
	
	if(dialogid == 1000)
	{
		if(response || !response)
		{
			new str[1000],str2[1000];
		    format(str2,sizeof(str2),""COL_GREEN"Freeroam Score\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_WHITE"- This is given on each kill of freeroam mode\n- Player will get 5 freeroam score on a streak of 5 kills in freeroam mode\n\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"Deathmatch Score\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_WHITE"- This is given on each kill of deathmatch mode\n- Player will get 5 deathmatch score on a streak of 5 kills in deathmatch mode\n\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"Total Score\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_WHITE"This is the sum of all scores\n");
		    strcat(str, str2);
			ShowPlayerDialog(playerid, 1001, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - Scores Help", str, "OK", "");
		}
	}
	
	if(dialogid == 1002)
	{
		if(listitem == 0)
		{
		    ShowPlayerDialog(playerid, 1003, DIALOG_STYLE_LIST, ""COL_GREEN"Get All","Including Admins\nNot Including Admins", "Select", "Cancel");
		}
		if(listitem == 1)
		{
		    ShowPlayerDialog(playerid, 1004, DIALOG_STYLE_LIST, ""COL_GREEN"Get All","Including Admins\nNot Including Admins", "Select", "Cancel");
		}
		if(listitem == 2)
		{
		    ShowPlayerDialog(playerid, 1005, DIALOG_STYLE_LIST, ""COL_GREEN"Get All","Including Admins\nNot Including Admins", "Select", "Cancel");
		}
	}
	
	if(dialogid == 1003)
	{
		if(listitem == 0)
		{
            new Float:x, Float:y, Float:z;
 	        GetPlayerPos(playerid, x, y, z);
 	        foreach(Player, i)
		    {
		        if(IsPlayerConnected(i) && (i != playerid) && fr[i] == 1)
		        {
					if(indm[playerid] == 1)
					{
						GDDM(i);
						return 1;
					}
					if(indm[playerid] == 2)
					{
						GSDM(i);
						return 1;
					}
					if(indm[playerid] == 3)
					{
						GSOS(i);
						return 1;
					}
					if(indm[playerid] == 4)
					{
						GDDM2(i);
						return 1;
					}
					if(indm[playerid] == 5)
					{
						GSCR(i);
						return 1;
					}
                    SetPlayerPos(i, x+3, y, z);
                    SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
                    SetPlayerInterior(i, GetPlayerInterior(playerid));
                    fr[i] = fr[playerid];
                    indm[i] = indm[playerid];
		        }
		    }
		    SendClientMessage(playerid, BAN, "* You have teleported all players from freeroam mode to your position");
		}
		if(listitem == 1)
		{
            new Float:x, Float:y, Float:z;
 	        GetPlayerPos(playerid, x, y, z);
 	        foreach(Player, i)
		    {
		        if(IsPlayerConnected(i) && (i != playerid) && fr[i] == 1 && PlayerInfo[i][pAdmin] == 0)
		        {
					if(indm[playerid] == 1)
					{
						GDDM(i);
						return 1;
					}
					if(indm[playerid] == 2)
					{
						GSDM(i);
						return 1;
					}
					if(indm[playerid] == 3)
					{
						GSOS(i);
						return 1;
					}
					if(indm[playerid] == 4)
					{
						GDDM2(i);
						return 1;
					}
					if(indm[playerid] == 5)
					{
						GSCR(i);
						return 1;
					}
                    SetPlayerPos(i, x+3, y, z);
                    SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
                    SetPlayerInterior(i, GetPlayerInterior(playerid));
                    fr[i] = fr[playerid];
                    indm[i] = indm[playerid];
		        }
		    }
		    SendClientMessage(playerid, BAN, "* You have teleported all players from freeroam mode to your position (INCLUDING ADMINS)");
		}
	}
	if(dialogid == 1004)
	{
		if(listitem == 0)
		{
            new Float:x, Float:y, Float:z;
 	        GetPlayerPos(playerid, x, y, z);
 	        foreach(Player, i)
		    {
		        if(IsPlayerConnected(i) && (i != playerid) && indm[i] >= 1)
		        {
					if(indm[playerid] == 1)
					{
						GDDM(i);
						return 1;
					}
					if(indm[playerid] == 2)
					{
						GSDM(i);
						return 1;
					}
					if(indm[playerid] == 3)
					{
						GSOS(i);
						return 1;
					}
					if(indm[playerid] == 4)
					{
						GDDM2(i);
						return 1;
					}
					if(indm[playerid] == 5)
					{
						GSCR(i);
						return 1;
					}
                    SetPlayerPos(i, x+3, y, z);
                    SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
                    SetPlayerInterior(i, GetPlayerInterior(playerid));
                    fr[i] = fr[playerid];
                    indm[i] = indm[playerid];
		        }
		    }
		    SendClientMessage(playerid, BAN, "* You have teleported all players from deathmatch mode to your position");
		}
		if(listitem == 1)
		{
            new Float:x, Float:y, Float:z;
 	        GetPlayerPos(playerid, x, y, z);
 	        foreach(Player, i)
		    {
		        if(IsPlayerConnected(i) && (i != playerid) && indm[i] >= 1  && PlayerInfo[i][pAdmin] == 0)
		        {
					if(indm[playerid] == 1)
					{
						GDDM(i);
						return 1;
					}
					if(indm[playerid] == 2)
					{
						GSDM(i);
						return 1;
					}
					if(indm[playerid] == 3)
					{
						GSOS(i);
						return 1;
					}
					if(indm[playerid] == 4)
					{
						GDDM2(i);
						return 1;
					}
					if(indm[playerid] == 5)
					{
						GSCR(i);
						return 1;
					}
                    SetPlayerPos(i, x+3, y, z);
                    SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
                    SetPlayerInterior(i, GetPlayerInterior(playerid));
                    fr[i] = fr[playerid];
                    indm[i] = indm[playerid];
		        }
		    }
		    SendClientMessage(playerid, BAN, "* You have teleported all players from deathmatch mode to your position (INCLUDING ADMINS)");
		}
	}
	if(dialogid == 1005)
	{
		if(listitem == 0)
		{
            new Float:x, Float:y, Float:z;
 	        GetPlayerPos(playerid, x, y, z);
 	        foreach(Player, i)
		    {
		        if(IsPlayerConnected(i) && (i != playerid) && PlayerInfo[i][Jail] == 0)
		        {
					if(indm[playerid] == 1)
					{
						GDDM(i);
						return 1;
					}
					if(indm[playerid] == 2)
					{
						GSDM(i);
						return 1;
					}
					if(indm[playerid] == 3)
					{
						GSOS(i);
						return 1;
					}
					if(indm[playerid] == 4)
					{
						GDDM2(i);
						return 1;
					}
					if(indm[playerid] == 5)
					{
						GSCR(i);
						return 1;
					}
                    SetPlayerPos(i, x+3, y, z);
                    SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
                    SetPlayerInterior(i, GetPlayerInterior(playerid));
                    fr[i] = fr[playerid];
                    indm[i] = indm[playerid];
		        }
		    }
		    SendClientMessage(playerid, BAN, "* You have teleported all players to your position");
		}
		if(listitem == 1)
		{
            new Float:x, Float:y, Float:z;
 	        GetPlayerPos(playerid, x, y, z);
 	        foreach(Player, i)
		    {
		        if(IsPlayerConnected(i) && (i != playerid) && PlayerInfo[i][pAdmin] == 0)
		        {
					if(indm[playerid] == 1)
					{
						GDDM(i);
						return 1;
					}
					if(indm[playerid] == 2)
					{
						GSDM(i);
						return 1;
					}
					if(indm[playerid] == 3)
					{
						GSOS(i);
						return 1;
					}
					if(indm[playerid] == 4)
					{
						GDDM2(i);
						return 1;
					}
					if(indm[playerid] == 5)
					{
						GSCR(i);
						return 1;
					}
                    SetPlayerPos(i, x+3, y, z);
                    SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
                    SetPlayerInterior(i, GetPlayerInterior(playerid));
                    fr[i] = fr[playerid];
                    indm[i] = indm[playerid];
		        }
		    }
		    SendClientMessage(playerid, BAN, "* You have teleported all players to your position (INCLUDING ADMINS)");
		}
	}
	if(dialogid == 1006)
	{
	if(response)
	{
	if(listitem == 0)
	{
		new str[2000],str2[500];
	    format(str2,sizeof(str2),""COL_GREEN"/fr "COL_WHITE"- join FreeRoam Mode\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/dm "COL_WHITE"- join DeathMatch Mode\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/c "COL_WHITE"- list commands\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/t "COL_WHITE"- list teleports\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/new "COL_WHITE"- show server updates\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/admins "COL_WHITE"- show online admins\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/vips "COL_WHITE"- show online Very Important Players (VIPs)\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/wanted "COL_WHITE"- show most wanted players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/report "COL_WHITE"- report a player to the admins\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/go [player id] "COL_WHITE"- teleport to a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/gos "COL_WHITE"- toggle player teleports on/off\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/pm [player id] [message] "COL_WHITE"- private message a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/r [message] "COL_WHITE"- reply to last private message\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/pms "COL_WHITE"- toggle provate messages on/off\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/cms "COL_WHITE"- toggle chat messages on/off\n");
	    strcat(str, str2);
		ShowPlayerDialog(playerid, 1007, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - General Commands", str, "OK", "Back");
	}
	if(listitem == 1)
	{
		new str[1000],str2[1000];
	    format(str2,sizeof(str2),""COL_GREEN"/stats (optional: [player id]) "COL_WHITE"- join FreeRoam Mode\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/w "COL_WHITE"- choose a weapon\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/skin [skin id: 0-311] "COL_WHITE"- join FreeRoam Mode\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/kill "COL_WHITE"- kill yourself\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/para "COL_WHITE"- parachute\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/jp "COL_WHITE"- jetpack\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/cam "COL_WHITE"- camera\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/god "COL_WHITE"- toggle god mode on/off (you can't die)\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/fs "COL_WHITE"- change your fighting style\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/dive (optional: [custome height]) "COL_WHITE"- dive with a parachute\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/drunk "COL_WHITE"- set your drunk level (affects movement and visual)\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/duel [id] "COL_WHITE"- duel a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/time [hour: 0-24] "COL_WHITE"- change game time\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/rtime "COL_WHITE"- reset game time to default\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/weather [weather id: 1-65535] "COL_WHITE"- change game weather\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/rweather "COL_WHITE"- reset game weather to default\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/color (optional: [red: 0-255] [green: 0-255] [blue: 0-255] "COL_WHITE"- change name color\n");
	    strcat(str, str2);
		ShowPlayerDialog(playerid, 1008, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - Player Commands", str, "OK", "Back");
	}
	if(listitem == 2)
	{
		new str[1000],str2[1000];
	    format(str2,sizeof(str2),""COL_GREEN"/v (optional: [vehicleid: 400-600]) "COL_WHITE"- spawn a vehicle\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/lock "COL_WHITE"- toggle vehicle lock/unlock\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/engine "COL_WHITE"- toggle vehicle engine on/off\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/hydraulics "COL_WHITE"- add hydraulics to vehicle\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/engine "COL_WHITE"- toggle vehicle engine on/off\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/vcolor "COL_WHITE"- change your vehicle color\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/eject [player id] "COL_WHITE"- eject a player from your vehicle\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/ejectall "COL_WHITE"- eject all players from your vehicle except you\n");
	    strcat(str, str2);
	    ShowPlayerDialog(playerid, 1009, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - Vehicle Commands", str, "OK", "Back");
	}
	if(listitem == 3)
	{
		new str[1000],str2[1000];
	    format(str2,sizeof(str2),""COL_GREEN"/neon "COL_WHITE"- add a neon to vehicle\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/siren "COL_WHITE"- add siren to vehicle\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/pship "COL_WHITE"- spawn a controllable pirate ship\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/vvcolor "COL_WHITE"- vehicle rainbow colors\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/count [seconds: 1-10]"COL_WHITE"- start a counting\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/megajump "COL_WHITE"- toggle mega jump on/off\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/cart "COL_WHITE"- spawn a cart\n");
	    strcat(str, str2);
	    ShowPlayerDialog(playerid, 1010, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - Very Important Player (VIP) Commands", str, "OK", "Back");
	}
	if(listitem == 4)
	{
		new str[3000],str2[300];
		if(PlayerInfo[playerid][pAdmin] == 1)
		{
	    format(str2,sizeof(str2),""COL_GREEN"/reports "COL_WHITE"- see the list of reports\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/equip "COL_WHITE"- gives armour and health\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/clearchat "COL_WHITE"- clears the chat\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/killplayer [player id] "COL_WHITE"- kill a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/ip [player id] "COL_WHITE"- see the ip of a player\n");
	    strcat(str, str2);
        ShowPlayerDialog(playerid, 1012, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - Admin Commands", str, "OK", "Back");
		}
		if(PlayerInfo[playerid][pAdmin] == 2)
		{
	    format(str2,sizeof(str2),""COL_GREEN"/reports "COL_WHITE"- see the list of reports\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/equip "COL_WHITE"- gives armour and health\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/clearchat "COL_WHITE"- clears the chat\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/killplayer [player id] "COL_WHITE"- kill a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/ip [player id] "COL_WHITE"- see the ip of a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/mute [player id] [reason] "COL_WHITE"- mute a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unmute [player id] "COL_WHITE"- unmute a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/fcs [player id] "COL_WHITE"- force a player for class selection\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/muted "COL_WHITE"- see the list of muted player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/jailed "COL_WHITE"- see the list of jailed players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/frozen "COL_WHITE"- see the list of frozen player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/kick [player id] [reason] "COL_WHITE"- kick a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/heal [player id] "COL_WHITE"- heal a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/armour [player id] "COL_WHITE"- armour a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/settime [player id] [time: 0-24] "COL_WHITE"- change a player's game time\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setweather [player id] [weather id] "COL_WHITE"- change a player's game weather\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/sethealth [player id] [health: 0-100] "COL_WHITE"- set a player's health\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setarmour [player id] [armour: 0-100]"COL_WHITE"- set a player's armour\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setinterior [player id] [interior id] "COL_WHITE"- set a player's interior\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setworld [player id] [world id]"COL_WHITE"- set a player's world\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetminigun [player id] "COL_WHITE"- reset a player's minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetrpg [player id] "COL_WHITE"- reset a player's rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetgrenade [player id] "COL_WHITE"- reset a player's grenade\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/port [player id] [player id 2] "COL_WHITE"- teleport a player to another player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/invisible "COL_WHITE"- get invisible\n");
	    strcat(str, str2);
		ShowPlayerDialog(playerid, 1012, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - Admin Commands", str, "OK", "Back");
		}
		if(PlayerInfo[playerid][pAdmin] == 3)
		{
	    format(str2,sizeof(str2),""COL_GREEN"/reports "COL_WHITE"- see the list of reports\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/equip "COL_WHITE"- gives armour and health\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/clearchat "COL_WHITE"- clears the chat\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/killplayer [player id] "COL_WHITE"- kill a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/ip [player id] "COL_WHITE"- see the ip of a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/mute [player id] [reason] "COL_WHITE"- mute a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unmute [player id] "COL_WHITE"- unmute a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/fcs [player id] "COL_WHITE"- force a player for class selection\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/muted "COL_WHITE"- see the list of muted player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/jailed "COL_WHITE"- see the list of jailed players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/frozen "COL_WHITE"- see the list of frozen player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/kick [player id] [reason] "COL_WHITE"- kick a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/heal [player id] "COL_WHITE"- heal a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/armour [player id] "COL_WHITE"- armour a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/settime [player id] [time: 0-24] "COL_WHITE"- change a player's game time\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setweather [player id] [weather id] "COL_WHITE"- change a player's game weather\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/sethealth [player id] [health: 0-100] "COL_WHITE"- set a player's health\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setarmour [player id] [armour: 0-100]"COL_WHITE"- set a player's armour\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setinterior [player id] [interior id] "COL_WHITE"- set a player's interior\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setworld [player id] [world id]"COL_WHITE"- set a player's world\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetminigun [player id] "COL_WHITE"- reset a player's minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetrpg [player id] "COL_WHITE"- reset a player's rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetgrenade [player id] "COL_WHITE"- reset a player's grenade\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/port [player id] [player id 2] "COL_WHITE"- teleport a player to another player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/invisible "COL_WHITE"- get invisible\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/get [player id] "COL_WHITE"- teleport a player to your position\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/freeze [player id] "COL_WHITE"- freeze a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unfreeze [player id] "COL_WHITE"- unfreeze a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/disarm [player id] "COL_WHITE"- disarm a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/slap [player id] "COL_WHITE"- slap a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/explode [player id] "COL_WHITE"- explode a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/jail [player id] [time] [reason] "COL_WHITE"- jail a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unjail [player id] "COL_WHITE"- unjail a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/drop [player id] [height] "COL_WHITE"- make a player fall from custom height\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/hide "COL_WHITE"- hide yourself from admins list\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/minigun "COL_WHITE"- spawn/unspawn a minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/rpg "COL_WHITE"- spawn/unspawn a rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetweapon [player id] [weapon id] "COL_WHITE"- reset a weapon from a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetweapons [player id] "COL_WHITE"- reset player weapons\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/miniguns "COL_WHITE"- see a list of players using minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/rpgs "COL_WHITE"- see a list of players using rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/grenades "COL_WHITE"- see a list of players using grenades\n");
	    strcat(str, str2);
		ShowPlayerDialog(playerid, 1012, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - Admin Commands", str, "OK", "Back");
		}
		if(PlayerInfo[playerid][pAdmin] == 4)
		{
	    format(str2,sizeof(str2),""COL_GREEN"/announce [text] "COL_WHITE"- used for announcments\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/aannounce [text] [time] [style: 1-6] "COL_WHITE"- announce a message in advanced way\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/ban [player id] [reason] "COL_WHITE"- ban a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/getall "COL_WHITE"- teleport all players to you\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/spawnall "COL_WHITE"- spawn all players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/slapall [player id] "COL_WHITE"- slap all players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/explodeall [player id] "COL_WHITE"- explode all players\n");
        strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/reports "COL_WHITE"- see the list of reports\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/equip "COL_WHITE"- gives armour and health\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/clearchat "COL_WHITE"- clears the chat\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/killplayer [player id] "COL_WHITE"- kill a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/ip [player id] "COL_WHITE"- see the ip of a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/mute [player id] [reason] "COL_WHITE"- mute a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unmute [player id] "COL_WHITE"- unmute a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/fcs [player id] "COL_WHITE"- force a player for class selection\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/muted "COL_WHITE"- see the list of muted player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/jailed "COL_WHITE"- see the list of jailed players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/frozen "COL_WHITE"- see the list of frozen player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/kick [player id] [reason] "COL_WHITE"- kick a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/heal [player id] "COL_WHITE"- heal a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/armour [player id] "COL_WHITE"- armour a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/settime [player id] [time: 0-24] "COL_WHITE"- change a player's game time\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setweather [player id] [weather id] "COL_WHITE"- change a player's game weather\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/sethealth [player id] [health: 0-100] "COL_WHITE"- set a player's health\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setarmour [player id] [armour: 0-100]"COL_WHITE"- set a player's armour\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setinterior [player id] [interior id] "COL_WHITE"- set a player's interior\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setworld [player id] [world id]"COL_WHITE"- set a player's world\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetminigun [player id] "COL_WHITE"- reset a player's minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetrpg [player id] "COL_WHITE"- reset a player's rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetgrenade [player id] "COL_WHITE"- reset a player's grenade\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/port [player id] [player id 2] "COL_WHITE"- teleport a player to another player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/invisible "COL_WHITE"- get invisible\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/get [player id] "COL_WHITE"- teleport a player to your position\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/freeze [player id] "COL_WHITE"- freeze a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unfreeze [player id] "COL_WHITE"- unfreeze a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/disarm [player id] "COL_WHITE"- disarm a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/slap [player id] "COL_WHITE"- slap a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/explode [player id] "COL_WHITE"- explode a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/jail [player id] [time] [reason] "COL_WHITE"- jail a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unjail [player id] "COL_WHITE"- unjail a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/drop [player id] [height] "COL_WHITE"- make a player fall from custom height\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/hide "COL_WHITE"- hide yourself from admins list\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/minigun "COL_WHITE"- spawn/unspawn a minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/rpg "COL_WHITE"- spawn/unspawn a rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetweapon [player id] [weapon id] "COL_WHITE"- reset a weapon from a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetweapons [player id] "COL_WHITE"- reset player weapons\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/miniguns "COL_WHITE"- see a list of players using minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/rpgs "COL_WHITE"- see a list of players using rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/grenades "COL_WHITE"- see a list of players using grenades\n");
	    strcat(str, str2);
		ShowPlayerDialog(playerid, 1012, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - Admin Commands", str, "OK", "Back");
		}
		if(PlayerInfo[playerid][pAdmin] == 5)
		{
	    format(str2,sizeof(str2),""COL_GREEN"/announce [text] "COL_WHITE"- used for announcments\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/aannounce [text] [time] [style: 1-6] "COL_WHITE"- announce a message in advanced way\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/ban [player id] [reason] "COL_WHITE"- ban a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/getall "COL_WHITE"- teleport all players to you\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/spawnall "COL_WHITE"- spawn all players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/slapall [player id] "COL_WHITE"- slap all players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/explodeall [player id] "COL_WHITE"- explode all players\n");
        strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/reports "COL_WHITE"- see the list of reports\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/equip "COL_WHITE"- gives armour and health\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/clearchat "COL_WHITE"- clears the chat\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/killplayer [player id] "COL_WHITE"- kill a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/ip [player id] "COL_WHITE"- see the ip of a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/mute [player id] [reason] "COL_WHITE"- mute a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unmute [player id] "COL_WHITE"- unmute a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/fcs [player id] "COL_WHITE"- force a player for class selection\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/muted "COL_WHITE"- see the list of muted player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/jailed "COL_WHITE"- see the list of jailed players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/frozen "COL_WHITE"- see the list of frozen player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/kick [player id] [reason] "COL_WHITE"- kick a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/heal [player id] "COL_WHITE"- heal a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/armour [player id] "COL_WHITE"- armour a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/settime [player id] [time: 0-24] "COL_WHITE"- change a player's game time\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setweather [player id] [weather id] "COL_WHITE"- change a player's game weather\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/sethealth [player id] [health: 0-100] "COL_WHITE"- set a player's health\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setarmour [player id] [armour: 0-100]"COL_WHITE"- set a player's armour\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setinterior [player id] [interior id] "COL_WHITE"- set a player's interior\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setworld [player id] [world id]"COL_WHITE"- set a player's world\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetminigun [player id] "COL_WHITE"- reset a player's minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetrpg [player id] "COL_WHITE"- reset a player's rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetgrenade [player id] "COL_WHITE"- reset a player's grenade\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/port [player id] [player id 2] "COL_WHITE"- teleport a player to another player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/invisible "COL_WHITE"- get invisible\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/get [player id] "COL_WHITE"- teleport a player to your position\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/freeze [player id] "COL_WHITE"- freeze a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unfreeze [player id] "COL_WHITE"- unfreeze a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/disarm [player id] "COL_WHITE"- disarm a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/slap [player id] "COL_WHITE"- slap a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/explode [player id] "COL_WHITE"- explode a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/jail [player id] [time] [reason] "COL_WHITE"- jail a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unjail [player id] "COL_WHITE"- unjail a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/drop [player id] [height] "COL_WHITE"- make a player fall from custom height\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/hide "COL_WHITE"- hide yourself from admins list\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/minigun "COL_WHITE"- spawn/unspawn a minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/rpg "COL_WHITE"- spawn/unspawn a rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetweapon [player id] [weapon id] "COL_WHITE"- reset a weapon from a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetweapons [player id] "COL_WHITE"- reset player weapons\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/miniguns "COL_WHITE"- see a list of players using minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/rpgs "COL_WHITE"- see a list of players using rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/grenades "COL_WHITE"- see a list of players using grenades\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/write "COL_WHITE"- write something in the chat box\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/fakechat "COL_WHITE"- fake chat a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/healall "COL_WHITE"- heal all players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/armourall "COL_WHITE"- armour all players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/givefrscore [player id] [score] "COL_WHITE"- give freeroam score to a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/givedmscore [player id] [score] "COL_WHITE"- give deathmatch score to a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/reducefrscore [player id] [score] [player id] "COL_WHITE"- reduce custom ammount of freeraom score from a player's account\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/reducedmscore [player id] [score] "COL_WHITE"- reduce custom ammount of deathmatch score from a player's account\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setscore [player id] [score] "COL_WHITE"- set a player's score\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/banip [ip] "COL_WHITE"- ban an ip\n");
	    strcat(str, str2);
		ShowPlayerDialog(playerid, 1012, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - Admin Commands", str, "OK", "Back");
		}
		if(PlayerInfo[playerid][pAdmin] == 6)
		{
	    format(str2,sizeof(str2),""COL_GREEN"/announce [text] "COL_WHITE"- used for announcments\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/aannounce [text] [time] [style: 1-6] "COL_WHITE"- announce a message in advanced way\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/ban [player id] [reason] "COL_WHITE"- ban a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/getall "COL_WHITE"- teleport all players to you\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/spawnall "COL_WHITE"- spawn all players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/slapall [player id] "COL_WHITE"- slap all players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/explodeall [player id] "COL_WHITE"- explode all players\n");
        strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/reports "COL_WHITE"- see the list of reports\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/equip "COL_WHITE"- gives armour and health\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/clearchat "COL_WHITE"- clears the chat\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/killplayer [player id] "COL_WHITE"- kill a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/ip [player id] "COL_WHITE"- see the ip of a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/mute [player id] [reason] "COL_WHITE"- mute a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unmute [player id] "COL_WHITE"- unmute a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/fcs [player id] "COL_WHITE"- force a player for class selection\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/muted "COL_WHITE"- see the list of muted player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/jailed "COL_WHITE"- see the list of jailed players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/frozen "COL_WHITE"- see the list of frozen player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/kick [player id] [reason] "COL_WHITE"- kick a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/heal [player id] "COL_WHITE"- heal a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/armour [player id] "COL_WHITE"- armour a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/settime [player id] [time: 0-24] "COL_WHITE"- change a player's game time\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setweather [player id] [weather id] "COL_WHITE"- change a player's game weather\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/sethealth [player id] [health: 0-100] "COL_WHITE"- set a player's health\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setarmour [player id] [armour: 0-100]"COL_WHITE"- set a player's armour\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setinterior [player id] [interior id] "COL_WHITE"- set a player's interior\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setworld [player id] [world id]"COL_WHITE"- set a player's world\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetminigun [player id] "COL_WHITE"- reset a player's minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetrpg [player id] "COL_WHITE"- reset a player's rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetgrenade [player id] "COL_WHITE"- reset a player's grenade\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/port [player id] [player id 2] "COL_WHITE"- teleport a player to another player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/invisible "COL_WHITE"- get invisible\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/get [player id] "COL_WHITE"- teleport a player to your position\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/freeze [player id] "COL_WHITE"- freeze a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unfreeze [player id] "COL_WHITE"- unfreeze a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/disarm [player id] "COL_WHITE"- disarm a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/slap [player id] "COL_WHITE"- slap a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/explode [player id] "COL_WHITE"- explode a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/jail [player id] [time] [reason] "COL_WHITE"- jail a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unjail [player id] "COL_WHITE"- unjail a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/drop [player id] [height] "COL_WHITE"- make a player fall from custom height\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/hide "COL_WHITE"- hide yourself from admins list\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/minigun "COL_WHITE"- spawn/unspawn a minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/rpg "COL_WHITE"- spawn/unspawn a rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetweapon [player id] [weapon id] "COL_WHITE"- reset a weapon from a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetweapons [player id] "COL_WHITE"- reset player weapons\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/miniguns "COL_WHITE"- see a list of players using minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/rpgs "COL_WHITE"- see a list of players using rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/grenades "COL_WHITE"- see a list of players using grenades\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/write "COL_WHITE"- write something in the chat box\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/fakechat "COL_WHITE"- fake chat a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/healall "COL_WHITE"- heal all players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/armourall "COL_WHITE"- armour all players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/givefrscore [player id] [score] "COL_WHITE"- give freeroam score to a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/givedmscore [player id] [score] "COL_WHITE"- give deathmatch score to a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/reducefrscore [player id] [score] [player id] "COL_WHITE"- reduce custom ammount of freeraom score from a player's account\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/reducedmscore [player id] [score] "COL_WHITE"- reduce custom ammount of deathmatch score from a player's account\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setscore [player id] [score] "COL_WHITE"- set a player's score\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/banip [ip] "COL_WHITE"- ban an ip\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/readcmds "COL_WHITE"- toggle commands reading for all admins on/off\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/readpms "COL_WHITE"- toggle pms readinf for all admins on/off\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/chat "COL_WHITE"- toggle server chat on/off\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unbanip [ip] "COL_WHITE"- unban an ip\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unban [player id] "COL_WHITE"- unban a player\n");
	    strcat(str, str2);
		ShowPlayerDialog(playerid, 1012, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - Admin Commands", str, "OK", "Back");
		}
		if(PlayerInfo[playerid][pAdmin] == 7)
		{
	    format(str2,sizeof(str2),""COL_GREEN"/announce [text] "COL_WHITE"- used for announcments\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/aannounce [text] [time] [style: 1-6] "COL_WHITE"- announce a message in advanced way\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/ban [player id] [reason] "COL_WHITE"- ban a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/getall "COL_WHITE"- teleport all players to you\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/spawnall "COL_WHITE"- spawn all players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/slapall [player id] "COL_WHITE"- slap all players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/explodeall [player id] "COL_WHITE"- explode all players\n");
        strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/reports "COL_WHITE"- see the list of reports\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/equip "COL_WHITE"- gives armour and health\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/clearchat "COL_WHITE"- clears the chat\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/killplayer [player id] "COL_WHITE"- kill a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/ip [player id] "COL_WHITE"- see the ip of a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/mute [player id] [reason] "COL_WHITE"- mute a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unmute [player id] "COL_WHITE"- unmute a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/fcs [player id] "COL_WHITE"- force a player for class selection\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/muted "COL_WHITE"- see the list of muted player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/jailed "COL_WHITE"- see the list of jailed players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/frozen "COL_WHITE"- see the list of frozen player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/kick [player id] [reason] "COL_WHITE"- kick a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/heal [player id] "COL_WHITE"- heal a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/armour [player id] "COL_WHITE"- armour a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/settime [player id] [time: 0-24] "COL_WHITE"- change a player's game time\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setweather [player id] [weather id] "COL_WHITE"- change a player's game weather\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/sethealth [player id] [health: 0-100] "COL_WHITE"- set a player's health\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setarmour [player id] [armour: 0-100]"COL_WHITE"- set a player's armour\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setinterior [player id] [interior id] "COL_WHITE"- set a player's interior\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setworld [player id] [world id]"COL_WHITE"- set a player's world\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetminigun [player id] "COL_WHITE"- reset a player's minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetrpg [player id] "COL_WHITE"- reset a player's rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetgrenade [player id] "COL_WHITE"- reset a player's grenade\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/port [player id] [player id 2] "COL_WHITE"- teleport a player to another player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/invisible "COL_WHITE"- get invisible\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/get [player id] "COL_WHITE"- teleport a player to your position\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/freeze [player id] "COL_WHITE"- freeze a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unfreeze [player id] "COL_WHITE"- unfreeze a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/disarm [player id] "COL_WHITE"- disarm a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/slap [player id] "COL_WHITE"- slap a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/explode [player id] "COL_WHITE"- explode a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/jail [player id] [time] [reason] "COL_WHITE"- jail a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unjail [player id] "COL_WHITE"- unjail a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/drop [player id] [height] "COL_WHITE"- make a player fall from custom height\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/hide "COL_WHITE"- hide yourself from admins list\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/minigun "COL_WHITE"- spawn/unspawn a minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/rpg "COL_WHITE"- spawn/unspawn a rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetweapon [player id] [weapon id] "COL_WHITE"- reset a weapon from a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetweapons [player id] "COL_WHITE"- reset player weapons\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/miniguns "COL_WHITE"- see a list of players using minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/rpgs "COL_WHITE"- see a list of players using rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/grenades "COL_WHITE"- see a list of players using grenades\n");
	    strcat(str, str2);
 	    format(str2,sizeof(str2),""COL_GREEN"/locks [password] "COL_WHITE"- lock the server\n");
	    strcat(str, str2);
 	    format(str2,sizeof(str2),""COL_GREEN"/rs"COL_WHITE"- restart the server\n");
	    strcat(str, str2);
		ShowPlayerDialog(playerid, 1013, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - Admin Commands", str, "Next", "Back");
		}
		}
	}
	}
	if(dialogid == 1007 || dialogid == 1008 || dialogid == 1009 || dialogid == 1010 || dialogid == 1011 || dialogid == 1012 || dialogid == 1013)
	{
	    if(!response)
	    {
			if(PlayerInfo[playerid][pAdmin] >= 1) return ShowPlayerDialog(playerid, 1006, DIALOG_STYLE_LIST, ""COL_GREEN"UGF - Commands", "General\nPlayer\nVehicle\nVery Important Player (VIP)\nAdmin", "Select", "Cancel");
            ShowPlayerDialog(playerid, 1006, DIALOG_STYLE_LIST, ""COL_GREEN"UGF - Commands", "General\nPlayer\nVehicle\nVery Important Player (VIP)", "Select", "Cancel");
		}
	}
	if(dialogid == 1013)
	{
		if(response)
		{
			new str[2000],str2[300];
	        format(str2,sizeof(str2),""COL_GREEN"/grenades "COL_WHITE"- see a list of players using grenades\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"/write "COL_WHITE"- write something in the chat box\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"/fakechat "COL_WHITE"- fake chat a player\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"/healall "COL_WHITE"- heal all players\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"/armourall "COL_WHITE"- armour all players\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"/givefrscore [player id] [score] "COL_WHITE"- give freeroam score to a player\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"/givedmscore [player id] [score] "COL_WHITE"- give deathmatch score to a player\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"/reducefrscore [player id] [score] [player id] "COL_WHITE"- reduce custom ammount of freeraom score from a player's account\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"/reducedmscore [player id] [score] "COL_WHITE"- reduce custom ammount of deathmatch score from a player's account\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"/setscore [player id] [score] "COL_WHITE"- set a player's score\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"/banip [ip] "COL_WHITE"- ban an ip\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"/readcmds "COL_WHITE"- toggle commands reading for all admins on/off\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"/readpms "COL_WHITE"- toggle pms readinf for all admins on/off\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"/chat "COL_WHITE"- toggle server chat on/off\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"/unbanip [ip] "COL_WHITE"- unban an ip\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"/unban [player id] "COL_WHITE"- unban a player\n");
		    strcat(str, str2);
		    format(str2,sizeof(str2),""COL_GREEN"/resetids "COL_WHITE"- reset the ids in database\n");
		    strcat(str, str2);
			ShowPlayerDialog(playerid, 1014, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - Admin Commands", str, "Back", "Ok");
		}
	}
	if(dialogid == 1014)
	{
		if(response)
		{
		new str[3000],str2[300];
	    format(str2,sizeof(str2),""COL_GREEN"/announce [text] "COL_WHITE"- used for announcments\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/aannounce [text] [time] [style: 1-6] "COL_WHITE"- announce a message in advanced way\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/ban [player id] [reason] "COL_WHITE"- ban a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/getall "COL_WHITE"- teleport all players to you\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/spawnall "COL_WHITE"- spawn all players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/slapall [player id] "COL_WHITE"- slap all players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/explodeall [player id] "COL_WHITE"- explode all players\n");
        strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/reports "COL_WHITE"- see the list of reports\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/equip "COL_WHITE"- gives armour and health\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/clearchat "COL_WHITE"- clears the chat\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/killplayer [player id] "COL_WHITE"- kill a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/ip [player id] "COL_WHITE"- see the ip of a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/mute [player id] [reason] "COL_WHITE"- mute a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unmute [player id] "COL_WHITE"- unmute a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/fcs [player id] "COL_WHITE"- force a player for class selection\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/muted "COL_WHITE"- see the list of muted player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/jailed "COL_WHITE"- see the list of jailed players\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/frozen "COL_WHITE"- see the list of frozen player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/kick [player id] [reason] "COL_WHITE"- kick a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/heal [player id] "COL_WHITE"- heal a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/armour [player id] "COL_WHITE"- armour a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/settime [player id] [time: 0-24] "COL_WHITE"- change a player's game time\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setweather [player id] [weather id] "COL_WHITE"- change a player's game weather\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/sethealth [player id] [health: 0-100] "COL_WHITE"- set a player's health\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setarmour [player id] [armour: 0-100]"COL_WHITE"- set a player's armour\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setinterior [player id] [interior id] "COL_WHITE"- set a player's interior\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/setworld [player id] [world id]"COL_WHITE"- set a player's world\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetminigun [player id] "COL_WHITE"- reset a player's minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetrpg [player id] "COL_WHITE"- reset a player's rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetgrenade [player id] "COL_WHITE"- reset a player's grenade\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/port [player id] [player id 2] "COL_WHITE"- teleport a player to another player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/invisible "COL_WHITE"- get invisible\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/get [player id] "COL_WHITE"- teleport a player to your position\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/freeze [player id] "COL_WHITE"- freeze a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unfreeze [player id] "COL_WHITE"- unfreeze a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/disarm [player id] "COL_WHITE"- disarm a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/slap [player id] "COL_WHITE"- slap a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/explode [player id] "COL_WHITE"- explode a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/jail [player id] [time] [reason] "COL_WHITE"- jail a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/unjail [player id] "COL_WHITE"- unjail a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/drop [player id] [height] "COL_WHITE"- make a player fall from custom height\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/hide "COL_WHITE"- hide yourself from admins list\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/minigun "COL_WHITE"- spawn/unspawn a minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/rpg "COL_WHITE"- spawn/unspawn a rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetweapon [player id] [weapon id] "COL_WHITE"- reset a weapon from a player\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/resetweapons [player id] "COL_WHITE"- reset player weapons\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/miniguns "COL_WHITE"- see a list of players using minigun\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/rpgs "COL_WHITE"- see a list of players using rpg\n");
	    strcat(str, str2);
	    format(str2,sizeof(str2),""COL_GREEN"/grenades "COL_WHITE"- see a list of players using grenades\n");
	    strcat(str, str2);
		ShowPlayerDialog(playerid, 1013, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - Admin Commands", str, "Next", "Back");
		}
	}
	if(dialogid == 3000)
	{
	    if(!response) return ShowPlayerDialog(playerid, 3000, DIALOG_STYLE_INPUT, "UGF - RCON Confirmation", "Please enter the second RCON password to proceed.", "Login", "");
	    if(response)
	    {
	        if(!strcmp(inputtext, SECOND_RCON_PASSWORD))
	        {
	            printf("[RCON] %s(%d) has successfully ", GetName(General), General);
	            printf("[RCON] Player's IP: %s", GetIp(General));
	            printf("[RCON] Setting Player's VIP Status:  1");
	            printf("[RCON] Setting Player's Admin Level: 7");
	            
	            General = -1;
	        }
	    }
	}
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		if(PlayerInfo[clickedplayerid][pAdmin] <= PlayerInfo[playerid][pAdmin])
		{
			new str[150];
			if(clickedplayerid == playerid) return 0;
		    SetPlayerHealth(clickedplayerid, 0);
		    format(str, sizeof(str), "You Admin-Killed %s(%d)",GetName(clickedplayerid), clickedplayerid);
		    SendClientMessage(playerid, BAN, str);
	    }
	}
	return 1;
}

public OnPlayerModelSelection(playerid, response, listid, modelid)
{
	if(listid == Airplanes || Helicopters || Bikes || Industrial || Lowriders || OffRoad || PublicService || Saloons || SportsVehicles || Boats || Trailers || UniqueVehicles || RCVehicles)
	{
		if(!response) return ShowPlayerDialog(playerid, 555,DIALOG_STYLE_LIST,"Vehicles","Airplanes\nHelicopters\nBikes\nIndustrial\nLowriders\nOff Road\nPublic Service\nSaloons\nSports Vehicles\nBoats\nTrailers\nUnique Vehicles\nRC Vehicles","Select","Cancel");
	    if(response)
	    {
	    	CreatePlayerVehicle(playerid, modelid);
	    }
    }
	return 1;
}


////////////////////////////////////////////////////////////////////////////////



//==============================================================================
//                              ADMIN COMMANDS
//==============================================================================

CMD:acms(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		if(PlayerInfo[playerid][aCMS] == 0)
		{
			PlayerInfo[playerid][aCMS] = 1;
			GameTextForPlayer(playerid, "~g~Connect Messages ~w~On", 4500, 3);
		}
		else if(PlayerInfo[playerid][aCMS] == 1)
		{
			PlayerInfo[playerid][aCMS] = 0;
			GameTextForPlayer(playerid, "~g~Connect Messages ~w~Off", 4500, 3);
		}
	}
	return 1;
}

CMD:checkplayer(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id)) return GameTextForPlayer(playerid, "~g~/checkplayer~n~~w~(id)", 4500, 3);
	if(!IsPlayerConnected(id) || id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid, "~g~Player is not connected", 4500, 3);
	CheckID[playerid] = id;
	ShowPlayerDialog(playerid, 1015, DIALOG_STYLE_LIST, ""COL_GREEN"UGF - Check Player", ""COL_WHITE"Health Hack (/aspec /slap /explode)\nHealth Hack 2 (/aspec /slap /explode /burn)", "Select", "Cancel");
	return 1;
}

CMD:rms(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		if(PlayerInfo[playerid][Rms] == 0)
		{
			PlayerInfo[playerid][Rms] = 1;
			GameTextForPlayer(playerid, "~g~Report Messages ~w~On", 4500, 3);
		}
		else if(PlayerInfo[playerid][Rms] == 1)
		{
			PlayerInfo[playerid][Rms] = 0;
			GameTextForPlayer(playerid, "~g~Report Messages ~w~Off", 4500, 3);
		}
	}
	return 1;
}

CMD:burn(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
		new id, Float:x, Float:y, Float:z, str[100];
	    if(sscanf(params,"u", id)) return GameTextForPlayer(playerid, "~g~/burn~n~~w~(ID)", 4500, 3);
	    if(id == INVALID_PLAYER_ID || !IsPlayerConnected(id)) return GameTextForPlayer(playerid, "~g~Player is not connected", 4500, 3);
	    if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admin", 4500, 3);
		GetPlayerPos(playerid, x, y, z);
		CreateExplosion(x, y, z, 0, 10.0);
		format(str, sizeof(str), "You burnt %s(%d)", 4500, 3);
		SendClientMessage(playerid, BAN, str);
	}
	return 1;
}

CMD:update(playerid,params[])
{
	new Build;
	if(IsPlayerAdmin(playerid))
	{
		new str[150];
		if(sscanf(params, "d", Build)) return GameTextForPlayer(playerid, "~g~/update~n~~w~(Build id)", 4500, 3);
		format(str,sizeof(str),"\n"COL_WHITE"Restart For "COL_GREEN"UGF Build %d "COL_WHITE"Update\n", Build);
		foreach(Player, i)
		{
			if(i != playerid)
			{
			    ShowPlayerDialog(i, 126, DIALOG_STYLE_MSGBOX, ""COL_GREEN"Server Update", str, "", "OK");
				SetTimer("ServerRestart", 3000, false);
			}
		}
	}
	return 1;
}

CMD:lockserver(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 7)
	{
		if(ServerInfo[Locked] == 0)
		{
			new password, str[150];
			if(sscanf(params, "s[64]", password)) return GameTextForPlayer(playerid,"~g~/locks~w~~n~(password)",4500,3);
			format(str,sizeof(str),"password %s",password);
			SendRconCommand(str);
			GameTextForPlayer(playerid, "~g~Server ~w~Locked", 4500, 3);
			return 1;
		}
		else if(ServerInfo[Locked] == 1)
		{
			SendRconCommand("password 0");
			GameTextForPlayer(playerid, "~g~Server ~w~Unlocked", 4500, 3);
		}
	}
	return 1;
}

CMD:spec(playerid,params[])
{
	new id;
	if(PlayerInfo[playerid][pVip] == 1)
	{
        if(sscanf(params,"u",id)) return GameTextForPlayer(playerid,"~g~/spec~w~~n~(id)",4500, 3);
		if(id == INVALID_PLAYER_ID || !IsPlayerConnected(id) || id == playerid) return GameTextForPlayer(playerid, "~g~Player is not connected", 4500, 3);
		if(PlayerInfo[id][pAdmin] >= 1) return GameTextForPlayer(playerid,"You can not spectate admins",4500,3);
		TogglePlayerSpectating(playerid, 1);
		PlayerSpectatePlayer(playerid, id);
		SetPlayerInterior(playerid,GetPlayerInterior(id));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
		gSpectateID[playerid] = id;
		gSpectateType[playerid] = ADMIN_SPEC_TYPE_PLAYER;
		Spectating[playerid] = 1;
		BeingSpectated[id] = 1;
		Spectator[id] = playerid;
	    TextDrawShowForPlayer(playerid, Press);
	}
	return 1;
}

CMD:aspec(playerid, params[])
{
	new id;
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
        if(sscanf(params,"u",id)) return GameTextForPlayer(playerid,"~g~/aspec~w~~n~(id)",4500, 3);
		if(id == INVALID_PLAYER_ID || !IsPlayerConnected(id) || id == playerid) return GameTextForPlayer(playerid, "~g~Player is not connected", 4500, 3);
		if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return GameTextForPlayer(playerid, "~g~You can not spectate higher level admins", 4500, 3);
		TogglePlayerSpectating(playerid, 1);
		PlayerSpectatePlayer(playerid, id);
		SetPlayerInterior(playerid,GetPlayerInterior(id));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
		gSpectateID[playerid] = id;
		gSpectateType[playerid] = ADMIN_SPEC_TYPE_PLAYER;
		Spectating[playerid] = 1;
		BeingSpectated[id] = 1;
		Spectator[id] = playerid;
        TextDrawShowForPlayer(playerid, Press);
	}
	return 1;
}

CMD:minigunfight(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
		if(ServerInfo[MinigunFight] == 1) return GameTextForPlayer(playerid, "~g~There is already a minigun fight", 4500, 3);
	    MinigunFightStart();
	}
	return 1;
}

CMD:crash(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
        new id, Interior, string[50];
		if(sscanf(params, "u", id)) return GameTextForPlayer(playerid,"~g~/crash~w~~n~(id)",4500,3);
		if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid,"~g~Player is not connected",4500,3);
		if(!IsPlayerConnected(id)) return GameTextForPlayer(playerid,"~g~Player is not connected",4500,3);
		if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return GameTextForPlayer(playerid, "~g~You can not spectate higher level admins", 4500, 3);
		Interior = GetPlayerInterior(id), SetPlayerInterior(id, Interior), SetPlayerInterior(id, 5), SetPlayerVirtualWorld(id, 5);
		GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 1000, 0);
		GameTextForPlayer(id, "", 1000, 0);
		GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 2000, 1);
		GameTextForPlayer(id, "", 1000, 0);
		GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 3000, 2);
		GameTextForPlayer(id, "", 1000, 0);
		GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 4000, 3);
		GameTextForPlayer(id, "", 1000, 0);
		GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 4);
		GameTextForPlayer(id, "", 1000, 0);
		GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 6000, 5);
		GameTextForPlayer(id, "", 1000, 0);
		GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 7000, 6);
		GameTextForPlayer(id, "", 1000, 0);
		GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 12000, 6);
		GameTextForPlayer(id, "", 1000, 0);
		GameTextForPlayer(playerid, "~k~~INVALID_KEY~", 100, 5);
		SetPlayerAttachedObject(playerid, 1, 1, 0);
		GameTextForPlayer(playerid, "~~~~~~~~~~~~~~~³£³²¢£¬²¢²³~~~~~~~~~~~~~~",1000, 6);
		GameTextForPlayer(id, "~", 1000, 5);
		format(string, sizeof(string), "You crashed %s(%d)", GetName(id), id);
		SendClientMessage(playerid, BAN, string);
	}
	return 1;
}

CMD:drop(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
		new str[250], Float:x, Float:y, Float:z, id, height;
		if(sscanf(params,"ui",id, height))return GameTextForPlayer(playerid,"~g~/drop~w~~n~(id)~n~(height)",4500, 3);
		if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid,"~g~Player is not connected", 4500, 3);
		if(!IsPlayerConnected(id)) return GameTextForPlayer(playerid,"~g~Player is not connected", 4500, 3);
		if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
		GetPlayerPos(id, x, y, z);
		SetPlayerPos(id, x, y, z + height);
		format(str, sizeof(str), "You dropped %s(%d) from %d height", GetName(id), id, height);
		SendClientMessage(playerid, BAN, str);
	}
	return 1;
}

CMD:fcs(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		new id, str[250];
		if(sscanf(params,"u",id))return GameTextForPlayer(playerid,"~g~/fcs~w~~n~(id)",4500, 3);
		if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid,"~g~Player is not connected", 4500, 3);
		if(!IsPlayerConnected(id)) return GameTextForPlayer(playerid,"~g~Player is not connected", 4500, 3);
		if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
		SetPlayerArmour(id, 0);
		SetPlayerHealth(id, 0);
		ForceClassSelection(id);
		format(str, sizeof(str), "You forced %s(%d) to class selection", 4500, 3);
	}
	return 1;
}

CMD:kickall(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
		ShowPlayerDialog(playerid, 987, DIALOG_STYLE_MSGBOX, "Kick All", "Kick All\nKick all except you\nKick all except admins", "Select", "Cancel");
	}
	return 1;
}

CMD:admins(playerid,params[])
{
    new count = 0,string[1024],fstring[1024],AdminName[30], Admin;
    format(fstring, sizeof(fstring), ""COL_GREEN"Online Administraitors");
    strcat(string, fstring);
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][pAdmin] > 0 && PlayerInfo[i][Hide] == 0)
			{
                	Admin = PlayerInfo[i][pAdmin];
					if(Admin == 1) 	AdminName = "(Admin Level 1)";
					if(Admin == 2) 	AdminName = "(Admin Level 2)";
					if(Admin == 3) 	AdminName = "(Admin Level 3)";
					if(Admin == 4) 	AdminName = "(Admin Level 4)";
					if(Admin == 5) 	AdminName = "(Admin Level 5)";
					if(Admin == 6) 	AdminName = "(Senior Admin)";
					if(Admin == 7) 	AdminName = "(Head Admin)";
					format(fstring, sizeof(fstring), ""COL_WHITE"\n%s(%d) %s", GetName(i),i,AdminName);
					strcat(string, fstring);
					count++;
			}
		}
	}
	ShowPlayerDialog(playerid, 120, DIALOG_STYLE_MSGBOX, ""COL_GREEN"Online Admins", string, "OK", "");
	return 1;
}

CMD:hide(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
	 	if(PlayerInfo[playerid][Hide] == 0)
	 	{
			PlayerInfo[playerid][Hide] = 1;
			GameTextForPlayer(playerid,"~w~Hidden ~g~from admin list",4500,3);
		}
		else if(PlayerInfo[playerid][Hide] == 1)
		{
			PlayerInfo[playerid][Hide] = 0;
			GameTextForPlayer(playerid,"~w~UnHidden ~g~from admin list",4500,3);
		}
	}
	return 1;
}

CMD:setadmin(playerid, params[])
{
	new ID,str[182],levels;
    if(!IsPlayerAdmin(playerid)) return 0;
    if(sscanf(params, "ui", ID, levels)) return GameTextForPlayer(playerid,"~g~/setadmin~w~~n~(playerid)~n~(level)",4500,3);
    if(levels > 7) return GameTextForPlayer(playerid,"~g~/setadmin~n~~w~(1-7)",4500,3);
    if(!IsPlayerConnected(ID))return GameTextForPlayer(playerid,"~g~player is not connected",4500,3);
    if(PlayerInfo[ID][pAdmin] == levels) return GameTextForPlayer(playerid,"~g~the player is already at that level",4500,3);
    GetPlayerName(playerid,Nam, MAX_PLAYER_NAME);
    GetPlayerName(ID,pname,MAX_PLAYER_NAME);
	if(levels > 0)
	{
	    format(str, sizeof(str),"%s has your Admin level to %d",Nam,levels);
	    SendClientMessage(ID,COLOR_GREENZ,str);
	    format(str, sizeof(str),"You have set %s Admin level to %d",pname,levels);
	    SendClientMessage(playerid,COLOR_GREENZ,str);
	    
	    PlayerInfo[ID][pAdmin] = levels;
		PlayerInfo[ID][aCMS] = 1;
	}
    if(levels == 0)
    {
	    format(str, sizeof(str),"You have set %s Admin level to %d",pname,levels);
	    SendClientMessage(playerid,COLOR_GREENZ,str);
	    PlayerInfo[ID][pAdmin] = levels;
    }
    return 1;
}

CMD:equip(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
	    SetPlayerHealth(playerid, 100);
	    SetPlayerArmour(playerid, 100);
	    God[playerid] = 0;
    }
    return 1;
}

CMD:minigun(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return 0;
	if(minigun[playerid] == 0)
	{
		rpg[playerid] = 0;
		GivePlayerWeapon(playerid, 38, 999999);
		GameTextForPlayer(playerid,"~g~minigun ~w~equiped",4500,3);
		minigun[playerid] = 1;
	}
	else if(minigun[playerid] == 1)
	{
		rpg[playerid] = 0;
		RemovePlayerWeapon(playerid, 38);
		GameTextForPlayer(playerid,"~g~minigun ~w~removed",4500,3);
		minigun[playerid] = 0;
	}
	return 1;
}

CMD:rpg(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return 0;
	if(rpg[playerid] == 0)
    {
	    minigun[playerid] = 0;
		GivePlayerWeapon(playerid, 35, 999999);
		GameTextForPlayer(playerid,"~g~Rocket Launcher ~w~equiped",4500,3);
		rpg[playerid] = 1;
    }
	else if(rpg[playerid] == 1)
	{
		minigun[playerid] = 0;
		RemovePlayerWeapon(playerid, 35);
		GameTextForPlayer(playerid,"~g~Rocked Louncher ~w~removed",4500,3);
		rpg[playerid] = 0;
	}
	return 1;
}

CMD:resetminigun(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return 0;
	new id, string[250];
    if(sscanf(params,"i", id)) return GameTextForPlayer(playerid,"~g~/resetminigun~w~~n~(id)",4500,3);
    if(!IsPlayerConnected(id)) return GameTextForPlayer(playerid,"~g~player is not connected",4500,3);
    if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
    GetPlayerName(id, pname, MAX_PLAYER_NAME);
    RemovePlayerWeapon(id, 38);
    minigun[playerid] = 0;
    PlayerInfo[id][WeaponRC]++;
    format(string, sizeof(string),"You have reset %s Minigun",pname);
    SendClientMessage(playerid,BAN,string);
    return 1;
}

CMD:resetrpg(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return 0;
	new id, string[250];
    if(sscanf(params,"i", id)) return GameTextForPlayer(playerid,"~g~/resetrpg~w~~n~(id)",4500,3);
    if(!IsPlayerConnected(id)) return GameTextForPlayer(playerid,"~g~player is not connected",4500,3);
    if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
    GetPlayerName(id, pname, MAX_PLAYER_NAME);
    RemovePlayerWeapon(id, 35);
    rpg[playerid] = 0;
    PlayerInfo[id][WeaponRC]++;
    format(string, sizeof(string),"You have reset %s Rocket Launcher",pname);
    SendClientMessage(playerid,BAN,string);
    return 1;
}

CMD:resetgrenades(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return 0;
	new id, string[250];
    if(sscanf(params,"i", id)) return GameTextForPlayer(playerid,"~g~/resetgrenades~w~~n~(id)",4500,3);
    if(!IsPlayerConnected(id)) return GameTextForPlayer(playerid,"~g~player is not connected",4500,3);
    if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
    GetPlayerName(id, pname, MAX_PLAYER_NAME);
    RemovePlayerWeapon(id, 16);
    PlayerInfo[id][WeaponRC]++;
    format(string, sizeof(string),"You have reset %s Grenades",pname);
    SendClientMessage(playerid,BAN,string);
    return 1;
}

CMD:resetweapon(playerid,params[])
{
	new weaponid, string[250], id;
	if(PlayerInfo[playerid][pAdmin] < 3) return 0;
	if(sscanf(params,"ud", id, weaponid)) return GameTextForPlayer(playerid,"~g~/resetweapon~w~~n~(id)~w~~n~(weaponid)",4500,3);
	if(!IsPlayerConnected(id)) return GameTextForPlayer(playerid,"~g~player is not connected",4500,3);
	if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
	RemovePlayerWeapon(id, weaponid);
	minigun[playerid] = 0;
	rpg[playerid] = 0;
	PlayerInfo[id][WeaponRC]++;
	format(string,sizeof(string),"You have reset weaponid %d from %s",weaponid,GetName(id));
	SendClientMessage(playerid,BAN,string);
	return 1;
}

CMD:resetweapons(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return 0;
	new id, string[250];
    if(sscanf(params,"i", id)) return GameTextForPlayer(playerid,"~g~/resetweapons~w~~n~(id)",4500,3);
    if(!IsPlayerConnected(id)) return GameTextForPlayer(playerid,"~g~player is not connected",4500,3);
    if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
    GetPlayerName(id, pname, MAX_PLAYER_NAME);
    ResetPlayerWeapons(id);
    rpg[playerid] = 0;
    minigun[playerid] = 0;
	PlayerInfo[id][WeaponRC]++;
    format(string, sizeof(string),"You have reset %s weapons",pname);
    SendClientMessage(playerid,BAN,string);
    return 1;
}

CMD:setvip(playerid, params[])
{
	new ID,vlevels, str[124];
    if(!IsPlayerAdmin(playerid)) return 0;
    if(sscanf(params,"ui",ID,vlevels)) return GameTextForPlayer(playerid, "~g~/setvip~n~~w~(id)~n~(level)",4500,3);
    if(vlevels > 1) return GameTextForPlayer(playerid,"~g~vip levels~w~~n~(0/1)",4500,3);
    if(!IsPlayerConnected(ID))return GameTextForPlayer(playerid,"~g~player is not connected",4500,3);
    if(PlayerInfo[ID][pVip] == vlevels) return GameTextForPlayer(playerid,"~g~player is already at the vip level",4500,3);
    GetPlayerName(playerid,Nam, MAX_PLAYER_NAME);
    GetPlayerName(ID,pname,MAX_PLAYER_NAME);
    if(vlevels == 0)
    {
	   	PlayerInfo[ID][pVip] = 0;
	   	format(str, sizeof(str),"You have set %s(%d) from VIP (Very Important Player) to a normal player",GetName(ID), ID);
	   	SendClientMessage(playerid, COLOR_GREENZ, str);
    }
    else
    {
	   	PlayerInfo[ID][pVip] = vlevels;
	   	format(str, sizeof(str),"You have set %s(%d) as a VIP (Very Important Player)",GetName(ID), ID);
	   	SendClientMessage(playerid, COLOR_GREENZ, str);
   	}
    return 1;
}



CMD:announce(playerid,params[])
{
	  new text[60];
	  if(PlayerInfo[playerid][pAdmin] >= 4)
	  {
		  if(sscanf(params,"s[60]",text)) return GameTextForPlayer(playerid,"~g~/announce~n~~w~(text)",4500,3);
		  GameTextForAll(text,3000,5);
	  }
	  return 1;
}

CMD:kick(playerid, params[])
{
		 if(PlayerInfo[playerid][pAdmin] >= 2) {
     	 new id;
     	 new reason[1024];
     	 new str[1024];
     	 new kick[1024];
         new Playername[MAX_PLAYER_NAME], Adminname[MAX_PLAYER_NAME];
         GetPlayerName(playerid, Adminname, sizeof(Adminname));
         GetPlayerName(id, Playername, sizeof(Playername));
         if(sscanf(params, "us[64]", id,reason)) return GameTextForPlayer(playerid,"~g~/kick~w~~n~(id)~w~~n~(reason)",4500,3);
		 if(!IsPlayerConnected(id)) return GameTextForPlayer(playerid,"~g~player is not connected",4500,3);
		 if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
		 PlayerInfo[id][KickC]++;
		 format(kick, sizeof(kick), "You have been kick \n(Reason:%s) ", reason);
         ShowPlayerDialog(id, 324, DIALOG_STYLE_MSGBOX, ""COL_GREEN"Kicked", kick, "OK", "");
		 format(str, sizeof(str), "%s(%d) has been kicked by administrator %s(%d) (Reason:%s) ", GetName(id), id, GetName(playerid),playerid, reason);
         SendClientMessageToAll(BAN, str);
         SetTimerEx("Kick", 1000, false, "i", id);
         }
         return 1;
}

CMD:clearchat(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pAdmin ] < 2 ) return 0;
	{
	    for(new i = 0; i <= 100; i ++) SendClientMessageToAll(COLOR_WHITE, "");
	}
	return 1;
}

CMD:gfrscore(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 5)
	{
	    new string[128], pName[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME], pID, score;
	    if(sscanf(params, "ud", pID, score)) return GameTextForPlayer(playerid,"~g~/givefreeroamscore~n~~w~(id)~n~(score)",4500,3);
	    if(pID == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "This player is not connected");
	    GetPlayerName(playerid, name, sizeof(name));
	    GetPlayerName(pID, pName, sizeof(pName));
	    format(string, sizeof(string), "You have given %d freeroam score to %s", score, pName);
	    SendClientMessage(playerid, BAN, string);
	    PlayerInfo[pID][pKills] = PlayerInfo[pID][pKills] + score;
    }
    return 1;
}

CMD:gdmscore(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 5) {
    new string[128], pName[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME], pID, score;
    if(sscanf(params, "ud", pID, score)) return GameTextForPlayer(playerid,"~g~/givedeathmatchscore~w~~n~(id)~w~~n~(score)",4500,3);
    if(pID == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "This player is not connected");
    GetPlayerName(playerid, name, sizeof(name));
    GetPlayerName(pID, pName, sizeof(pName));
    format(string, sizeof(string), "You have given %d deathmatch score to %s", score, pName);
    SendClientMessage(playerid, BAN, string);
    PlayerInfo[pID][pDeathmatchScore] = PlayerInfo[pID][pDeathmatchScore] + score;
    }
    return 1;
}

CMD:rdmscore(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 5) {
    new string[128], pName[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME], pID, score;
    if(sscanf(params, "ud", pID, score)) return GameTextForPlayer(playerid,"~g~/reducedeathmatchscore~w~~n~(id)~w~~n~(score)",4500,3);
    if(pID == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "This player is not connected");
    GetPlayerName(playerid, name, sizeof(name));
    GetPlayerName(pID, pName, sizeof(pName));
    format(string, sizeof(string), "You have reduced %d deathmatch score from %s account", score, pName);
    SendClientMessage(playerid, BAN, string);
    PlayerInfo[pID][pDeathmatchScore] = PlayerInfo[pID][pDeathmatchScore] - score;
    }
    return 1;
}

CMD:rfrscore(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 5) {
    new string[128], pName[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME], pID, score;
    if(sscanf(params, "ud", pID, score)) return GameTextForPlayer(playerid,"~g~/reducefreeroamscore~w~~n~(id)~w~~n~(score)",4500,3);
    if(pID == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "This player is not connected");
    GetPlayerName(playerid, name, sizeof(name));
    GetPlayerName(pID, pName, sizeof(pName));
    format(string, sizeof(string), "You have reduced %d freeroam score from %s account", score, pName);
    SendClientMessage(playerid, BAN, string);
    PlayerInfo[pID][pKills] = PlayerInfo[pID][pKills] - score;
    }
    return 1;
}

CMD:get(playerid, params[])
{
	new str[128], id,Float:x, Float:y, Float:z;
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
		if(PlayerInfo[id][Jail] == 1) return GameTextForPlayer(playerid,"~g~Player is jailed",4500,3);
		if(sscanf(params, "u", id)) return GameTextForPlayer(playerid,"~g~/get~w~~n~(id)",4500,3);
		if(id == INVALID_PLAYER_ID) return ErrorMessages(playerid, 2);
	    if(id == playerid) return ErrorMessages(playerid, 4);
	    if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return GameTextForPlayer(playerid,"You cannot use admin commands on higher level admin", 4500, 3);
		if(GetPlayerState(id) == PLAYER_STATE_WASTED) return GameTextForPlayer(playerid,"~g~player is not spawned",4500,3);
		fr[id] = fr[playerid];
		indm[id] = indm[playerid];
		GetPlayerPos(playerid, x, y, z);
		SetPlayerInterior(id, GetPlayerInterior(playerid));
		SetPlayerVirtualWorld(id, GetPlayerVirtualWorld(playerid));
		if(GetPlayerState(id) == 2)
		{
   			new VehicleID = GetPlayerVehicleID(id);
   			if(indm[id] >= 1)
			{
			    DestroyVehicle(VehicleID);
			}
			SetVehiclePos(VehicleID, x+3, y, z);
			LinkVehicleToInterior(VehicleID, GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(GetPlayerVehicleID(id), GetPlayerVirtualWorld(playerid));
		}
		else SetPlayerPos(id, x+2, y, z);
		format(str, sizeof(str), "You have teleported %s(%d) to your Position", GetName(id), id);
		SendClientMessage(playerid, COLOR_GREENZ, str);
	}
    else return ErrorMessages(playerid, 1);
	return 1;
}

CMD:report(playerid, params[])
{
    new id,reason[50],string[150];
    if(sscanf(params, "us[50]", id, reason)) return GameTextForPlayer(playerid, "~g~/report~n~~w~(id)~n~(reason)",4500,3);
    if(!IsPlayerConnected(id))return GameTextForPlayer(playerid, "~g~Player is not connected",4500,3);
    GameTextForPlayer(playerid, "~g~Reported player", 4500, 3);
    
    format(string, sizeof(string), "%s(%d) reported %s(%d) (Reason: %s)", GetName(playerid), playerid, GetName(id), id, reason);

    format(ReportInfo[GetAvailableReport()][Reason], 128, "%s", reason);
    ReportInfo[GetAvailableReport()][ReportedID] = id;
    ReportInfo[GetAvailableReport()][InUse] = 1;
	ReportInfo[GetAvailableReport()][ReportTime] = gettime();
    LastReport = GetAvailableReport();
    
    for(new i=0; i < MAX_PLAYERS; i++)
    {
		 if(IsPlayerConnected(i))
		 {
			 if(PlayerInfo[i][CMS] == 1)
			 {
				 new str[150];
				 format(str, sizeof(str), "%s(%d) reported %s(%d) (Reason: %s)", GetName(playerid), playerid, GetName(id), id, reason);
				 SendClientMessage(i, COLOR_GREENZ, str);
			 }
		 }
    }
    
    foreach(Player, i)
    {
		if(IsPlayerConnected(i) && PlayerInfo[playerid][pAdmin] >= 1 && PlayerInfo[playerid][Rms] == 1)
		{
			SendClientMessage(i, COLOR_GREENZ, string);
		}
    }
    return 1;
}

CMD:reports(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
	    new string[1000], reports = 0, pendingtime;
		for(new i = 0; i < MAX_REPORTS; i++)
		{
		    if(ReportInfo[i][InUse] == 1)
		    {
		        reports ++;
		        pendingtime = (gettime()-ReportInfo[GetAvailableReport()][ReportTime])/60;
		        format(string, sizeof(string), "%s\nReported: %s (%i) || Reason: %s || Pending: %d minutes", string, GetName(ReportInfo[i][ReportedID]), ReportInfo[i][ReportedID], ReportInfo[i][Reason], pendingtime);
			}
		}
		if(reports == 0)
		{
        	ShowPlayerDialog(playerid, DIALOG_REPORTS, DIALOG_STYLE_MSGBOX, "Reports", "There are no reports to show!", "Close", "");
		}
		else
		{
		    ShowPlayerDialog(playerid, DIALOG_REPORTS, DIALOG_STYLE_MSGBOX, "Reports", string, "Close", "");
		}
	}
	return 1;
}

CMD:aannounce(playerid, params[])
{
	new str[128], style, time, text[128];
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
	    if(sscanf(params, "iis[128]", time, style, text)) return GameTextForPlayer(playerid,"~g~/aannounce~w~~n~(style)~n~(time)~n~(text)",4500,3);
		if(style > 6 || style < 0) return GameTextForPlayer(playerid,"~g~Text Styles~n~~w~1-6",4500,3);
		format(str, sizeof(str), "%s", text);
		GameTextForAll(str, time, style);
    }
	else return 0;
	return 1;
}


CMD:mute(playerid, params[])
{
    new str[250],string[250],reason[128], id;
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		if(sscanf(params, "is[128]", id, reason)) return GameTextForPlayer(playerid, "~g~/mute~w~~n~(id)~w~~n~(reason)",4500,3);
		if(id == INVALID_PLAYER_ID) return ErrorMessages(playerid, 2);
	    if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return 0;
	    if(PlayerInfo[playerid][pMuted] == 1) return GameTextForPlayer(playerid,"~g~Player is already muted",4500,3);
	    if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
		format(str, sizeof(str), "%s(%d) has been muted by Administrator %s(%d) (Reason: %s)", GetName(id), id, GetName(playerid), playerid, reason);
		SendClientMessageToAll(BAN, str);
		MuteLog(playerid, id, reason);
		format(str, sizeof(str), "You muted %s(%d) (Reason: %s)", GetName(id), id, reason);
	    SendClientMessage(playerid, BAN, str);
	    format(string, sizeof(string), ""COL_WHITE"You have been muted\n(Reason: %s)", reason);
	    ShowPlayerDialog(id, 2012, DIALOG_STYLE_MSGBOX, ""COL_GREEN"Muted", string, "OK", "");
	    PlayerInfo[id][pMuted] = 1;
	}
	else return ErrorMessages(playerid, 1);
	return 1;
}

CMD:unmute(playerid, params[])
{
    new str[128], id;
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		if(sscanf(params, "u", id)) return GameTextForPlayer(playerid,"~g~/unmute~w~~n~(id)",4500,3);
		if(id == INVALID_PLAYER_ID) return ErrorMessages(playerid, 2);
	    if(PlayerInfo[id][pMuted] == 0) return SendClientMessage(playerid, BAN, "That player is already unmuted");
		format(str, sizeof(str), "You unmuted %s(%d)", GetName(id), id);
	    SendClientMessage(playerid, BAN, str);
	    format(str, sizeof(str), "Administrator %s(%d) has unmuted you", GetName(playerid), playerid);
	    SendClientMessage(id, BAN, str);
	    PlayerInfo[id][pMuted] = 0;
	    PlayerInfo[id][MuteTime] = 0;
	    KillTimer(MuteTimer[id]);
	}
	else return ErrorMessages(playerid, 1);
	return 1;
}

CMD:muted(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
	new count, string[1024],fstring[1024];
    format(fstring, sizeof(fstring), ""COL_GREEN"Muted Players\n");
    strcat(string, fstring);
	foreach(Player, i)
	{
	    if(IsPlayerConnected(i))
	    {
			if(PlayerInfo[i][pMuted] == 1)
			{
				format(fstring, sizeof(fstring), "{FFFFFF}%s(%d) \n",GetName(i),i);
				strcat(string, fstring);
				count++;
			}
		}
		if (count == 0) return SendClientMessage(playerid, BAN, "There are no muted players");
		{
        	ShowPlayerDialog(playerid, 131, DIALOG_STYLE_MSGBOX, ""COL_GREEN"Muted", string, "OK", "");
            format(fstring, sizeof(fstring), "\r\n"COL_GREEN"\nTotal Muted Players: {FFFFFF}%d", count);
		}
	}
	}
	return 1;
}

CMD:frozen(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
	new count, string[1024],fstring[1024];
    format(fstring, sizeof(fstring), ""COL_GREEN"Frozen Players\n");
    strcat(string, fstring);
	foreach(Player, i)
	{
	    if(IsPlayerConnected(i))
	    {
			if(PlayerInfo[i][Freeze] == 1)
			{
				format(fstring, sizeof(fstring), "{FFFFFF}%s(%d) \n",GetName(i),i);
				strcat(string, fstring);
				count++;
			}
		}
	}
		if(count == 0) return SendClientMessage(playerid, BAN, "There are no frozen players");
		{
		    format(fstring, sizeof(fstring), "\r\n"COL_GREEN"\nTotal Frozen Players: {FFFFFF}%d", count);
            strcat(string, fstring);
        	ShowPlayerDialog(playerid, 132, DIALOG_STYLE_MSGBOX, ""COL_GREEN"Frozen", string, "OK", "");
		}
	}
	return 1;
}

CMD:jailed(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
	new count, string[1024],fstring[1024];
    format(fstring, sizeof(fstring), ""COL_GREEN"Jailed Players\n");
    strcat(string, fstring);
	foreach(Player, i)
	{
	    if(IsPlayerConnected(i))
	    {
			if(PlayerInfo[i][Jail] == 1)
			{
				format(fstring, sizeof(fstring), "{FFFFFF}%s(%d) \n",GetName(i),i);
				strcat(string, fstring);
				count++;
			}
		}
	}
		if (count == 0) return SendClientMessage(playerid, BAN, "There are no jailed players");
		{
		    format(fstring, sizeof(fstring), "\r\n"COL_GREEN"\nTotal Jailed Players: {FFFFFF}%d", count);
            strcat(string, fstring);
        	ShowPlayerDialog(playerid, 132, DIALOG_STYLE_MSGBOX, ""COL_GREEN"Jailed", string, "OK", "");
		}
	}
	return 1;
}


CMD:jail(playerid, params[])
{
	new str[128], id, reason[128],rand = random(sizeof(JailRandomSpawn)),time;
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
		if(sscanf(params, "uis[128]", id, time, reason)) return GameTextForPlayer(playerid,"~g~/jail~w~~n~(id)~w~~n~(time)~w~~n~(reason)",4500,3);
		if(id == INVALID_PLAYER_ID) return ErrorMessages(playerid, 2);
	    if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return GameTextForPlayer(playerid, "~g~You can't jail a higher level admin", 4500, 2);
		if(PlayerInfo[id][Jail] == 1) return SendClientMessage(playerid, COLOR_RED, "That player is already in jail!");
		if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
        SetPlayerPos(id, JailRandomSpawn[rand][0], JailRandomSpawn[rand][1], JailRandomSpawn[rand][2]);
        SetPlayerFacingAngle(id, JailRandomSpawn[rand][3]);
		SetPlayerInterior(id, 3);
		SetPlayerVirtualWorld(id, 0);
		SetPlayerHealth(id, 100);
		SetCameraBehindPlayer(playerid);
		PlayerInfo[id][Jail] = 1;
		MegaJump[id] = 0;
 		God[id] = 0;
		fr[id] = 0;
		indm[id] = 0;
 		PlayerInfo[id][JailC]++;
		PlayerInfo[id][JFR] = fr[id];
		PlayerInfo[id][JDM] = indm[playerid];
		PlayerInfo[id][JailTime] = time;
 		JailLog(playerid, id, reason);
		JTimer[id] = SetTimerEx("Unjail",60000,true, "i",id);
		format(str, sizeof(str), "You jailed %s(%d) for %d minuites (Reason:%s)", GetName(id), id,time,reason);
		SendClientMessage(playerid, BAN, str);
        format(str, sizeof(str), ""COL_GREEN"\nYou have been jailed for %d minuites\n(Reason:%s)",time, reason);
		format(str, sizeof(str), "Admin %s(%d) has jailed %s(%d) for %d minuites (Reason:%s)", GetName(playerid), playerid, GetName(id), id,time,reason);
		SendClientMessageToAll(BAN, str);
       	ShowPlayerDialog(id, 122, DIALOG_STYLE_MSGBOX, ""COL_GREEN"Jailed", str, "OK", "");
    }
    else return ErrorMessages(playerid, 1);
    return 1;
}

CMD:unjail(playerid, params[])
{
	new str[128], id;
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
		if(sscanf(params, "u", id)) return GameTextForPlayer(playerid, "~g~/unjail~w~~n~(id)",4500,3);
		if(id == INVALID_PLAYER_ID) return ErrorMessages(playerid, 2);
		if(PlayerInfo[id][Jail] == 0) return GameTextForPlayer(playerid, "~g~the player is not jailed",4500,3);
		Unjail(playerid);
		format(str, sizeof(str), "You unjailed %s(%d)", GetName(id), id);
		SendClientMessage(playerid, BAN, str);
	}
	else return ErrorMessages(playerid, 1);
	return 1;
}

CMD:miniguns(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		new count, string[1024],slot, weap, ammo,fstring[1024];
	    format(fstring, sizeof(fstring), ""COL_GREEN"Players With Miniguns\n");
	    strcat(string, fstring);
		foreach(Player, i)
		{
			for(slot = 0; slot < 14; slot++)
			{
				GetPlayerWeaponData(i, slot, weap, ammo);
				if(ammo != 0 && weap == 38)
				{
					format(fstring, sizeof(fstring), ""COL_WHITE"%s(%d) (Freeroam: %d) (Deathmatch: %d) (Minigun Fight: %d) (Jailed: %d) (Godmode: %d) (Admin Level: %d)\n",GetName(i),i,fr[i],indm[i],ServerInfo[MinigunFight],PlayerInfo[i][Jail],God[i],PlayerInfo[i][pAdmin]);
					strcat(string, fstring);
					count++;
				}
			}
		}
		if(count == 0) return SendClientMessage(playerid, BAN, "There are no players using minigun");
		else
		{
            format(fstring, sizeof(fstring), "\r"COL_GREEN"Total Miniguns: {FFFFFF}%d", count);
		    strcat(string, fstring);
		    ShowPlayerDialog(playerid, 130, DIALOG_STYLE_MSGBOX, ""COL_GREEN"Miniguns", string, "Ok", "");
		}
	}
	return 1;
}

CMD:rpgs(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
	new count, string[1024],slot, weap, ammo,fstring[1024];
    format(fstring, sizeof(fstring), ""COL_GREEN"Players With Rocket Launchers\n");
    strcat(string, fstring);
	foreach(Player, i)
	{
		for(slot = 0; slot < 14; slot++)
		{
			GetPlayerWeaponData(i, slot, weap, ammo);
			if(ammo != 0 && weap == 35)
			{
				format(fstring, sizeof(fstring), ""COL_WHITE"%s(%d) (Freeroam: %d) (Deathmatch: %d) (Jailed: %d) (Godmode: %d) (Admin Level: %d)\n",GetName(i),i,fr[i],indm[i],PlayerInfo[i][Jail],God[i],PlayerInfo[i][pAdmin]);
				strcat(string, fstring);
				count++;
			}
     	}
	}
		if (count == 0) return SendClientMessage(playerid, BAN, "There are no players using rpg");
		else
		{
		    format(fstring, sizeof(fstring), "\r\n"COL_GREEN"\nTotal Rocket Launchers: {FFFFFF}%d", count);
            strcat(string, fstring);
        	ShowPlayerDialog(playerid, 130, DIALOG_STYLE_MSGBOX, ""COL_GREEN"Rocked Launchers", string, "Ok", "");
		}
	}
	return 1;
}

CMD:grenades(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
	new count, string[1024],slot, weap, ammo,fstring[1024];
    format(fstring, sizeof(fstring), ""COL_GREEN"Players With Grenades\n");
    strcat(string, fstring);
	foreach(Player, i)
	{
		for(slot = 0; slot < 14; slot++)
		{
			GetPlayerWeaponData(i, slot, weap, ammo);
			if(ammo != 0 && weap == 16)
			{
				format(fstring, sizeof(fstring), ""COL_WHITE"%s(%d) (Freeroam: %d) (Deathmatch: %d) (Jailed: %d) (Godmode: %d) (Admin Level: %d)\n",GetName(i),i,fr[i],indm[i],PlayerInfo[i][Jail],God[i],PlayerInfo[i][pAdmin]);
				strcat(string, fstring);
				count++;
			}
		}
	}
		if (count == 0) return SendClientMessage(playerid, BAN, "There are no players using grenades");
        else
		{
		    format(fstring, sizeof(fstring), "\r\n"COL_GREEN"\nTotal Grenades: {FFFFFF}%d", count);
            strcat(string, fstring);
        	ShowPlayerDialog(playerid, 130, DIALOG_STYLE_MSGBOX, ""COL_GREEN"Grenades", string, "Ok", "");
		}
	}
	return 1;
}

CMD:slap(playerid, params[])
{
    new Float:x, Float:y, Float:z, Float:health,str[128], id;
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
	    if(sscanf(params, "us[128]", id)) return GameTextForPlayer(playerid, "~g~/slap~w~~n~(id)",4500,3);
		if(id == INVALID_PLAYER_ID) return ErrorMessages(playerid, 2);
	    if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
		GetPlayerPos(id, x, y, z);
	    GetPlayerHealth(id, health);
	    SetPlayerHealth(id, health-25);
		SetPlayerPos(id, x, y, z+5);
		format(str, sizeof(str), "You slapped %s(%d)", GetName(id), id);
		PlayerInfo[id][SlapC]++;
		SendClientMessage(playerid, BAN, str);
	    PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
	    PlayerPlaySound(id, 1190, 0.0, 0.0, 0.0);
	}
	else return ErrorMessages(playerid, 1);
	return 1;
}

CMD:explode(playerid, params[])
{
	new str[128], id, Float:x, Float:y, Float:z;
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
		if(sscanf(params, "us[128]", id)) return GameTextForPlayer(playerid, "~g~/explode~w~~n~(id)",4500,3);
		if(id == INVALID_PLAYER_ID) return ErrorMessages(playerid, 2);
        if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
		GetPlayerPos(id, x, y, z);
		format(str, sizeof(str), "You exploded %s(%d)", GetName(id), id);
		PlayerInfo[id][ExplodeC]++;
		SendClientMessage(playerid, BAN, str);
		CreateExplosion(x, y, z, 7, 1.00);
	}
	else return ErrorMessages(playerid, 6);
	return 1;
}

CMD:disarm(playerid, params[])
{
	new str[128], id;
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		if(sscanf(params, "u", id)) return GameTextForPlayer(playerid, "~g~/disarm~w~~n~(id)",4500,3);
		if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid, "~g~Player is not connected",4500,3);
        if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
        ResetPlayerWeapons(id);
        format(str, sizeof(str), "You disarmed %s(%d)", GetName(id), id);
        SendClientMessage(playerid, BAN, str);
	}
	else return ErrorMessages(playerid, 6);
	return 1;
}

CMD:freeze(playerid, params[])
{
	new str[128], id;
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
        if(sscanf(params, "us[128]", id)) return GameTextForPlayer(playerid, "~g~/freeze~w~~n~(id)",4500,3);
		if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid, "~g~Player is not connected",4500,3);
        if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
		if(PlayerInfo[id][Freeze] != 0) return GameTextForPlayer(playerid, "~g~Player Already frozen",4500,3);
		TogglePlayerControllable(id, 0);
		PlayerInfo[id][Freeze] = 1;
		PlayerInfo[id][FreezeC]++;
		PlayerPlaySound(id, 1057, 0.0, 0.0, 0.0);
		format(str, sizeof(str), "You frozen %s(%d)", GetName(id), id);
		SendClientMessage(playerid, BAN, str);
	}
	else return ErrorMessages(playerid, 6);
	return 1;
}

CMD:unfreeze(playerid, params[])
{
	new str[128], id;
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
        if(sscanf(params, "u", id)) return GameTextForPlayer(playerid, "~g~/unfreeze~w~~n~(id)",4500,3);
		if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid, "~g~Player is not connected",4500,3);
		if(PlayerInfo[id][Freeze] != 1) return GameTextForPlayer(playerid, "~g~Player is already frozen", 4500, 3);
		TogglePlayerControllable(id, 1);
		PlayerInfo[id][Freeze] = 0;
		PlayerPlaySound(id, 1057, 0.0, 0.0, 0.0);
		format(str, sizeof(str), "You unfrozen %s(%d)", GetName(id), id);
		SendClientMessage(playerid, BAN, str);
	}
	else return ErrorMessages(playerid, 6);
	return 1;
}

CMD:heal(playerid, params[])
{
	new str[128], id;
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
        if(sscanf(params, "u", id)) return GameTextForPlayer(playerid, "~g~/heal~w~~n~(id)",4500,3);
		if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid, "~g~Player is not connected",4500,3);
		SetPlayerHealth(id, 100.0);
		format(str, sizeof(str), "You healed %s(%d)", GetName(id), id);
		SendClientMessage(playerid, BAN, str);
	}
	else return ErrorMessages(playerid, 6);
	return 1;
}

CMD:armour(playerid, params[])
{
	new str[128], id;
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
        if(sscanf(params, "u", id)) return GameTextForPlayer(playerid, "~g~/armour~w~~n~(id)",4500,3);
		if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid, "~g~Player is not connected",4500,3);
		SetPlayerArmour(id, 100.0);
		format(str, sizeof(str), "You armoured %s(%d)", GetName(id), id);
		SendClientMessage(playerid, BAN, str);
	}
	else return 0;
	return 1;
}

CMD:killplayer(playerid, params[])
{
	new str[128], id;
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
        if(sscanf(params, "u", id)) return GameTextForPlayer(playerid, "~g~/killplayer~w~~n~(id)",4500,3);
		if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid, "~g~Player is not connected",4500,3);
		if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
		SetPlayerArmour(id, 0);
		SetPlayerHealth(id, 0);
		format(str, sizeof(str), "You killed %s(%d) as an admin", GetName(id), id);
		SendClientMessage(playerid, BAN, str);
	}
	return 1;
}

CMD:ban(playerid, params[])
{
    new string[128], str[356], query[250], id, reason[1024], ip[50], update[150];
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
	    if(sscanf(params, "us[1024]", id, reason)) return GameTextForPlayer(playerid, "~g~/ban~w~~n~(id)~w~~n~(reason)",4500,3);
		if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid, "~g~Player is not connected",4500,3);
		if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
		format(str, sizeof(str), ""COL_WHITE"You are banned from this server\n\n(Reason: %s)", reason);
		ShowPlayerDialog(playerid, 1016, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - Banned", str, "OK", "");
		format(string, sizeof(string), "%s(%d) has banned %s(%d) from the server (Reason: %s)", GetName(playerid), playerid, GetName(id), id, reason);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(PlayerInfo[i][CMS] == 1)
				{
					SendClientMessage(i, BAN, string);
				}
			}
		}
		GetPlayerIp(playerid, ip, sizeof(ip));
		format(query, sizeof(query), "INSERT INTO banlog(`Name`, `Account_ID`, `Banned_By`, `IP`, `Type`, `Date`) VALUES (%s, %d, %s, %s, 1, NOW())", GetName(id), PlayerInfo[id][Accountid],GetName(playerid), ip);
		format(update, sizeof(update), "UPDATE `players` SET `Banned` = 1 WHERE Name = %s", GetName(id));
		mysql_query(mysql, query);
		mysql_query(mysql, update);
	}
	else return 0;
	return 1;
}

CMD:unban(playerid, params[])
{
	new accountid, query[150], pBanned, Name[50], IP[16], update[150], rowdelete[150], str[100], rows;
	if(PlayerInfo[playerid][pAdmin] >= 6)
	{
	    if(sscanf(params, "d", accountid)) return GameTextForPlayer(playerid,"~g~/unban~w~~n~(account id)",4500,3);
		format(query, sizeof(query), "SELECT `Banned` FROM `players` WHERE `Account_ID` = %d LIMIT 1", accountid);
	    mysql_query(mysql, query);
	    cache_get_row_count(rows);
	    if(rows)
	    {
            cache_get_value_name(0, "Name", Name);
            cache_get_value_name_int(0, "Banned", pBanned);
			cache_get_value_name(0, "IP", IP);
			if(pBanned == 1)
			{
				format(update ,sizeof(update), "UPDATE `players` SET `Banned` = 0 WHERE `Account_ID` = %d", accountid);
				format(rowdelete, sizeof(rowdelete), "DELETE * FROM `banlog` WHERE `Account_ID` = %d", accountid);
				mysql_query(mysql, update);
				mysql_query(mysql, rowdelete);

				format(str, sizeof(str), "You unbanned an account,the account details are below\n\nName: %s\nAccount ID: %d\nIP: %s", Name, accountid, IP);
			}
	    }
	    else GameTextForPlayer(playerid,"~g~Account does not exist", 4500, 3);
	}
	return 1;
}

CMD:banip(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
		new ip[16], str[30], str2[50];
		if(sscanf(params, "s", ip)) return GameTextForPlayer(playerid, "~g~/banip~n~~w~(IP)", 4500, 3);
		if(!StringContainsIP(ip)) return GameTextForPlayer(playerid, "~g~IP does not exists", 4500, 3);
		format(str, sizeof(str), "banip %s", ip);
		SendRconCommand(str);
		SendRconCommand("reloadbans");
		format(str2, sizeof(str2), "You banned IP %s", ip);
		SendClientMessage(playerid, BAN, str2);
	}
	return 1;
}

CMD:unbanip(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
		new ip[16], str[30], str2[50];
		if(sscanf(params, "s", ip)) return GameTextForPlayer(playerid, "~g~/unbanip~n~~w~(IP)", 4500, 3);
		if(!StringContainsIP(ip)) return GameTextForPlayer(playerid, "~g~Ip does not exists", 4500, 3);
		format(str, sizeof(str), "unbanip %s", ip);
		SendRconCommand(str);
		SendRconCommand("reloadbans");
		format(str2, sizeof(str2), "You unbanned IP %s", ip);
		SendClientMessage(playerid, BAN, str2);
	}
	return 1;
}

CMD:ip(playerid,params[])
{
	new TargetID,tmp[128];
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new string[256];
		if(sscanf(params, "i", TargetID)) return GameTextForPlayer(playerid,"~g~/ip~w~~n~(id)",4500,3);
		if(!IsPlayerConnected(TargetID))return GameTextForPlayer(playerid,"~g~Player is not connected",4500,3);
	   	GetPlayerIp(TargetID,tmp,50);
		format(string,sizeof(string),"IP From Player %s is %s *", GetName(TargetID), tmp);
		SendClientMessage(playerid, BAN, string);
	}
	return 1;
}

CMD:invisible(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		if(PlayerInfo[playerid][Invisible] == 0)
		{
			PlayerInfo[playerid][pColor] = GetPlayerColor(playerid);
			SetPlayerColor(playerid, 0xFFFFFF00);
			PlayerInfo[playerid][Invisible] = 1;
			foreach(Player, i)
			{
                SetPlayerMarkerForPlayer(playerid, i, 0xFFFFFF00);
                ShowPlayerNameTagForPlayer(i, playerid, false);
			}
   			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
   			{
   	    		LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(playerid)+1);
    		}
   			GameTextForPlayer(playerid, "~n~~n~~n~~n~~g~Invisible!", 2500, 3);
		}
		else if(PlayerInfo[playerid][Invisible] == 1)
		{
   			SetPlayerColor(playerid, PlayerInfo[playerid][pColor]);
   			PlayerInfo[playerid][Invisible] = 0;
		    foreach(Player, i)
			{
                SetPlayerMarkerForPlayer(playerid, i, 0xFFFFFF00);
                ShowPlayerNameTagForPlayer(i, playerid, false);
			}
            if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
   			{
   	    		LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(playerid));
   			}
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~g~Visible!", 2500, 3);
		}
	}
	else return ErrorMessages(playerid, 7);
	return 1;
}

CMD:sethealth(playerid, params[])
{
	new str[128], id, Float:health;
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		if(sscanf(params, "uf", id, health)) return GameTextForPlayer(playerid, "~g~/sethealth~w~~n~(id)",4500,3);
        if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
		if(id == INVALID_PLAYER_ID) return ErrorMessages(playerid, 2);

		format(str, sizeof(str), "You set %s(%d) health to %.1f", GetName(id), id, health);
		SendClientMessage(playerid, BAN, str);
		format(str, sizeof(str), "Administrator %s(%d) set your health to %.1f", GetName(id), id, health);
		SendClientMessage(id, BAN, str);
		SetPlayerHealth(id, health);
	}
	else return ErrorMessages(playerid, 7);
	return 1;
}

CMD:setarmour(playerid, params[])
{
	new str[128], id, Float:arm;
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		if(sscanf(params, "uf", id, arm)) return GameTextForPlayer(playerid, "~g~/setarmour~w~~n~(id)",4500,3);
        if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
		if(id == INVALID_PLAYER_ID) return ErrorMessages(playerid, 2);
		format(str, sizeof(str), "You have set %s(%d) armour to %.1f", GetName(id), id, arm);
		SendClientMessage(playerid, BAN, str);
		format(str, sizeof(str), "Administrator %s(%d) have set your armour to %.1f", GetName(id), id, arm);
		SendClientMessage(id, BAN, str);
	    SetPlayerArmour(id, arm);
	}
	else return ErrorMessages(playerid, 7);
	return 1;
}

CMD:settime(playerid, params[])
{
	new str[128], id, time;
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		if(sscanf(params, "ui", id, time)) return GameTextForPlayer(playerid,"~g~/settime~w~~n~(id)~n~(time)",4500,3);
        if(id == INVALID_PLAYER_ID) return ErrorMessages(playerid, 2);
		if(time < 0 || time > 23) return GameTextForPlayer(playerid,"~g~Time~w~~n~0-23",4500,3);
		if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
		SetPlayerTime(id, time, 0);
		format(str, sizeof(str), "You have set %s(%d) time to %02d:00", GetName(id), id, time);
		SendClientMessage(playerid, BAN, str);
		format(str, sizeof(str), "Administrator %s(%d) has set your time to %02d:00", GetName(id), id, time);
		SendClientMessage(id, BAN, str);
	}
	else return ErrorMessages(playerid, 7);
	return 1;
}

CMD:setweather(playerid, params[])
{
	new str[128], id, weather;
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		if(sscanf(params, "ui", id, weather)) return GameTextForPlayer(playerid,"~g~/setweather~w~~n~(id)~n~(weather)",4500,3);
        if(id == INVALID_PLAYER_ID) return ErrorMessages(playerid, 2);
		if(weather < 0 || weather > 45) return GameTextForPlayer(playerid,"~g~Weathers~w~~n~0-45",4500,3);
		if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
		SetPlayerWeather(id, weather);
		format(str, sizeof(str), "You set %s(%d) weather to %d", GetName(id), id, weather);
		SendClientMessage(playerid, BAN, str);
		format(str, sizeof(str), "Administrator %s(%d) has your weather to %d", GetName(id), id, weather);
		SendClientMessage(id, BAN, str);
	}
	else return ErrorMessages(playerid, 7);
	return 1;
}

CMD:setinterior(playerid, params[])
{
	new str[128], id, iint;
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		if(sscanf(params, "ui", id, iint)) return GameTextForPlayer(playerid,"~g~/setinterior~w~~n~(id)~n~(interior)",4500,3);
		if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
		if(id == INVALID_PLAYER_ID) return 0;
		SetPlayerInterior(id, iint);
		format(str, sizeof(str), "Administrator %s(%d) has set your interior to %d", GetName(playerid), playerid, iint);
		SendClientMessage(id, BAN, str);
		format(str, sizeof(str), "You set %s(%d) interior to %d", GetName(id), id, iint);
		SendClientMessage(playerid, BAN, str);
	}
	else return ErrorMessages(playerid, 7);
	return 1;
}

CMD:setworld(playerid, params[])
{
	new str[128], id, vw;
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		if(sscanf(params, "ui", id, vw)) return GameTextForPlayer(playerid,"~g~/setworld~w~~n~(id)~n~(world id)",4500,3);
		if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
		if(id == INVALID_PLAYER_ID) return ErrorMessages(playerid, 2);
		SetPlayerVirtualWorld(id, vw);
		format(str, sizeof(str), "Administrator %s(%d) has set your virtual world to %d", GetName(playerid), playerid, vw);
		SendClientMessage(id, BAN, str);
		format(str, sizeof(str), "You set %s(%d) virtual world to %d", GetName(id), id, vw);
		SendClientMessage(playerid, BAN, str);
	}
	else return ErrorMessages(playerid, 7);
	return 1;
}

CMD:readcmds(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return 0;
	if(ServerInfo[ReadCmds] == 0)
	{
		ServerInfo[ReadCmds] = 1;
		GameTextForPlayer(playerid,"~g~read commands ~w~on",4500,3);
	}
	else if(ServerInfo[ReadCmds] == 1)
	{
		ServerInfo[ReadCmds] = 0;
		GameTextForPlayer(playerid,"~g~read commands ~w~off",4500,3);
	}
	return 1;
}

CMD:readpms(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return 0;
	if(ServerInfo[ReadPms] == 0)
	{
		ServerInfo[ReadPms] = 1;
		GameTextForPlayer(playerid,"~g~read pms ~w~on",4500,3);
	}
	else if(ServerInfo[ReadPms] == 1)
	{
		ServerInfo[ReadPms] = 0;
		GameTextForPlayer(playerid,"~g~read pms ~w~off",4500,3);
	}
	return 1;
}

CMD:port(playerid, params[])
{
	new str[128], id, id2, Float:x, Float:y, Float:z;
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
		if(sscanf(params, "uu", id, id2))
		{
			GameTextForPlayer(playerid,"~g~/port~w~~n~(id)~n~(id 2)",4500,3);
			return 1;
		}
    	if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return ErrorMessages(playerid, 3);
    	if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id2][pAdmin]) return ErrorMessages(playerid, 3);
		if(id == INVALID_PLAYER_ID) return ErrorMessages(playerid, 2);
		if(id2 == INVALID_PLAYER_ID) return ErrorMessages(playerid, 2);
		if(id == playerid && id2 == playerid) return SendClientMessage(playerid, COLOR_RED, "You cannot teleport yourself to yourself!");
		if(PlayerInfo[id][Jail] == 1) return GameTextForPlayer(playerid,"~g~Playerid 1 is jailed",4500,3);
		if(PlayerInfo[id2][Jail] == 1) return GameTextForPlayer(playerid,"~g~Playerid 2 is jailed",4500,3);
		GetPlayerPos(id2, x, y, z);
		format(str, sizeof(str), "You port %s(%d) to %s(%d)", GetName(id), id, GetName(id2), id2);
		SendClientMessage(playerid, BAN, str);
		format(str, sizeof(str), "You have been port to %s(%d) by Administrator %s(%d)", GetName(id2), id2, GetName(playerid), playerid);
		SendClientMessage(id, BAN, str);
		format(str, sizeof(str), "Administrator %s(%d) has port %s(%d) to you", GetName(playerid), playerid, GetName(id), id);
		SendClientMessage(id2, BAN, str);
		SetPlayerInterior(id, GetPlayerInterior(id2));
		SetPlayerVirtualWorld(id, GetPlayerVirtualWorld(id2));
		if(GetPlayerState(id) == 2)
		{
			SetVehiclePos(GetPlayerVehicleID(id), x+3, y, z);
			LinkVehicleToInterior(GetPlayerVehicleID(id), GetPlayerInterior(id2));
			SetVehicleVirtualWorld(GetPlayerVehicleID(id), GetPlayerVirtualWorld(id2));
		}
		else SetPlayerPos(id, x+2, y, z);
	}
	else return ErrorMessages(playerid, 7);
	return 1;
}

CMD:getall(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
	    ShowPlayerDialog(playerid, 1002, DIALOG_STYLE_LIST, ""COL_GREEN"UGF - Get All","Get All From FreeRoam\nGet All From Deathmatch\nGet All From All Modes", "Select", "Cancel");
	}
	return 1;
}

CMD:write(playerid, params[])
{
	new str[128];
	if(PlayerInfo[playerid][pAdmin] >= 6)
	{
	    if(sscanf(params, "s[128]", params)) return GameTextForPlayer(playerid,"~g~/write~w~~n~(text)",4500,3);
	    format(str, sizeof(str), "%s", params);
	    SendClientMessageToAll(-1, str);
	}
	else return ErrorMessages(playerid, 8);
	return 1;
}

CMD:fakechat(playerid, params[])
{
	new id, str[50];
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
	    if(sscanf(params, "us[128]", id, params)) return GameTextForPlayer(playerid,"~g~/fakechat~w~~n~(id)~n~(text)",4500,3);
		if(id == INVALID_PLAYER_ID || !IsPlayerConnected(id)) return GameTextForPlayer(playerid, "~g~Player is not connected", 4500, 3);
		if(PlayerInfo[id][pMuted] == 1) return GameTextForPlayer(playerid, "~g~Player is muted", 4500, 3);
		if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return GameTextForPlayer(playerid, "~g~You cant use this command on higher level admins", 4500, 3);
		
        new ChatBubble[MAX_CHATBUBBLE_LENGTH+1];
		new Chats[MAX_CHATBUBBLE_LENGTH+1];
		
        format(Chats,MAX_CHATBUBBLE_LENGTH,"{%06x}%s(%d):{FFFFFF} %s",GetPlayerColor(playerid) >>> 8, params);
        SetPlayerChatBubble(playerid,ChatBubble,MESSAGE_COLOR,35.0,10000);
        
        foreach(Player, i)
        {
			if(IsPlayerConnected(i))
			{
				if(PlayerInfo[i][CMS] == 1)
				{
					SendClientMessage(playerid, 0xFFFFFFFF, Chats);
				}
			}
        }
        
        
		format(str, sizeof(str), "You fake chat %s(%d)", GetName(id), id);
		SendClientMessage(playerid, BAN, str);
	}
	else return ErrorMessages(playerid, 8);
	return 1;
}

CMD:healall(playerid, params[])
{
	new str[128];
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
		foreach(Player, i)
		{
			if(IsPlayerConnected(i))
			{
				SetPlayerHealth(i, 100.0);
			}
		}
		GameTextForAll("~g~Heal by ~w~Admin!", 3000, 3);
		format(str, sizeof(str), "Administrator %s(%d) has healed all players!", GetName(playerid), playerid);
		SendClientMessageToAll(BAN, str);
		SendClientMessage(playerid, BAN, "You healed all players!");
	}
	else return ErrorMessages(playerid, 8);
	return 1;
}

CMD:restartserver(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 7)
	{
		foreach(Player, i)
		{
			if(IsPlayerConnected(i))
			{
				ShowPlayerDialog(i, 89, DIALOG_STYLE_MSGBOX, ""COL_GREEN"Server Restart", ""COL_WHITE"The rerver is restarting in 10 seconds","OK","");
				SetTimer("ServerRestart",10000,false);
			}
		}
	}
	return 1;
}

CMD:rs(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 7)
	{
		foreach(Player, i)
		{
			if(IsPlayerConnected(i))
			{
				ShowPlayerDialog(i, 89, DIALOG_STYLE_MSGBOX, ""COL_GREEN"Server Restart", ""COL_WHITE"The rerver is restarting in 10 seconds","OK","");
				SetTimer("ServerRestart",10000,false);
			}
		}
	}
	return 1;
}

CMD:gmx(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 7)
	{
		SendRconCommand("gmx");
    }
	return 1;
}

CMD:armourall(playerid, params[])
{
	new str[128];
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
		foreach(Player, i)
		{
			if(IsPlayerConnected(i) && (i != playerid) && (PlayerInfo[playerid][pAdmin] < PlayerInfo[i][pAdmin]))
			{
				SetPlayerArmour(i, 100);
			}
		}
		GameTextForAll("~g~Armoured by ~w~Admin!", 3000, 3);
		format(str, sizeof(str), "Administrator %s(%d) has armoured all players!", GetName(playerid), playerid);
		SendClientMessageToAll(BAN, str);
		SendClientMessage(playerid, BAN, "You armoured all players!");
	}
	else return ErrorMessages(playerid, 8);
	return 1;
}

CMD:slapall(playerid, params[])
{
	new str[128];
	new Float:x, Float:y, Float:z, Float:hp;
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
	   	foreach(Player, i)
  		{
			if(IsPlayerConnected(i) && PlayerInfo[playerid][pAdmin] == 0)
			{
				GetPlayerPos(i, x, y, z);
			    GetPlayerHealth(i, hp);
			    SetPlayerHealth(i, hp-25);
			    SetPlayerPos(i, x, y, z+5);
			    PlayerPlaySound(i, 1190, 0.0, 0.0, 0.0);
				PlayerInfo[i][SlapC]++;
			}
		}
		format(str, sizeof(str), "Administrator %s(%d) has slapped all players!", GetName(playerid), playerid);
		SendClientMessageToAll(BAN, str);
		SendClientMessage(playerid, BAN, "You slapped all players!");
		PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
	}
	else return ErrorMessages(playerid, 8);
	return 1;
}

CMD:explodeall(playerid, params[])
{
	new str[128],Float:x, Float:y, Float:z;
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
	   	foreach(Player, i)
  		{
			if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] == 0)
	        GetPlayerPos(i, x, y, z);
	        CreateExplosion(x, y, z, 7, 1.00);
	        PlayerInfo[i][ExplodeC]++;
		}
		format(str, sizeof(str), "Administrator %s(%d) has exploded all players!", GetName(playerid), playerid);
		SendClientMessageToAll(BAN, str);
		SendClientMessage(playerid, BAN, "You explode all players!");
	}
	else return ErrorMessages(playerid, 5);
	return 1;
}

CMD:giveallweapon(playerid, params[])
{
    new weap, str[128], WeapName[32];
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
		if(sscanf(params, "i", weap)) return GameTextForPlayer(playerid,"~g~/giveallweapon~w~~n~(weapon)",4500,3);
		if(weap == 19 || weap == 20 || weap == 21) return GameTextForPlayer(playerid, "This weapon does not exist",4500,3);
		if(weap < 1 || weap > 47) return GameTextForPlayer(playerid, "~g~/giveallweapon~w~~n~(1-47)",4500,3);
		foreach(Player, i)
		{
			if(indm[i] == 0 && God[i] == 0)
		    {
		        GivePlayerWeapon(i, weap, 999999);
			}
		}
		GetWeaponName(weap, WeapName, 32);
	    format(str, sizeof(str), "You given everyone a %s", WeapName, weap);
	    SendClientMessage(playerid, BAN, str);
	}
	else return ErrorMessages(playerid, 5);
    return 1;
}

CMD:giveweapon(playerid, params[])
{
    new weap, str[128], id, WeapName[32];
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
		if(sscanf(params, "ui", id, weap)) return GameTextForPlayer(playerid,"~g~/giveweapon~w~~n~(playerid id)~n~(weapon)",4500,3);
		if(weap == 19 || weap == 20 || weap == 21) return GameTextForPlayer(playerid, "This weapon does not exist",4500,3);
		if(weap < 1 || weap > 47) return GameTextForPlayer(playerid, "~g~/giveweapon~w~~n~(1-47)",4500,3);
        GivePlayerWeapon(id, weap, 999999);
		GetWeaponName(weap, WeapName, 32);
	    format(str, sizeof(str), "You given a %s to %s(%d)", WeapName, GetName(id), id);
	    SendClientMessage(playerid, BAN, str);
	}
	else return ErrorMessages(playerid, 5);
    return 1;
}

CMD:spawnall(playerid, params[])
{
	new str[128];
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
	   	foreach(Player, i)
  		{
            SpawnPlayer(i);
		}
		format(str, sizeof(str), "Administrator %s(%d) has spawned all players!", GetName(playerid), playerid);
		SendClientMessageToAll(BAN, str);
		SendClientMessage(playerid, BAN, "You spawned all players!");
	}
	else return ErrorMessages(playerid, 8);
	return 1;
}

CMD:setmoney(playerid, params[])
{
	new string[128], id, cash;
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
	    if(sscanf(params, "ui", id, cash)) return GameTextForPlayer(playerid,"~g~/setmoney~w~~n~[id]~n~[money]",4500,3);
        if(id == INVALID_PLAYER_ID) return ErrorMessages(playerid, 2);
		format(string, sizeof(string), "Administrator %s(%d) has set %s(%d) cash to $%i", GetName(playerid), playerid, GetName(id), id, cash);
		SendClientMessageToAll(BAN, string);
		format(string, sizeof(string), "You set %s(%d) cash to $%i", GetName(id), id, cash);
		SendClientMessage(playerid, BAN, string);
		format(string, sizeof(string), "Administrator %s(%d) has set your cash to $%i", GetName(playerid), playerid, cash);
		SendClientMessage(id, BAN, string);
		ResetPlayerMoney(id);
		GivePlayerMoney(id, cash);
	}
	else return ErrorMessages(playerid, 9);
	return 1;
}

//==============================================================================
//                            GENERAL COMMANDS
//==============================================================================

CMD:landstalker(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 400);
	return 1;
}

CMD:bravura(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 401);
	return 1;
}

CMD:buffalo(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 402);
	return 1;
}

CMD:linerunner(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 403);
	return 1;
}

CMD:perenniel(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 404);
	return 1;
}

CMD:sentiel(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 405);
	return 1;
}

CMD:dumper(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 406);
	return 1;
}

CMD:firetruck(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 407);
	return 1;
}

CMD:trashmaster(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 408);
	return 1;
}

CMD:trashtruck(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 408);
	return 1;
}

CMD:manana(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 410);
	return 1;
}

CMD:infernus(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 411);
	return 1;
}

CMD:voodoo(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 412);
	return 1;
}

CMD:pony(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 413);
	return 1;
}

CMD:mule(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 414);
	return 1;
}

CMD:cheetah(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 415);
	return 1;
}

CMD:ambulance(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 416);
	return 1;
}

CMD:leviathan(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 417);
	return 1;
}

CMD:moonbeam(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 418);
	return 1;
}

CMD:esperanto(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 419);
	return 1;
}

CMD:taxi(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 420);
	return 1;
}

CMD:washington(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 421);
	return 1;
}

CMD:bobcat(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 422);
	return 1;
}

CMD:mrwhoopee(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 423);
	return 1;
}

CMD:whoopee(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 423);
	return 1;
}

CMD:bfinjection(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 424);
	return 1;
}

CMD:hunter(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(PlayerInfo[playerid][pAdmin] == 0) return 0;
	CreatePlayerVehicle(playerid, 425);
	return 1;
}

CMD:premier(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 426);
	return 1;
}

CMD:enforcer(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 427);
	return 1;
}

CMD:securicar(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 428);
	return 1;
}

CMD:banshee(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 429);
	return 1;
}

CMD:predator(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 430);
	return 1;
}

CMD:bus(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 431);
	return 1;
}

CMD:rhino(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(PlayerInfo[playerid][pAdmin] == 0) return 0;
	CreatePlayerVehicle(playerid, 432);
	return 1;
}

CMD:barracks(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 433);
	return 1;
}

CMD:hotknife(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 434);
	return 1;
}

CMD:articletrailer(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 435);
	return 1;
}

CMD:articletrailera(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 435);
	return 1;
}

CMD:previon(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 436);
	return 1;
}

CMD:coach(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 437);
	return 1;
}

CMD:cabbie(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 438);
	return 1;
}

CMD:stallion(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 439);
	return 1;
}

CMD:rumpo(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 440);
	return 1;
}

CMD:rcbandit(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 441);
	return 1;
}

CMD:romero(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 442);
	return 1;
}

CMD:packer(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 443);
	return 1;
}


CMD:monstertruck(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 444);
	return 1;
}

CMD:admiral(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 445);
	return 1;
}

CMD:squallo(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 446);
	return 1;
}

CMD:seasparrow(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(PlayerInfo[playerid][pAdmin] == 0) return 0;
	CreatePlayerVehicle(playerid, 447);
	return 1;
}

CMD:pizzaboy(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 448);
	return 1;
}

CMD:pizzascooter(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 448);
	return 1;
}

CMD:pizza(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 448);
	return 1;
}

CMD:articletrailer2(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 450);
	return 1;
}

CMD:articletrailerb(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 450);
	return 1;
}

CMD:turismo(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 451);
	return 1;
}

CMD:speeder(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 452);
	return 1;
}

CMD:reefer(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 453);
	return 1;
}

CMD:tropic(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 454);
	return 1;
}

CMD:flatbed(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 455);
	return 1;
}

CMD:yankee(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 456);
	return 1;
}

CMD:caddy(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 457);
	return 1;
}

CMD:solair(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 458);
	return 1;
}

CMD:topfun(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 459);
	return 1;
}

CMD:topfunvan(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 459);
	return 1;
}


CMD:skimmer(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 460);
	return 1;
}

CMD:pcg600(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 461);
	return 1;
}

CMD:pcg(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 461);
	return 1;
}

CMD:faggio(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 462);
	return 1;
}

CMD:freeway(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 463);
	return 1;
}

CMD:rcbaron(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 464);
	return 1;
}

CMD:rcraider(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 465);
	return 1;
}

CMD:glendale(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 466);
	return 1;
}

CMD:oceanic(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 467);
	return 1;
}

CMD:sanchez(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 468);
	return 1;
}

CMD:sparrow(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 469);
	return 1;
}

CMD:patriot(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 470);
	return 1;
}

CMD:quad(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 471);
	return 1;
}

CMD:coastguard(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 472);
	return 1;
}

CMD:dinghy(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 473);
	return 1;
}

CMD:hermes(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 474);
	return 1;
}

CMD:sabre(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 475);
	return 1;
}

CMD:rustler(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 476);
	return 1;
}

CMD:zr350(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 477);
	return 1;
}

CMD:zr(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 477);
	return 1;
}

CMD:walton(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 478);
	return 1;
}

CMD:regina(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 479);
	return 1;
}

CMD:comet(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 480);
	return 1;
}

CMD:bmx(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 481);
	return 1;
}

CMD:burrito(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 482);
	return 1;
}

CMD:marquis(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 484);
	return 1;
}

CMD:baggage(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 485);
	return 1;
}

CMD:dozer(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 486);
	return 1;
}

CMD:maverick(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 487);
	return 1;
}

CMD:newsmaverick(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 488);
	return 1;
}

CMD:rancher(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 489);
	return 1;
}

CMD:fbirancher(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 490);
	return 1;
}

CMD:rancherfbi(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 490);
	return 1;
}

CMD:virgo(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 491);
	return 1;
}

CMD:greenwood(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 492);
	return 1;
}

CMD:jetmax(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 493);
	return 1;
}

CMD:hotringracer(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 494);
	return 1;
}

CMD:hotringracer1(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 494);
	return 1;
}

CMD:hotringracera(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 494);
	return 1;
}

CMD:sandking(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 495);
	return 1;
}

CMD:blistacompact(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 496);
	return 1;
}

CMD:blista(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 496);
	return 1;
}

CMD:policemaverick(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 497);
	return 1;
}

CMD:boxville(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 498);
	return 1;
}

CMD:boxville1(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 498);
	return 1;
}

CMD:boxvillea(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 498);
	return 1;
}

CMD:benson(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 499);
	return 1;
}

CMD:mesa(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 500);
	return 1;
}

CMD:rcgoblin(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 501);
	return 1;
}

CMD:hotringracer2(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 502);
	return 1;
}

CMD:hotringracerb(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 502);
	return 1;
}

CMD:hotringracer3(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 503);
	return 1;
}

CMD:hotringracerc(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 503);
	return 1;
}

CMD:bloodringbanger(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 504);
	return 1;
}

CMD:rancher2(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 505);
	return 1;
}

CMD:rancherb(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 505);
	return 1;
}

CMD:supergt(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 506);
	return 1;
}

CMD:elegant(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 507);
	return 1;
}

CMD:journey(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 508);
	return 1;
}

CMD:bike(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 509);
	return 1;
}

CMD:mountainbike(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 510);
	return 1;
}

CMD:mountain(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 510);
	return 1;
}

CMD:beagle(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 511);
	return 1;
}

CMD:cropduster(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 512);
	return 1;
}

CMD:stuntplane(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 513);
	return 1;
}

CMD:tanker(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 514);
	return 1;
}

CMD:roadtrain(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 515);
	return 1;
}

CMD:nebula(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 516);
	return 1;
}

CMD:majestic(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 517);
	return 1;
}

CMD:buccaneer(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 518);
	return 1;
}

CMD:shamal(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 519);
	return 1;
}

CMD:hydra(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(PlayerInfo[playerid][pAdmin] == 0) return 0;
	CreatePlayerVehicle(playerid, 520);
	return 1;
}

CMD:fcr900(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 521);
	return 1;
}

CMD:fcr(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 521);
	return 1;
}

CMD:nrg(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 522);
	return 1;
}

CMD:hpv(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 523);
	return 1;
}

CMD:cementtruck(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 524);
	return 1;
}

CMD:twotruck(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 525);
	return 1;
}

CMD:fortune(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 526);
	return 1;
}

CMD:cadrona(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 527);
	return 1;
}

CMD:fbitruck(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 528);
	return 1;
}

CMD:truckfbi(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 528);
	return 1;
}

CMD:willard(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 529);
	return 1;
}

CMD:forklift(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 530);
	return 1;
}

CMD:tractor(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 531);
	return 1;
}

CMD:combineharvester(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 532);
	return 1;
}

CMD:harvester(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 532);
	return 1;
}

CMD:feltzer(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 533);
	return 1;
}

CMD:remington(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 534);
	return 1;
}

CMD:slamvan(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 535);
	return 1;
}

CMD:blade(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 536);
	return 1;
}

CMD:vortex(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 539);
	return 1;
}

CMD:vincent(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 540);
	return 1;
}

CMD:bullet(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 541);
	return 1;
}

CMD:clover(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 542);
	return 1;
}

CMD:sadler(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 543);
	return 1;
}

CMD:firetruckla(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 544);
	return 1;
}

CMD:firetruckb(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 544);
	return 1;
}

CMD:firetruck2(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 544);
	return 1;
}

CMD:hustler(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 545);
	return 1;
}

CMD:intruder(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 546);
	return 1;
}

CMD:primo(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 547);
	return 1;
}

CMD:cargobob(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 548);
	return 1;
}

CMD:tampa(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 549);
	return 1;
}

CMD:sunrise(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 550);
	return 1;
}

CMD:merit(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 551);
	return 1;
}

CMD:utilityvan(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 552);
	return 1;
}

CMD:utility(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 552);
	return 1;
}

CMD:van(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 552);
	return 1;
}

CMD:nevada(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 553);
	return 1;
}

CMD:yosemite(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 554);
	return 1;
}

CMD:windsor(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 555);
	return 1;
}

CMD:monstera(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 556);
	return 1;
}

CMD:monstertrucka(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 556);
	return 1;
}

CMD:monsterb(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 557);
	return 1;
}

CMD:monstertruckb(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 557);
	return 1;
}

CMD:uranus(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 558);
	return 1;
}

CMD:jester(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 559);
	return 1;
}

CMD:sultan(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 560);
	return 1;
}

CMD:stratum(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 561);
	return 1;
}

CMD:elegy(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 562);
	return 1;
}

CMD:raindance(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 563);
	return 1;
}

CMD:rctiger(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 564);
	return 1;
}

CMD:tiger(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 564);
	return 1;
}

CMD:flash(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 565);
	return 1;
}

CMD:tahoma(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 566);
	return 1;
}

CMD:savanna(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 567);
	return 1;
}

CMD:bandito(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 568);
	return 1;
}

CMD:kart(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 571);
	return 1;
}

CMD:mover(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 572);
	return 1;
}

CMD:dune(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 573);
	return 1;
}

CMD:sweeper(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 574);
	return 1;
}

CMD:broadway(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 575);
	return 1;
}

CMD:tornado(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 576);
	return 1;
}

CMD:at400(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 577);
	return 1;
}

CMD:dft30(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 578);
	return 1;
}

CMD:dft(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 578);
	return 1;
}


CMD:huntley(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 579);
	return 1;
}

CMD:stafford(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 580);
	return 1;
}

CMD:bf400(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 581);
	return 1;
}

CMD:bf(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 581);
	return 1;
}

CMD:newsvan(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 582);
	return 1;
}

CMD:tug(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 583);
	return 1;
}

CMD:petroltrailer(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 584);
	return 1;
}

CMD:emperor(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 585);
	return 1;
}

CMD:wayfarer(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 586);
	return 1;
}

CMD:euros(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 587);
	return 1;
}

CMD:hotdog(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 588);
	return 1;
}

CMD:hotdogvan(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 588);
	return 1;
}

CMD:club(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 589);
	return 1;
}

CMD:articletrailer3(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 591);
	return 1;
}

CMD:articletrailerc(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 591);
	return 1;
}

CMD:andromada(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 592);
	return 1;
}

CMD:dodo(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 593);
	return 1;
}

CMD:rccam(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 594);
	return 1;
}

CMD:launch(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 595);
	return 1;
}

CMD:policecarlspd(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 596);
	return 1;
}

CMD:policecar(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 596);
	return 1;
}

CMD:policecarsfpd(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 597);
	return 1;
}

CMD:policecarlvpd(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 598);
	return 1;
}

CMD:policeranger(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 599);
	return 1;
}

CMD:picador(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 600);
	return 1;
}

CMD:swat(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 601);
	return 1;
}

CMD:alpha(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 602);
	return 1;
}

CMD:phoenix(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 603);
	return 1;
}

CMD:glendaleshit(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 604);
	return 1;
}

CMD:sadlershit(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 605);
	return 1;
}

CMD:baggagetrailera(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 606);
	return 1;
}

CMD:baggagetrailer(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 607);
	return 1;
}

CMD:tugstairstrailer(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 608);
	return 1;
}

CMD:boxville2(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 609);
	return 1;
}

CMD:boxvilleb(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 609);
	return 1;
}

CMD:farmtrailer(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 610);
	return 1;
}

CMD:utilitytrailer(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	CreatePlayerVehicle(playerid, 611);
	return 1;
}

CMD:eject(playerid, params[])
{
    new id;
    {
        if(PlayerInfo[playerid][Freeze] == 1) return 0;
		if(PlayerInfo[playerid][Jail] == 1) return 0;
		if(sscanf(params, "u", id)) return GameTextForPlayer(playerid, "~g~/eject <id>",4500,3);
		if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid,"~g~Player is not connected", 4500, 3);
		if(!IsPlayerInVehicle(id, GetPlayerVehicleID(playerid))) return GameTextForPlayer(playerid, "~g~The player is not in your vehicle",4500,3);
		if(GetPlayerState(playerid) != 2) return GameTextForPlayer(playerid, "~g~you need to be in a vehicle",4500,3);
        if(IsPlayerInVehicle(id, GetPlayerVehicleID(playerid)) && GetPlayerVehicleSeat(playerid) == 0)
        {
			RemovePlayerFromVehicle(id);
	        GameTextForPlayer(playerid,"~g~ejected the passenger",4500,3);
	        GameTextForPlayer(id,"~g~ejected",4500,3);
		}
	}
    return 1;
}

CMD:ejectall(playerid, params[])
{
        if(PlayerInfo[playerid][Freeze] == 1) return 0;
		if(PlayerInfo[playerid][Jail] == 1) return 0;
		if(GetPlayerState(playerid) != 2) return GameTextForPlayer(playerid, "~g~you need to be in a vehicle",4500,3);
		foreach(Player, i)
		{
			if(IsPlayerInVehicle(i, GetPlayerVehicleID(playerid)) && GetPlayerVehicleSeat(i) != 0 && GetPlayerVehicleSeat(playerid) == 0)
	        {
				RemovePlayerFromVehicle(i);
		        GameTextForPlayer(playerid,"~g~ejected all passengers",4500,3);
		        GameTextForPlayer(i,"~g~ejected",4500,3);
			}
		}
        return 1;
}

CMD:duel(playerid, params[])
{
	new id,str[200],str2[1000];
	if(sscanf(params, "u", id)) return GameTextForPlayer(playerid,"~g~/duel~n~~w~(id)",4500,3);
	if(fr[playerid] == 0) return GameTextForPlayer(playerid, "~g~You are not in freeroam", 4500, 3);
	if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid, "~g~Player is not connected", 4500,3);
	if(id == playerid) return GameTextForPlayer(playerid, "~g~Invalid player id", 4500,3);
	if(fr[id] == 0) return GameTextForPlayer(playerid,"~g~Player is not in freeroam", 4500, 3);
	DuelInfo[playerid][DuelID] = id;
    for(new i;i<sizeof(Weapon);i++)
    {
		format(str,sizeof(str),"%s\n",Weapon[i][WeaponName]);
		strcat(str2, str);
    }
    ShowPlayerDialog(playerid, 130, DIALOG_STYLE_LIST, "Duel Weapon 1", str2, "Next", "Cancel");
	return 1;
}

CMD:duel2(playerid, params[])\
{
	new id = DuelInfo[playerid][DuelID],str[150];
	if(DuelInfo[playerid][DuelID] == INVALID_PLAYER_ID || DuelInfo[playerid][DuelID] == playerid || DuelInfo[playerid][DuelID] == -1) return GameTextForPlayer(playerid,"~g~Noone requested a duel with you", 4500,3);
	if(!IsPlayerConnected(DuelInfo[playerid][DuelID])) return GameTextForPlayer(playerid, "~g~Player is not connected", 4500,3);

	SetDuel(playerid);
    SetDuel(id);
	
	DuelInfo[playerid][InDuel] = 1;
	DuelInfo[id][InDuel] = 1;
	fr[playerid] = 0;
	fr[id] = 0;
	
	format(str, sizeof(str), "~w~%s~n~~g~VS~n~~w~%s~n~~n~%d/%d",GetName(playerid),GetName(id),DuelInfo[playerid][Rounds],DuelInfo[playerid][TotalRounds]);
	GameTextForPlayer(playerid, str, 4500, 3);
	return 1;
}

CMD:jp(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return 0;
    SetPlayerSpecialAction(playerid,2);
    GameTextForPlayer(playerid,"~g~Jetpack",4500,3);
    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
    return 1;
}

CMD:cms(playerid,params[])
{
	if(PlayerInfo[playerid][pLogged] == 0) return ShowPlayerDialog(playerid, 142, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF Register",""COL_WHITE"\nYou need to be registerd to use this command", "OK", "");
    if(PlayerInfo[playerid][CMS] == 1)
	{
		GameTextForPlayer(playerid,"~g~Chat Messages ~w~Off",4500,3);
		PlayerInfo[playerid][CMS] = 0;
	}
	else if(PlayerInfo[playerid][CMS] == 0)
	{
		GameTextForPlayer(playerid,"~g~Chat Messages ~w~On",4500,3);
		PlayerInfo[playerid][CMS] = 1;
	}
	return 1;
}

CMD:pms(playerid,params[])
{
	if(PlayerInfo[playerid][Pms] == 0)
	{
	PlayerInfo[playerid][Pms] = 1;
    GameTextForPlayer(playerid,"~g~Personal messages ~w~on",4500,3);
    }
    else if(PlayerInfo[playerid][Pms] == 1)
    {
    PlayerInfo[playerid][Pms] = 0;
    GameTextForPlayer(playerid,"~g~Personal messages ~w~off",4500,3);
    }
    return 1;
}

CMD:pm(playerid, params[])
{
	new id, str[500], ip[16];
	if(sscanf(params, "us[500]", id, params)) return GameTextForPlayer(playerid,"~g~/pm [id] [text]",4500,3);
	if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid,"~g~Player is not connected",4500,3);
    if(PlayerInfo[id][Pms] == 0 && PlayerInfo[playerid][pAdmin] == 0) return GameTextForPlayer(playerid,"~g~Player has ~w~Disabled ~g~their pms",4500,3);
    if(PlayerInfo[playerid][Pms] == 0) return GameTextForPlayer(playerid,"~g~You have ~w~ disabled ~g~your pms~n~~w~use /pms to enable pms",4500,3);
	if(PlayerInfo[id][Pms] == 0 && PlayerInfo[playerid][pAdmin] >= 1) return GameTextForPlayer(playerid,"~g~Player has ~w~Disabled ~g~their pms",4500,3);
	GetPlayerIp(playerid, ip, sizeof(ip));
	format(str, sizeof(str), "PM to %s(%d): %s", GetName(id), id, params);
	SendClientMessage(playerid, COLOR_RED, str);
    PlayerInfo[playerid][pPm] = id;
    PlayerInfo[id][pPm] = playerid;
	format(str, sizeof(str), "PM from %s(%d): %s", GetName(playerid), playerid, params);
	SendClientMessage(id, COLOR_RED, str);
	SendPMInfoToAdmins(playerid, id, params);
	return 1;
}

CMD:r(playerid, params[])
{
    new str[128],id = PlayerInfo[playerid][pPm];
    if(id == -1) return GameTextForPlayer(playerid,"~g~Player is not connected",4500,3);
    if(!IsPlayerConnected(id)) return GameTextForPlayer(playerid,"~g~Player is not connected",4500,3);
    if(PlayerInfo[id][Pms] == 0 && PlayerInfo[playerid][pAdmin] == 0) return GameTextForPlayer(playerid,"~g~Player has ~w~Disabled ~g~their pms",4500,3);
    if(PlayerInfo[playerid][Pms] == 0) return GameTextForPlayer(playerid,"~g~You have ~w~ disabled ~g~your pms~n~~w~use /pms to enable pms",4500,3);
	if(IsPlayerConnected(id))
    {
        if(isnull(params)) return GameTextForPlayer(playerid,"~g~/r ~n~~w~(text)",4500,3);
        format(str, sizeof(str), "PM to %s(%d): %s", GetName(id), id, params);
        SendClientMessage(playerid, COLOR_RED, str);
        format(str, sizeof(str), "PM from %s(%d): %s", GetName(playerid), playerid, params);
        SendClientMessage(id, COLOR_RED, str);
        SendPMInfoToAdmins(playerid, id, params);
    }
    else return GameTextForPlayer(playerid,"~g~Player is not connected",4500,3);
    return 1;
}

CMD:time(playerid, params[])
{
	if(PlayerInfo[playerid][pLogged] == 0) return ShowPlayerDialog(playerid, 142, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF Register",""COL_WHITE"\nYou need to be registerd to use this command", "OK", "");
	new time;
	{
        if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
		if(sscanf(params, "i", time)) return GameTextForPlayer(playerid,"~g~/time ~w~~n~(time id)",4500,3);
		if(time < 0 || time > 23) return GameTextForPlayer(playerid,"~g~/time ~w~~n~(0-23)",4500,3);
		PlayerInfo[playerid][Time] = time;
		SetPlayerTime(playerid, PlayerInfo[playerid][Time], 0);
	}
	return 1;
}

CMD:rtime(playerid, params[])
{
	if(PlayerInfo[playerid][pLogged] == 0) return ShowPlayerDialog(playerid, 142, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF Register",""COL_WHITE"\nYou need to be registerd to use this command", "OK", "");
	SetPlayerTime(playerid, 12, 0);
	GameTextForPlayer(playerid,"~g~time reset",4500,3);
	PlayerInfo[playerid][Time] = 12;
	return 1;
}

CMD:weather(playerid, params[])
{
	if(PlayerInfo[playerid][pLogged] == 0) return ShowPlayerDialog(playerid, 142, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF Register",""COL_WHITE"\nYou need to be registerd to use this command", "OK", "");
	new weather;
	{
        if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
		if(sscanf(params, "i", weather)) return GameTextForPlayer(playerid,"~g~/weather ~w~~n~(id)",4500,3);
		if(weather < 0 || weather > 65535) return GameTextForPlayer(playerid,"~g~/time ~w~~n~(0-65535)",4500,3);
		SetPlayerWeather(playerid, weather);
        PlayerInfo[playerid][Weather] = weather;
	}
	return 1;
}

CMD:rweather(playerid, params[])
{
	if(PlayerInfo[playerid][pLogged] == 0) return ShowPlayerDialog(playerid, 142, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF Register",""COL_WHITE"\nYou need to be registerd to use this command", "OK", "");
	SetPlayerWeather(playerid, 10);
	GameTextForPlayer(playerid,"~g~weather reset",4500,3);
	PlayerInfo[playerid][Weather] = 0;
	return 1;
}

CMD:v(playerid,params[])
{
	new vehicleid;
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
    if(sscanf(params, "d", vehicleid))
    {
        ShowPlayerDialog(playerid, 555,DIALOG_STYLE_LIST,"Vehicles","Airplanes\nHelicopters\nBikes\nIndustrial\nLowriders\nOff Road\nPublic Service\nSaloons\nSports Vehicles\nBoats\nTrailers\nUnique Vehicles\nRC Vehicles","Select","Cancel");
    }
    else
    {
		if(vehicleid >= 400)
		{
			if(vehicleid <= 600)
			{
				if(PlayerInfo[playerid][pAdmin] == 0 && vehicleid == 432 || 425 || 520) return 0;
	            CreatePlayerVehicle(playerid, vehicleid);
	        }
	    }
	}
	return 1;
}

CMD:c(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1) return ShowPlayerDialog(playerid, 1006, DIALOG_STYLE_LIST, ""COL_GREEN"UGF - Commands", "General\nPlayer\nVehicle\nVery Important Player (VIP)\nAdmin", "OK", "Cancel");
    ShowPlayerDialog(playerid, 1006, DIALOG_STYLE_LIST, ""COL_GREEN"UGF - Commands", "General\nPlayer\nVehicle\nVery Important Player (VIP)", "OK", "Cancel");
    return 1;
}

CMD:netstats(playerid,params[])
{
	new line[1024];
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new id;
		if(sscanf(params, "u", id))
		{
            GetPlayerNetworkStats(playerid, line, sizeof(line));
		}
		else
		{
            GetPlayerNetworkStats(id, line, sizeof(line));
		}
	}
	else
	{
		GetPlayerNetworkStats(playerid, line, sizeof(line));
		ShowPlayerDialog(playerid, 8910, DIALOG_STYLE_MSGBOX,"Network Stats", line, "OK", "");
	}
	return 1;
}

CMD:vcolor(playerid, params[])
{
        if(PlayerInfo[playerid][Freeze] == 1) return 0;
        if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
        if (indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
        if(GetPlayerState(playerid) == 2) return GameTextForPlayer(playerid,"~g~you are not in a vehicle",4500,3);
        for(new i; i < sizeof(ChangeColor); i++)
        {
	        TextDrawSetPreviewModel(ChangeColor[i], 19349);
	        TextDrawShowForPlayer(playerid,ChangeColor[i]);
        }
        SelectTextDraw(playerid, 0xFFFFFF66) ;
        return 1;
}

CMD:stats(playerid,params[])
{
	new id;
    if(!sscanf(params, "u", id))
	{
		if(PlayerInfo[playerid][pAdmin] >= 1) return StatsEx(id);
		Stats(id);
	}
	else
	{
		if(PlayerInfo[playerid][pAdmin] >= 1) return StatsEx(playerid);
		Stats(playerid);
	}
	return 1;
}

CMD:t(playerid, params[])
{
    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_LIST, ""COL_GREEN"UGF - Teleports", ""COL_WHITE"Stunts\nSpecials\nChallenges\nJumps\nParachute Jumps\nCities\nHotspots\nInteriors\nInteriors\nHouse Interiors\nHouses\nVehicle Tuning\nDrift Spots", "OK", "Cancel");
    return 1;
}

CMD:gos(playerid,params[])
{
	if(PlayerInfo[playerid][Gos] == 0)
	{
		PlayerInfo[playerid][Gos] = 1;
	    GameTextForPlayer(playerid,"~g~Gos ~w~on",4500,3);
    }
    else if(PlayerInfo[playerid][Gos] == 1)
    {
	    PlayerInfo[playerid][Gos] = 0;
	    GameTextForPlayer(playerid,"~g~Gos ~w~off",4500,3);
    }
    return 1;
}


CMD:god(playerid,params[])
{
        if(PlayerInfo[playerid][Freeze] == 1) return 0;
        if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	    if (indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~You are not in freeroam",3500,3);
	    
        if (God[playerid] == 1)
        {
			GameTextForPlayer(playerid,"~g~God mode ~w~Off",4500,3);
            SetPlayerHealth(playerid, 100);
            God[playerid] = 0;
            return 1;
        }
        else if(God[playerid] == 0)
        {
            GameTextForPlayer(playerid,"~g~God mode ~w~On",4500,3);
            SetPlayerHealth(playerid, 99999);
			ResetPlayerWeapons(playerid);
			God[playerid] = 1;
            return 1;
        }
        return 1;
}

CMD:skin(playerid,params[])
{
    new skinid;
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(sscanf(params, "d", skinid)) { SetPlayerHealth(playerid, 0); ForceClassSelection(playerid); }
    else
    {
	    if(skinid < 0 || skinid > 311) GameTextForPlayer(playerid,"~g~/skin~n~~w~(0-311)",4500,3);
    	PlayerInfo[playerid][pSkin] = skinid;
    	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
    }
    return 1;
}

CMD:w(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(God[playerid] == 1) return GameTextForPlayer(playerid, "~g~Your godmode is enabled ~n~~w~use /god to disable it",4500,3);
    ShowPlayerDialog(playerid, DIALOGID, DIALOG_STYLE_LIST, "Weapons List", "{FFFFFF}Pistols\n{FFFFFF}Sub-Machine Guns\n{FFFFFF}Shotguns\n{FFFFFF}Assault Rifles\n{FFFFFF}Melee Weapons", "Select", "Cancel");
    return 1;
}

CMD:kill(playerid,params[])
{
        if(PlayerInfo[playerid][Freeze] == 1) return 0;
        if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
		SetPlayerHealth(playerid, 0);
		return 1;
}

CMD:go(playerid, params[])
{
	new str[128], id,Float:x, Float:y, Float:z;
	{
        if(PlayerInfo[playerid][Freeze] == 1) return 0;
		if(sscanf(params, "u", id)) return GameTextForPlayer(playerid,"~g~/go~w~~n~(id)",4500,4);
		if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid,"~g~Player is not conected", 4500, 3);
		if(PlayerInfo[id][Jail] == 1) return GameTextForPlayer(playerid,"~g~Player is not in freeroam",2500,3);
		if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
		if(indm[id] >= 1) return GameTextForPlayer(playerid, "~g~player is not in freeroam",2500,3);
		if(GetPlayerState(id) == PLAYER_STATE_WASTED || GetPlayerState(id) == PLAYER_STATE_NONE || GetPlayerState(id) == PLAYER_STATE_SPECTATING) return GameTextForPlayer(playerid,"~g~player is not spawned",4500,3);
		if(PlayerInfo[id][Gos] == 0 && PlayerInfo[playerid][pAdmin] == 0) return GameTextForPlayer(playerid, "~g~player has ~w~disabled ~g~their gos",4500,3);
		if(PlayerInfo[id][Gos] == 0 && PlayerInfo[id][pAdmin] >= 1) return GameTextForPlayer(playerid,"~g~Player has ~w~disabled ~g~their gos", 4500, 3);
		GetPlayerPos(id, x, y, z);
		format(str, sizeof(str), "You have teleported to %s (/go)", GetName(id));
		SendClientMessage(playerid, GREEN, str);
		format(str, sizeof(str), "%s(%d) has teleported to you (/go)", GetName(playerid), playerid);
		SendClientMessage(id, GREEN, str);
		
		if(GetPlayerState(playerid) == 2)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), x + 3, y, z + 3);
			LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(id));
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetPlayerVirtualWorld(id));
		}
		else
		{
			SetPlayerInterior(playerid, GetPlayerInterior(id));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
		    SetPlayerPos(playerid, x + 2, y, z + 3);
		}
    }
    return 1;
}

CMD:fs(playerid, params[])
{
	if(PlayerInfo[playerid][pLogged] == 0) return ShowPlayerDialog(playerid, 142, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF Register",""COL_WHITE"\nYou need to be registerd to use this command", "OK", "");
    if (indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	ShowPlayerDialog(playerid, 4, DIALOG_STYLE_LIST, "Fighting Styles", "Normal\nBoxing\nKungfu\nKneehead\nGrabkick\nElbow", "Select", "Cancel");
	return 1;
}

CMD:color(playerid, params[])
{
	if(PlayerInfo[playerid][pLogged] == 0) return ShowPlayerDialog(playerid, 142, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF Register",""COL_WHITE"\nYou need to be registerd to use this command", "OK", "");
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	new color;
	if(sscanf(params, "x", color))
	{
	    ShowPlayerDialog(playerid, 98, DIALOG_STYLE_LIST, "Choose A Color For Your Name", "Reset Color\n{FFFFFF}White\n{00FF00}Green\n{FFFF00}Yellow\n{FF9900}Orange\n{FF0000}Red\n{FF33CC}Pink\n{0000FF}Blue\n{A1A1A1}Gray", "Select", "Cancel");
	}
	else
	{
	    SetPlayerColor(playerid, color);
	}
	return 1;
}

CMD:new(playerid, params[])
{
    new news[3000];
    strcat(news, ""COL_GREEN"  UGF Build 14 \n\n", sizeof(news));
    strcat(news, ""COL_WHITE"- Fixed Lag\n", sizeof(news));
    strcat(news, ""COL_WHITE"- Fixed (/stopanim) command\n", sizeof(news));
    strcat(news, ""COL_WHITE"- Fixed (/god) command in jail\n", sizeof(news));
    strcat(news, ""COL_WHITE"- Fixed green color in (/color) command\n", sizeof(news));
    ShowPlayerDialog(playerid, 30, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF - New Updates", news, "OK", "");
    return 1;
}

CMD:spawn(playerid, params[])
{
	if(PlayerInfo[playerid][pLogged] == 0) return ShowPlayerDialog(playerid, 142, DIALOG_STYLE_MSGBOX, ""COL_GREEN"UGF Register",""COL_WHITE"\nYou need to be registerd to use this command", "OK", "");
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(GetPlayerState(playerid) == PLAYER_STATE_WASTED) return GameTextForPlayer(playerid,"~g~You are not spawned",4500,3);
	
	new query[130];
    GetPlayerPos(playerid, PlayerInfo[playerid][posX],PlayerInfo[playerid][posY],PlayerInfo[playerid][posZ]);
	GetPlayerFacingAngle(playerid, PlayerInfo[playerid][posAngle]);
	PlayerInfo[playerid][SpawnInterior] = GetPlayerInterior(playerid);
	PlayerInfo[playerid][Spawn] = 1;
    GameTextForPlayer(playerid,"~g~Spawn Position Changed", 4500, 3);
    mysql_format(mysql, query, sizeof(query), "UPDATE `players` SET `Spawn` = %d, `Spawn_Interior` = %d, `Spawn_X` = %f, `Spawn_Y` = %f, `Spawn_Z` = %f `Spawn_Angle` = %f", PlayerInfo[playerid][Spawn], PlayerInfo[playerid][SpawnInterior], PlayerInfo[playerid][posX], PlayerInfo[playerid][posY], PlayerInfo[playerid][posZ], PlayerInfo[playerid][posAngle]);
    mysql_query(mysql, query);
    return 1;
}

CMD:rspawn(playerid, params[])
{
	new query[50];
    if(PlayerInfo[playerid][pLogged] == 0) return GameTextForPlayer(playerid, "~g~You are not registered", 4500, 3);
    if (indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	PlayerInfo[playerid][Spawn] = 0;
	GameTextForPlayer(playerid,"~g~Spawn Reset",4500,3);
    mysql_format(mysql, query, sizeof(query), "UPDATE `players` SET `Spawn` = %d, `Spawn_Interior` = -1, `Spawn_X` = 0, `Spawn_Y` = 0, `Spawn_Z` = 0 `Spawn_Angle` = 0 ", PlayerInfo[playerid][Spawn]);
    mysql_query(mysql, query);
	return 1;
}

CMD:home(playerid, params[])
{
	if(PlayerInfo[playerid][pLogged] == 0) return GameTextForPlayer(playerid, "~g~You are not registered", 4500, 3);
	if(PlayerInfo[playerid][Spawn] == 0) return GameTextForPlayer(playerid, "You dont have a custom spawn", 4500,3);
    if (indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~You are not in freeroam",2500,3);
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	SetPlayerPos(playerid, PlayerInfo[playerid][posX],PlayerInfo[playerid][posY],PlayerInfo[playerid][posZ]);
	SetPlayerFacingAngle(playerid, PlayerInfo[playerid][posAngle]);
	return 1;
}

////////////////////////////////-ANIMATIONS-////////////////////////////////////

CMD:a(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
	ShowPlayerDialog(playerid, 141, DIALOG_STYLE_LIST, ""COL_GREEN"Animations",""COL_WHITE"Stop Animation (/stopanim)\nDance (/dance)\nDance 2 (/dance2)\nDance 3 (/dance3)\nDance 4 (/dance4)\nWank (/wank)\nSit (/sit)\nInjured (/injured)\nSlapass (/slapass)", "Select", "Cancel");
	return 1;
}

CMD:stopanim(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    ClearAnimations(playerid);
    GameTextForPlayer(playerid, "~g~Stopped animation", 4500,3);
	return 1;
}

CMD:dance(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
	Anim[playerid] = 1;
	return 1;
}

CMD:dance2(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
	Anim[playerid] = 1;
	return 1;
}

CMD:dance3(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
	Anim[playerid] = 1;
	return 1;
}

CMD:dance4(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
	Anim[playerid] = 1;
	return 1;
}

CMD:wank(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    ApplyAnimation(playerid,"PAULNMAC","wank_loop",4.0,1,1,1,1,0);
    Anim[playerid] = 1;
    return 1;
}

CMD:sit(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    ApplyAnimation(playerid,"PED","SEAT_idle", 4.0, 1, 0, 0, 0, 0);
    Anim[playerid] = 1;
	return 1;
}

CMD:injured(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    ApplyAnimation(playerid,"SWEET","Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0);
    Anim[playerid] = 1;
    return 1;
}

CMD:slapass(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    ApplyAnimation(playerid,"SWEET","sweet_ass_slap",4.0,0,0,0,0,0);
    Anim[playerid] = 1;
	return 1;
}

//////////////////////////////-VEHICLE COMMANDS-////////////////////////////////

CMD:engine(playerid,params[])
{
	        new vehicleid = GetPlayerVehicleID(playerid);
	        new engine, lights, alarm, doors, bonnet, boot, objective;
	        if(GetPlayerState(playerid) == 2)
            {
                if(GetPlayerVehicleSeat(playerid) == 0)
                {
                    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
                    if(engine)
                    {
                        GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
                        SetVehicleParamsEx(vehicleid,false,lights,alarm,doors,bonnet,boot,objective);
                        GameTextForPlayer(playerid,"~g~Vehicle engine ~w~stopped",4500,3);
                        return 1;
                    }
                    else
                    {
	                    SetVehicleParamsEx(vehicleid,true,lights,alarm,doors,bonnet,boot,objective);
	                    GameTextForPlayer(playerid,"~g~Vehicle engine ~w~started",4500,3);
                    }
                }
                else GameTextForPlayer(playerid,"~g~you need to drive a vehicle",4500,3);
                return 1;
            }
            else
            GameTextForPlayer(playerid,"~g~you need to drive a vehicle",4500,3);
			return 1;
}

CMD:lock(playerid,params[])
{
	        new engine, lights, alarm, doors, bonnet, boot, objective;
	        new vehicleid = GetPlayerVehicleID(playerid);
	        if(GetPlayerState(playerid) == 2)
            {
	                if(GetPlayerVehicleSeat(playerid) == 0)
	                {
		                GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		                if(doors)
		                {
		                    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
                            SetVehicleParamsEx(vehicleid,engine,lights,alarm,false,bonnet,boot,objective);
                            GameTextForPlayer(playerid,"Vehicle ~w~Unlocked",2000,6);
                            return 1;
		                }
		                else
		                {
			                SetVehicleParamsEx(vehicleid,engine,lights,alarm,true,bonnet,boot,objective);
			                GameTextForPlayer(playerid,"~g~Vehicle ~w~Locked",4500,3);
		                }
	                }
	                else GameTextForPlayer(playerid,"~g~you need to drive a vehicle",4500,3);
            }
            else
            GameTextForPlayer(playerid,"~g~you need to drive a vehicle",4500,3);
			return 1;
}

CMD:hydraulics(playerid, params[])
{
	if(GetPlayerState(playerid) != 2) return GameTextForPlayer(playerid,"~g~you need to drive a vehicle",4500,3);
	if(GetVehicleComponentInSlot(GetPlayerVehicleID(playerid),GetVehicleComponentType(1087)) != 1087)
	{
        AddVehicleComponent(GetPlayerVehicleID(playerid), 1087);
        GameTextForPlayer(playerid,"~g~hydraulics ~w~added",4500,3);
    }
    else if(GetVehicleComponentInSlot(GetPlayerVehicleID(playerid),GetVehicleComponentType(1087)) == 1087)
    {
		RemoveVehicleComponent(GetPlayerVehicleID(playerid),1087);
		GameTextForPlayer(playerid,"~g~hydraulics ~w~removed",4500,3);
	}
	return 1;
}

////////////////////////////////-FUN COMMANDS-//////////////////////////////////

CMD:cam(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	GivePlayerWeapon(playerid, 43, 999999);
	GameTextForPlayer(playerid,"~g~Camera",4500,3);
	return 1;
}

CMD:flowers(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	GivePlayerWeapon(playerid, 14, 1);
	GameTextForPlayer(playerid,"~g~Flowers",4500,3);
	return 1;
}

CMD:nightvision(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	GivePlayerWeapon(playerid, 44, 1);
	GameTextForPlayer(playerid,"~g~Night vision goggles",4500,3);
	return 1;
}

CMD:para(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
	GivePlayerWeapon(playerid, 46, 1);
    GameTextForPlayer(playerid,"~g~Parachute",4500,3);
    }
    else GameTextForPlayer(playerid, "~g~you are not in freeroam",2500,3);
	return 1;
}

CMD:dive(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(fr[playerid] == 1)
	{
    new hight;
   	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	if(sscanf(params,"i",hight))
	{
	    SetPlayerPos(playerid, x, y, z+1000);
	    GivePlayerWeapon(playerid, 46, 1);
	    GameTextForPlayer(playerid,"~g~Skydive", 4500, 3);
	}
	else
	{
	    SetPlayerPos(playerid,x,y,z+hight);
	    if(hight >= 10)
		{
		    GameTextForPlayer(playerid,"~g~Skydive",4500,3);
		}
	}
	}
	else
	{
	    GameTextForPlayer(playerid, "~g~you are not in freeroam",2500,3);
	}
	return 1;
}

////////////////////////////////////-PED ANIMS-////////////////////////////////

CMD:drunk(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	ShowPlayerDialog(playerid, 140, DIALOG_STYLE_LIST, ""COL_GREEN"Drunk Level", ""COL_WHITE"None\nVery Low\nLow\nHigh\nVery High", "OK", "Cancel");
	return 1;
}

CMD:cuffed(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	SetPlayerSpecialAction(playerid, 24);
	return 1;
}

CMD:drink(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	SetPlayerSpecialAction(playerid, 20);
	return 1;
}

CMD:handsup(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	SetPlayerSpecialAction(playerid, 10);
	return 1;
}

CMD:piss(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	SetPlayerSpecialAction(playerid, 68);
	return 1;
}

CMD:carry(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	SetPlayerSpecialAction(playerid, 25);
	return 1;
}

CMD:call(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	SetPlayerSpecialAction(playerid, 11);
	return 1;
}

CMD:smoke(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	SetPlayerSpecialAction(playerid, 21);
	return 1;
}

/////////////////////////////////////-TELEPORTS-////////////////////////////////
CMD:army(playerid, params[])
{
	Army(playerid);
	return 1;
}

CMD:sp(playerid, params[])
{
    SP(playerid);
	return 1;
}

CMD:a51(playerid,params[])
{
   A51(playerid);
   return 1;
}

CMD:si(playerid,params[])
{
   StuntIsland(playerid);
   return 1;
}

CMD:lsa(playerid, params[])
{
   LSA(playerid);
	return 1;
}

CMD:sfa(playerid, params[])
{
    SFA(playerid);
	return 1;
}

CMD:lva(playerid, params[])
{
    LVA(playerid);
	return 1;
}

CMD:aa(playerid, params[])
{
    AA(playerid);
    return 1;
}

CMD:ls(playerid, params[])
{
	LS(playerid);
	return 1;
}

CMD:sf(playerid, params[])
{
	SF(playerid);
	return 1;
}

CMD:lv(playerid, params[])
{
	LV(playerid);
	return 1;
}

CMD:cj(playerid, params[])
{
	CJ(playerid);
	return 1;
}

CMD:atd(playerid, params[])
{
	ATD(playerid);
	return 1;
}

CMD:wh2(playerid, params[])
{
	WH2(playerid);
	return 1;
}

CMD:wh(playerid, params[])
{
	WH(playerid);
	return 1;
}

CMD:arch(playerid, params[])
{
	Arch(playerid);
	return 1;
}

CMD:tf(playerid, params[])
{
	TF(playerid);
	return 1;
}

CMD:loco(playerid, params[])
{
	Loco(playerid);
	return 1;
}

//==============================================================================
// 								VIP COMMANDS
//==============================================================================

CMD:balloon(playerid,params[])
{
        if(PlayerInfo[playerid][pVip] == 1)
        {
			if(PlayerIn[playerid][BalloonPlayer] == 1)
			{
		        DestroyDynamicObject(Balloon[playerid]);
		    }
		    
			new Float:x,Float:y,Float:z;
			
	        GetPlayerPos(playerid,x,y,z);
	        
	        Balloon[playerid] = CreateDynamicObject(19335,x,y,z + 3.5,0.0,0.0,0.0, GetPlayerVirtualWorld(playerid));
	        SetPlayerPos(playerid,x,y,z + 3.5);
		    SendClientMessage(playerid,COLOR_GREENZ,"Use the following keys to control the controllable object");
		    SendClientMessage(playerid,COLOR_GREENZ,"~k~~PED_SPRINT~+~k~~CONVERSATION_YES~ (Move Balloon Up)");
		    SendClientMessage(playerid,COLOR_GREENZ,"~k~~PED_SPRINT~+~k~~CONVERSATION_NO~ (Move Balloon Down)");
		    SendClientMessage(playerid,COLOR_GREENZ,"~k~~VEHICLE_ENTER_EXIT~+~k~~CONVERSATION_YES~ (Move Balloon Forward)");
		    SendClientMessage(playerid,COLOR_GREENZ,"~k~~VEHICLE_ENTER_EXIT~+~k~~CONVERSATION_NO~ (Move Balloon Back)");
		    SendClientMessage(playerid,COLOR_GREENZ,"~k~~SNEAK_ABOUT~+~k~~CONVERSATION_NO~ (Move Balloon Left)");
		    SendClientMessage(playerid,COLOR_GREENZ,"~k~~SNEAK_ABOUT~+~k~~CONVERSATION_YES~ (Move Balloon Right)");
		    PlayerIn[playerid][BalloonPlayer] = 1;
	    }
        return 1;
}

CMD:destroyballoon(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] == 7)
	{
		if(PlayerIn[playerid][BalloonPlayer] == 0) return GameTextForPlayer(playerid,"~g~you dident spawned any balloon",4500,3);
		DestroyDynamicObject(Balloon[playerid]);
	    PlayerIn[playerid][BalloonPlayer] = 0;
	    GameTextForPlayer(playerid,"~g~Destroyed controllable object",4500,3);
    }
    return 1;
}

CMD:vw(playerid,params[])
{
	if(PlayerInfo[playerid][pVip] == 1)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		PlayerInfo[playerid][VW] = 6;
	    SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][VW]);
	    SetPlayerPos(playerid, x, y, z+3);
	    GameTextForPlayer(playerid, "~g~VIP World", 4500, 3);
    }
	return 1;
}

CMD:vips(playerid,params[])
{
    new count = 0,string[1024],fstring[1024];
    format(fstring, sizeof(fstring), ""COL_GREEN"Online Very Important Players (VIPs)");
    strcat(string, fstring);
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][pVip] > 0)
			{
				format(fstring, sizeof(fstring), ""COL_WHITE"\n%s(%d)",GetName(i),i);
				strcat(string, fstring);
				count++;
			}
		}
	}
    ShowPlayerDialog(playerid, 120, DIALOG_STYLE_MSGBOX, "{6EF83C}Online VIPs", string, "OK", "");
	return 1;
}

CMD:count(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(PlayerInfo[playerid][pVip] >= 1)
    {
	    new seconds;
	    if(sscanf(params,"i",seconds)) return GameTextForPlayer(playerid, "~g~/count~n~~w~(seconds)",4500,3);
		if(seconds > MAX_COUNTDOWN_TIME || seconds <= 0) return GameTextForPlayer(playerid, "~g~/count~n~~w~(1-10)",4500,3);
        Count[playerid] = seconds;
		CountTimer = SetTimer("Counting",1000,true);
	}
	return 1;
}

CMD:megajump(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] >= 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(PlayerInfo[playerid][pVip] >= 1)
	{
	if (MegaJump[playerid] == 1)
	{
		MegaJump[playerid] = 0;
		GameTextForPlayer(playerid,"~g~MegaJump ~w~Off",4500,3);
		return 1;
	}
	else if (MegaJump[playerid] == 0)
	{
		MegaJump[playerid] = 1;
		GameTextForPlayer(playerid,"~g~MegaJump ~w~On",4500,3);
		return 1;
	}
	}
	return 1;
}

CMD:neon(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(PlayerInfo[playerid][pVip] >= 1)
	{
		if(GetPlayerState(playerid) == 2)
		{
            new string[128];
			ShowPlayerDialog(playerid, neondialog, DIALOG_STYLE_LIST, "Select a neon color", "Dark Blue\nRed\nGreen\nWhite\nPurple\nYellow\nBlue\nLight Blue\nPink\nOrange\nLight Green (Lime)\nCyan\nRemove all neons", "Choose", "Cancel");
			PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
	}
    return 1;
}

CMD:cart(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][pVip] == 0) return GameTextForPlayer(playerid, "~g~you are not vip",4500,3);
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    
    new Float:x, Float:y, Float:z;
    new cart =  CreatePlayerVehicle(playerid, 457);
	new mCart[1];
    
	GetPlayerPos(playerid, x, y, z);
	
    mCart[0] = CreateObject(1572, x, y, z, 0.00000, 0.00000, 0.00000);
    AttachObjectToVehicle(mCart[0], cart, 0, 0, 0, 0.00000, 0.00000, 0.00000);
    
    LinkVehicleToInterior(cart, 2001);
    PutPlayerInVehicle(playerid, cart, 0);
    return 1;
}

CMD:siren(playerid, params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(PlayerInfo[playerid][pVip] >= 1)
	{
    
	    new type;

		if(sscanf(params, "d", type)) return GameTextForPlayer(playerid, "~g~/Siren~w~~n~(type)~n~~n~(1 = Inside)~n~(2 = Roof)~n~(3 = Remove)", 5000, 3);

	    new string[128];
		new VID = GetPlayerVehicleID(playerid);

		switch(type)
	    {
			case 1:
			{
				if(Siren[VID] == 1) return GameTextForPlayer(playerid, "~g~This vehicle already have a siren~n~~w~Use /siren 3 to remove", 5000, 3);
				Siren[VID] = 1;
				SirenObject[VID] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
				AttachObjectToVehicle(SirenObject[VID], VID, 0.0, 0.75, 0.275, 0.0, 0.1, 0.0);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				return 1;
			}
			case 2:
			{
				if(Siren[VID] == 1) return GameTextForPlayer(playerid, "~g~This vehicle already have a siren~n~~w~Use /siren 3 to remove", 5000, 3);
				Siren[VID] = 1;
				SirenObject[VID] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
				AttachObjectToVehicle(SirenObject[VID], VID, -0.43, 0.0, 0.785, 0.0, 0.1, 0.0);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				return 1;
			}
			case 3:
			{
				if(Siren[VID] == 1) return GameTextForPlayer(playerid, "~g~This vehicle already have a siren~n~~w~Use /siren 3 to remove", 5000, 3);
				Siren[VID] = 0;
				DestroyObject(SirenObject[VID]);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				return 1;
			}
		}
   	}
   	else SendClientMessage(playerid, COLOR_GREY, "You're not authorised to use this command.");
	return 1;
}

CMD:rvcolor(playerid,params[])
{
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	if(PlayerInfo[playerid][pVip] >= 1)
	{
		if(GetPlayerState(playerid) == 2)
		{
		   RVColorTimer[playerid] = SetTimerEx("ColorChanger",10,0,"d",playerid);
		   rvc[playerid] = 1;
		}
		else GameTextForPlayer(playerid,"~g~you are not in any vehicle",4500,3);
	}
	return 1;
}

CMD:pship(playerid,params[])
{
    if(PlayerInfo[playerid][pVip] >= 1)
    if(PlayerInfo[playerid][Freeze] == 1) return 0;
    if(PlayerInfo[playerid][Jail] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
    if(indm[playerid] == 1) return GameTextForPlayer(playerid,"~g~you are not in freeroam",2500,3);
	SpawnPship(playerid);
	return 1;
}

CMD:svo(playerid,params[])
{
	if(PlayerInfo[playerid][pVip] >= 1)
	ShowPlayerDialog(playerid, 97, DIALOG_STYLE_MSGBOX, ""COL_GREEN"Special VIP Objects", ""COL_WHITE"\n\n Pirate Ship (/pship) \n Flying Balloon (/balloon)", "OK", "");
	return 1;
}
////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////(DEATHMATCHES)///////////////////////////////
////////////////////////////////////////////////////////////////////////////////
CMD:dm(playerid,params[])
{
            new string[500];
			new ddm,
			ddm2,
			sdm,
			scr,
			sos;
			foreach(Player, i)
			{
				if(IsPlayerConnected(i))
				{
                    if(indm[i] == 1)
                    {
						ddm++;
					}
					if(indm[i] == 2)
					{
						sdm++;
					}
					if(indm[i] == 3)
					{
						sos++;
					}
					if(indm[i] == 4)
					{
						ddm2++;
					}
					if(indm[i] == 5)
					{
						scr++;
					}
				}
			}
            format(string,sizeof(string),
			""COL_GREEN"Map\t"COL_GREEN"Players\n\
			"COL_WHITE"Deagle (/ddm)\t%d\n\
			Deagle 2 (/ddm2)\t%d\n\
			Sawn-Off Shotgun (/sos)\t%d\n\
			Sniper (/sdm)\t%d\n\
            Skyscraper (/scr)\t%d",ddm,ddm2,sos,sdm,scr);
			ShowPlayerDialog(playerid, 125, DIALOG_STYLE_TABLIST_HEADERS, ""COL_GREEN"Deathmatch",string, "Select","Cancel");
	        return 1;
}

CMD:ddm(playerid, params[])
{
	DDM(playerid);
	return 1;
}


CMD:sdm(playerid, params[])
{
	SDM(playerid);
	return 1;
}

CMD:sos(playerid,params[])
{
	SOS(playerid);
    return 1;
}

CMD:ddm2(playerid, params[])
{
	DDM2(playerid);
	return 1;
}

CMD:scr(playerid, params[])
{
	SCR(playerid);
	return 1;
}
//------------------------------------------------------------------------------
CMD:fr(playerid, params[])
{
	FR(playerid);
	return 1;
}
//------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////(MAPS)/////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//---------------------------(Stunt Island)-------------------------------------
CreateSIObjects(playerid)
{
	new TempObjectNumber;

    CreatePlayerObject(playerid,19672,331.9166,3396.5845,85.9599,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19532,77.5000,3570.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19542,335.0000,3570.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19540,335.0000,3757.5000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19532,7.5000,3500.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19535,77.5000,3422.5000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19532,7.5000,3640.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19532,-62.5000,3570.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19539,335.0000,3663.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19533,77.5000,3678.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19533,77.5000,3461.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19542,7.5000,3835.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19533,-62.5000,3678.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19531,-132.5000,3570.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19538,-132.5000,3678.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19532,-132.5000,3500.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19534,-62.5000,3500.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19534,-62.5000,3640.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19541,-62.4998,3835.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19541,84.9997,3827.5000,4.3078,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19538,-132.5000,3461.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19532,-132.5000,3640.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19533,-62.5000,3461.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19532,7.5000,3422.5000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19532,-132.5000,3422.5000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19538,-132.5000,3383.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19542,-55.0000,3227.5000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19545,-62.5000,3383.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19543,-202.5000,3383.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19533,-202.5000,3461.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19541,15.0001,3352.5000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19541,77.5000,3835.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19541,-62.5000,3165.0000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19542,-132.5000,3165.0000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19541,-202.5000,3165.0000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19539,-210.0000,3383.7500,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19541,-210.0000,3422.5000,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19539,-210.0000,3461.2500,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19541,-210.0000,3499.9998,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19532,-202.5000,3570.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19533,-202.5000,3678.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19542,-210.0000,3570.0000,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19541,-210.0000,3640.0000,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19539,-210.0000,3678.7500,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19541,-202.4998,3710.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19540,335.0000,3257.5000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19546,85.0000,3352.5000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19547,-132.5000,3290.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19546,-54.9999,3352.5000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19543,-62.5000,3321.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19543,-62.5000,3258.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19536,-132.5000,3196.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19543,-62.5000,3196.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19540,-55.0000,3165.0000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19542,-210.0000,3290.0000,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19543,-202.5000,3321.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19543,-202.5000,3258.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19543,-202.5000,3196.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19539,-210.0000,3196.2500,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19546,84.9999,3757.5000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19532,77.5000,3772.5000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19539,178.7500,3757.5000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19540,85.0000,3835.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19540,-69.9998,3835.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19546,-69.9998,3710.0000,4.3080,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19532,-62.4999,3772.5000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19539,-163.7498,3710.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19539,-69.9998,3803.7500,4.3077,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19539,335.0000,3726.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19529,7.5000,3570.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19539,241.2500,3757.5000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19539,303.7500,3757.5000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19539,241.2500,3257.5000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19539,303.7500,3257.5000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19535,-62.5000,3422.5000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19535,-202.5000,3422.5000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19535,-202.5000,3500.0000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19535,-202.5000,3640.0000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19535,77.5000,3640.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,149.4099,3422.5000,-40.2988,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19646,300.0856,3261.5845,83.4814,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19642,124.1813,3422.5000,8.8521,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19647,134.1813,3422.5000,8.8520,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19650,96.9146,3422.5000,6.1717,0.0000,-10.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19643,114.1813,3422.5000,8.8521,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19659,-15.6602,3682.0776,29.3538,0.0000,0.0000,0.0000,999.0);

	TempObjectNumber = CreatePlayerObject(playerid,19665,311.1857,3531.0288,86.7789,0.0000,0.0000,-90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "YellowDirt1", 0);

	TempObjectNumber = CreatePlayerObject(playerid,19667,305.6357,3426.5845,95.3124,0.0000,0.0000,-90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "BlueDirt1", 0);

	CreatePlayerObject(playerid,19664,70.0058,3666.1621,31.6038,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19663,331.9166,3381.5845,81.2314,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,326.6671,3417.2505,83.4814,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19662,337.7673,3671.4116,87.1412,0.0000,0.0000,90.0000,999.0);

	TempObjectNumber = CreatePlayerObject(playerid,19651,284.1701,3276.5845,73.4814,0.0000,0.0000,90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);

	TempObjectNumber = CreatePlayerObject(playerid,19652,266.0011,3406.5845,53.4814,0.0000,0.0000,180.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);

	CreatePlayerObject(playerid,19660,316.0011,3245.9185,83.4814,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,188.5509,3422.5000,25.7300,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19649,203.5318,3422.5000,26.3325,0.0000,20.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19674,200.6326,3498.2903,17.2481,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19676,140.8339,3498.2903,12.0060,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19673,231.6195,3422.5000,36.5668,0.0000,15.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19675,144.5353,3422.5000,9.2890,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19678,120.0057,3697.9932,51.5540,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19675,154.9452,3422.5000,10.6383,0.0000,5.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19675,165.1978,3422.5000,12.8897,0.0000,10.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19675,175.2152,3422.5000,16.0262,0.0000,15.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19670,255.9339,3422.5000,-7.4172,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19673,241.1739,3422.5000,39.5792,0.0000,10.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19673,250.9545,3422.5000,41.7474,0.0000,5.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19673,260.8867,3422.5000,43.0549,0.0000,0.0000,180.0000,999.0);

	TempObjectNumber = CreatePlayerObject(playerid,19652,266.0011,3406.5845,73.4814,0.0000,0.0000,180.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);

	CreatePlayerObject(playerid,19649,291.0011,3422.5000,83.4814,0.0000,-0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19670,291.0011,3422.5000,33.4567,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19684,314.6369,3697.9932,126.3243,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19682,213.1957,3717.7407,29.3538,0.0000,0.0000,-135.0000,999.0);
	CreatePlayerObject(playerid,19681,157.1870,3668.5852,29.3538,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19686,260.6396,3739.9441,70.3298,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19685,181.5493,3697.9929,58.8229,0.0000,-30.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19663,331.9166,3331.5845,81.2314,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,331.9167,3356.5845,33.4567,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19663,331.9166,3281.5845,81.2314,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19646,300.0856,3271.5845,83.4814,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,331.9166,3306.5845,33.4567,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,300.0856,3301.5845,63.4814,0.0000,-0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,300.0856,3351.5845,63.4814,0.0000,-0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,300.0856,3401.5845,63.4814,0.0000,-0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,300.0855,3356.5845,13.4567,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,300.0856,3306.5845,13.4567,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,311.1857,3451.5845,63.4814,0.0000,-0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,311.1857,3501.5845,63.4814,0.0000,-0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,311.1857,3466.5845,13.4567,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,311.1858,3516.5845,13.4567,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,311.1857,3575.2466,87.1413,0.0000,-0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19663,311.1858,3625.2466,84.8912,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,311.1857,3560.2466,37.1166,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,316.4353,3660.9126,87.1412,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,311.1857,3625.2466,32.6165,0.0000,0.0000,90.0000,999.0);

	TempObjectNumber = CreatePlayerObject(playerid,19652,358.9323,3682.0776,97.1412,0.0000,0.0000,-90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);

	TempObjectNumber = CreatePlayerObject(playerid,19652,358.9323,3682.0776,117.1413,0.0000,0.0000,-90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);

	TempObjectNumber = CreatePlayerObject(playerid,19667,95.0057,3729.8225,46.0054,-90.0000,0.0000,0.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "BlueDirt1", 0);

	CreatePlayerObject(playerid,19662,337.7672,3692.7434,127.1412,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19684,290.5576,3697.9929,119.8723,0.0000,15.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19649,257.7041,3697.9929,101.8476,0.0000,-30.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19649,214.4028,3697.9929,76.8476,0.0000,-30.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19685,157.4701,3697.9929,52.3709,0.0000,-15.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19670,149.8595,3697.9929,1.6564,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19670,343.0168,3682.0776,37.1165,0.0000,0.0000,90.0000,999.0);

	TempObjectNumber = CreatePlayerObject(playerid,19667,95.0057,3729.8225,34.9053,-90.0000,0.0000,0.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "BlueDirt1", 0);

	TempObjectNumber = CreatePlayerObject(playerid,19668,124.6504,3397.5898,84.0644,0.0000,15.0000,-90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "BlueDirt1", 0);

	TempObjectNumber = CreatePlayerObject(playerid,19666,159.4614,3413.4658,108.9914,0.0000,0.0000,90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "YellowDirt1", 0);

	CreatePlayerObject(playerid,19680,70.0058,3697.9932,29.3538,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19670,25.0058,3697.9932,-20.6709,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19649,20.0058,3697.9932,29.3539,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19659,-15.6602,3682.0776,34.8538,180.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19649,20.0058,3666.1621,29.3538,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19649,120.0058,3666.1621,29.3538,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19670,25.0058,3666.1621,-20.6709,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19664,241.2924,3679.2480,31.6038,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,185.1914,3693.1628,29.3538,0.0000,0.0000,-135.0000,999.0);
	CreatePlayerObject(playerid,19661,236.0429,3714.9141,29.3538,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19670,125.0058,3666.1621,-20.6709,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19648,241.2924,3599.2480,29.3538,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19644,110.4799,3498.2903,11.5691,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19670,241.2924,3679.2480,-16.1709,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19647,241.2924,3569.2480,29.3539,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19664,241.2924,3489.2480,31.6038,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,241.2924,3489.2480,-16.1709,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19663,241.2924,3419.2480,27.1038,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19646,241.2924,3459.2480,29.3538,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19646,241.2924,3449.2480,29.3538,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19664,241.2924,3369.2480,31.6038,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,241.2924,3369.2480,-16.1709,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19663,241.2924,3319.2480,27.1038,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,236.0429,3283.5820,29.3538,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,235.9641,3283.5449,34.8538,-180.0000,0.0000,179.0000,999.0);
	CreatePlayerObject(playerid,19649,200.3770,3278.3325,29.3538,0.0000,-0.0000,-0.0000,999.0);

	TempObjectNumber = CreatePlayerObject(playerid,19652,175.3770,3294.2480,39.3538,0.0000,0.0000,0.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);

	TempObjectNumber = CreatePlayerObject(playerid,19652,175.3770,3294.2480,59.3538,0.0000,0.0000,0.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);

	TempObjectNumber = CreatePlayerObject(playerid,19652,175.3769,3294.2480,79.3538,0.0000,0.0000,0.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);

	TempObjectNumber = CreatePlayerObject(playerid,19652,175.3770,3294.2480,44.8538,180.0000,0.0000,-180.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);

	TempObjectNumber = CreatePlayerObject(playerid,19652,175.3769,3294.2480,99.3538,0.0000,0.0000,0.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);

	CreatePlayerObject(playerid,19670,185.3770,3278.3325,-20.6709,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19661,164.7110,3283.5820,109.3538,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19649,159.4614,3319.2480,109.3538,0.0000,-0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,159.4614,3369.2480,109.3538,0.0000,-0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,159.4614,3364.2480,59.3291,0.0000,0.0000,90.0000,999.0);

	TempObjectNumber = CreatePlayerObject(playerid,19666,159.4614,3487.1279,85.3316,0.0000,0.0000,90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "YellowDirt1", 0);

	TempObjectNumber = CreatePlayerObject(playerid,19666,159.4614,3560.7900,61.6717,0.0000,0.0000,90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "YellowDirt1", 0);

	CreatePlayerObject(playerid,19670,119.1004,3385.7981,-1.9767,0.0000,0.0000,90.0000,999.0);

	TempObjectNumber = CreatePlayerObject(playerid,19649,159.4614,3442.9102,85.6940,0.0000,-0.0000,-90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "YellowDirt1", 0);

	CreatePlayerObject(playerid,19684,159.4614,3667.4851,81.6925,0.0000,-30.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,159.4614,3634.6316,63.6678,0.0000,30.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19684,159.4614,3691.5645,88.1445,0.0000,-15.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,164.7109,3734.6946,88.9614,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,159.4614,3714.0286,38.9367,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,283.7699,3734.6946,69.5128,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19684,187.8412,3739.9441,88.1445,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19649,224.2404,3739.9441,79.2371,0.0000,-15.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19670,273.1040,3739.9441,19.4881,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19646,289.0194,3719.0288,69.5128,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,283.7699,3734.6946,75.0128,180.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19682,286.5965,3701.8474,69.5128,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19681,237.4409,3645.8386,69.5129,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,262.0187,3673.8430,69.5129,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19649,235.0180,3608.6575,69.5129,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,235.0180,3558.6575,69.5129,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19682,232.5950,3521.4763,69.5129,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,130.2005,3429.9766,59.7885,0.0000,-15.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19682,208.2971,3497.1785,69.5129,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19649,171.1159,3494.7554,69.5129,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19646,222.1594,3507.6140,69.5129,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19662,135.4500,3489.5059,69.5129,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19684,130.2004,3466.3757,68.6959,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,258.4832,3670.3076,19.4881,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19686,108.0004,3345.2810,37.9402,0.0000,0.0000,-90.0000,999.0);

	TempObjectNumber = CreatePlayerObject(playerid,19649,119.1004,3381.6802,46.8476,0.0000,-15.0000,90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "BlueDirt1", 0);

	TempObjectNumber = CreatePlayerObject(playerid,19668,113.5504,3349.2935,71.1235,0.0000,15.0000,-90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "BlueDirt1", 0);

	CreatePlayerObject(playerid,19663,108.0004,3257.8167,34.8733,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,130.2004,3473.6985,19.3535,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,108.0003,3332.8167,-12.9014,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,216.7155,3422.5000,35.9592,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,275.3560,3419.4604,50.1579,0.0000,0.0000,-36.0000,999.0);
	CreatePlayerObject(playerid,19672,281.1376,3401.6663,54.0688,0.0000,0.0000,72.0000,999.0);
	CreatePlayerObject(playerid,19672,266.0011,3390.6689,58.0268,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,250.8645,3401.6663,61.8254,0.0000,0.0000,-72.0000,999.0);
	CreatePlayerObject(playerid,19672,256.6462,3419.4604,65.9731,0.0000,0.0000,-144.0000,999.0);
	CreatePlayerObject(playerid,19672,256.6462,3419.4604,85.7634,0.0000,0.0000,-144.0000,999.0);
	CreatePlayerObject(playerid,19672,275.3560,3419.4604,69.9482,0.0000,0.0000,-36.0000,999.0);
	CreatePlayerObject(playerid,19672,281.1376,3401.6663,73.8591,0.0000,0.0000,72.0000,999.0);
	CreatePlayerObject(playerid,19672,266.0011,3390.6689,77.8171,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,250.8645,3401.6663,81.6157,0.0000,0.0000,-72.0000,999.0);
	CreatePlayerObject(playerid,19672,276.0011,3422.5000,88.0673,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,305.9753,3422.5000,88.0673,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,327.3069,3417.8904,87.9516,0.0000,0.0000,-45.0000,999.0);
	CreatePlayerObject(playerid,19550,7.5000,3710.0000,4.3077,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19672,331.9166,3366.5771,85.9599,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,331.9166,3316.5845,85.9599,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,331.9166,3346.5918,85.9599,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,331.9166,3266.5923,85.9599,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,331.9166,3296.5999,85.9599,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,327.3070,3245.2786,88.2336,0.0000,0.0000,-135.0000,999.0);
	CreatePlayerObject(playerid,19672,304.6953,3245.2788,88.1757,0.0000,0.0000,135.0000,999.0);
	CreatePlayerObject(playerid,19672,297.0461,3285.9395,86.1250,0.0000,0.0000,126.0000,999.0);
	CreatePlayerObject(playerid,19672,279.2520,3291.7209,82.0771,0.0000,0.0000,16.0000,999.0);
	CreatePlayerObject(playerid,19672,268.2546,3276.5845,78.2285,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,279.2520,3261.4480,73.9912,0.0000,0.0000,-20.0000,999.0);
	CreatePlayerObject(playerid,19672,297.0460,3267.2297,70.2106,0.0000,0.0000,54.0000,999.0);
	CreatePlayerObject(playerid,19672,300.0856,3286.5845,68.0976,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,300.0856,3316.5479,68.0976,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,300.0001,3336.5508,68.3325,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,300.0001,3366.5588,68.3325,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,300.0001,3386.5305,68.3325,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,300.0001,3416.5354,68.3325,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1857,3436.5845,68.1464,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1857,3466.5889,68.1464,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1857,3486.5654,68.1464,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1857,3516.5720,68.1464,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1857,3531.8862,91.8754,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1857,3560.2422,91.8754,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1857,3590.2336,91.8754,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1858,3610.2466,89.8444,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1858,3640.2439,89.8444,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,315.7955,3661.5525,91.7584,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19540,85.0000,3257.5000,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19540,-210.0000,3165.0000,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19540,-210.0000,3710.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,338.4071,3670.7717,91.8683,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19672,346.0564,3691.4324,93.9506,0.0000,0.0000,54.0000,999.0);
	CreatePlayerObject(playerid,19672,363.8504,3697.2141,97.8625,0.0000,0.0000,-18.0000,999.0);
	CreatePlayerObject(playerid,19672,374.8478,3682.0776,101.8288,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,363.8505,3666.9409,105.8737,0.0000,0.0000,18.0000,999.0);
	CreatePlayerObject(playerid,19672,346.0564,3672.7227,109.8370,0.0000,0.0000,-54.0000,999.0);
	CreatePlayerObject(playerid,19672,346.0564,3672.7227,129.7860,0.0000,0.0000,-54.0000,999.0);
	CreatePlayerObject(playerid,19672,363.8505,3666.9409,125.8226,0.0000,0.0000,18.0000,999.0);
	CreatePlayerObject(playerid,19672,374.8478,3682.0776,121.7777,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,363.8504,3697.2141,117.8115,0.0000,0.0000,-18.0000,999.0);
	CreatePlayerObject(playerid,19672,346.0564,3691.4324,113.8996,0.0000,0.0000,54.0000,999.0);
	CreatePlayerObject(playerid,19672,338.4071,3693.3833,131.7450,0.0000,0.0000,-45.0000,999.0);
	CreatePlayerObject(playerid,19672,311.7588,3697.9929,130.6222,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,287.1232,3697.9929,123.3002,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,269.3201,3697.9929,113.6222,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,243.3627,3697.9929,98.6212,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,226.0258,3697.9929,88.6012,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,200.0598,3697.9929,73.6839,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,178.2511,3697.9929,62.4286,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,154.6358,3697.9929,56.6647,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,35.0058,3697.9932,34.0287,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,5.0128,3697.9932,34.0287,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,5.0128,3666.1621,34.0287,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,35.0058,3666.1621,34.0287,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,55.0236,3666.1621,36.0365,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,85.0416,3666.1621,36.0365,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,105.0083,3666.1621,34.0287,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,134.9800,3666.1621,34.0287,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4567,3669.6313,34.0726,0.0000,0.0000,27.0000,999.0);
	CreatePlayerObject(playerid,19672,174.5848,3682.5562,34.1170,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19672,195.7980,3703.7695,34.1170,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19672,215.5406,3718.6057,33.9744,0.0000,0.0000,18.0000,999.0);
	CreatePlayerObject(playerid,19672,234.7318,3717.1240,34.0809,0.0000,0.0000,-36.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3694.2480,36.0042,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3664.2678,36.0042,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3504.2703,36.0042,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3474.2324,36.0042,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3434.2769,32.0711,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3404.2515,32.0711,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3384.2493,36.0140,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3354.2383,36.0140,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3334.2317,32.0321,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3304.2390,31.9984,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,215.3770,3278.3325,33.8870,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,185.3680,3278.3325,33.8870,0.0000,0.0000,-0.0000,999.0);

	TempObjectNumber = CreatePlayerObject(playerid,19652,175.3770,3294.2480,64.8538,180.0000,0.0000,-180.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);

	TempObjectNumber = CreatePlayerObject(playerid,19652,175.3769,3294.2480,84.8538,180.0000,0.0000,-180.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);

	CreatePlayerObject(playerid,19672,159.4614,3304.2480,114.0335,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,164.0711,3282.9424,113.9617,0.0000,0.0000,-45.0000,999.0);
	CreatePlayerObject(playerid,19672,184.7318,3281.3721,112.0262,0.0000,0.0000,36.0000,999.0);
	CreatePlayerObject(playerid,19672,190.5135,3299.1663,107.8524,0.0000,0.0000,-72.0000,999.0);
	CreatePlayerObject(playerid,19672,175.3769,3310.1636,103.8580,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,160.2404,3299.1663,100.0933,0.0000,0.0000,72.0000,999.0);
	CreatePlayerObject(playerid,19672,166.0220,3281.3721,95.9705,0.0000,0.0000,-36.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4614,3334.2378,114.0335,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4614,3354.2266,114.0335,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4614,3384.2668,114.0335,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4614,3412.5928,114.0335,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4614,3486.2449,90.4535,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4614,3559.9297,66.7921,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4614,3579.7673,44.2265,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4615,3427.9221,90.4296,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4615,3457.8840,90.4296,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4613,3620.2524,60.4987,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4613,3646.2703,75.5153,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4613,3668.8413,87.1338,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4613,3693.7808,93.1308,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,190.6684,3739.9441,92.3369,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,210.4541,3739.9441,87.6401,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,239.4345,3739.9441,79.8874,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,263.4093,3739.9441,74.7607,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,285.5501,3699.5776,74.1313,-0.0000,0.0000,63.0000,999.0);
	CreatePlayerObject(playerid,19672,272.6253,3684.4497,74.1723,-0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19672,251.4121,3663.2366,74.1261,-0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19672,236.5759,3643.4939,74.1149,-0.0000,0.0000,72.0000,999.0);
	CreatePlayerObject(playerid,19672,235.0180,3623.6575,74.2145,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,235.0180,3593.5452,74.2145,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,235.0180,3573.5925,74.2145,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,235.0180,3543.6985,74.2145,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,231.5486,3519.2065,74.1295,-0.0000,0.0000,63.0000,999.0);
	CreatePlayerObject(playerid,19672,205.9522,3496.3135,74.1754,-0.0000,0.0000,18.0000,999.0);
	CreatePlayerObject(playerid,19672,186.1409,3494.8167,74.1754,-0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,156.0972,3494.8167,74.1754,-0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,134.8101,3490.1458,74.2067,-0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19672,130.2005,3463.4688,72.9750,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,130.2005,3443.7839,68.1349,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,130.2005,3414.7671,60.4308,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,129.9005,3396.0225,56.9608,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,119.1004,3395.4226,55.3437,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,119.1004,3366.4854,47.5958,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,118.8004,3347.7910,44.0340,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,108.0004,3342.5022,42.2326,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,108.0004,3272.8323,39.8413,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,108.0004,3242.8140,39.7832,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,241.2924,3629.2480,29.3538,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,241.2925,3539.2480,29.3539,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19642,241.2924,3589.2480,29.3539,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19642,241.2924,3579.2480,29.3539,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,241.7848,3542.6001,-22.0166,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,241.2924,3624.2480,-20.6709,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3524.2693,34.0474,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3554.2651,34.0474,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3614.2158,34.0474,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3644.2666,34.0474,0.0000,0.0000,-90.0000,999.0);

	TempObjectNumber = CreatePlayerObject(playerid,19649,159.4614,3516.5723,62.0340,0.0000,-0.0000,-90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "YellowDirt1", 0);

	CreatePlayerObject(playerid,19672,159.4615,3501.5842,66.7697,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4615,3531.5461,66.7697,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19685,159.4614,3577.6987,39.1911,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19685,159.4614,3601.7781,45.6431,0.0000,15.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19646,159.4614,3709.0286,88.9614,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19646,159.4614,3719.0286,88.9614,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,235.0180,3533.6575,19.4881,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,235.0180,3613.6575,19.4881,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,159.4614,3447.9102,35.6692,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,159.4614,3521.5723,12.0093,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,159.4614,3570.0881,-11.5234,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,164.7110,3734.6946,94.4614,-180.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19670,316.0011,3240.6689,33.4567,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19550,272.4998,3570.0000,4.3080,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19550,147.4997,3570.0000,4.3080,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19550,272.4998,3445.0000,4.3080,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19550,272.4998,3320.0000,4.3080,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19549,85.0002,3273.7500,4.3077,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19542,334.9997,3445.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19542,334.9997,3320.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19550,147.4997,3445.0000,4.3080,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19550,147.4997,3320.0000,4.3080,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,762,159.2296,3364.1545,8.0631,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,621,172.3828,3530.9956,4.1185,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,621,210.9594,3632.0981,4.1185,0.0000,0.0000,-81.0000,999.0);
	CreatePlayerObject(playerid,621,216.5798,3372.2180,4.1185,0.0000,0.0000,-55.0000,999.0);
	CreatePlayerObject(playerid,621,169.0373,3244.0442,4.1185,0.0000,0.0000,21.0000,999.0);
	CreatePlayerObject(playerid,621,348.5469,3253.4072,4.1185,0.0000,0.0000,71.0000,999.0);
	CreatePlayerObject(playerid,762,159.7794,3569.8127,8.0631,0.0000,0.0000,40.0000,999.0);
	CreatePlayerObject(playerid,762,311.5156,3624.8386,8.0631,0.0000,0.0000,78.0000,999.0);
	CreatePlayerObject(playerid,762,298.8590,3306.5583,8.0631,0.0000,0.0000,126.0000,999.0);
	CreatePlayerObject(playerid,762,24.2674,3664.7112,8.0631,0.0000,0.0000,169.0000,999.0);
	CreatePlayerObject(playerid,762,159.5200,3713.7891,8.0631,0.0000,0.0000,-140.0000,999.0);
	CreatePlayerObject(playerid,762,290.4150,3422.7559,8.0631,0.0000,0.0000,-175.0000,999.0);
	CreatePlayerObject(playerid,762,240.0694,3678.5208,8.0631,0.0000,0.0000,122.0000,999.0);
	CreatePlayerObject(playerid,762,107.5217,3293.8779,9.0631,0.0000,0.0000,50.0000,999.0);
	CreatePlayerObject(playerid,621,60.2490,3681.9932,4.1185,0.0000,0.0000,36.0000,999.0);
	CreatePlayerObject(playerid,621,313.2220,3679.3630,4.1185,0.0000,0.0000,82.0000,999.0);
	CreatePlayerObject(playerid,621,267.0584,3501.8621,4.1185,0.0000,0.0000,27.0000,999.0);
	CreatePlayerObject(playerid,621,263.6267,3280.8892,4.1185,0.0000,0.0000,-52.0000,999.0);
	CreatePlayerObject(playerid,621,318.7102,3387.3503,4.1185,0.0000,0.0000,42.0000,999.0);
	CreatePlayerObject(playerid,621,131.9952,3640.5090,4.1185,0.0000,0.0000,121.0000,999.0);
	CreatePlayerObject(playerid,3509,87.8005,3438.1350,4.1266,0.0000,0.0000,-45.0000,999.0);
	CreatePlayerObject(playerid,3509,87.8005,3407.0583,4.1266,0.0000,0.0000,62.0000,999.0);
	CreatePlayerObject(playerid,19649,108.0004,3307.8167,37.1233,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19684,139.8314,3245.2810,36.3063,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,139.8315,3281.6802,27.3989,0.0000,-15.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19686,139.8315,3318.0793,18.4916,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,145.0810,3451.2097,17.6746,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,139.8315,3355.5437,17.6746,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,139.8315,3405.5437,17.6746,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19646,139.8315,3435.5437,17.6746,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,180.7469,3456.4592,17.6746,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19662,216.4129,3461.7087,17.6746,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19662,216.4129,3493.0408,17.6746,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19646,221.6624,3477.3748,17.6746,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,170.8531,3498.2903,14.6323,0.0000,-5.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19648,130.4799,3498.2903,11.5691,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19642,120.4800,3498.2903,11.5691,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19650,93.7424,3498.2903,6.9995,0.0000,-19.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19534,77.5000,3500.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,3509,87.8005,3513.5872,4.1266,0.0000,0.0000,-45.0000,999.0);
	CreatePlayerObject(playerid,3509,87.8005,3482.5103,4.1266,0.0000,0.0000,62.0000,999.0);
	CreatePlayerObject(playerid,19672,108.0004,3322.8167,41.8230,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,108.0004,3292.8167,41.8230,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,112.6100,3221.5107,41.8151,0.0000,0.0000,135.0000,999.0);
	CreatePlayerObject(playerid,19672,135.2216,3221.5107,41.8151,0.0000,0.0000,-135.0000,999.0);
	CreatePlayerObject(playerid,19672,139.8314,3244.9832,40.9682,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,139.8314,3267.9055,35.9077,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,139.8314,3296.8618,28.1914,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,139.8314,3317.8293,23.2563,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,139.8314,3340.5437,22.4207,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,139.8314,3370.5759,22.4207,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,139.8314,3390.5437,22.4207,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,139.8314,3420.5437,22.4207,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,144.4411,3451.8496,22.4207,-0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19672,165.7469,3456.4592,22.4207,-0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,195.7418,3456.4592,22.4207,-0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,217.0527,3461.0688,22.4207,-0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19672,217.0528,3493.6804,22.4207,-0.0000,0.0000,-45.0000,999.0);
	CreatePlayerObject(playerid,19672,185.5585,3498.2903,20.4852,-0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,155.6512,3498.2903,17.9867,-0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19670,108.0004,3257.8167,-17.4014,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,139.8314,3232.8167,-12.9015,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,139.8315,3330.5437,-32.3501,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,139.8315,3410.5437,-32.3501,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,185.7469,3456.4592,-32.3501,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19670,175.5944,3498.2903,-34.9671,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19659,123.9158,3222.1506,37.1233,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19542,147.4997,3257.5000,4.3080,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19543,77.5002,3383.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19536,7.5000,3461.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19536,7.5000,3803.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19550,147.4997,3695.0000,4.3080,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19550,272.4998,3695.0000,4.3080,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,621,236.0952,3742.8730,4.1185,0.0000,0.0000,125.0000,999.0);
	CreatePlayerObject(playerid,19536,7.5000,3383.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	return 1;
}

Tube()
{
	AddStaticVehicle(411,413.9708,1290.8983,11.1234,277.2508,64,1); // 1
	AddStaticVehicle(411,414.3809,1288.3691,10.9546,278.1350,123,1); // 2
	AddStaticVehicle(411,414.6618,1285.8993,10.7741,278.3894,116,1); // 3
	AddStaticVehicle(411,415.0540,1283.4214,10.5984,278.8067,112,1); // 4
	AddStaticVehicle(411,415.4046,1280.9591,10.4250,278.6530,106,1); // 5
	AddStaticVehicle(411,415.7927,1278.4559,10.2478,278.8196,80,1); // 6
	AddStaticVehicle(411,416.0209,1276.0127,10.0790,276.2284,75,1); // 7
	Func_TubeConnector(0, 0, TUBE, TBR_RED, 19646, 426.399017, 1336.730468, 14.547410, 4.099989, 11.500008, 91.699851, 2000.0);
	Func_TubeConnector(1, 0, TUBE, TBR_RED, 19686, 425.694946, 1353.995727, 11.874095, -4.099986, -11.500003, -88.300140, 2000.0);
	Func_TubeConnector(2, 0, TUBE, TBR_RED, 19689, 425.190185, 1378.491333, 14.972855, 4.099980, -48.499992, -268.300109, 2000.0);
	Func_TubeConnector(3, 0, TUBE, TBR_RED, 19689, 426.015289, 1394.665771, 33.172485, 4.099987, -93.500000, -268.300109, 2000.0);
	Func_TubeConnector(4, 0, TUBE, TBR_RED, 19689, 427.797210, 1393.230468, 57.427040, 4.099974, -138.499984, -268.300109, 2000.0);
	Func_TubeConnector(5, 0, TUBE, TBR_RED, 19689, 429.492126, 1375.026489, 73.528533, 4.099967, -183.499969, -268.300109, 2000.0);
	Func_TubeConnector(6, 2, TUBE, TBR_RED, 19680, 430.607940, 1337.780029, 73.674087, 4.099981, -183.499969, 91.699867, 2000.0);
	Func_TubeConnector(7, 2, TUBE, TBR_RED, 19680, 431.870239, 1287.888793, 70.629501, 84.611251, 40.419937, -128.845367, 2000.0);
	Func_TubeConnector(8, 0, TUBE, TBR_RED, 19649, 433.132568, 1237.997558, 67.584922, -4.099971, 3.499960, -88.300094, 2000.0);
	Func_TubeConnector(9, 1, TUBE, TBR_RED, 19667, 430.558593, 1211.012695, 98.149658, -4.099973, 3.499960, -88.300086, 2000.0);
	Func_TubeConnector(10, 0, TUBE, TBR_GREEN, 19649, 423.328247, 1187.777709, 65.334945, -4.099973, 3.499960, -88.300064, 2000.0);
	Func_TubeConnector(11, 1, TUBE, TBR_GREEN, 19662, 419.016784, 1152.034545, 63.536941, 4.099973, -3.499960, 91.699943, 2000.0);
	Func_TubeConnector(12, 1, TUBE, TBR_GREEN, 19662, 397.749145, 1151.403320, 65.062088, 3.490995, 4.107605, 1.449362, 2000.0);
	Func_TubeConnector(13, 0, TUBE, TBR_GREEN, 19649, 391.613952, 1186.835815, 67.609214, 4.099970, -3.499963, 91.699897, 2000.0);
	Func_TubeConnector(14, 2, TUBE, TBR_GREEN, 19661, 385.501617, 1222.269653, 70.154739, -3.490998, -4.107604, -178.550628, 2000.0);
	Func_TubeConnector(15, 1, TUBE, TBR_GREEN, 19651, 375.065155, 1242.484985, 82.161926, 3.490998, 4.107604, 1.449375, 2000.0);
	Func_TubeConnector(16, 0, TUBE, TBR_GREEN, 19649, 351.273315, 1225.275390, 92.936042, -3.490998, -4.107604, -178.550598, 2000.0);
	Func_TubeConnector(17, 1, TUBE, TBR_BLUE, 19667, 328.536346, 1228.198608, 126.751640, -3.490998, -4.107604, -178.550567, 2000.0);
	Func_TubeConnector(18, 0, TUBE, TBR_BLUE, 19649, 301.143035, 1234.871826, 97.187789, -3.490998, -4.107604, -178.550537, 2000.0);
	Func_TubeConnector(19, 2, TUBE, TBR_BLUE, 19661, 265.715972, 1228.600219, 99.419479, -4.099968, 3.499965, -88.299964, 2000.0);
	Func_TubeConnector(20, 2, TUBE, TBR_BLUE, 19661, 266.231719, 1207.314208, 98.122200, 3.490995, 4.107605, 1.449504, 2000.0);
	Func_TubeConnector(21, 0, TUBE, TBR_BLUE, 19649, 301.922851, 1203.130493, 95.252517, 3.490995, 4.107605, 1.449504, 2000.0);
	Func_TubeConnector(22, 0, TUBE, TBR_BLUE, 19649, 351.772918, 1204.610107, 91.677673, 3.490995, 4.107605, 1.449504, 2000.0);
	Func_TubeConnector(23, 0, TUBE, TBR_BLUE, 19649, 401.622985, 1206.089721, 88.102828, 3.490995, 4.107605, 1.449504, 2000.0);
	Func_TubeConnector(24, 0, TUBE, TBR_BLUE, 19649, 451.473052, 1207.569335, 84.527984, 3.490995, 4.107605, 1.449504, 2000.0);
	Func_TubeConnector(25, 2, TUBE, TBR_YELLOW, 19661, 486.900115, 1213.840942, 82.296287, 4.099970, -3.499963, 91.700042, 2000.0);
	Func_TubeConnector(26, 0, TUBE, TBR_YELLOW, 19649, 491.234375, 1249.584228, 84.092628, 4.099968, -3.499965, 91.700027, 2000.0);
	Func_TubeConnector(27, 2, TUBE, TBR_YELLOW, 19661, 485.121948, 1285.018066, 86.638153, -3.490998, -4.107604, -178.550506, 2000.0);
	Func_TubeConnector(28, 0, TUBE, TBR_YELLOW, 19649, 449.430816, 1289.201782, 89.507835, -3.490998, -4.107604, -178.550476, 2000.0);
	Func_TubeConnector(29, 2, TUBE, TBR_YELLOW, 19680, 399.580749, 1287.722167, 93.082679, -3.490998, -4.107604, -178.550445, 2000.0);
	Func_TubeConnector(30, 2, TUBE, TBR_YELLOW, 19680, 349.730682, 1286.242553, 96.657524, -84.611251, 229.579971, 51.154785, 2000.0);
	Func_TubeConnector(31, 0, TUBE, TBR_YELLOW, 19689, 312.486846, 1285.285156, 96.902343, 3.490998, 139.107604, -358.550415, 2000.0);
	Func_TubeConnector(32, 0, TUBE, TBR_YELLOW, 19689, 294.051879, 1285.790039, 80.983329, 3.491000, -265.892364, -358.550415, 2000.0);
	Func_TubeConnector(33, 0, TUBE, TBR_YELLOW, 19689, 292.270080, 1287.225097, 56.728759, 3.491014, 49.107635, -358.550415, 2000.0);
	Func_TubeConnector(34, 0, TUBE, TBR_YELLOW, 19689, 308.185241, 1288.749511, 38.346618, 3.491031, 4.107619, -358.550384, 2000.0);
	Func_TubeConnector(35, 0, TUBE, TBR_PURPLE, 19649, 345.075012, 1289.992431, 33.276779, 3.491034, 4.107601, 1.449591, 2000.0);
	Func_TubeConnector(36, 2, TUBE, TBR_PURPLE, 19661, 380.502075, 1296.264038, 31.045093, 4.099977, -3.500015, 91.700141, 2000.0);
	Func_TubeConnector(37, 0, TUBE, TBR_PURPLE, 19649, 384.836273, 1332.007324, 32.841468, 4.099969, -3.500024, 91.700126, 2000.0);
	Func_TubeConnector(38, 1, TUBE, TBR_PURPLE, 19662, 389.147613, 1367.750488, 34.639514, -4.099967, 3.500027, -88.299850, 2000.0);
	Func_TubeConnector(39, 0, TUBE, TBR_PURPLE, 19649, 424.573608, 1374.045043, 32.409255, 3.491055, 4.107604, 1.449589, 2000.0);
	Func_TubeConnector(40, 1, TUBE, TBR_PURPLE, 19662, 460.264648, 1369.884277, 29.540924, -3.491055, -4.107605, -178.550369, 2000.0);
	Func_TubeConnector(41, 0, TUBE, TBR_PURPLE, 19649, 466.400024, 1334.451782, 26.993759, -4.099968, 3.500025, -88.299797, 2000.0);
	Func_TubeConnector(42, 0, TUBE, TBR_PURPLE, 19649, 467.662597, 1284.560546, 23.949121, -4.099970, 3.500022, -88.299781, 2000.0);
	Func_TubeConnector(43, 1, TUBE, TBR_PURPLE, 19662, 463.351318, 1248.817382, 22.151079, 4.099973, -3.500020, 91.700218, 2000.0);
	Func_TubeConnector(44, 0, TUBE, TBR_PURPLE, 19649, 427.925323, 1242.522705, 24.381338, -3.491058, -4.107604, -178.550292, 2000.0);
	Func_TubeConnector(45, 0, TUBE, TBR_PURPLE, 19649, 378.075256, 1241.042968, 27.956184, -3.491058, -4.107604, -178.550247, 2000.0);
	Func_TubeConnector(46, 1, TUBE, TBR_PURPLE, 19662, 342.384185, 1245.203613, 30.824516, 3.491058, 4.107604, 1.449759, 2000.0);
	Func_TubeConnector(47, 2, TUBE, TBR_RED, 19661, 331.399108, 1266.174926, 32.872364, -3.491058, -4.107604, -178.550201, 2000.0);
	Func_TubeConnector(48, 0, TUBE, TBR_RED, 19649, 295.707946, 1270.358520, 35.742053, -3.491058, -4.107604, -178.550155, 2000.0);
	Func_TubeConnector(49, 1, TUBE, TBR_RED, 19662, 260.016876, 1274.519042, 38.610385, 3.491058, 4.107604, 1.449849, 2000.0);
	Func_TubeConnector(50, 1, TUBE, TBR_RED, 19662, 259.478149, 1295.804199, 39.909324, -4.099969, 3.500026, -88.299583, 2000.0);
	Func_TubeConnector(51, 0, TUBE, TBR_RED, 19649, 294.904113, 1302.098999, 37.679065, 3.491055, 4.107607, 1.449861, 2000.0);
	Func_TubeConnector(52, 2, TUBE, TBR_RED, 19661, 330.331146, 1308.370849, 35.447376, 4.099972, -3.500022, 91.700393, 2000.0);
	Func_TubeConnector(53, 1, TUBE, TBR_GREEN, 19651, 351.895782, 1319.050415, 44.539325, -4.099969, 3.500026, -88.299598, 2000.0);
	Func_TubeConnector(54, 0, TUBE, TBR_GREEN, 19649, 336.128265, 1342.935913, 57.155345, 4.099970, -3.500024, 91.700408, 2000.0);
	Func_TubeConnector(55, 2, TUBE, TBR_GREEN, 19661, 330.015594, 1378.369628, 59.700904, -3.491059, -4.107604, -178.550109, 2000.0);
	Func_TubeConnector(56, 2, TUBE, TBR_GREEN, 19661, 308.747375, 1377.761108, 61.227443, -4.099969, 3.500026, -88.299537, 2000.0);
	Func_TubeConnector(57, 0, TUBE, TBR_GREEN, 19649, 304.413360, 1342.017822, 59.431068, -4.099971, 3.500023, -88.299514, 2000.0);
	Func_TubeConnector(58, 0, TUBE, TBR_GREEN, 19649, 305.676208, 1292.126586, 56.386432, -4.099973, 3.500021, -88.299484, 2000.0);
	Func_TubeConnector(59, 1, TUBE, TBR_GREEN, 19662, 301.365112, 1256.383422, 54.588390, 4.099973, -3.500020, 91.700500, 2000.0);
	Func_TubeConnector(60, 0, TUBE, TBR_GREEN, 19649, 265.939147, 1250.088623, 56.818649, -3.491058, -4.107604, -178.550003, 2000.0);
	Func_TubeConnector(61, 1, TUBE, TBR_GREEN, 19662, 230.248062, 1254.249145, 59.686981, 3.491058, 4.107604, 1.450001, 2000.0);
	Func_TubeConnector(62, 0, TUBE, TBR_GREEN, 19649, 224.112472, 1289.681518, 62.234146, 4.099969, -3.500026, 91.700538, 2000.0);
	Func_TubeConnector(63, 0, TUBE, TBR_GREEN, 19649, 222.849594, 1339.572753, 65.278785, 4.099967, -3.500028, 91.700531, 2000.0);
	Func_TubeConnector(64, 0, TUBE, TBR_GREEN, 19649, 221.586730, 1389.463989, 68.323425, 4.099967, -3.500028, 91.700508, 2000.0);
	Func_TubeConnector(65, 1, TUBE, TBR_GREEN, 19665, 220.443420, 1433.606933, 70.655273, 4.099967, -3.500028, 91.700485, 2000.0);
	Func_TubeConnector(66, 2, TUBE, TBR_GREEN, 19661, 213.145874, 1449.897460, 48.753829, -3.491060, -4.107603, -178.550033, 2000.0);
	Func_TubeConnector(67, 2, TUBE, TBR_GREEN, 19661, 191.877655, 1449.288940, 50.280368, -4.099969, 3.500026, -88.299468, 2000.0);
	Func_TubeConnector(68, 0, TUBE, TBR_GREEN, 19649, 187.543701, 1413.545654, 48.483993, -4.099971, 3.500023, -88.299446, 2000.0);
	Func_TubeConnector(69, 1, TUBE, TBR_GREEN, 19662, 183.232620, 1377.802490, 46.685951, 4.099973, -3.500021, 91.700553, 2000.0);
	Func_TubeConnector(70, 0, TUBE, TBR_GREEN, 19649, 147.806671, 1371.507690, 48.916210, -3.491058, -4.107604, -178.549957, 2000.0);
	Func_TubeConnector(71, 1, TUBE, TBR_GREEN, 19662, 112.115577, 1375.668090, 51.784542, 3.491058, 4.107604, 1.450044, 2000.0);
	Func_TubeConnector(72, 0, TUBE, TBR_GREEN, 19649, 105.979965, 1411.100463, 54.331707, 4.099969, -3.500026, 91.700592, 2000.0);
	Func_TubeConnector(73, 1, TUBE, TBR_BLUE, 19662, 110.291023, 1446.843627, 56.129753, -4.099967, 3.500028, -88.299392, 2000.0);
	Func_TubeConnector(74, 0, TUBE, TBR_BLUE, 19687, 133.258636, 1452.768554, 54.792907, 3.491056, 4.107605, 1.450080, 2000.0);
	Func_TubeConnector(75, 1, TUBE, TBR_BLUE, 19651, 146.854598, 1436.668701, 62.885871, -3.491055, -4.107606, -178.549880, 2000.0);
	Func_TubeConnector(76, 0, TUBE, TBR_BLUE, 19651, 148.317489, 1435.490600, 82.797477, -3.491058, -4.107604, -178.549835, 2000.0);
	Func_TubeConnector(77, 0, TUBE, TBR_BLUE, 19651, 149.780380, 1434.312500, 102.709083, -3.491058, -4.107604, -178.549789, 2000.0);
	Func_TubeConnector(78, 0, TUBE, TBR_BLUE, 19649, 175.034805, 1450.344360, 111.846588, 3.491058, 4.107604, 1.450212, 2000.0);
	Func_TubeConnector(79, 0, TUBE, TBR_BLUE, 19649, 224.884872, 1451.824584, 108.271743, 3.491057, 4.107604, 1.450206, 2000.0);
	Func_TubeConnector(80, 1, TUBE, TBR_BLUE, 19667, 252.278350, 1445.151855, 137.836593, 3.491057, 4.107604, 1.450203, 2000.0);
	Func_TubeConnector(81, 0, TUBE, TBR_BLUE, 19649, 275.015441, 1442.228881, 104.021987, 3.491057, 4.107605, 1.450196, 2000.0);
	Func_TubeConnector(82, 0, TUBE, TBR_BLUE, 19649, 324.865509, 1443.709106, 100.447143, 3.491057, 4.107605, 1.450189, 2000.0);
	Func_TubeConnector(83, 1, TUBE, TBR_BLUE, 19662, 360.556610, 1439.548706, 97.578811, -3.491057, -4.107605, -178.549774, 2000.0);
	Func_TubeConnector(84, 0, TUBE, TBR_BLUE, 19649, 366.692321, 1404.116333, 95.031646, -4.099969, 3.500026, -88.299209, 2000.0);
	Func_TubeConnector(85, 0, TUBE, TBR_BLUE, 19649, 367.955444, 1354.225097, 91.987007, -4.099971, 3.500023, -88.299179, 2000.0);
	Func_TubeConnector(86, 1, TUBE, TBR_BLUE, 19665, 369.045928, 1310.124877, 88.933761, -4.099973, 3.500021, -88.299179, 2000.0);
	Func_TubeConnector(87, 0, TUBE, TBR_YELLOW, 19649, 368.085540, 1282.121459, 63.946060, -4.099973, 3.500020, -88.299179, 2000.0);
	Func_TubeConnector(88, 2, TUBE, TBR_YELLOW, 19661, 374.198455, 1246.687866, 61.400505, 3.491051, 4.107609, 1.450261, 2000.0);
	Func_TubeConnector(89, 0, TUBE, TBR_YELLOW, 19649, 409.889648, 1242.504638, 58.530811, 3.491051, 4.107610, 1.450256, 2000.0);
	Func_TubeConnector(90, 0, TUBE, TBR_YELLOW, 19649, 459.739715, 1243.984863, 54.955963, 3.491050, 4.107610, 1.450251, 2000.0);
	Func_TubeConnector(91, 1, TUBE, TBR_PURPLE, 19667, 487.133209, 1237.312133, 84.520797, 3.491050, 4.107610, 1.450247, 2000.0);
	Func_TubeConnector(92, 0, TUBE, TBR_PURPLE, 19649, 509.870269, 1234.389160, 50.706199, 3.491050, 4.107610, 1.450242, 2000.0);
	Func_TubeConnector(93, 2, TUBE, TBR_PURPLE, 19661, 545.297180, 1240.661254, 48.474510, 4.099975, -3.500018, 91.700775, 2000.0);
	Func_TubeConnector(94, 2, TUBE, TBR_PURPLE, 19661, 544.781127, 1261.947265, 49.771816, -3.491057, -4.107605, -178.549743, 2000.0);
	Func_TubeConnector(95, 0, TUBE, TBR_PURPLE, 19649, 509.089935, 1266.130493, 52.641506, -3.491058, -4.107604, -178.549697, 2000.0);
	Func_TubeConnector(96, 1, TUBE, TBR_PURPLE, 19662, 473.398834, 1270.290771, 55.509838, 3.491058, 4.107604, 1.450304, 2000.0);
	Func_TubeConnector(97, 0, TUBE, TBR_PURPLE, 19649, 467.263092, 1305.723144, 58.057003, 4.099969, -3.500026, 91.700843, 2000.0);
	Func_TubeConnector(98, 1, TUBE, TBR_PURPLE, 19651, 483.230560, 1330.551025, 68.397232, -4.099967, 3.500028, -88.299140, 2000.0);
	Func_TubeConnector(99, 0, TUBE, TBR_PURPLE, 19649, 467.462829, 1354.436523, 81.013252, 4.099970, -3.500024, 91.700859, 2000.0);
	Func_TubeConnector(100, 2, TUBE, TBR_RED, 19661, 461.349884, 1389.870117, 83.558815, -3.491059, -4.107604, -178.549652, 2000.0);
	Func_TubeConnector(101, 0, TUBE, TBR_RED, 19649, 425.658660, 1394.053344, 86.428504, -3.491058, -4.107604, -178.549606, 2000.0);
	Func_TubeConnector(102, 2, TUBE, TBR_RED, 19661, 390.231689, 1387.781250, 88.660194, -4.099969, 3.500026, -88.299041, 2000.0);
	Func_TubeConnector(103, 0, TUBE, TBR_RED, 19649, 385.898010, 1352.037963, 86.863822, -4.099971, 3.500023, -88.299026, 2000.0);
	Func_TubeConnector(104, 1, TUBE, TBR_RED, 19665, 386.988647, 1307.937744, 83.810577, -4.099973, 3.500021, -88.298995, 2000.0);
	Func_TubeConnector(105, 0, TUBE, TBR_RED, 19687, 385.712646, 1292.402954, 59.583778, -4.099973, 3.500020, -88.298995, 2000.0);
	Func_TubeConnector(106, 2, TUBE, TBR_RED, 19661, 391.509857, 1269.442138, 57.799381, 3.491051, 4.107609, 1.450444, 2000.0);
	Func_TubeConnector(107, 2, TUBE, TBR_RED, 19661, 412.778076, 1270.050903, 56.272838, 4.099974, -3.500019, 91.700981, 2000.0);
	Func_TubeConnector(108, 0, TUBE, TBR_RED, 19649, 417.111724, 1305.794189, 58.069213, 4.099969, -3.500025, 91.700958, 2000.0);
	Func_TubeConnector(109, 0, TUBE, TBR_RED, 19649, 415.848480, 1355.685424, 61.113857, 4.099968, -3.500027, 91.700935, 2000.0);
	Func_TubeConnector(110, 2, TUBE, TBR_RED, 19661, 409.735504, 1391.119018, 63.659416, -3.491060, -4.107603, -178.549575, 2000.0);
	Func_TubeConnector(111, 0, TUBE, TBR_RED, 19649, 374.044281, 1395.302246, 66.529106, -3.491058, -4.107604, -178.549530, 2000.0);
	Func_TubeConnector(112, 1, TUBE, TBR_RED, 19667, 351.307250, 1398.225097, 100.344696, -3.491058, -4.107604, -178.549484, 2000.0);
	Func_TubeConnector(113, 0, TUBE, TBR_RED, 19649, 323.913787, 1404.897705, 70.780845, -3.491058, -4.107604, -178.549438, 2000.0);
	Func_TubeConnector(114, 0, TUBE, TBR_RED, 19649, 274.063720, 1403.417236, 74.355690, -3.491058, -4.107604, -178.549392, 2000.0);
	Func_TubeConnector(115, 0, TUBE, TBR_RED, 19649, 224.213668, 1401.936767, 77.930534, -3.491058, -4.107604, -178.549346, 2000.0);
	Func_TubeConnector(116, 0, TUBE, TBR_RED, 19649, 174.363616, 1400.456176, 81.505378, -3.491058, -4.107604, -178.549301, 2000.0);
	Func_TubeConnector(117, 0, TUBE, TBR_RED, 19649, 124.513565, 1398.975585, 85.080223, -3.491058, -4.107604, -178.549255, 2000.0);
	Func_TubeConnector(118, 1, TUBE, TBR_RED, 19662, 88.822418, 1403.135620, 87.948554, 3.491058, 4.107604, 1.450746, 2000.0);
	Func_TubeConnector(119, 0, TUBE, TBR_RED, 19649, 82.686370, 1438.567993, 90.495719, 4.099969, -3.500026, 91.701286, 2000.0);
	Func_TubeConnector(120, 1, TUBE, TBR_RED, 19662, 86.997001, 1474.311157, 92.293769, -4.099967, 3.500028, -88.298706, 2000.0);
	Func_TubeConnector(121, 0, TUBE, TBR_RED, 19649, 122.422866, 1480.606445, 90.063507, 3.491056, 4.107605, 1.450749, 2000.0);
	Func_TubeConnector(122, 0, TUBE, TBR_RED, 19687, 159.814208, 1481.717041, 87.382102, 3.491056, 4.107606, 1.450749, 2000.0);
	Func_TubeConnector(123, 1, TUBE, TBR_RED, 19662, 183.042846, 1477.186767, 85.407485, -3.491055, -4.107606, -178.549209, 2000.0);
	Func_TubeConnector(124, 0, TUBE, TBR_RED, 19687, 188.863128, 1454.223022, 83.621223, -4.099969, 3.500026, -88.298645, 2000.0);
	Func_TubeConnector(125, 1, TUBE, TBR_RED, 19667, 185.973937, 1439.710937, 114.947082, -4.099971, 3.500023, -88.298622, 2000.0);
	Func_TubeConnector(126, 0, TUBE, TBR_RED, 19689, 178.597442, 1429.127441, 85.326309, -4.099973, -41.499977, -88.298622, 2000.0);
	Func_TubeConnector(127, 0, TUBE, TBR_RED, 19688, 180.128738, 1407.706665, 97.807205, -4.099969, -41.499973, -88.298606, 2000.0);
	Func_TubeConnector(128, 2, TUBE, TBR_RED, 19661, 186.115112, 1384.925415, 98.453048, 3.491065, 4.107613, 1.450832, 2000.0);
	Func_TubeConnector(129, 0, TUBE, TBR_GREEN, 19649, 221.806350, 1380.742553, 95.583351, 3.491057, 4.107604, 1.450829, 2000.0);
	Func_TubeConnector(130, 1, TUBE, TBR_GREEN, 19662, 257.497497, 1376.582641, 92.715019, -3.491057, -4.107605, -178.549133, 2000.0);
	Func_TubeConnector(131, 1, TUBE, TBR_GREEN, 19662, 258.036590, 1355.297485, 91.416076, 4.099969, -3.500026, 91.701408, 2000.0);
	Func_TubeConnector(132, 0, TUBE, TBR_GREEN, 19649, 222.610748, 1349.002075, 93.646331, -3.491060, -4.107603, -178.549102, 2000.0);
	Func_TubeConnector(133, 0, TUBE, TBR_GREEN, 19649, 172.760696, 1347.521240, 97.221176, -3.491058, -4.107604, -178.549057, 2000.0);
	Func_TubeConnector(134, 1, TUBE, TBR_GREEN, 19651, 148.164886, 1362.072509, 109.933525, 3.491058, 4.107604, 1.450946, 2000.0);
	Func_TubeConnector(135, 0, TUBE, TBR_GREEN, 19651, 149.627792, 1360.894409, 129.845138, 3.491057, 4.107604, 1.450942, 2000.0);
	Func_TubeConnector(136, 2, TUBE, TBR_GREEN, 19661, 140.260971, 1338.885620, 139.275573, -4.099969, 3.500025, -88.298492, 2000.0);
	Func_TubeConnector(137, 0, TUBE, TBR_GREEN, 19649, 135.927627, 1303.142211, 137.479202, -4.099972, 3.500022, -88.298477, 2000.0);
	Func_TubeConnector(138, 2, TUBE, TBR_GREEN, 19661, 142.041000, 1267.708618, 134.933639, 3.491053, 4.107608, 1.450988, 2000.0);
	Func_TubeConnector(139, 0, TUBE, TBR_GREEN, 19649, 177.732254, 1263.525756, 132.063949, 3.491052, 4.107608, 1.450989, 2000.0);
	Func_TubeConnector(140, 0, TUBE, TBR_GREEN, 19649, 227.582305, 1265.006591, 128.489105, 3.491052, 4.107609, 1.450988, 2000.0);
	Func_TubeConnector(141, 0, TUBE, TBR_GREEN, 19649, 277.432342, 1266.487426, 124.914253, 3.491052, 4.107609, 1.450985, 2000.0);
	Func_TubeConnector(142, 1, TUBE, TBR_GREEN, 19662, 313.123535, 1262.327514, 122.045921, -3.491051, -4.107610, -178.548980, 2000.0);
	Func_TubeConnector(143, 0, TUBE, TBR_GREEN, 19687, 318.943908, 1239.363769, 120.259658, -4.099969, 3.500026, -88.298408, 2000.0);
	Func_TubeConnector(144, 1, TUBE, TBR_GREEN, 19667, 316.054779, 1224.851684, 151.585525, -4.099971, 3.500023, -88.298377, 2000.0);
	Func_TubeConnector(145, 0, TUBE, TBR_GREEN, 19649, 308.825134, 1201.616455, 118.770782, -4.099973, 3.500021, -88.298355, 2000.0);
	Func_TubeConnector(146, 2, TUBE, TBR_GREEN, 19661, 314.938568, 1166.182861, 116.225227, 3.491052, 4.107609, 1.451113, 2000.0);
	Func_TubeConnector(147, 2, TUBE, TBR_GREEN, 19661, 336.206787, 1166.791870, 114.698684, 4.099974, -3.500019, 91.701637, 2000.0);
	Func_TubeConnector(148, 0, TUBE, TBR_BLUE, 19649, 340.540039, 1202.535278, 116.495063, 4.099969, -3.500025, 91.701614, 2000.0);
	Func_TubeConnector(149, 0, TUBE, TBR_BLUE, 19649, 339.276214, 1252.426513, 119.539703, 4.099968, -3.500027, 91.701591, 2000.0);
	Func_TubeConnector(150, 0, TUBE, TBR_BLUE, 19649, 338.012420, 1302.317749, 122.584342, 4.099967, -3.500028, 91.701576, 2000.0);
	Func_TubeConnector(151, 1, TUBE, TBR_BLUE, 19662, 342.322875, 1338.060913, 124.382392, -4.099967, 3.500028, -88.298423, 2000.0);
	Func_TubeConnector(152, 0, TUBE, TBR_BLUE, 19649, 377.748718, 1344.356323, 122.152130, 3.491056, 4.107605, 1.451021, 2000.0);
	Func_TubeConnector(153, 2, TUBE, TBR_BLUE, 19661, 413.175628, 1350.628906, 119.920440, 4.099970, -3.500024, 91.701553, 2000.0);
	Func_TubeConnector(154, 2, TUBE, TBR_BLUE, 19661, 412.659301, 1371.914916, 121.217742, -3.491059, -4.107604, -178.548965, 2000.0);
	Func_TubeConnector(155, 0, TUBE, TBR_BLUE, 19649, 376.968048, 1376.097656, 124.087432, -3.491058, -4.107604, -178.548919, 2000.0);
	Func_TubeConnector(156, 0, TUBE, TBR_BLUE, 19649, 327.118011, 1374.616699, 127.662277, -3.491058, -4.107604, -178.548873, 2000.0);
	Func_TubeConnector(157, 1, TUBE, TBR_BLUE, 19667, 304.380920, 1377.539306, 161.477874, -3.491058, -4.107604, -178.548828, 2000.0);
	Func_TubeConnector(158, 0, TUBE, TBR_BLUE, 19649, 276.987396, 1384.211669, 131.914031, -3.491058, -4.107604, -178.548782, 2000.0);
	Func_TubeConnector(159, 0, TUBE, TBR_BLUE, 19649, 227.137359, 1382.730590, 135.488876, -3.491058, -4.107604, -178.548736, 2000.0);
	Func_TubeConnector(160, 1, TUBE, TBR_YELLOW, 19651, 202.541458, 1397.281616, 148.201248, 3.491058, 4.107604, 1.451267, 2000.0);
	Func_TubeConnector(161, 0, TUBE, TBR_RED, 19649, 178.750213, 1380.071411, 158.975357, -3.491058, -4.107604, -178.548690, 2000.0);
	Func_TubeConnector(162, 0, TUBE, TBR_RED, 19649, 128.900177, 1378.590332, 162.550201, -3.491058, -4.107604, -178.548645, 2000.0);
	Func_TubeConnector(163, 2, TUBE, TBR_RED, 19661, 93.473297, 1372.317626, 164.781875, -4.099969, 3.500026, -88.298072, 2000.0);
	Func_TubeConnector(164, 0, TUBE, TBR_RED, 19649, 89.140228, 1336.574218, 162.985504, -4.099971, 3.500023, -88.298042, 2000.0);
	Func_TubeConnector(165, 0, TUBE, TBR_RED, 19649, 90.404335, 1286.682983, 159.940872, -4.099973, 3.500021, -88.298011, 2000.0);
	Func_TubeConnector(166, 1, TUBE, TBR_RED, 19667, 87.831336, 1259.697998, 190.505569, -4.099973, 3.500020, -88.297988, 2000.0);
	Func_TubeConnector(167, 0, TUBE, TBR_RED, 19649, 80.601860, 1236.462768, 157.690826, -4.099974, 3.500020, -88.297950, 2000.0);
	Func_TubeConnector(168, 2, TUBE, TBR_RED, 19661, 86.715553, 1201.029296, 155.145263, 3.491051, 4.107610, 1.451512, 2000.0);
	Func_TubeConnector(169, 2, TUBE, TBR_RED, 19680, 122.406845, 1196.846801, 152.275573, 3.491050, 4.107610, 1.451509, 2000.0);
	Func_TubeConnector(170, 2, TUBE, TBR_RED, 19661, 157.583511, 1198.211303, 144.521057, 4.099974, 86.499977, 91.702056, 2000.0);
	Func_TubeConnector(171, 0, TUBE, TBR_RED, 19649, 160.209503, 1200.467651, 108.637786, 4.099969, 86.499969, 91.702033, 2000.0);
	Func_TubeConnector(172, 1, TUBE, TBR_RED, 19681, 159.906387, 1202.729370, 71.448822, -4.099986, -86.499938, -88.297958, 2000.0);
	Func_TubeConnector(173, 1, TUBE, TBR_RED, 19681, 175.820785, 1204.254516, 53.066741, 40.800365, -85.386054, -91.567108, 2000.0);
	Func_TubeConnector(174, 1, TUBE, TBR_RED, 19677, 212.712799, 1205.498779, 47.996372, -84.611183, 49.579093, 51.155822, 2000.0);
	Func_TubeConnector(175, 0, TUBE, TBR_RED, 19649, 262.562835, 1206.980102, 44.421524, 3.491111, 4.107604, 1.451497, 2000.0);
	Func_TubeConnector(176, 1, TUBE, TBR_RED, 19653, 288.255950, 1191.545532, 46.642860, -3.491108, -4.107601, -178.548477, 2000.0);
	Func_TubeConnector(177, 0, TUBE, TBR_RED, 19649, 313.144256, 1207.872192, 50.802482, 3.491113, 4.107596, 1.451536, 2000.0);
	Func_TubeConnector(178, 1, TUBE, TBR_RED, 19653, 338.837371, 1192.437744, 53.023822, -3.491113, -4.107596, -178.548431, 2000.0);
	Func_TubeConnector(179, 0, TUBE, TBR_RED, 19649, 363.725677, 1208.764526, 57.183444, 3.491113, 4.107596, 1.451581, 2000.0);
	Func_TubeConnector(180, 0, TUBE, TBR_RED, 19649, 413.575714, 1210.245849, 53.608604, 3.491113, 4.107596, 1.451582, 2000.0);
	Func_TubeConnector(181, 0, TUBE, TBR_RED, 19649, 463.425750, 1211.727172, 50.033767, 3.491113, 4.107596, 1.451582, 2000.0);
	Func_TubeConnector(182, 0, TUBE, TBR_RED, 19689, 500.669525, 1212.685791, 49.788948, 3.491113, -40.892402, -358.548400, 2000.0);
	Func_TubeConnector(183, 0, TUBE, TBR_RED, 19689, 519.104553, 1212.181396, 65.707962, 3.491113, -85.892402, -358.548370, 2000.0);
	Func_TubeConnector(184, 0, TUBE, TBR_RED, 19689, 520.886413, 1210.746459, 89.962532, 3.491119, -130.892395, -358.548339, 2000.0);
	Func_TubeConnector(185, 0, TUBE, TBR_RED, 19689, 504.971282, 1209.221313, 108.344665, 3.491109, -175.892395, -358.548339, 2000.0);
	Func_TubeConnector(186, 2, TUBE, TBR_RED, 19680, 468.075164, 1207.977050, 113.413063, 3.491127, -175.892364, 1.451654, 2000.0);
	Func_TubeConnector(187, 2, TUBE, TBR_RED, 19680, 418.225128, 1206.495605, 116.987937, 84.611106, -49.579254, -128.843841, 2000.0);
	Func_TubeConnector(188, 1, TUBE, TBR_RED, 19662, 382.533905, 1210.655151, 119.856315, 3.491153, 4.107666, 1.451675, 2000.0);
	Func_TubeConnector(189, 0, TUBE, TBR_RED, 19649, 376.397308, 1246.087402, 122.403541, 4.100028, -3.500121, 91.702224, 2000.0);
	Func_TubeConnector(190, 0, TUBE, TBR_RED, 19687, 375.448974, 1283.509643, 124.687316, 4.100028, -3.500121, 91.702201, 2000.0);
	Func_TubeConnector(191, 1, TUBE, TBR_RED, 19662, 380.075103, 1306.780151, 125.724235, -4.100029, 3.500119, -88.297813, 2000.0);
	Func_TubeConnector(192, 0, TUBE, TBR_RED, 19649, 415.500885, 1313.076049, 123.493942, 3.491147, 4.107667, 1.451623, 2000.0);
	Func_TubeConnector(193, 2, TUBE, TBR_RED, 19661, 450.927734, 1319.348999, 121.262222, 4.100031, -3.500116, 91.702171, 2000.0);
	Func_TubeConnector(194, 0, TUBE, TBR_RED, 19649, 455.260650, 1355.092407, 123.058654, 4.100029, -3.500119, 91.702163, 2000.0);
	Func_TubeConnector(195, 1, TUBE, TBR_RED, 19667, 462.490173, 1378.327636, 155.874420, 4.100028, -3.500121, 91.702156, 2000.0);
	Func_TubeConnector(196, 0, TUBE, TBR_RED, 19649, 465.063140, 1405.312622, 125.310737, 4.100028, -3.500121, 91.702133, 2000.0);
	Func_TubeConnector(197, 1, TUBE, TBR_RED, 19667, 472.292663, 1428.547851, 158.126495, 4.100028, -3.500121, 91.702117, 2000.0);
	Func_TubeConnector(198, 0, TUBE, TBR_RED, 19649, 474.865661, 1455.532836, 127.562812, 4.100028, -3.500121, 91.702095, 2000.0);
	Func_TubeConnector(199, 1, TUBE, TBR_RED, 19667, 482.095214, 1478.768066, 160.378570, 4.100028, -3.500121, 91.702072, 2000.0);
	Func_TubeConnector(200, 1, TUBE, TBR_RED, 19662, 490.242553, 1491.604980, 128.568283, -4.100029, 3.500119, -88.297943, 2000.0);
	Func_TubeConnector(201, 1, TUBE, TBR_RED, 19662, 511.510162, 1492.236938, 127.043113, -3.491147, -4.107667, -178.548477, 2000.0);
	Func_TubeConnector(202, 0, TUBE, TBR_GREEN, 19649, 517.646667, 1456.804687, 124.495887, -4.100029, 3.500119, -88.297889, 2000.0);
	Func_TubeConnector(203, 0, TUBE, TBR_GREEN, 19649, 518.910888, 1406.913452, 121.451171, -4.100031, 3.500116, -88.297866, 2000.0);
	Func_TubeConnector(204, 0, TUBE, TBR_GREEN, 19649, 520.175170, 1357.022216, 118.406455, -4.100033, 3.500115, -88.297836, 2000.0);
	Func_TubeConnector(205, 1, TUBE, TBR_GREEN, 19662, 515.865051, 1321.278930, 116.608360, 4.100035, -3.500113, 91.702133, 2000.0);
	Func_TubeConnector(206, 2, TUBE, TBR_GREEN, 19661, 494.866180, 1310.192016, 117.495208, -4.100031, 3.500118, -88.297859, 2000.0);
	Func_TubeConnector(207, 0, TUBE, TBR_GREEN, 19687, 490.217285, 1286.917114, 116.459709, -4.100032, 3.500115, -88.297836, 2000.0);
	Func_TubeConnector(208, 1, TUBE, TBR_GREEN, 19662, 485.591125, 1263.646606, 115.422798, 4.100034, -3.500114, 91.702140, 2000.0);
	Func_TubeConnector(209, 0, TUBE, TBR_GREEN, 19649, 450.165344, 1257.350830, 117.653083, -3.491148, -4.107667, -178.548400, 2000.0);
	Func_TubeConnector(210, 1, TUBE, TBR_GREEN, 19665, 406.053680, 1256.062011, 120.453865, -3.491150, -4.107665, -178.548355, 2000.0);
	Func_TubeConnector(211, 0, TUBE, TBR_GREEN, 19649, 374.997985, 1256.562133, 99.363723, -3.491150, -4.107665, -178.548309, 2000.0);
	Func_TubeConnector(212, 0, TUBE, TBR_GREEN, 19649, 325.147949, 1255.080688, 102.938621, -3.491150, -4.107665, -178.548278, 2000.0);
	Func_TubeConnector(213, 1, TUBE, TBR_GREEN, 19662, 289.456726, 1259.240112, 105.806999, 3.491150, 4.107665, 1.451733, 2000.0);
	Func_TubeConnector(214, 0, TUBE, TBR_GREEN, 19649, 283.320068, 1294.672363, 108.354225, 4.100029, -3.500119, 91.702285, 2000.0);
	Func_TubeConnector(215, 1, TUBE, TBR_GREEN, 19651, 299.286865, 1319.500610, 118.694480, -4.100029, 3.500119, -88.297721, 2000.0);
	Func_TubeConnector(216, 0, TUBE, TBR_GREEN, 19687, 283.833953, 1330.912475, 130.549407, 4.100031, -3.500116, 91.702262, 2000.0);
	Func_TubeConnector(217, 2, TUBE, TBR_GREEN, 19661, 278.036224, 1353.873168, 132.333847, -3.491150, -4.107665, -178.548278, 2000.0);
	Func_TubeConnector(218, 0, TUBE, TBR_GREEN, 19649, 242.344924, 1358.055419, 135.203582, -3.491150, -4.107665, -178.548248, 2000.0);
	Func_TubeConnector(219, 1, TUBE, TBR_GREEN, 19667, 219.607879, 1360.977661, 169.019210, -3.491150, -4.107665, -178.548202, 2000.0);
	Func_TubeConnector(220, 0, TUBE, TBR_GREEN, 19649, 192.214263, 1367.649780, 139.455398, -3.491150, -4.107665, -178.548171, 2000.0);
	Func_TubeConnector(221, 1, TUBE, TBR_GREEN, 19662, 156.523040, 1371.809082, 142.323776, 3.491150, 4.107665, 1.451842, 2000.0);
	Func_TubeConnector(222, 2, TUBE, TBR_GREEN, 19661, 145.537200, 1392.780029, 144.371658, -3.491150, -4.107665, -178.548126, 2000.0);
	Func_TubeConnector(223, 2, TUBE, TBR_GREEN, 19661, 124.269004, 1392.170776, 145.898208, -4.100029, 3.500119, -88.297538, 2000.0);
	Func_TubeConnector(224, 1, TUBE, TBR_GREEN, 19667, 116.099166, 1379.333618, 177.711151, -4.100031, 3.500116, -88.297523, 2000.0);
	Func_TubeConnector(225, 0, TUBE, TBR_GREEN, 19649, 108.869827, 1356.098388, 144.896392, -4.100033, 3.500115, -88.297500, 2000.0);
	Func_TubeConnector(226, 0, TUBE, TBR_GREEN, 19649, 110.134407, 1306.207153, 141.851684, -4.100034, 3.500114, -88.297470, 2000.0);
	Func_TubeConnector(227, 0, TUBE, TBR_GREEN, 19649, 111.398986, 1256.316040, 138.806976, -4.100035, 3.500113, -88.297462, 2000.0);
	Func_TubeConnector(228, 0, TUBE, TBR_GREEN, 19649, 112.663589, 1206.424926, 135.762268, -4.100035, 3.500113, -88.297431, 2000.0);
	Func_TubeConnector(229, 1, TUBE, TBR_GREEN, 19667, 110.090888, 1179.439941, 166.326950, -4.100035, 3.500112, -88.297409, 2000.0);
	Func_TubeConnector(230, 0, TUBE, TBR_GREEN, 19649, 102.861579, 1156.204711, 133.512191, -4.100035, 3.500112, -88.297409, 2000.0);
	Func_TubeConnector(231, 2, TUBE, TBR_GREEN, 19661, 108.975585, 1120.771240, 130.966567, 3.491143, 4.107671, 1.452015, 2000.0);
	Func_TubeConnector(232, 0, TUBE, TBR_GREEN, 19649, 144.666915, 1116.589233, 128.096817, 3.491143, 4.107671, 1.452015, 2000.0);
	Func_TubeConnector(233, 0, TUBE, TBR_GREEN, 19649, 194.516937, 1118.070922, 124.521911, 3.491143, 4.107671, 1.452015, 2000.0);
	Func_TubeConnector(234, 0, TUBE, TBR_GREEN, 19649, 244.366958, 1119.552612, 120.947006, 3.491143, 4.107671, 1.452015, 2000.0);
	Func_TubeConnector(235, 1, TUBE, TBR_GREEN, 19651, 270.425964, 1103.823852, 128.146209, -3.491143, -4.107671, -178.547958, 2000.0);
	Func_TubeConnector(236, 0, TUBE, TBR_GREEN, 19649, 295.679840, 1119.856323, 137.283706, 3.491150, 4.107665, 1.452053, 2000.0);
	Func_TubeConnector(237, 0, TUBE, TBR_GREEN, 19649, 345.529876, 1121.338134, 133.708816, 3.491150, 4.107665, 1.452053, 2000.0);
	Func_TubeConnector(238, 1, TUBE, TBR_BLUE, 19667, 372.923583, 1114.666015, 163.273620, 3.491150, 4.107665, 1.452053, 2000.0);
	Func_TubeConnector(239, 0, TUBE, TBR_BLUE, 19649, 395.660705, 1111.743774, 129.458984, 3.491150, 4.107665, 1.452053, 2000.0);
	Func_TubeConnector(240, 0, TUBE, TBR_BLUE, 19649, 445.510711, 1113.225585, 125.884086, 3.491150, 4.107665, 1.452053, 2000.0);
	Func_TubeConnector(241, 1, TUBE, TBR_BLUE, 19665, 489.569396, 1114.557495, 122.361900, 3.491150, 4.107665, 1.452053, 2000.0);
	Func_TubeConnector(242, 2, TUBE, TBR_BLUE, 19661, 502.793365, 1121.593872, 98.405174, 4.100029, -3.500119, 91.702598, 2000.0);
	Func_TubeConnector(243, 0, TUBE, TBR_BLUE, 19687, 507.442077, 1144.868896, 99.440681, 4.100028, -3.500121, 91.702583, 2000.0);
	Func_TubeConnector(244, 2, TUBE, TBR_BLUE, 19661, 501.644226, 1167.829589, 101.225128, -3.491152, -4.107664, -178.547958, 2000.0);
	Func_TubeConnector(245, 0, TUBE, TBR_BLUE, 19649, 465.952880, 1172.011596, 104.094863, -3.491150, -4.107665, -178.547927, 2000.0);
	Func_TubeConnector(246, 0, TUBE, TBR_BLUE, 19687, 428.561584, 1170.900146, 106.776306, -3.491150, -4.107665, -178.547882, 2000.0);
	Func_TubeConnector(247, 0, TUBE, TBR_BLUE, 19649, 391.174072, 1169.788696, 109.457481, -3.491150, -4.107665, -178.547851, 2000.0);
	Func_TubeConnector(248, 2, TUBE, TBR_BLUE, 19661, 355.747283, 1163.515502, 111.689201, -4.100029, 3.500119, -88.297271, 2000.0);
	Func_TubeConnector(249, 1, TUBE, TBR_BLUE, 19662, 345.840393, 1141.919799, 111.139381, 4.100031, -3.500116, 91.702720, 2000.0);
	Func_TubeConnector(250, 0, TUBE, TBR_BLUE, 19649, 310.414703, 1135.623657, 113.369667, -3.491150, -4.107665, -178.547821, 2000.0);
	Func_TubeConnector(251, 1, TUBE, TBR_BLUE, 19667, 287.677673, 1138.545654, 147.185302, -3.491150, -4.107665, -178.547775, 2000.0);
	Func_TubeConnector(252, 1, TUBE, TBR_BLUE, 19662, 274.442779, 1150.858520, 116.914978, 3.491150, 4.107665, 1.452238, 2000.0);
	Func_TubeConnector(253, 0, TUBE, TBR_BLUE, 19649, 268.305816, 1186.290771, 119.462203, 4.100029, -3.500119, 91.702781, 2000.0);
	Func_TubeConnector(254, 2, TUBE, TBR_BLUE, 19661, 262.191680, 1221.724243, 122.007827, -3.491152, -4.107664, -178.547760, 2000.0);
	Func_TubeConnector(255, 1, TUBE, TBR_BLUE, 19665, 232.238693, 1226.098999, 124.103446, -3.491150, -4.107665, -178.547714, 2000.0);
	Func_TubeConnector(256, 0, TUBE, TBR_BLUE, 19683, 213.619659, 1227.018432, 101.302459, -3.491150, -4.107665, -178.547668, 2000.0);
	Func_TubeConnector(257, 0, TUBE, TBR_BLUE, 19683, 189.140396, 1226.684570, 96.602813, -3.491150, 10.892334, -178.547622, 2000.0);
	Func_TubeConnector(258, 0, TUBE, TBR_BLUE, 19683, 166.703689, 1226.778564, 85.739212, -3.491148, 25.892330, -178.547576, 2000.0);
	Func_TubeConnector(259, 0, TUBE, TBR_BLUE, 19683, 147.838562, 1227.294311, 69.451988, -3.491149, 40.892333, -178.547561, 2000.0);
	Func_TubeConnector(260, 0, TUBE, TBR_BLUE, 19689, 131.312576, 1228.007690, 50.897926, -3.491144, 10.892330, -178.547546, 2000.0);
	Func_TubeConnector(261, 0, TUBE, TBR_BLUE, 19686, 107.413345, 1227.781372, 44.675331, 3.491150, -10.892330, 1.452459, 2000.0);
	Func_TubeConnector(262, 2, TUBE, TBR_BLUE, 19661, 84.428802, 1221.904296, 45.194843, -4.100031, 3.500117, -88.296951, 2000.0);
	Func_TubeConnector(263, 2, TUBE, TBR_BLUE, 19661, 84.945686, 1200.618408, 43.897506, 3.491146, 4.107668, 1.452510, 2000.0);
	Func_TubeConnector(264, 0, TUBE, TBR_BLUE, 19649, 120.637031, 1196.436645, 41.027770, 3.491147, 4.107668, 1.452515, 2000.0);
	Func_TubeConnector(265, 0, TUBE, TBR_BLUE, 19649, 170.487045, 1197.918823, 37.452869, 3.491147, 4.107676, 1.452514, 2000.0);
	Func_TubeConnector(266, 2, TUBE, TBR_BLUE, 19661, 205.913787, 1204.192260, 35.221149, 4.100035, -3.500113, 91.703071, 2000.0);
	Func_TubeConnector(267, 0, TUBE, TBR_BLUE, 19649, 210.246154, 1239.935791, 37.017578, 4.100031, -3.500118, 91.703056, 2000.0);
	Func_TubeConnector(268, 0, TUBE, TBR_BLUE, 19649, 208.981109, 1289.826904, 40.062297, 4.100029, -3.500119, 91.703041, 2000.0);
	Func_TubeConnector(269, 1, TUBE, TBR_BLUE, 19662, 213.290634, 1325.570190, 41.860393, -4.100029, 3.500119, -88.296966, 2000.0);
	Func_TubeConnector(270, 0, TUBE, TBR_BLUE, 19649, 248.716308, 1331.866577, 39.630104, 3.491147, 4.107667, 1.452479, 2000.0);
	Func_TubeConnector(271, 2, TUBE, TBR_BLUE, 19661, 284.143066, 1338.140014, 37.398387, 4.100031, -3.500116, 91.703025, 2000.0);
	Func_TubeConnector(272, 1, TUBE, TBR_BLUE, 19662, 294.049835, 1359.735717, 37.948215, -4.100029, 3.500119, -88.296966, 2000.0);
	Func_TubeConnector(273, 0, TUBE, TBR_BLUE, 19649, 329.475494, 1366.032104, 35.717926, 3.491147, 4.107667, 1.452479, 2000.0);
	Func_TubeConnector(274, 0, TUBE, TBR_BLUE, 19688, 366.364654, 1367.276977, 30.646486, 3.491148, 4.107667, 1.452479, 2000.0);
	Func_TubeConnector(275, 0, TUBE, TBR_BLUE, 19689, 385.952514, 1368.703247, 15.415170, 3.491148, 4.107666, -358.547485, 2000.0);
	Func_TubeConnector(276, 2, TUBE, TBR_BLUE, 19661, 408.417724, 1374.759399, 11.689388, 4.100026, -3.500123, 91.703063, 2000.0);
	Func_TubeConnector(277, 2, TUBE, TBR_BLUE, 19661, 407.900848, 1396.045288, 12.986725, -3.491153, -4.107663, -178.547470, 2000.0);
	Func_TubeConnector(278, 1, TUBE, TBR_BLUE, 19662, 386.368133, 1405.868041, 15.149936, 3.491150, 4.107665, 1.452537, 2000.0);
	Func_TubeConnector(279, 0, TUBE, TBR_BLUE, 19646, 380.737030, 1421.343627, 16.479276, 4.100029, -3.500119, 91.703086, 2000.0);
	Func_TubeConnector(280, 1, TUBE, TBR_BLUE, 19662, 385.552581, 1437.130493, 17.059486, -4.100029, 3.500119, -88.296913, 2000.0);
	Func_TubeConnector(281, 0, TUBE, TBR_BLUE, 19649, 420.978240, 1443.426879, 14.829196, 3.491147, 4.107667, 1.452539, 2000.0);
	Func_TubeConnector(282, 0, TUBE, TBR_BLUE, 19649, 470.828247, 1444.909057, 11.254297, 3.491148, 4.107667, 1.452546, 2000.0);
	Func_TubeConnector(283, 1, TUBE, TBR_BLUE, 19667, 498.222015, 1438.237182, 40.819099, 3.491148, 4.107667, 1.452546, 2000.0);
	Func_TubeConnector(284, 0, TUBE, TBR_BLUE, 19686, 508.522491, 1434.895385, 8.715311, -3.491148, -4.107667, -178.547424, 2000.0);
	Func_TubeConnector(285, 0, TUBE, TBR_BLUE, 19686, 532.997802, 1435.229248, 13.414536, -3.491150, 10.892334, -178.547393, 2000.0);
	Func_TubeConnector(286, 0, TUBE, TBR_BLUE, 19686, 555.430786, 1435.135253, 24.276716, -3.491148, 25.892330, -178.547363, 2000.0);
	Func_TubeConnector(287, 0, TUBE, TBR_BLUE, 19649, 584.313415, 1434.411376, 48.140583, 3.491147, -40.892333, 1.452648, 2000.0);
	Func_TubeConnector(288, 0, TUBE, TBR_BLUE, 19649, 622.148864, 1433.376953, 80.811828, 3.491154, -40.892330, 1.452655, 2000.0);
	Func_TubeConnector(289, 0, TUBE, TBR_BLUE, 19688, 651.865356, 1432.759765, 103.275856, 3.491163, -40.892330, 1.452659, 2000.0);
	Func_TubeConnector(290, 0, TUBE, TBR_BLUE, 19669, 678.277770, 1433.397460, 103.800552, -3.491184, -4.107673, -178.547332, 2000.0);

	//COVERS:
	Func_TubeConnector(11, 1, COVER, TBR_GREEN, 19662, 419.419067, 1151.710571, 69.012634, 3.490997, 184.107604, 1.449380, 2000.0);
	Func_TubeConnector(12, 1, COVER, TBR_GREEN, 19662, 398.151428, 1151.079345, 70.537780, -4.099970, 183.499969, -88.300079, 2000.0);
	Func_TubeConnector(14, 2, COVER, TBR_GREEN, 19661, 385.903900, 1221.945678, 75.630432, 4.099968, 176.500030, 91.699913, 2000.0);
	Func_TubeConnector(19, 2, COVER, TBR_BLUE, 19661, 266.118255, 1228.276245, 104.895172, -3.490995, 175.892395, -178.550476, 2000.0);
	Func_TubeConnector(20, 2, COVER, TBR_BLUE, 19661, 266.634002, 1206.990234, 103.597892, -4.099970, 183.499969, -88.299934, 2000.0);
	Func_TubeConnector(25, 2, COVER, TBR_YELLOW, 19661, 487.302398, 1213.516967, 87.771980, 3.490998, 184.107604, 1.449486, 2000.0);
	Func_TubeConnector(27, 2, COVER, TBR_YELLOW, 19661, 485.524230, 1284.694091, 92.113845, 4.099968, 176.500030, 91.700035, 2000.0);
	Func_TubeConnector(36, 2, COVER, TBR_PURPLE, 19661, 380.904357, 1295.940063, 36.520786, 3.491055, 184.107604, 1.449594, 2000.0);
	Func_TubeConnector(38, 1, COVER, TBR_PURPLE, 19662, 389.549896, 1367.426513, 40.115207, -3.491055, 175.892395, -178.550369, 2000.0);
	Func_TubeConnector(40, 1, COVER, TBR_PURPLE, 19662, 460.666931, 1369.560302, 35.016616, 4.099968, 176.499969, 91.700172, 2000.0);
	Func_TubeConnector(43, 1, COVER, TBR_PURPLE, 19662, 463.753601, 1248.493408, 27.626771, 3.491058, 184.107604, 1.449663, 2000.0);
	Func_TubeConnector(46, 1, COVER, TBR_PURPLE, 19662, 342.786468, 1244.879638, 36.300209, -4.099968, 183.500030, -88.299682, 2000.0);
	Func_TubeConnector(47, 2, COVER, TBR_RED, 19661, 331.801391, 1265.850952, 38.348056, 4.099969, 176.499969, 91.700340, 2000.0);
	Func_TubeConnector(49, 1, COVER, TBR_RED, 19662, 260.419158, 1274.195068, 44.086078, -4.099969, 183.500030, -88.299591, 2000.0);
	Func_TubeConnector(50, 1, COVER, TBR_RED, 19662, 259.880432, 1295.480224, 45.385017, -3.491055, 175.892395, -178.550094, 2000.0);
	Func_TubeConnector(52, 2, COVER, TBR_RED, 19661, 330.733428, 1308.046875, 40.923069, 3.491058, 184.107604, 1.449840, 2000.0);
	Func_TubeConnector(55, 2, COVER, TBR_GREEN, 19661, 330.417877, 1378.045654, 65.176597, 4.099969, 176.499969, 91.700431, 2000.0);
	Func_TubeConnector(56, 2, COVER, TBR_GREEN, 19661, 309.149658, 1377.437133, 66.703132, -3.491055, 175.892395, -178.550033, 2000.0);
	Func_TubeConnector(59, 1, COVER, TBR_GREEN, 19662, 301.767395, 1256.059448, 60.064083, 3.491058, 184.107604, 1.449953, 2000.0);
	Func_TubeConnector(61, 1, COVER, TBR_GREEN, 19662, 230.650360, 1253.925170, 65.162673, -4.099969, 183.500030, -88.299438, 2000.0);
	Func_TubeConnector(66, 2, COVER, TBR_GREEN, 19661, 213.548171, 1449.573486, 54.229522, 4.099969, 176.499969, 91.700508, 2000.0);
	Func_TubeConnector(67, 2, COVER, TBR_GREEN, 19661, 192.279953, 1448.964965, 55.756061, -3.491055, 175.892395, -178.549957, 2000.0);
	Func_TubeConnector(71, 1, COVER, TBR_GREEN, 19662, 112.517868, 1375.344116, 57.260234, -4.099969, 183.500030, -88.299392, 2000.0);
	Func_TubeConnector(73, 1, COVER, TBR_BLUE, 19662, 110.693313, 1446.519653, 61.605445, -3.491055, 175.892395, -178.549880, 2000.0);
	Func_TubeConnector(83, 1, COVER, TBR_BLUE, 19662, 360.958892, 1439.224731, 103.054504, 4.099969, 176.499969, 91.700767, 2000.0);
	Func_TubeConnector(88, 2, COVER, TBR_YELLOW, 19661, 374.600738, 1246.363891, 66.876197, -4.099974, 183.500015, -88.299179, 2000.0);
	Func_TubeConnector(93, 2, COVER, TBR_PURPLE, 19661, 545.699462, 1240.337280, 53.950202, 3.491057, 184.107604, 1.450215, 2000.0);
	Func_TubeConnector(94, 2, COVER, TBR_PURPLE, 19661, 545.183471, 1261.623291, 55.247509, 4.099969, 176.499969, 91.700798, 2000.0);
	Func_TubeConnector(96, 1, COVER, TBR_PURPLE, 19662, 473.801116, 1269.966796, 60.985530, -4.099969, 183.500030, -88.299140, 2000.0);
	Func_TubeConnector(100, 2, COVER, TBR_RED, 19661, 461.752166, 1389.546142, 89.034507, 4.099969, 176.499969, 91.700889, 2000.0);
	Func_TubeConnector(102, 2, COVER, TBR_RED, 19661, 390.634002, 1387.457275, 94.135887, -3.491055, 175.892395, -178.549545, 2000.0);
	Func_TubeConnector(106, 2, COVER, TBR_RED, 19661, 391.912139, 1269.118164, 63.275074, -4.099974, 183.500015, -88.298995, 2000.0);
	Func_TubeConnector(107, 2, COVER, TBR_RED, 19661, 413.180389, 1269.726928, 61.748531, 3.491057, 184.107604, 1.450420, 2000.0);
	Func_TubeConnector(110, 2, COVER, TBR_RED, 19661, 410.137786, 1390.795043, 69.135108, 4.099969, 176.499969, 91.700965, 2000.0);
	Func_TubeConnector(118, 1, COVER, TBR_RED, 19662, 89.224716, 1402.811645, 93.424247, -4.099969, 183.500030, -88.298690, 2000.0);
	Func_TubeConnector(120, 1, COVER, TBR_RED, 19662, 87.399299, 1473.987182, 97.769462, -3.491055, 175.892395, -178.549209, 2000.0);
	Func_TubeConnector(128, 2, COVER, TBR_RED, 19661, 186.517410, 1384.601440, 103.928741, -4.099969, 183.500030, -88.298606, 2000.0);
	Func_TubeConnector(130, 1, COVER, TBR_GREEN, 19662, 257.899780, 1376.258666, 98.190711, 4.099969, 176.499969, 91.701408, 2000.0);
	Func_TubeConnector(131, 1, COVER, TBR_GREEN, 19662, 258.438903, 1354.973510, 96.891769, 3.491060, 184.107604, 1.450860, 2000.0);
	Func_TubeConnector(136, 2, COVER, TBR_GREEN, 19661, 140.663269, 1338.561645, 144.751266, -3.491054, 175.892395, -178.548995, 2000.0);
	Func_TubeConnector(138, 2, COVER, TBR_GREEN, 19661, 142.443298, 1267.384643, 140.409332, -4.099973, 183.500015, -88.298446, 2000.0);
	Func_TubeConnector(142, 1, COVER, TBR_GREEN, 19662, 313.525817, 1262.003540, 127.521614, 4.099969, 176.499969, 91.701560, 2000.0);
	Func_TubeConnector(146, 2, COVER, TBR_GREEN, 19661, 315.340850, 1165.858886, 121.700920, -4.099974, 183.500015, -88.298324, 2000.0);
	Func_TubeConnector(147, 2, COVER, TBR_GREEN, 19661, 336.609100, 1166.467895, 120.174377, 3.491057, 184.107604, 1.451079, 2000.0);
	Func_TubeConnector(151, 1, COVER, TBR_BLUE, 19662, 342.725189, 1337.736938, 129.858078, -3.491055, 175.892395, -178.548950, 2000.0);
	Func_TubeConnector(153, 2, COVER, TBR_BLUE, 19661, 413.577941, 1350.304931, 125.396133, 3.491059, 184.107604, 1.450994, 2000.0);
	Func_TubeConnector(154, 2, COVER, TBR_BLUE, 19661, 413.061584, 1371.590942, 126.693435, 4.099969, 176.499969, 91.701576, 2000.0);
	Func_TubeConnector(163, 2, COVER, TBR_RED, 19661, 93.875595, 1371.993652, 170.257568, -3.491055, 175.892395, -178.548568, 2000.0);
	Func_TubeConnector(168, 2, COVER, TBR_RED, 19661, 87.117851, 1200.705322, 160.620956, -4.099974, 183.500015, -88.297927, 2000.0);
	Func_TubeConnector(170, 2, COVER, TBR_RED, 19661, 157.444458, 1203.699340, 144.855972, -84.611213, 229.579559, 51.156288, 2000.0);
	Func_TubeConnector(172, 1, COVER, TBR_RED, 19681, 159.767333, 1208.217407, 71.783737, 40.800365, 94.613937, -91.567138, 2000.0);
	Func_TubeConnector(173, 1, COVER, TBR_RED, 19681, 175.681732, 1209.742553, 53.401657, 84.611183, 130.420898, -128.844161, 2000.0);
	Func_TubeConnector(188, 1, COVER, TBR_RED, 19662, 382.936187, 1210.331176, 125.332008, -4.100028, 183.500122, -88.297752, 2000.0);
	Func_TubeConnector(191, 1, COVER, TBR_RED, 19662, 380.477416, 1306.456298, 131.199920, -3.491147, 175.892333, -178.548355, 2000.0);
	Func_TubeConnector(193, 2, COVER, TBR_RED, 19661, 451.330047, 1319.025146, 126.737915, 3.491150, 184.107666, 1.451608, 2000.0);
	Func_TubeConnector(200, 1, COVER, TBR_RED, 19662, 490.644866, 1491.281127, 134.043975, -3.491147, 175.892333, -178.548477, 2000.0);
	Func_TubeConnector(201, 1, COVER, TBR_RED, 19662, 511.912445, 1491.912963, 132.518798, 4.100029, 176.499877, 91.702079, 2000.0);
	Func_TubeConnector(205, 1, COVER, TBR_GREEN, 19662, 516.267333, 1320.955078, 122.084053, 3.491148, 184.107666, 1.451567, 2000.0);
	Func_TubeConnector(206, 2, COVER, TBR_GREEN, 19661, 495.268493, 1309.868164, 122.970901, -3.491146, 175.892333, -178.548385, 2000.0);
	Func_TubeConnector(208, 1, COVER, TBR_GREEN, 19662, 485.993438, 1263.322753, 120.898490, 3.491148, 184.107666, 1.451567, 2000.0);
	Func_TubeConnector(213, 1, COVER, TBR_GREEN, 19662, 289.859008, 1258.916137, 111.282691, -4.100029, 183.500122, -88.297691, 2000.0);
	Func_TubeConnector(217, 2, COVER, TBR_GREEN, 19661, 278.438507, 1353.549194, 137.809539, 4.100029, 176.499877, 91.702285, 2000.0);
	Func_TubeConnector(221, 1, COVER, TBR_GREEN, 19662, 156.925354, 1371.485107, 147.799468, -4.100029, 183.500122, -88.297584, 2000.0);
	Func_TubeConnector(222, 2, COVER, TBR_GREEN, 19661, 145.939514, 1392.456054, 149.847351, 4.100029, 176.499877, 91.702438, 2000.0);
	Func_TubeConnector(223, 2, COVER, TBR_GREEN, 19661, 124.671318, 1391.846923, 151.373901, -3.491147, 175.892333, -178.548080, 2000.0);
	Func_TubeConnector(231, 2, COVER, TBR_GREEN, 19661, 109.377899, 1120.447265, 136.442260, -4.100035, 183.500106, -88.297409, 2000.0);
	Func_TubeConnector(242, 2, COVER, TBR_BLUE, 19661, 503.195678, 1121.270019, 103.880867, 3.491152, 184.107666, 1.452036, 2000.0);
	Func_TubeConnector(248, 2, COVER, TBR_BLUE, 19661, 356.149597, 1163.191650, 117.164894, -3.491147, 175.892333, -178.547805, 2000.0);
	Func_TubeConnector(249, 1, COVER, TBR_BLUE, 19662, 346.242706, 1141.595947, 116.615074, 3.491150, 184.107666, 1.452159, 2000.0);
	Func_TubeConnector(252, 1, COVER, TBR_BLUE, 19662, 274.845062, 1150.534545, 122.390670, -4.100029, 183.500122, -88.297187, 2000.0);
	Func_TubeConnector(254, 2, COVER, TBR_BLUE, 19661, 262.593963, 1221.400268, 127.483520, 4.100029, 176.499877, 91.702804, 2000.0);
	Func_TubeConnector(262, 2, COVER, TBR_BLUE, 19661, 84.831115, 1221.580444, 50.670536, -3.491146, 175.892333, -178.547470, 2000.0);
	Func_TubeConnector(263, 2, COVER, TBR_BLUE, 19661, 85.347999, 1200.294433, 49.373199, -4.100032, 183.500122, -88.296913, 2000.0);
	Func_TubeConnector(264, 0, COVER, TBR_BLUE, 19649, 121.039344, 1196.112670, 46.503463, 3.491147, 184.107666, 1.452515, 2000.0);
	Func_TubeConnector(266, 2, COVER, TBR_BLUE, 19661, 206.316101, 1203.868408, 40.696842, 3.491148, 184.107666, 1.452505, 2000.0);
	Func_TubeConnector(269, 1, COVER, TBR_BLUE, 19662, 213.692947, 1325.246337, 47.336086, -3.491147, 175.892333, -178.547500, 2000.0);
	Func_TubeConnector(271, 2, COVER, TBR_BLUE, 19661, 284.545379, 1337.816162, 42.874080, 3.491150, 184.107666, 1.452466, 2000.0);
	Func_TubeConnector(272, 1, COVER, TBR_BLUE, 19662, 294.452148, 1359.411865, 43.423908, -3.491147, 175.892333, -178.547500, 2000.0);
	Func_TubeConnector(276, 2, COVER, TBR_BLUE, 19661, 408.820037, 1374.435546, 17.165079, 3.491153, 184.107666, 1.452501, 2000.0);
	Func_TubeConnector(277, 2, COVER, TBR_BLUE, 19661, 408.303131, 1395.721313, 18.462417, 4.100029, 176.499877, 91.703086, 2000.0);
	Func_TubeConnector(278, 1, COVER, TBR_BLUE, 19662, 386.770416, 1405.544067, 20.625627, -4.100029, 183.500122, -88.296890, 2000.0);
	Func_TubeConnector(280, 1, COVER, TBR_BLUE, 19662, 385.954895, 1436.806640, 22.535177, -3.491147, 175.892333, -178.547439, 2000.0);


	//LIGHTS:
	Func_TubeConnector(0, 0, LIGHT, -1, 19672, 426.707733, 1337.700073, 19.253673, 4.099987, 11.500003, 91.699821, 2000.0);
	Func_TubeConnector(1, 0, LIGHT, -1, 19672, 426.003112, 1354.963500, 16.571561, -4.099980, -1.500005, -88.300117, 2000.0);
	Func_TubeConnector(2, 0, LIGHT, -1, 19672, 425.563629, 1378.190673, 20.056091, -4.099987, 23.500003, -88.300094, 2000.0);
	Func_TubeConnector(3, 0, LIGHT, -1, 19672, 426.370513, 1390.850585, 36.547031, -4.099973, 68.500000, -88.300094, 2000.0);
	Func_TubeConnector(4, 0, LIGHT, -1, 19672, 427.926116, 1388.135864, 57.116138, -4.099967, 113.499961, -88.300102, 2000.0);
	Func_TubeConnector(5, 0, LIGHT, -1, 19672, 429.319213, 1371.636718, 69.714302, -4.099981, 158.499969, -88.300109, 2000.0);
	Func_TubeConnector(6, 2, LIGHT, -1, 19672, 426.993530, 1337.880126, 70.536483, 48.985000, 174.676055, 95.471397, 2000.0);
	Func_TubeConnector(7, 2, LIGHT, -1, 19672, 428.733367, 1287.589477, 74.233543, 40.800376, 4.613810, -91.569152, 2000.0);
	Func_TubeConnector(8, 0, LIGHT, -1, 19672, 433.484771, 1237.713989, 72.378639, -4.099973, 3.499960, -88.300086, 2000.0);
	Func_TubeConnector(9, 1, LIGHT, -1, 19672, 434.079254, 1210.750732, 70.851577, -4.099973, 3.499960, -88.300064, 2000.0);
	Func_TubeConnector(10, 0, LIGHT, -1, 19672, 423.680450, 1187.494140, 70.128662, -4.099973, 3.499960, -88.300033, 2000.0);
	Func_TubeConnector(11, 1, LIGHT, -1, 19672, 420.029968, 1151.124389, 68.197418, -5.371489, -0.431562, -133.445632, 2000.0);
	Func_TubeConnector(12, 1, LIGHT, -1, 19672, 397.466217, 1150.454833, 69.815505, 0.429668, -5.371640, 136.594726, 2000.0);
	Func_TubeConnector(13, 0, LIGHT, -1, 19672, 391.966156, 1186.552246, 72.402931, 4.099968, -3.499965, 91.699882, 2000.0);
	Func_TubeConnector(14, 2, LIGHT, -1, 19672, 386.481994, 1222.656616, 74.894378, -0.429664, 5.371641, -43.405231, 2000.0);
	Func_TubeConnector(15, 1, LIGHT, -1, 19672, 375.012451, 1258.069580, 87.876625, 3.490998, 4.107604, 1.449373, 2000.0);
	Func_TubeConnector(16, 0, LIGHT, -1, 19672, 351.625488, 1224.991699, 97.729759, -3.490998, -4.107604, -178.550567, 2000.0);
	Func_TubeConnector(17, 1, LIGHT, -1, 19672, 324.699798, 1224.281616, 99.777824, -3.490998, -4.107604, -178.550537, 2000.0);
	Func_TubeConnector(18, 0, LIGHT, -1, 19672, 301.495208, 1234.588134, 101.981506, -3.490998, -4.107604, -178.550506, 2000.0);
	Func_TubeConnector(19, 2, LIGHT, -1, 19672, 265.400238, 1228.948852, 104.252059, 5.371489, 0.431562, 46.554481, 2000.0);
	Func_TubeConnector(20, 2, LIGHT, -1, 19672, 265.948791, 1206.365722, 102.875617, 0.429668, -5.371640, 136.594863, 2000.0);
	Func_TubeConnector(21, 0, LIGHT, -1, 19672, 302.275024, 1202.846801, 100.046234, 3.490995, 4.107605, 1.449504, 2000.0);
	Func_TubeConnector(22, 0, LIGHT, -1, 19672, 352.125091, 1204.326416, 96.471389, 3.490995, 4.107605, 1.449504, 2000.0);
	Func_TubeConnector(23, 0, LIGHT, -1, 19672, 401.975158, 1205.806030, 92.896545, 3.490995, 4.107605, 1.449504, 2000.0);
	Func_TubeConnector(24, 0, LIGHT, -1, 19672, 451.825225, 1207.285644, 89.321701, 3.490995, 4.107605, 1.449504, 2000.0);
	Func_TubeConnector(25, 2, LIGHT, -1, 19672, 487.913299, 1212.930786, 86.956764, -5.371489, -0.431560, -133.445495, 2000.0);
	Func_TubeConnector(26, 0, LIGHT, -1, 19672, 491.586578, 1249.300659, 88.886344, 4.099968, -3.499967, 91.700004, 2000.0);
	Func_TubeConnector(27, 2, LIGHT, -1, 19672, 486.102325, 1285.405029, 91.377792, -0.429664, 5.371641, -43.405101, 2000.0);
	Func_TubeConnector(28, 0, LIGHT, -1, 19672, 449.782989, 1288.918090, 94.301551, -3.490998, -4.107604, -178.550445, 2000.0);
	Func_TubeConnector(29, 2, LIGHT, -1, 19672, 399.914276, 1284.153320, 96.256088, -48.334495, -6.174080, 177.079940, 2000.0);
	Func_TubeConnector(30, 2, LIGHT, -1, 19672, 349.569427, 1283.054809, 93.089477, -41.370429, -174.533035, 5.319565, 2000.0);
	Func_TubeConnector(31, 0, LIGHT, -1, 19672, 312.113403, 1285.585937, 91.819107, -3.491000, 195.892364, -178.550399, 2000.0);
	Func_TubeConnector(32, 0, LIGHT, -1, 19672, 297.387329, 1286.109619, 77.130805, -3.491014, -119.107635, -178.550384, 2000.0);
	Func_TubeConnector(33, 0, LIGHT, -1, 19672, 297.360595, 1287.376098, 56.363708, -3.491031, -74.107620, -178.550369, 2000.0);
	Func_TubeConnector(34, 0, LIGHT, -1, 19672, 312.048858, 1288.643676, 41.682880, -3.491034, -29.107601, -178.550354, 2000.0);
	Func_TubeConnector(35, 0, LIGHT, -1, 19672, 345.427185, 1289.708740, 38.070499, 3.491045, 4.107614, 1.449594, 2000.0);
	Func_TubeConnector(36, 2, LIGHT, -1, 19672, 381.515258, 1295.353881, 35.705570, -5.371531, -0.431519, -133.445388, 2000.0);
	Func_TubeConnector(37, 0, LIGHT, -1, 19672, 385.188476, 1331.723754, 37.635189, 4.099967, -3.500026, 91.700111, 2000.0);
	Func_TubeConnector(38, 1, LIGHT, -1, 19672, 388.831878, 1368.099121, 39.472099, 5.371531, 0.431519, 46.554565, 2000.0);
	Func_TubeConnector(39, 0, LIGHT, -1, 19672, 424.925781, 1373.761352, 37.202976, 3.491055, 4.107605, 1.449586, 2000.0);
	Func_TubeConnector(40, 1, LIGHT, -1, 19672, 461.245025, 1370.271240, 34.280559, -0.429621, 5.371682, -43.404975, 2000.0);
	Func_TubeConnector(41, 0, LIGHT, -1, 19672, 466.752227, 1334.168212, 31.787479, -4.099970, 3.500022, -88.299781, 2000.0);
	Func_TubeConnector(42, 0, LIGHT, -1, 19672, 468.014801, 1284.276977, 28.742841, -4.099973, 3.500020, -88.299758, 2000.0);
	Func_TubeConnector(43, 1, LIGHT, -1, 19672, 464.364501, 1247.907226, 26.811555, -5.371531, -0.431517, -133.445327, 2000.0);
	Func_TubeConnector(44, 0, LIGHT, -1, 19672, 428.277496, 1242.239013, 29.175058, -3.491058, -4.107604, -178.550247, 2000.0);
	Func_TubeConnector(45, 0, LIGHT, -1, 19672, 378.427429, 1240.759277, 32.749904, -3.491058, -4.107604, -178.550201, 2000.0);
	Func_TubeConnector(46, 1, LIGHT, -1, 19672, 342.101257, 1244.255126, 35.577938, 0.429621, -5.371682, 136.595123, 2000.0);
	Func_TubeConnector(47, 2, LIGHT, -1, 19672, 332.379486, 1266.561889, 37.611999, -0.429622, 5.371682, -43.404808, 2000.0);
	Func_TubeConnector(48, 0, LIGHT, -1, 19672, 296.060119, 1270.074829, 40.535774, -3.491058, -4.107604, -178.550109, 2000.0);
	Func_TubeConnector(49, 1, LIGHT, -1, 19672, 259.733947, 1273.570556, 43.363807, 0.429622, -5.371682, 136.595214, 2000.0);
	Func_TubeConnector(50, 1, LIGHT, -1, 19672, 259.162414, 1296.152832, 44.741909, 5.371531, 0.431521, 46.554840, 2000.0);
	Func_TubeConnector(51, 0, LIGHT, -1, 19672, 295.256286, 1301.815307, 42.472785, 3.491054, 4.107607, 1.449856, 2000.0);
	Func_TubeConnector(52, 2, LIGHT, -1, 19672, 331.344329, 1307.460693, 40.107849, -5.371531, -0.431517, -133.445144, 2000.0);
	Func_TubeConnector(53, 1, LIGHT, -1, 19672, 368.096740, 1319.240234, 48.149059, -4.099971, 3.500023, -88.299575, 2000.0);
	Func_TubeConnector(54, 0, LIGHT, -1, 19672, 336.480468, 1342.652343, 61.949066, 4.099968, -3.500027, 91.700393, 2000.0);
	Func_TubeConnector(55, 2, LIGHT, -1, 19672, 330.995971, 1378.756591, 64.440544, -0.429622, 5.371682, -43.404712, 2000.0);
	Func_TubeConnector(56, 2, LIGHT, -1, 19672, 308.431640, 1378.109741, 66.060028, 5.371531, 0.431521, 46.554901, 2000.0);
	Func_TubeConnector(57, 0, LIGHT, -1, 19672, 304.765563, 1341.734252, 64.224784, -4.099973, 3.500021, -88.299484, 2000.0);
	Func_TubeConnector(58, 0, LIGHT, -1, 19672, 306.028411, 1291.843017, 61.180152, -4.099973, 3.500020, -88.299476, 2000.0);
	Func_TubeConnector(59, 1, LIGHT, -1, 19672, 302.378295, 1255.473266, 59.248863, -5.371531, -0.431517, -133.445037, 2000.0);
	Func_TubeConnector(60, 0, LIGHT, -1, 19672, 266.291320, 1249.804931, 61.612369, -3.491058, -4.107604, -178.549957, 2000.0);
	Func_TubeConnector(61, 1, LIGHT, -1, 19672, 229.965164, 1253.300659, 64.440406, 0.429622, -5.371682, 136.595367, 2000.0);
	Func_TubeConnector(62, 0, LIGHT, -1, 19672, 224.464660, 1289.397949, 67.027862, 4.099967, -3.500028, 91.700531, 2000.0);
	Func_TubeConnector(63, 0, LIGHT, -1, 19672, 223.201782, 1339.289184, 70.072502, 4.099967, -3.500028, 91.700508, 2000.0);
	Func_TubeConnector(64, 0, LIGHT, -1, 19672, 221.938919, 1389.180419, 73.117141, 4.099967, -3.500028, 91.700485, 2000.0);
	Func_TubeConnector(65, 1, LIGHT, -1, 19672, 220.859649, 1431.316894, 75.511390, 4.099967, -3.500028, 91.700462, 2000.0);
	Func_TubeConnector(66, 2, LIGHT, -1, 19672, 214.126220, 1450.284423, 53.493465, -0.429622, 5.371682, -43.404636, 2000.0);
	Func_TubeConnector(67, 2, LIGHT, -1, 19672, 191.561904, 1449.637573, 55.112953, 5.371531, 0.431521, 46.554965, 2000.0);
	Func_TubeConnector(68, 0, LIGHT, -1, 19672, 187.895889, 1413.262084, 53.277713, -4.099973, 3.500021, -88.299423, 2000.0);
	Func_TubeConnector(69, 1, LIGHT, -1, 19672, 184.245819, 1376.892333, 51.346424, -5.371531, -0.431517, -133.444992, 2000.0);
	Func_TubeConnector(70, 0, LIGHT, -1, 19672, 148.158859, 1371.223999, 53.709930, -3.491058, -4.107604, -178.549911, 2000.0);
	Func_TubeConnector(71, 1, LIGHT, -1, 19672, 111.832656, 1374.719604, 56.537963, 0.429622, -5.371682, 136.595413, 2000.0);
	Func_TubeConnector(72, 0, LIGHT, -1, 19672, 106.332153, 1410.816894, 59.125427, 4.099967, -3.500028, 91.700584, 2000.0);
	Func_TubeConnector(73, 1, LIGHT, -1, 19672, 109.975273, 1447.192260, 60.962337, 5.371531, 0.431519, 46.555061, 2000.0);
	Func_TubeConnector(74, 0, LIGHT, -1, 19672, 133.610168, 1452.485473, 59.577667, 3.491056, 4.107606, 1.450082, 2000.0);
	Func_TubeConnector(75, 1, LIGHT, -1, 19672, 147.604949, 1420.522583, 66.664215, -3.491058, -4.107604, -178.549835, 2000.0);
	Func_TubeConnector(76, 0, LIGHT, -1, 19672, 149.067855, 1419.344482, 86.575820, -3.491058, -4.107604, -178.549789, 2000.0);
	Func_TubeConnector(77, 0, LIGHT, -1, 19672, 150.530761, 1418.166381, 106.487426, -3.491058, -4.107604, -178.549743, 2000.0);
	Func_TubeConnector(78, 0, LIGHT, -1, 19672, 175.386993, 1450.060791, 116.640304, 3.491057, 4.107604, 1.450206, 2000.0);
	Func_TubeConnector(79, 0, LIGHT, -1, 19672, 225.237060, 1451.541015, 113.065460, 3.491057, 4.107604, 1.450203, 2000.0);
	Func_TubeConnector(80, 1, LIGHT, -1, 19672, 252.179046, 1452.238403, 111.239234, 3.491057, 4.107605, 1.450196, 2000.0);
	Func_TubeConnector(81, 0, LIGHT, -1, 19672, 275.367645, 1441.945312, 108.815704, 3.491057, 4.107605, 1.450189, 2000.0);
	Func_TubeConnector(82, 0, LIGHT, -1, 19672, 325.217712, 1443.425537, 105.240859, 3.491057, 4.107605, 1.450189, 2000.0);
	Func_TubeConnector(83, 1, LIGHT, -1, 19672, 361.536987, 1439.935668, 102.318450, -0.429622, 5.371682, -43.404376, 2000.0);
	Func_TubeConnector(84, 0, LIGHT, -1, 19672, 367.044525, 1403.832763, 99.825363, -4.099971, 3.500023, -88.299179, 2000.0);
	Func_TubeConnector(85, 0, LIGHT, -1, 19672, 368.307647, 1353.941528, 96.780723, -4.099973, 3.500021, -88.299179, 2000.0);
	Func_TubeConnector(86, 1, LIGHT, -1, 19672, 369.361145, 1311.826049, 94.033454, -4.099973, 3.500020, -88.299179, 2000.0);
	Func_TubeConnector(87, 0, LIGHT, -1, 19672, 368.437744, 1281.837890, 68.739776, -4.099974, 3.500020, -88.299171, 2000.0);
	Func_TubeConnector(88, 2, LIGHT, -1, 19672, 373.915527, 1245.739379, 66.153930, 0.429631, -5.371682, 136.595611, 2000.0);
	Func_TubeConnector(89, 0, LIGHT, -1, 19672, 410.241851, 1242.221069, 63.324531, 3.491050, 4.107610, 1.450251, 2000.0);
	Func_TubeConnector(90, 0, LIGHT, -1, 19672, 460.091918, 1243.701293, 59.749683, 3.491050, 4.107610, 1.450247, 2000.0);
	Func_TubeConnector(91, 1, LIGHT, -1, 19672, 487.033905, 1244.398681, 57.923439, 3.491050, 4.107610, 1.450242, 2000.0);
	Func_TubeConnector(92, 0, LIGHT, -1, 19672, 510.222473, 1234.105590, 55.499919, 3.491050, 4.107610, 1.450239, 2000.0);
	Func_TubeConnector(93, 2, LIGHT, -1, 19672, 546.310424, 1239.751098, 53.134983, -5.371531, -0.431520, -133.444793, 2000.0);
	Func_TubeConnector(94, 2, LIGHT, -1, 19672, 545.761474, 1262.334228, 54.511451, -0.429622, 5.371682, -43.404350, 2000.0);
	Func_TubeConnector(95, 0, LIGHT, -1, 19672, 509.442138, 1265.846923, 57.435226, -3.491058, -4.107604, -178.549652, 2000.0);
	Func_TubeConnector(96, 1, LIGHT, -1, 19672, 473.115905, 1269.342285, 60.263259, 0.429622, -5.371682, 136.595657, 2000.0);
	Func_TubeConnector(97, 0, LIGHT, -1, 19672, 467.615295, 1305.439575, 62.850723, 4.099967, -3.500028, 91.700836, 2000.0);
	Func_TubeConnector(98, 1, LIGHT, -1, 19672, 499.431518, 1330.740966, 72.006965, -4.099970, 3.500024, -88.299118, 2000.0);
	Func_TubeConnector(99, 0, LIGHT, -1, 19672, 467.815032, 1354.152954, 85.806968, 4.099968, -3.500027, 91.700843, 2000.0);
	Func_TubeConnector(100, 2, LIGHT, -1, 19672, 462.330261, 1390.257080, 88.298454, -0.429622, 5.371682, -43.404254, 2000.0);
	Func_TubeConnector(101, 0, LIGHT, -1, 19672, 426.010864, 1393.769775, 91.222221, -3.491058, -4.107604, -178.549560, 2000.0);
	Func_TubeConnector(102, 2, LIGHT, -1, 19672, 389.915954, 1388.129882, 93.492774, 5.371531, 0.431521, 46.555393, 2000.0);
	Func_TubeConnector(103, 0, LIGHT, -1, 19672, 386.250213, 1351.754394, 91.657539, -4.099973, 3.500021, -88.298995, 2000.0);
	Func_TubeConnector(104, 1, LIGHT, -1, 19672, 387.303833, 1309.638916, 88.910270, -4.099973, 3.500020, -88.298995, 2000.0);
	Func_TubeConnector(105, 0, LIGHT, -1, 19672, 386.064178, 1292.119873, 64.368537, -4.099974, 3.500020, -88.298995, 2000.0);
	Func_TubeConnector(106, 2, LIGHT, -1, 19672, 391.226928, 1268.493652, 62.552803, 0.429631, -5.371682, 136.595809, 2000.0);
	Func_TubeConnector(107, 2, LIGHT, -1, 19672, 413.791259, 1269.140747, 60.933311, -5.371531, -0.431520, -133.444580, 2000.0);
	Func_TubeConnector(108, 0, LIGHT, -1, 19672, 417.463928, 1305.510620, 62.862934, 4.099968, -3.500027, 91.700935, 2000.0);
	Func_TubeConnector(109, 0, LIGHT, -1, 19672, 416.200683, 1355.401855, 65.907577, 4.099967, -3.500028, 91.700920, 2000.0);
	Func_TubeConnector(110, 2, LIGHT, -1, 19672, 410.715881, 1391.505981, 68.399055, -0.429622, 5.371682, -43.404174, 2000.0);
	Func_TubeConnector(111, 0, LIGHT, -1, 19672, 374.396484, 1395.018676, 71.322822, -3.491058, -4.107604, -178.549484, 2000.0);
	Func_TubeConnector(112, 1, LIGHT, -1, 19672, 347.470794, 1394.307983, 73.370872, -3.491058, -4.107604, -178.549438, 2000.0);
	Func_TubeConnector(113, 0, LIGHT, -1, 19672, 324.265991, 1404.614135, 75.574562, -3.491058, -4.107604, -178.549392, 2000.0);
	Func_TubeConnector(114, 0, LIGHT, -1, 19672, 274.415924, 1403.133666, 79.149406, -3.491058, -4.107604, -178.549346, 2000.0);
	Func_TubeConnector(115, 0, LIGHT, -1, 19672, 224.565856, 1401.653198, 82.724250, -3.491058, -4.107604, -178.549301, 2000.0);
	Func_TubeConnector(116, 0, LIGHT, -1, 19672, 174.715805, 1400.172607, 86.299095, -3.491058, -4.107604, -178.549255, 2000.0);
	Func_TubeConnector(117, 0, LIGHT, -1, 19672, 124.865753, 1398.692016, 89.873939, -3.491058, -4.107604, -178.549209, 2000.0);
	Func_TubeConnector(118, 1, LIGHT, -1, 19672, 88.539512, 1402.187133, 92.701972, 0.429622, -5.371682, 136.596115, 2000.0);
	Func_TubeConnector(119, 0, LIGHT, -1, 19672, 83.038566, 1438.284423, 95.289436, 4.099967, -3.500028, 91.701271, 2000.0);
	Func_TubeConnector(120, 1, LIGHT, -1, 19672, 86.681251, 1474.659790, 97.126350, 5.371531, 0.431519, 46.555732, 2000.0);
	Func_TubeConnector(121, 0, LIGHT, -1, 19672, 122.775054, 1480.322875, 94.857223, 3.491056, 4.107606, 1.450749, 2000.0);
	Func_TubeConnector(122, 0, LIGHT, -1, 19672, 160.165740, 1481.433959, 92.166862, 3.491055, 4.107606, 1.450751, 2000.0);
	Func_TubeConnector(123, 1, LIGHT, -1, 19672, 184.023178, 1477.573730, 90.147125, -0.429622, 5.371682, -43.403812, 2000.0);
	Func_TubeConnector(124, 0, LIGHT, -1, 19672, 189.214660, 1453.939941, 88.405982, -4.099971, 3.500023, -88.298622, 2000.0);
	Func_TubeConnector(125, 1, LIGHT, -1, 19672, 189.494613, 1439.449096, 87.648994, -4.099973, 3.500021, -88.298591, 2000.0);
	Func_TubeConnector(126, 0, LIGHT, -1, 19672, 178.970916, 1428.826782, 90.409545, 4.099969, 16.499973, 91.701362, 2000.0);
	Func_TubeConnector(127, 0, LIGHT, -1, 19672, 180.301574, 1411.096435, 101.621437, -4.099977, -21.499961, -88.298599, 2000.0);
	Func_TubeConnector(128, 2, LIGHT, -1, 19672, 185.832229, 1383.976928, 103.206466, 0.429622, -5.371682, 136.596191, 2000.0);
	Func_TubeConnector(129, 0, LIGHT, -1, 19672, 222.158538, 1380.458984, 100.377067, 3.491057, 4.107604, 1.450828, 2000.0);
	Func_TubeConnector(130, 1, LIGHT, -1, 19672, 258.477874, 1376.969604, 97.454658, -0.429622, 5.371682, -43.403732, 2000.0);
	Func_TubeConnector(131, 1, LIGHT, -1, 19672, 259.049774, 1354.387329, 96.076553, -5.371531, -0.431514, -133.444137, 2000.0);
	Func_TubeConnector(132, 0, LIGHT, -1, 19672, 222.962936, 1348.718505, 98.440048, -3.491058, -4.107604, -178.549057, 2000.0);
	Func_TubeConnector(133, 0, LIGHT, -1, 19672, 173.112884, 1347.237670, 102.014892, -3.491058, -4.107604, -178.549011, 2000.0);
	Func_TubeConnector(134, 1, LIGHT, -1, 19672, 148.111770, 1377.657104, 115.648239, 3.491057, 4.107604, 1.450942, 2000.0);
	Func_TubeConnector(135, 0, LIGHT, -1, 19672, 149.574676, 1376.479003, 135.559860, 3.491057, 4.107604, 1.450942, 2000.0);
	Func_TubeConnector(136, 2, LIGHT, -1, 19672, 139.945220, 1339.234252, 144.108169, 5.371531, 0.431522, 46.555938, 2000.0);
	Func_TubeConnector(137, 0, LIGHT, -1, 19672, 136.279815, 1302.858642, 142.272918, -4.099973, 3.500021, -88.298446, 2000.0);
	Func_TubeConnector(138, 2, LIGHT, -1, 19672, 141.758132, 1266.760131, 139.687072, 0.429629, -5.371682, 136.596343, 2000.0);
	Func_TubeConnector(139, 0, LIGHT, -1, 19672, 178.084442, 1263.242187, 136.857666, 3.491052, 4.107609, 1.450988, 2000.0);
	Func_TubeConnector(140, 0, LIGHT, -1, 19672, 227.934494, 1264.723022, 133.282821, 3.491052, 4.107609, 1.450985, 2000.0);
	Func_TubeConnector(141, 0, LIGHT, -1, 19672, 277.784545, 1266.203857, 129.707977, 3.491051, 4.107609, 1.450983, 2000.0);
	Func_TubeConnector(142, 1, LIGHT, -1, 19672, 314.103912, 1262.714477, 126.785560, -0.429622, 5.371682, -43.403587, 2000.0);
	Func_TubeConnector(143, 0, LIGHT, -1, 19672, 319.295440, 1239.080688, 125.044418, -4.099971, 3.500023, -88.298377, 2000.0);
	Func_TubeConnector(144, 1, LIGHT, -1, 19672, 319.575439, 1224.589843, 124.287437, -4.099973, 3.500021, -88.298355, 2000.0);
	Func_TubeConnector(145, 0, LIGHT, -1, 19672, 309.177337, 1201.332885, 123.564498, -4.099973, 3.500020, -88.298324, 2000.0);
	Func_TubeConnector(146, 2, LIGHT, -1, 19672, 314.655639, 1165.234375, 120.978645, 0.429631, -5.371682, 136.596466, 2000.0);
	Func_TubeConnector(147, 2, LIGHT, -1, 19672, 337.219970, 1165.881713, 119.359161, -5.371531, -0.431520, -133.443923, 2000.0);
	Func_TubeConnector(148, 0, LIGHT, -1, 19672, 340.892242, 1202.251708, 121.288780, 4.099968, -3.500027, 91.701591, 2000.0);
	Func_TubeConnector(149, 0, LIGHT, -1, 19672, 339.628417, 1252.142944, 124.333419, 4.099967, -3.500028, 91.701576, 2000.0);
	Func_TubeConnector(150, 0, LIGHT, -1, 19672, 338.364624, 1302.034179, 127.378059, 4.099967, -3.500028, 91.701553, 2000.0);
	Func_TubeConnector(151, 1, LIGHT, -1, 19672, 342.007141, 1338.409545, 129.214981, 5.371531, 0.431519, 46.556003, 2000.0);
	Func_TubeConnector(152, 0, LIGHT, -1, 19672, 378.100921, 1344.072753, 126.945846, 3.491056, 4.107606, 1.451021, 2000.0);
	Func_TubeConnector(153, 2, LIGHT, -1, 19672, 414.188812, 1349.718750, 124.580917, -5.371531, -0.431514, -133.443984, 2000.0);
	Func_TubeConnector(154, 2, LIGHT, -1, 19672, 413.639678, 1372.301879, 125.957382, -0.429622, 5.371682, -43.403568, 2000.0);
	Func_TubeConnector(155, 0, LIGHT, -1, 19672, 377.320251, 1375.814086, 128.881149, -3.491058, -4.107604, -178.548873, 2000.0);
	Func_TubeConnector(156, 0, LIGHT, -1, 19672, 327.470214, 1374.333129, 132.455993, -3.491058, -4.107604, -178.548828, 2000.0);
	Func_TubeConnector(157, 1, LIGHT, -1, 19672, 300.544494, 1373.622192, 134.504028, -3.491058, -4.107604, -178.548782, 2000.0);
	Func_TubeConnector(158, 0, LIGHT, -1, 19672, 277.339599, 1383.928100, 136.707748, -3.491058, -4.107604, -178.548736, 2000.0);
	Func_TubeConnector(159, 0, LIGHT, -1, 19672, 227.489547, 1382.447021, 140.282592, -3.491058, -4.107604, -178.548690, 2000.0);
	Func_TubeConnector(160, 1, LIGHT, -1, 19672, 202.488250, 1412.866210, 153.915969, 3.491057, 4.107604, 1.451269, 2000.0);
	Func_TubeConnector(161, 0, LIGHT, -1, 19672, 179.102401, 1379.787841, 163.769073, -3.491058, -4.107604, -178.548645, 2000.0);
	Func_TubeConnector(162, 0, LIGHT, -1, 19672, 129.252365, 1378.306762, 167.343917, -3.491058, -4.107604, -178.548599, 2000.0);
	Func_TubeConnector(163, 2, LIGHT, -1, 19672, 93.157539, 1372.666259, 169.614471, 5.371531, 0.431521, 46.556377, 2000.0);
	Func_TubeConnector(164, 0, LIGHT, -1, 19672, 89.492424, 1336.290649, 167.779220, -4.099973, 3.500021, -88.298011, 2000.0);
	Func_TubeConnector(165, 0, LIGHT, -1, 19672, 90.756530, 1286.399414, 164.734588, -4.099973, 3.500020, -88.297988, 2000.0);
	Func_TubeConnector(166, 1, LIGHT, -1, 19672, 91.352020, 1259.436279, 163.207489, -4.099974, 3.500020, -88.297950, 2000.0);
	Func_TubeConnector(167, 0, LIGHT, -1, 19672, 80.954055, 1236.179199, 162.484542, -4.099974, 3.500020, -88.297927, 2000.0);
	Func_TubeConnector(168, 2, LIGHT, -1, 19672, 86.432655, 1200.080688, 159.898696, 0.429631, -5.371682, 136.596878, 2000.0);
	Func_TubeConnector(169, 2, LIGHT, -1, 19672, 122.569732, 1200.015747, 155.860168, -41.370380, 5.466965, 5.321486, 2000.0);
	Func_TubeConnector(170, 2, LIGHT, -1, 19672, 158.158569, 1202.949462, 145.412017, 40.800384, -85.386100, -91.567054, 2000.0);
	Func_TubeConnector(171, 0, LIGHT, -1, 19672, 160.087768, 1205.272216, 108.930984, 4.099986, 86.499938, 91.702011, 2000.0);
	Func_TubeConnector(172, 1, LIGHT, -1, 19672, 159.784652, 1207.533935, 71.742027, 20.851802, -86.263885, -89.880050, 2000.0);
	Func_TubeConnector(173, 1, LIGHT, -1, 19672, 175.699050, 1209.059082, 53.359943, 65.655868, -81.505020, -96.297744, 2000.0);
	Func_TubeConnector(174, 1, LIGHT, -1, 19672, 212.875686, 1208.667724, 51.581069, -41.370323, 5.466952, 5.321465, 2000.0);
	Func_TubeConnector(175, 0, LIGHT, -1, 19672, 262.915039, 1206.696533, 49.215244, 3.491108, 4.107601, 1.451495, 2000.0);
	Func_TubeConnector(176, 1, LIGHT, -1, 19672, 289.006683, 1175.399414, 50.421184, -3.491113, -4.107596, -178.548431, 2000.0);
	Func_TubeConnector(177, 0, LIGHT, -1, 19672, 313.496459, 1207.588623, 55.596202, 3.491113, 4.107596, 1.451538, 2000.0);
	Func_TubeConnector(178, 1, LIGHT, -1, 19672, 339.588134, 1176.291625, 56.802146, -3.491113, -4.107596, -178.548400, 2000.0);
	Func_TubeConnector(179, 0, LIGHT, -1, 19672, 364.077880, 1208.480957, 61.977165, 3.491113, 4.107596, 1.451582, 2000.0);
	Func_TubeConnector(180, 0, LIGHT, -1, 19672, 413.927917, 1209.962280, 58.402324, 3.491113, 4.107596, 1.451582, 2000.0);
	Func_TubeConnector(181, 0, LIGHT, -1, 19672, 463.777954, 1211.443603, 54.827487, 3.491113, 4.107596, 1.451582, 2000.0);
	Func_TubeConnector(182, 0, LIGHT, -1, 19672, 501.042968, 1212.385009, 54.872180, -3.491113, 15.892402, -178.548355, 2000.0);
	Func_TubeConnector(183, 0, LIGHT, -1, 19672, 515.769165, 1211.861694, 69.560478, -3.491119, 60.892398, -178.548355, 2000.0);
	Func_TubeConnector(184, 0, LIGHT, -1, 19672, 515.795898, 1210.595214, 90.327583, -3.491109, 105.892395, -178.548309, 2000.0);
	Func_TubeConnector(185, 0, LIGHT, -1, 19672, 501.107696, 1209.327026, 105.008407, -3.491127, 150.892364, -178.548324, 2000.0);
	Func_TubeConnector(186, 2, LIGHT, -1, 19672, 467.741516, 1211.545898, 110.239662, 48.334636, -173.825820, -2.918021, 2000.0);
	Func_TubeConnector(187, 2, LIGHT, -1, 19672, 418.386291, 1209.683349, 120.555984, 41.370273, -5.467032, -174.678283, 2000.0);
	Func_TubeConnector(188, 1, LIGHT, -1, 19672, 382.251007, 1209.706542, 124.609733, 0.429598, -5.371790, 136.597045, 2000.0);
	Func_TubeConnector(189, 0, LIGHT, -1, 19672, 376.749511, 1245.803833, 127.197257, 4.100028, -3.500121, 91.702201, 2000.0);
	Func_TubeConnector(190, 0, LIGHT, -1, 19672, 375.800537, 1283.226440, 129.472076, 4.100028, -3.500121, 91.702178, 2000.0);
	Func_TubeConnector(191, 1, LIGHT, -1, 19672, 379.759368, 1307.128784, 130.556808, 5.371639, 0.431499, 46.556606, 2000.0);
	Func_TubeConnector(192, 0, LIGHT, -1, 19672, 415.853088, 1312.792480, 128.287658, 3.491148, 4.107667, 1.451625, 2000.0);
	Func_TubeConnector(193, 2, LIGHT, -1, 19672, 451.940917, 1318.438842, 125.922698, -5.371639, -0.431494, -133.443374, 2000.0);
	Func_TubeConnector(194, 0, LIGHT, -1, 19672, 455.612854, 1354.808837, 127.852371, 4.100028, -3.500121, 91.702156, 2000.0);
	Func_TubeConnector(195, 1, LIGHT, -1, 19672, 455.033569, 1381.758911, 129.601333, 4.100028, -3.500121, 91.702133, 2000.0);
	Func_TubeConnector(196, 0, LIGHT, -1, 19672, 465.415344, 1405.029052, 130.104461, 4.100028, -3.500121, 91.702117, 2000.0);
	Func_TubeConnector(197, 1, LIGHT, -1, 19672, 464.836059, 1431.979125, 131.853408, 4.100028, -3.500121, 91.702095, 2000.0);
	Func_TubeConnector(198, 0, LIGHT, -1, 19672, 475.217864, 1455.249267, 132.356536, 4.100028, -3.500121, 91.702072, 2000.0);
	Func_TubeConnector(199, 1, LIGHT, -1, 19672, 474.638610, 1482.199340, 134.105484, 4.100028, -3.500121, 91.702049, 2000.0);
	Func_TubeConnector(200, 1, LIGHT, -1, 19672, 489.926818, 1491.953613, 133.400863, 5.371639, 0.431499, 46.556488, 2000.0);
	Func_TubeConnector(201, 1, LIGHT, -1, 19672, 512.490478, 1492.624023, 131.782745, -0.429599, 5.371790, -43.403068, 2000.0);
	Func_TubeConnector(202, 0, LIGHT, -1, 19672, 517.998840, 1456.521118, 129.289611, -4.100031, 3.500116, -88.297866, 2000.0);
	Func_TubeConnector(203, 0, LIGHT, -1, 19672, 519.263061, 1406.629882, 126.244888, -4.100033, 3.500115, -88.297836, 2000.0);
	Func_TubeConnector(204, 0, LIGHT, -1, 19672, 520.527343, 1356.738647, 123.200172, -4.100034, 3.500114, -88.297836, 2000.0);
	Func_TubeConnector(205, 1, LIGHT, -1, 19672, 516.878356, 1320.368774, 121.268836, -5.371639, -0.431497, -133.443420, 2000.0);
	Func_TubeConnector(206, 2, LIGHT, -1, 19672, 494.550445, 1310.540649, 122.327789, 5.371639, 0.431500, 46.556575, 2000.0);
	Func_TubeConnector(207, 0, LIGHT, -1, 19672, 490.568847, 1286.633911, 121.244468, -4.100034, 3.500114, -88.297836, 2000.0);
	Func_TubeConnector(208, 1, LIGHT, -1, 19672, 486.604309, 1262.736450, 120.083274, -5.371639, -0.431497, -133.443420, 2000.0);
	Func_TubeConnector(209, 0, LIGHT, -1, 19672, 450.517547, 1257.067260, 122.446800, -3.491150, -4.107665, -178.548355, 2000.0);
	Func_TubeConnector(210, 1, LIGHT, -1, 19672, 408.413421, 1255.826660, 125.288764, -3.491150, -4.107665, -178.548309, 2000.0);
	Func_TubeConnector(211, 0, LIGHT, -1, 19672, 375.350189, 1256.278564, 104.157440, -3.491150, -4.107665, -178.548278, 2000.0);
	Func_TubeConnector(212, 0, LIGHT, -1, 19672, 325.500152, 1254.797119, 107.732337, -3.491150, -4.107665, -178.548248, 2000.0);
	Func_TubeConnector(213, 1, LIGHT, -1, 19672, 289.173828, 1258.291503, 110.560417, 0.429599, -5.371790, 136.597106, 2000.0);
	Func_TubeConnector(214, 0, LIGHT, -1, 19672, 283.672271, 1294.388793, 113.147941, 4.100028, -3.500121, 91.702270, 2000.0);
	Func_TubeConnector(215, 1, LIGHT, -1, 19672, 315.487792, 1319.690917, 122.304199, -4.100031, 3.500116, -88.297706, 2000.0);
	Func_TubeConnector(216, 0, LIGHT, -1, 19672, 284.185516, 1330.629272, 135.334167, 4.100029, -3.500119, 91.702255, 2000.0);
	Func_TubeConnector(217, 2, LIGHT, -1, 19672, 279.016571, 1354.260253, 137.073471, -0.429599, 5.371790, -43.402873, 2000.0);
	Func_TubeConnector(218, 0, LIGHT, -1, 19672, 242.697128, 1357.771850, 139.997299, -3.491150, -4.107665, -178.548202, 2000.0);
	Func_TubeConnector(219, 1, LIGHT, -1, 19672, 215.771469, 1357.060424, 142.045379, -3.491150, -4.107665, -178.548171, 2000.0);
	Func_TubeConnector(220, 0, LIGHT, -1, 19672, 192.566467, 1367.366210, 144.249114, -3.491150, -4.107665, -178.548126, 2000.0);
	Func_TubeConnector(221, 1, LIGHT, -1, 19672, 156.240173, 1370.860473, 147.077194, 0.429599, -5.371790, 136.597213, 2000.0);
	Func_TubeConnector(222, 2, LIGHT, -1, 19672, 146.517547, 1393.167114, 149.111282, -0.429599, 5.371790, -43.402721, 2000.0);
	Func_TubeConnector(223, 2, LIGHT, -1, 19672, 123.953254, 1392.519409, 150.730789, 5.371639, 0.431499, 46.556888, 2000.0);
	Func_TubeConnector(224, 1, LIGHT, -1, 19672, 119.619819, 1379.072021, 150.413070, -4.100033, 3.500115, -88.297500, 2000.0);
	Func_TubeConnector(225, 0, LIGHT, -1, 19672, 109.222030, 1355.814819, 149.690109, -4.100034, 3.500114, -88.297470, 2000.0);
	Func_TubeConnector(226, 0, LIGHT, -1, 19672, 110.486610, 1305.923583, 146.645401, -4.100035, 3.500113, -88.297462, 2000.0);
	Func_TubeConnector(227, 0, LIGHT, -1, 19672, 111.751190, 1256.032470, 143.600692, -4.100035, 3.500113, -88.297431, 2000.0);
	Func_TubeConnector(228, 0, LIGHT, -1, 19672, 113.015792, 1206.141357, 140.555984, -4.100035, 3.500112, -88.297409, 2000.0);
	Func_TubeConnector(229, 1, LIGHT, -1, 19672, 113.611534, 1179.178344, 139.028869, -4.100035, 3.500112, -88.297409, 2000.0);
	Func_TubeConnector(230, 0, LIGHT, -1, 19672, 103.213783, 1155.921142, 138.305908, -4.100035, 3.500112, -88.297409, 2000.0);
	Func_TubeConnector(231, 2, LIGHT, -1, 19672, 108.692710, 1119.822631, 135.719985, 0.429609, -5.371790, 136.597381, 2000.0);
	Func_TubeConnector(232, 0, LIGHT, -1, 19672, 145.019119, 1116.305664, 132.890533, 3.491143, 4.107671, 1.452015, 2000.0);
	Func_TubeConnector(233, 0, LIGHT, -1, 19672, 194.869140, 1117.787353, 129.315628, 3.491143, 4.107671, 1.452015, 2000.0);
	Func_TubeConnector(234, 0, LIGHT, -1, 19672, 244.719161, 1119.269042, 125.740722, 3.491143, 4.107671, 1.452015, 2000.0);
	Func_TubeConnector(235, 1, LIGHT, -1, 19672, 271.176849, 1087.677734, 131.924514, -3.491150, -4.107665, -178.547927, 2000.0);
	Func_TubeConnector(236, 0, LIGHT, -1, 19672, 296.032043, 1119.572753, 142.077423, 3.491150, 4.107665, 1.452053, 2000.0);
	Func_TubeConnector(237, 0, LIGHT, -1, 19672, 345.882080, 1121.054565, 138.502532, 3.491150, 4.107665, 1.452053, 2000.0);
	Func_TubeConnector(238, 1, LIGHT, -1, 19672, 372.824035, 1121.752685, 136.676284, 3.491150, 4.107665, 1.452053, 2000.0);
	Func_TubeConnector(239, 0, LIGHT, -1, 19672, 396.012908, 1111.460205, 134.252700, 3.491150, 4.107665, 1.452053, 2000.0);
	Func_TubeConnector(240, 0, LIGHT, -1, 19672, 445.862915, 1112.942016, 130.677810, 3.491150, 4.107665, 1.452053, 2000.0);
	Func_TubeConnector(241, 1, LIGHT, -1, 19672, 487.941101, 1114.203735, 127.482795, 3.491150, 4.107665, 1.452053, 2000.0);
	Func_TubeConnector(242, 2, LIGHT, -1, 19672, 503.806579, 1120.683715, 103.065650, -5.371639, -0.431494, -133.442962, 2000.0);
	Func_TubeConnector(243, 0, LIGHT, -1, 19672, 507.793640, 1144.585693, 104.225440, 4.100028, -3.500121, 91.702560, 2000.0);
	Func_TubeConnector(244, 2, LIGHT, -1, 19672, 502.624572, 1168.216674, 105.964767, -0.429599, 5.371790, -43.402557, 2000.0);
	Func_TubeConnector(245, 0, LIGHT, -1, 19672, 466.305084, 1171.728027, 108.888580, -3.491150, -4.107665, -178.547882, 2000.0);
	Func_TubeConnector(246, 0, LIGHT, -1, 19672, 428.913116, 1170.616943, 111.561065, -3.491150, -4.107665, -178.547851, 2000.0);
	Func_TubeConnector(247, 0, LIGHT, -1, 19672, 391.526275, 1169.505126, 114.251197, -3.491150, -4.107665, -178.547821, 2000.0);
	Func_TubeConnector(248, 2, LIGHT, -1, 19672, 355.431518, 1163.864135, 116.521781, 5.371639, 0.431499, 46.557159, 2000.0);
	Func_TubeConnector(249, 1, LIGHT, -1, 19672, 346.853607, 1141.009643, 115.799858, -5.371639, -0.431494, -133.442825, 2000.0);
	Func_TubeConnector(250, 0, LIGHT, -1, 19672, 310.766906, 1135.340087, 118.163383, -3.491150, -4.107665, -178.547775, 2000.0);
	Func_TubeConnector(251, 1, LIGHT, -1, 19672, 283.841278, 1134.628417, 120.211471, -3.491150, -4.107665, -178.547729, 2000.0);
	Func_TubeConnector(252, 1, LIGHT, -1, 19672, 274.159881, 1149.909912, 121.668395, 0.429599, -5.371790, 136.597610, 2000.0);
	Func_TubeConnector(253, 0, LIGHT, -1, 19672, 268.658020, 1186.007202, 124.255920, 4.100028, -3.500121, 91.702766, 2000.0);
	Func_TubeConnector(254, 2, LIGHT, -1, 19672, 263.172027, 1222.111328, 126.747467, -0.429599, 5.371790, -43.402351, 2000.0);
	Func_TubeConnector(255, 1, LIGHT, -1, 19672, 234.598419, 1225.863647, 128.938354, -3.491150, -4.107665, -178.547668, 2000.0);
	Func_TubeConnector(256, 0, LIGHT, -1, 19672, 213.971206, 1226.735229, 106.087219, -3.491150, 5.892334, -178.547622, 2000.0);
	Func_TubeConnector(257, 0, LIGHT, -1, 19672, 188.239807, 1226.374145, 101.313468, -3.491148, 20.892330, -178.547576, 2000.0);
	Func_TubeConnector(258, 0, LIGHT, -1, 19672, 164.612335, 1226.462158, 90.054740, -3.491149, 35.892333, -178.547561, 2000.0);
	Func_TubeConnector(259, 0, LIGHT, -1, 19672, 144.698974, 1226.993408, 73.078300, -3.491149, 50.892330, -178.547546, 2000.0);
	Func_TubeConnector(260, 0, LIGHT, -1, 19672, 127.090827, 1227.726196, 53.755687, 3.491150, -35.892330, 1.452459, 2000.0);
	Func_TubeConnector(261, 0, LIGHT, -1, 19672, 106.512763, 1227.470947, 49.385986, 3.491151, -0.892329, 1.452459, 2000.0);
	Func_TubeConnector(262, 2, LIGHT, -1, 19672, 84.113052, 1222.252929, 50.027427, 5.371639, 0.431500, 46.557495, 2000.0);
	Func_TubeConnector(263, 2, LIGHT, -1, 19672, 84.662818, 1199.669799, 48.650928, 0.429605, -5.371790, 136.597885, 2000.0);
	Func_TubeConnector(264, 0, LIGHT, -1, 19672, 120.989242, 1196.153076, 45.821491, 3.491147, 4.107668, 1.452515, 2000.0);
	Func_TubeConnector(265, 0, LIGHT, -1, 19672, 170.839248, 1197.635253, 42.246589, 3.491144, 4.107671, 1.452517, 2000.0);
	Func_TubeConnector(266, 2, LIGHT, -1, 19672, 206.927032, 1203.282104, 39.881622, -5.371639, -0.431497, -133.442474, 2000.0);
	Func_TubeConnector(267, 0, LIGHT, -1, 19672, 210.598373, 1239.652221, 41.811298, 4.100029, -3.500119, 91.703041, 2000.0);
	Func_TubeConnector(268, 0, LIGHT, -1, 19672, 209.333328, 1289.543334, 44.856018, 4.100028, -3.500121, 91.703025, 2000.0);
	Func_TubeConnector(269, 1, LIGHT, -1, 19672, 212.974868, 1325.918823, 46.692977, 5.371639, 0.431499, 46.557468, 2000.0);
	Func_TubeConnector(270, 0, LIGHT, -1, 19672, 249.068511, 1331.583007, 44.423824, 3.491148, 4.107667, 1.452479, 2000.0);
	Func_TubeConnector(271, 2, LIGHT, -1, 19672, 285.156280, 1337.229858, 42.058860, -5.371639, -0.431494, -133.442520, 2000.0);
	Func_TubeConnector(272, 1, LIGHT, -1, 19672, 293.734069, 1360.084350, 42.780799, 5.371639, 0.431499, 46.557468, 2000.0);
	Func_TubeConnector(273, 0, LIGHT, -1, 19672, 329.827697, 1365.748535, 40.511646, 3.491148, 4.107667, 1.452479, 2000.0);
	Func_TubeConnector(274, 0, LIGHT, -1, 19672, 366.738128, 1366.976196, 35.729721, 3.491148, 24.107667, 1.452479, 2000.0);
	Func_TubeConnector(275, 0, LIGHT, -1, 19672, 389.816101, 1368.597534, 18.751426, -3.491154, -29.107662, -178.547454, 2000.0);
	Func_TubeConnector(276, 2, LIGHT, -1, 19672, 409.430938, 1373.849243, 16.349861, -5.371639, -0.431491, -133.442474, 2000.0);
	Func_TubeConnector(277, 2, LIGHT, -1, 19672, 408.881225, 1396.432373, 17.726362, -0.429599, 5.371790, -43.402065, 2000.0);
	Func_TubeConnector(278, 1, LIGHT, -1, 19672, 386.085266, 1404.919433, 19.903356, 0.429599, -5.371790, 136.597900, 2000.0);
	Func_TubeConnector(280, 1, LIGHT, -1, 19672, 385.236816, 1437.479125, 21.892070, 5.371639, 0.431499, 46.557525, 2000.0);
	Func_TubeConnector(281, 0, LIGHT, -1, 19672, 421.330444, 1443.143310, 19.622915, 3.491148, 4.107667, 1.452546, 2000.0);
	Func_TubeConnector(282, 0, LIGHT, -1, 19672, 471.180450, 1444.625488, 16.048015, 3.491148, 4.107667, 1.452546, 2000.0);
	Func_TubeConnector(283, 1, LIGHT, -1, 19672, 498.122406, 1445.323852, 14.221752, 3.491148, 4.107667, 1.452547, 2000.0);
	Func_TubeConnector(284, 0, LIGHT, -1, 19672, 508.874023, 1434.612182, 13.500070, -3.491150, 5.892334, -178.547393, 2000.0);
	Func_TubeConnector(285, 0, LIGHT, -1, 19672, 532.097167, 1434.918823, 18.125194, -3.491148, 20.892330, -178.547348, 2000.0);
	Func_TubeConnector(286, 0, LIGHT, -1, 19672, 553.339416, 1434.818847, 28.592248, -3.491149, 35.892333, -178.547348, 2000.0);
	Func_TubeConnector(287, 0, LIGHT, -1, 19672, 581.167968, 1434.109863, 51.773685, 3.491154, -40.892330, 1.452655, 2000.0);
	Func_TubeConnector(288, 0, LIGHT, -1, 19672, 619.003417, 1433.075439, 84.444931, 3.491163, -40.892330, 1.452659, 2000.0);
	Func_TubeConnector(289, 0, LIGHT, -1, 19672, 648.529968, 1432.440063, 107.128379, 3.491173, -20.892333, 1.452662, 2000.0);
}

StuntPark()
{
		CreateDynamicObject(19543,2305.5407710,1415.2512200,41.8302800,0.0000000,0.0000000,0.0000000,1,0);
		CreateDynamicObject(19543,2305.4970700,1477.7474360,41.8321300,0.0000000,0.0000000,0.0000000,1,0);
		CreateDynamicObject(19543,2320.4511710,1415.1517330,41.8258090,0.0000000,0.0000000,0.0000000,1,0);
		CreateDynamicObject(19543,2320.4890130,1477.6170650,41.8316910,0.0000000,0.0000000,0.0000000,1,0);
		CreateDynamicObject(19543,2335.4338370,1415.0855710,41.8343080,0.0000000,0.0000000,0.0000000,1,0);
		CreateDynamicObject(19543,2335.4377440,1477.5745840,41.8381420,0.0000000,0.0000000,0.0000000,1,0);
		CreateDynamicObject(19543,2349.1174310,1481.8350830,41.8640890,0.0000000,0.0000000,0.0000000,1,0);
		CreateDynamicObject(19543,2349.1267080,1425.8856200,41.8278920,0.0000000,0.0000000,0.0000000,1,0);
		CreateDynamicObject(19543,2340.0869140,1415.2171630,41.8417390,0.0000000,0.0000000,0.0000000,1,0);
		CreateDynamicObject(19543,2298.7416990,1391.4552000,41.8250420,0.0000000,0.0000000,-89.8000100,1,0);
		CreateDynamicObject(19543,2298.7231440,1394.9649650,41.8349150,0.0000000,0.0000000,-90.1000060,1,0);
		CreateDynamicObject(19543,2321.3918450,1515.2404780,41.8348990,0.0000000,0.0000000,-90.1999350,1,0);
		CreateDynamicObject(19543,2298.6933590,1515.0982660,41.8316950,0.0000000,0.0000000,89.9999460,1,0);
		CreateDynamicObject(9241,2326.9118650,1419.1203610,43.6089550,0.0000000,0.0000000,-179.8999930,1,0);
		CreateDynamicObject(19644,2327.8193350,1517.5809320,44.3128310,0.0000000,26.3000030,-89.5000070,1,0);
		CreateDynamicObject(19648,2327.8210440,1525.9737540,49.1186790,0.0000000,33.8000030,-89.2999640,1,0);
		CreateDynamicObject(19646,2327.7392570,1534.0665280,54.8771200,0.0000000,-36.0999870,90.5000220,1,0);
		CreateDynamicObject(19682,2324.8710930,1547.6226800,65.1280510,-25.8000100,-28.1000090,130.6999350,1,0);
		CreateDynamicObject(19682,2307.2192380,1560.4486080,75.5748900,-38.2000650,-0.1999930,-177.7001950,1,0);
		CreateDynamicObject(19661,2284.5161130,1557.8597410,74.0603330,-179.4997860,-143.1999200,88.9000240,1,0);
		CreateDynamicObject(19673,2279.0908200,1545.5556640,64.5832510,-0.1999980,35.1000170,-89.6998970,1,0);
		CreateDynamicObject(19675,2279.3459470,1538.0473630,58.3219030,1.3000000,35.2000270,-87.0999980,1,0);
		CreateDynamicObject(19675,2279.9274900,1530.1629630,52.2717930,1.7999990,30.0000170,-86.7000040,1,0);
		CreateDynamicObject(19652,2296.3510740,1409.2746580,54.2338940,0.0000000,0.0000000,2.9999990,1,0);
		CreateDynamicObject(19652,2296.5456540,1409.3076170,74.2116470,0.1000000,0.0000000,2.6000120,1,0);
		CreateDynamicObject(19649,2272.4580070,1392.9086910,84.2866820,-0.5999990,0.3999990,1.1000000,1,0);
		CreateDynamicObject(621,2344.5356440,1398.5767820,41.6517860,0.0000000,0.0000000,0.0000000,1,0);
		CreateDynamicObject(19543,2298.5808100,1510.7336420,41.8377760,0.0000000,0.0000000,90.0000070,1,0);
		CreateDynamicObject(19700,2264.3090820,1496.9602050,41.7172200,0.0000000,0.0000000,90.1000060,1,0);
		CreateDynamicObject(19700,2276.8017570,1496.9808340,41.7364800,0.0000000,0.0000000,90.0999520,1,0);
		CreateDynamicObject(19700,2289.2575680,1497.0014640,41.7506710,0.0000000,0.0000000,90.4999920,1,0);
		CreateDynamicObject(19700,2264.3457030,1484.5926510,40.9704930,0.0000000,-6.5999970,89.9999160,1,0);
		CreateDynamicObject(19700,2276.8254390,1484.6057120,40.9399560,0.0000000,6.7999960,-89.9000620,1,0);
		CreateDynamicObject(19700,2289.3334960,1484.6265860,40.9520600,0.0000000,6.9999910,-89.8999860,1,0);
		CreateDynamicObject(19700,2300.2915030,1496.9365230,45.3211170,35.0999640,1.4000020,-91.3000860,1,0);
		CreateDynamicObject(19543,2289.1809080,1447.2015380,38.2654870,3.6999990,0.0000000,0.0000000,1,0);
		CreateDynamicObject(19543,2274.2614740,1447.2443840,38.2717280,3.6999990,0.0000000,0.0000000,1,0);
		CreateDynamicObject(19543,2265.5605460,1447.2061760,38.2600590,3.6999980,0.0000000,0.0000000,1,0);
		CreateDynamicObject(19633,2277.9008780,1442.6948240,37.9767030,3.8999980,0.0000000,0.0000000,1,0);

		AddStaticVehicle(522, 2329.0000, 1434.5000, 42.4366, 323.9512, -1, -1);
		AddStaticVehicle(522, 2330.0000, 1434.5000, 42.4366, 323.9512, -1, -1);
		AddStaticVehicle(522, 2331.0000, 1434.5000, 42.4366, 323.9512, -1, -1);
		AddStaticVehicle(522, 2332.0000, 1434.5000, 42.4366, 323.9512, -1, -1);
		AddStaticVehicle(522, 2333.0000, 1434.5000, 42.4366, 323.9512, -1, -1);
		AddStaticVehicle(522, 2334.0000, 1434.5000, 42.4366, 323.9512, -1, -1);
		AddStaticVehicle(522, 2335.0000, 1434.5000, 42.4366, 323.9512, -1, -1);
		AddStaticVehicle(522, 2336.0000, 1434.5000, 42.4366, 323.9512, -1, -1);
		AddStaticVehicle(522, 2337.0000, 1434.5000, 42.4366, 323.9512, -1, -1);
		AddStaticVehicle(522, 2338.0000, 1434.5000, 42.4366, 323.9512, -1, -1);
		AddStaticVehicle(522, 2339.0000, 1434.5000, 42.4366, 323.9512, -1, -1);
}

//------------------------------------------(Abounded Airport)-----------------------------------
AAMaps()
{
	CreateDynamicObject(18841, 175.63991, 2541.88184, 37.16240,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(18842, 140.04288, 2541.83203, 21.26030,   -45.00000, 90.00000, 180.00000);
	CreateDynamicObject(18836, 140.10234, 2541.86841, 53.08484,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18836, 90.12973, 2541.92383, 53.12599,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18842, 90.04978, 2541.87915, 21.25370,   -45.00000, 90.00000, 180.00000);
	CreateDynamicObject(18841, 54.53903, 2541.90332, 69.03021,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18809, 90.10428, 2541.85303, 84.98668,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(0, 383.03030, 2425.18579, 39.08110,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(16203, 199.35635, 1943.77429, 18.20313,   356.85840, 0.00000, 3.14159);
	CreateDynamicObject(18809, 140.09081, 2541.82788, 85.00720,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18809, 190.09081, 2541.82788, 85.00720,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18809, 235.09081, 2541.82788, 85.00720,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18809, 285.09079, 2541.82788, 85.00720,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19667, 61.28162, 2426.75806, 49.83752,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19649, 66.83329, 2451.75122, 18.00330,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19667, 50.28160, 2426.75806, 49.83750,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19667, 39.28160, 2426.75806, 49.83750,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19661, 28.50173, 2416.11694, 18.01030,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18784, 438.23981, 2488.93359, 17.86738,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18784, 438.23981, 2508.93359, 17.86740,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18784, 438.23981, 2515.43359, 17.86740,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18787, 453.20166, 2488.95728, 22.77909,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(18787, 453.20169, 2508.95728, 22.77910,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(18787, 453.20169, 2515.45728, 22.77910,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(18787, 462.68719, 2515.47192, 28.49975,   10.00000, 0.00000, -90.00000);
	CreateDynamicObject(18787, 462.68719, 2495.47192, 28.49980,   10.00000, 0.00000, -90.00000);
	CreateDynamicObject(18787, 462.68719, 2488.97192, 28.49980,   10.00000, 0.00000, -90.00000);
	CreateDynamicObject(18787, 470.99075, 2515.47266, 35.77179,   20.00000, 0.00000, -90.00000);
	CreateDynamicObject(18787, 470.99081, 2495.47266, 35.77180,   20.00000, 0.00000, -90.00000);
	CreateDynamicObject(18787, 470.99081, 2488.97266, 35.77180,   20.00000, 0.00000, -90.00000);
	CreateDynamicObject(18783, 484.85727, 2515.46021, 37.30500,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18783, 484.85730, 2495.46021, 37.30500,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18783, 484.85730, 2489.46021, 37.30500,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(9241, 380.25665, 2541.19507, 17.21600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18811, 335.08182, 2541.77539, 85.17607,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18824, 379.76321, 2529.72729, 85.17303,   90.00000, 90.00000, 135.00000);
	CreateDynamicObject(18809, 391.82883, 2485.02686, 85.16042,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(18824, 379.76584, 2440.37964, 85.17300,   90.00000, 90.00000, 44.89991);
	CreateDynamicObject(18809, 334.98212, 2428.29297, 85.17918,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18822, 286.60782, 2428.30029, 91.92691,   180.00000, 68.00000, 0.00000);
	CreateDynamicObject(18822, 230.79700, 2428.36060, 91.92690,   180.00000, 68.00000, 180.00000);
	CreateDynamicObject(18809, 182.37505, 2428.39697, 85.12769,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19667, 157.38057, 2433.98975, 114.21038,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19649, 132.68501, 2439.48462, 82.43063,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19661, 97.17153, 2466.08813, 82.42770,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19661, 97.17990, 2444.75073, 82.42770,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19649, 132.63649, 2471.25293, 82.42498,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19649, 182.63651, 2471.25293, 82.42500,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19649, 232.61160, 2471.23828, 82.42500,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19667, 257.37271, 2465.70044, 114.23540,   0.00000, 0.00000, 900.00000);
	CreateDynamicObject(19649, 282.35089, 2460.14209, 82.38300,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(12919, 242.84502, 2535.37476, 15.81092,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 264.43427, 2547.74414, 16.84842,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18367, 196.99152, 2535.38696, 15.45623,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18784, 348.90292, 2501.85913, 18.08030,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(18783, 328.91083, 2501.86548, 18.08078,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18784, 308.91608, 2501.85229, 18.08030,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 333.95273, 2508.17114, 21.68445,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1634, 333.95270, 2495.67114, 21.68440,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1634, 323.45270, 2495.67114, 21.68440,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1634, 323.45270, 2508.17114, 21.68440,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(13592, 293.07053, 2491.75464, 25.25299,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(13592, 280.38385, 2484.89111, 25.25299,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19005, 249.31564, 2483.30542, 18.73670,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(13592, 324.65891, 2464.13599, 90.33359,   0.00000, 0.00000, 8.28000);
	CreateDynamicObject(1634, 313.62677, 2460.14258, 79.74963,   -25.00000, 0.00000, -90.00000);
	CreateDynamicObject(18829, -56.20544, 2502.49316, 20.50380,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(18831, -92.44420, 2502.51392, 25.13040,   0.00000, -45.00000, 0.00000);
	CreateDynamicObject(18831, -101.76884, 2502.51196, 47.68116,   0.00000, 135.00000, 0.00000);
	CreateDynamicObject(18788, -133.30714, 2502.48633, 46.40065,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18788, -173.30070, 2502.48413, 48.14544,   0.00000, 5.00000, 0.00000);
	CreateDynamicObject(18788, -212.87198, 2502.44507, 53.36560,   0.00000, 10.00000, 0.00000);
	CreateDynamicObject(18788, -251.58525, 2502.43018, 61.93944,   0.00000, 15.00000, 0.00000);
	CreateDynamicObject(18788, -289.52722, 2502.41772, 73.86922,   0.00000, 20.00000, 0.00000);
	CreateDynamicObject(18788, -326.08475, 2502.40308, 89.01475,   0.00000, 25.00000, 0.00000);
	CreateDynamicObject(18788, -361.27197, 2502.39404, 107.29359,   0.00000, 30.00000, 0.00000);
	CreateDynamicObject(18788, -394.70349, 2502.42139, 128.58861,   0.00000, 35.00000, 0.00000);
	CreateDynamicObject(18788, -425.80017, 2502.43335, 152.53117,   0.00000, 40.00000, 0.00000);
	CreateDynamicObject(18788, -454.72479, 2502.43970, 179.09152,   0.00000, 45.00000, 0.00000);
	CreateDynamicObject(19543, -475.39728, 2503.74780, 194.02475,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19543, -490.04910, 2503.76392, 194.04720,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19543, -505.03189, 2503.78223, 194.04164,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.88797, 2511.33667, 195.58919,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.87762, 2514.34131, 195.59357,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.86719, 2517.34717, 195.59789,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.85699, 2520.35229, 195.60213,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.83627, 2523.36182, 195.61147,   0.00000, 0.00000, 0.18000);
	CreateDynamicObject(19355, -467.84747, 2526.35596, 195.60527,   0.00000, 0.00000, 0.06000);
	CreateDynamicObject(19355, -467.81659, 2529.37280, 195.61955,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.80737, 2532.37646, 195.62244,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.82745, 2533.36548, 195.61345,   0.00000, 0.00000, -0.06000);
	CreateDynamicObject(19355, -468.03244, 2493.54150, 195.76620,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.97705, 2490.52148, 195.74336,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.98633, 2487.52319, 195.74471,   0.00000, 0.00000, 0.12000);
	CreateDynamicObject(19355, -467.99551, 2484.52588, 195.74603,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -468.00473, 2481.52588, 195.74728,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -468.01367, 2478.52856, 195.74852,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -468.02277, 2475.53003, 195.74969,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -468.03253, 2474.24805, 195.76498,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -510.93347, 2535.04395, 195.67018,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -508.23557, 2534.99146, 195.66829,   0.00000, 0.00000, 89.88000);
	CreateDynamicObject(19355, -505.21860, 2535.00098, 195.67575,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -502.24203, 2534.96899, 195.66632,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -499.25177, 2534.96313, 195.66066,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -496.26907, 2534.95483, 195.65404,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -493.25897, 2534.96167, 195.65976,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -490.27704, 2534.95044, 195.65181,   0.00000, 0.00000, 89.94000);
	CreateDynamicObject(19355, -487.28595, 2534.94702, 195.64835,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -484.29495, 2534.94287, 195.64482,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -481.30399, 2534.93701, 195.64122,   0.00000, 0.00000, 89.94000);
	CreateDynamicObject(19355, -478.31314, 2534.93384, 195.63760,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -475.33246, 2534.92456, 195.62903,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -472.32114, 2534.93115, 195.63609,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -469.34183, 2534.91943, 195.62523,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -469.50912, 2472.71045, 195.74533,   0.00000, 0.00000, 90.06000);
	CreateDynamicObject(19355, -472.49982, 2472.70923, 195.74385,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -475.49033, 2472.70776, 195.74231,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -478.48068, 2472.70435, 195.74072,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -481.47107, 2472.70313, 195.73907,   0.00000, 0.00000, 89.94000);
	CreateDynamicObject(19355, -484.46140, 2472.70215, 195.73738,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -487.45160, 2472.69873, 195.73567,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -490.44165, 2472.69800, 195.73386,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -493.43188, 2472.69458, 195.73204,   0.00000, 0.00000, 90.06000);
	CreateDynamicObject(19355, -496.42178, 2472.69165, 195.73015,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -499.41180, 2472.69092, 195.72823,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -502.40146, 2472.68848, 195.72623,   0.00000, 0.00000, 89.94000);
	CreateDynamicObject(19355, -505.39105, 2472.68530, 195.72420,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -508.38086, 2472.68286, 195.72212,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -511.11020, 2472.69189, 195.71999,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18813, -553.41400, 2503.31836, 169.55597,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19005, -502.45505, 2503.06812, 197.37318,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -512.61133, 2474.39111, 195.71780,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.60071, 2477.38965, 195.71558,   0.00000, 0.00000, -0.12000);
	CreateDynamicObject(19355, -512.58972, 2480.38721, 195.71326,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.56897, 2483.38110, 195.70714,   0.00000, 0.00000, -0.12000);
	CreateDynamicObject(19355, -512.57819, 2486.38428, 195.71233,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.55731, 2489.37817, 195.70610,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.54614, 2491.87695, 195.70360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.51385, 2513.86597, 195.69312,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.52374, 2516.87012, 195.69846,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.50153, 2519.86450, 195.69177,   0.00000, 0.00000, -0.06000);
	CreateDynamicObject(19355, -512.49011, 2522.86157, 195.68904,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.47839, 2525.85864, 195.68623,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.46643, 2528.85498, 195.68336,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.45441, 2531.85107, 195.68048,   0.00000, 0.00000, -0.12000);
	CreateDynamicObject(19355, -512.46320, 2533.47021, 195.67752,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, -77.89165, 2518.40820, 16.60110,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18985, -20.22920, 2541.87915, 20.76220,   0.30000, 0.00000, 90.00000);
	CreateDynamicObject(1634, 242.96516, 2546.35474, 15.83170,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(1634, 242.96519, 2524.85474, 15.74893,   0.00000, 0.00000, -0.00001);
	CreateDynamicObject(19646, 372.79944, 2471.13501, 18.04609,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19646, 372.79941, 2461.13501, 18.04299,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19646, 372.79941, 2451.13501, 18.03390,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19646, 372.79941, 2441.13501, 18.03690,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19646, 372.79941, 2431.13501, 18.03993,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19652, 356.93039, 2425.98730, 27.96624,   0.00000, 0.00000, -268.79971);
	CreateDynamicObject(19659, 388.74606, 2415.75171, 37.96269,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19670, 387.72174, 2410.61914, -11.99977,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19670, 357.06116, 2441.87305, -16.92518,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19643, 436.39648, 2459.73438, 24.37994,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19647, 446.20483, 2459.60767, 24.40983,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19652, 451.17441, 2443.73145, 34.42100,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(19652, 451.17441, 2443.73145, 54.42100,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(19652, 451.17441, 2443.73145, 74.42100,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(19652, 451.17441, 2443.73145, 94.42100,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(1634, -84.77725, 2518.40356, 22.58940,   30.00000, 0.00000, 90.00000);
	CreateDynamicObject(1634, -87.65410, 2518.39771, 31.00670,   60.00000, 0.00000, 90.00000);
	CreateDynamicObject(1634, -85.87364, 2518.39746, 39.91150,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(1634, -79.96849, 2518.37500, 46.72755,   120.00000, 0.00000, 90.00000);
	CreateDynamicObject(1634, -71.53983, 2518.39404, 49.59912,   150.00000, 0.00000, 90.00000);
	CreateDynamicObject(1634, -25.44366, 2471.32422, 16.55867,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(13592, -24.49575, 2317.19727, 82.25574,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -24.38803, 2310.18213, 84.59464,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -24.28099, 2303.38159, 86.92851,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -24.17407, 2296.31982, 89.38399,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -23.96804, 2289.38208, 91.83495,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -23.88976, 2282.39355, 94.31081,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -23.76185, 2275.28809, 96.70954,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -23.68928, 2268.39526, 99.04994,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -23.59254, 2261.36646, 101.48766,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -23.51829, 2255.20117, 103.54388,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -22.81983, 2181.44775, 128.40738,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -22.86788, 2187.10205, 126.39413,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -22.99164, 2193.98486, 123.96805,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -23.08882, 2200.62646, 121.71683,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -23.16752, 2207.06836, 119.77722,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -23.45354, 2248.64526, 105.82327,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -23.23000, 2213.86865, 117.34357,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -23.26463, 2220.85449, 115.16722,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -23.32713, 2227.93945, 112.69484,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -23.36913, 2235.00537, 110.29230,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -23.48122, 2241.69312, 107.95503,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -24.58291, 2323.83130, 79.97462,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -24.68390, 2330.36938, 77.61678,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -24.78136, 2337.29980, 75.23022,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -24.83886, 2343.96558, 72.83096,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -24.89918, 2357.23218, 68.16812,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -24.85484, 2350.47510, 70.59693,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -24.98652, 2364.10229, 65.69891,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -25.02400, 2371.17188, 63.17580,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -25.09158, 2378.18164, 60.66004,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -25.21365, 2385.10938, 58.17861,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -25.31051, 2398.42993, 53.40433,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -25.29044, 2391.96118, 55.71950,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -25.37513, 2404.80591, 51.12070,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -25.55238, 2411.75903, 48.69855,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -25.64521, 2418.65552, 46.23283,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -25.65893, 2425.67505, 43.71410,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -25.84807, 2432.76855, 41.21691,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -25.86933, 2439.72852, 38.70965,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -26.02224, 2446.70801, 36.22446,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -25.95322, 2453.67456, 33.98920,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(13592, -26.00988, 2460.59375, 31.54420,   -20.00000, 0.00000, 10.00000);
	CreateDynamicObject(19659, 461.78922, 2475.52026, 104.45708,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(18831, 352.32565, 2474.59326, 82.66466,   90.00000, 0.00000, 135.00000);
	CreateDynamicObject(18831, 352.35916, 2497.11426, 82.66470,   90.00000, 0.00000, 225.00000);
	CreateDynamicObject(13641, 336.26566, 2501.79883, 79.32196,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1634, 61.83310, 2541.87915, 13.68950,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1634, -76.94735, 2485.98730, 16.60110,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1634, -83.83339, 2485.99927, 22.58940,   30.00000, 0.00000, 90.00000);
	CreateDynamicObject(1634, -86.75637, 2486.00146, 31.00670,   60.00000, 0.00000, 90.00000);
	CreateDynamicObject(1634, -85.03747, 2486.01050, 39.91150,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(1634, -70.73246, 2486.00635, 49.59912,   150.00000, 0.00000, 90.00000);
	CreateDynamicObject(1634, -79.11563, 2486.01440, 46.72755,   120.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -469.50912, 2472.71045, 195.74533,   0.00000, 0.00000, 90.06000);
	CreateDynamicObject(19355, -472.49982, 2472.70923, 195.74385,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -475.49033, 2472.70776, 195.74231,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -478.48068, 2472.70435, 195.74072,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -481.47107, 2472.70313, 195.73907,   0.00000, 0.00000, 89.94000);
	CreateDynamicObject(19355, -484.46140, 2472.70215, 195.73738,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -487.45160, 2472.69873, 195.73567,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -490.44165, 2472.69800, 195.73386,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -496.42178, 2472.69165, 195.73015,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -493.43188, 2472.69458, 195.73204,   0.00000, 0.00000, 90.06000);
	CreateDynamicObject(19355, -499.41180, 2472.69092, 195.72823,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -502.40146, 2472.68848, 195.72623,   0.00000, 0.00000, 89.94000);
	CreateDynamicObject(19355, -505.39105, 2472.68530, 195.72420,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -508.38086, 2472.68286, 195.72212,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -511.11020, 2472.69189, 195.71999,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -512.61133, 2474.39111, 195.71780,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.60071, 2477.38965, 195.71558,   0.00000, 0.00000, -0.12000);
	CreateDynamicObject(19355, -512.58972, 2480.38721, 195.71326,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.57819, 2486.38428, 195.71233,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -468.03253, 2474.24805, 195.76498,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -468.02277, 2475.53003, 195.74969,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -468.01367, 2478.52856, 195.74852,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -468.00473, 2481.52588, 195.74728,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.99551, 2484.52588, 195.74603,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.98633, 2487.52319, 195.74471,   0.00000, 0.00000, 0.12000);
	CreateDynamicObject(19355, -467.97705, 2490.52148, 195.74336,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -468.03244, 2493.54150, 195.76620,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.88797, 2511.33667, 195.58919,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.87762, 2514.34131, 195.59357,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.86719, 2517.34717, 195.59789,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.85699, 2520.35229, 195.60213,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.83627, 2523.36182, 195.61147,   0.00000, 0.00000, 0.18000);
	CreateDynamicObject(19355, -467.84747, 2526.35596, 195.60527,   0.00000, 0.00000, 0.06000);
	CreateDynamicObject(19355, -467.81659, 2529.37280, 195.61955,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.80737, 2532.37646, 195.62244,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -467.82745, 2533.36548, 195.61345,   0.00000, 0.00000, -0.06000);
	CreateDynamicObject(19355, -469.34183, 2534.91943, 195.62523,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -472.32114, 2534.93115, 195.63609,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -475.33246, 2534.92456, 195.62903,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -478.31314, 2534.93384, 195.63760,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -481.30399, 2534.93701, 195.64122,   0.00000, 0.00000, 89.94000);
	CreateDynamicObject(19355, -484.29495, 2534.94287, 195.64482,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -487.28595, 2534.94702, 195.64835,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -490.27704, 2534.95044, 195.65181,   0.00000, 0.00000, 89.94000);
	CreateDynamicObject(19355, -493.25897, 2534.96167, 195.65976,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -496.26907, 2534.95483, 195.65404,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -499.25177, 2534.96313, 195.66066,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -502.24203, 2534.96899, 195.66632,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -505.21860, 2535.00098, 195.67575,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -508.23557, 2534.99146, 195.66829,   0.00000, 0.00000, 89.88000);
	CreateDynamicObject(19355, -510.93347, 2535.04395, 195.67018,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, -512.56897, 2483.38110, 195.70714,   0.00000, 0.00000, -0.12000);
	CreateDynamicObject(19355, -512.55731, 2489.37817, 195.70610,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.54614, 2491.87695, 195.70360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.51385, 2513.86597, 195.69312,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.52374, 2516.87012, 195.69846,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.50153, 2519.86450, 195.69177,   0.00000, 0.00000, -0.06000);
	CreateDynamicObject(19355, -512.49011, 2522.86157, 195.68904,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -512.47839, 2525.85864, 195.68623,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18783, -603.32239, 2503.19727, 192.10037,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18783, -623.32587, 2503.20508, 192.10037,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18783, -623.32477, 2523.20435, 192.10037,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18783, -623.32300, 2483.21631, 192.10037,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18783, -643.31049, 2483.21680, 192.10037,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18783, -643.30841, 2503.21362, 192.10037,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18783, -643.32428, 2523.20508, 192.10037,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18783, -663.30817, 2523.20166, 192.10037,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18783, -663.30835, 2503.19873, 192.10037,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18783, -663.30933, 2483.22046, 192.10037,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18784, -663.32739, 2483.19092, 196.99034,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(18784, -663.33350, 2503.19946, 196.99034,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(18784, -663.32452, 2523.22119, 196.99034,   0.00000, 0.00000, 180.00000);

	CreateVehicle(522, 378.1269, 2527.1470, 16.0750, 200.0000, -1, -1, 100);
	CreateVehicle(522, 376.6887, 2527.2148, 16.0750, 200.0000, -1, -1, 100);
	CreateVehicle(522, 375.0460, 2527.2148, 16.0750, 200.0000, -1, -1, 100);
	CreateVehicle(522, 373.3409, 2527.1785, 16.0750, 200.0000, -1, -1, 100);
	CreateVehicle(522, 371.4434, 2527.2744, 16.0750, 200.0000, -1, -1, 100);
	CreateVehicle(522, 405.8875, 2527.3479, 16.0750, 200.0000, -1, -1, 100);
	CreateVehicle(522, 404.4044, 2527.3074, 16.0750, 200.0000, -1, -1, 100);
	CreateVehicle(522, 402.9237, 2527.3257, 16.0750, 200.0000, -1, -1, 100);
	CreateVehicle(522, 401.3574, 2527.2078, 16.0750, 200.0000, -1, -1, 100);
	CreateVehicle(557, 363.9923, 2532.1865, 16.8347, 180.0000, -1, -1, 100);
	CreateVehicle(557, 363.9495, 2538.8718, 16.8347, 180.0000, -1, -1, 100);
	CreateVehicle(557, 363.9165, 2545.2625, 16.8347, 180.0000, -1, -1, 100);
	CreateVehicle(411, 381.2227, 2480.5186, 16.2194, 20.8200, -1, -1, 100);
	CreateVehicle(411, 384.4733, 2480.8774, 16.2194, 20.8200, -1, -1, 100);
	CreateVehicle(411, 387.7145, 2481.4182, 16.2194, 20.8200, -1, -1, 100);
	CreateVehicle(424, 420.5409, 2479.1211, 16.1972, 24.3000, -1, -1, 100);
	CreateVehicle(424, 423.6782, 2479.6584, 16.1972, 24.3000, -1, -1, 100);
	CreateVehicle(424, 426.9475, 2479.6284, 16.1972, 24.3000, -1, -1, 100);
	CreateVehicle(522, 491.9047, 2523.8376, 40.3259, 180.0000, -1, -1, 100);
	CreateVehicle(522, 490.7882, 2523.7966, 40.3259, 180.0000, -1, -1, 100);
	CreateVehicle(522, 489.5770, 2523.8289, 40.3259, 180.0000, -1, -1, 100);
	CreateVehicle(522, 492.1261, 2480.7961, 40.3259, 0.0000, -1, -1, 100);
	CreateVehicle(522, 491.0247, 2480.7986, 40.3259, 0.0000, -1, -1, 100);
	CreateVehicle(522, 489.8033, 2480.7935, 40.3259, 0.0000, -1, -1, 100);
	CreateVehicle(520, 302.9716, 1800.7097, 18.1517, 0.0000, -1, -1, 100);
	CreateVehicle(520, 314.3813, 1800.7156, 18.1517, 0.0000, -1, -1, 100);
	CreateVehicle(432, 331.2376, 1807.6104, 17.2076, 89.8800, -1, -1, 100);
	CreateVehicle(432, 331.3034, 1813.0337, 17.2076, 89.8800, -1, -1, 100);
	CreateVehicle(520, 314.6324, 2050.8337, 18.3661, 180.0000, -1, -1, 100);
	CreateVehicle(520, 301.8925, 2050.8965, 18.3661, 180.0000, -1, -1, 100);
	CreateVehicle(432, 277.2743, 2031.2571, 17.6173, -118.4400, -1, -1, 100);
	CreateVehicle(432, 278.3077, 2017.6031, 17.6173, -57.2401, -1, -1, 100);
	CreateVehicle(539, 274.1783, 2000.4640, 17.0883, -90.0000, -1, -1, 100);
	CreateVehicle(539, 274.6654, 1997.6603, 17.0883, -90.0000, -1, -1, 100);
	CreateVehicle(539, 274.6277, 1994.9243, 17.0883, -90.0000, -1, -1, 100);
	CreateVehicle(539, 274.6739, 1992.1068, 17.0883, -90.0000, -1, -1, 100);
	CreateVehicle(539, 274.6257, 1989.3533, 17.0883, -90.0000, -1, -1, 100);
	CreateVehicle(539, 274.6310, 1986.4713, 17.0883, -90.0000, -1, -1, 100);
	CreateVehicle(539, 274.7418, 1983.4427, 17.0883, -90.0000, -1, -1, 100);
	CreateVehicle(539, 274.7335, 1980.3326, 17.0883, -90.0000, -1, -1, 100);
	CreateVehicle(539, 274.5863, 1977.4958, 17.0883, -90.0000, -1, -1, 100);
	CreateVehicle(476, 277.9619, 1949.9514, 18.6483, -49.5000, -1, -1, 100);
	CreateVehicle(476, 277.4466, 1962.1387, 18.6483, -122.7600, -1, -1, 100);
	CreateVehicle(476, 278.8922, 1934.0715, 18.5998, -117.3599, -1, -1, 100);
	CreateVehicle(476, 279.3099, 1924.1010, 18.5998, -117.0600, -1, -1, 100);

}

//----------------------------(STUNT AIRPORTS)----------------------------------

Stunts()
{
	CreateDynamicObject(18649, -1221.81995, -20.98000, 13.17000,   0.00000, 0.00000, 317.98999);
	CreateDynamicObject(18646, -1248.93005, -36.62000, 20.40000,   312.00000, 0.00000, 110.00000);
	CreateDynamicObject(18857, -1370.92004, -216.44000, 16.27000,   0.00000, 214.00000, 348.00000);
	CreateDynamicObject(18857, -1387.01001, -213.02000, 27.36000,   0.00000, 213.99001, 347.98999);
	CreateDynamicObject(18857, -1403.22998, -209.58000, 38.54000,   0.00000, 213.99001, 347.98999);
	CreateDynamicObject(18777, -1278.57996, 93.08000, 15.64000,   0.00000, 0.00000, 44.74000);
	CreateDynamicObject(18830, -1352.90002, -254.24001, 15.72000,   0.00000, 212.00000, 45.25000);
	CreateDynamicObject(18830, -1361.31995, -245.99001, 15.77000,   0.00000, 211.99001, 45.24000);
	CreateDynamicObject(18786, -1334.55005, 85.94000, 14.64000,   0.00000, 3.99000, 277.98999);
	CreateDynamicObject(18786, -1336.57996, 100.26000, 24.19000,   0.00000, 33.99000, 277.98999);
	CreateDynamicObject(18984, -1545.29004, -163.24001, 18.17000,   0.00000, 0.49000, 315.23999);
	CreateDynamicObject(18850, -1245.16797, 39.04099, 1.84000,   0.00000, 0.00000, 315.48999);
	CreateDynamicObject(619, -1226.52002, 39.51000, 13.98000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18848, -1185.50000, 7.87000, 12.58000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18717, -1270.41003, 44.95000, 11.44000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18717, -1274.21997, 48.60000, 11.44000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1280.00000, 34.37000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1284.42004, 29.87000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1288.15002, 26.26000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1292.03003, 22.31000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1295.81995, 18.20000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1299.60999, 14.49000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1284.22998, 38.61000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1288.67004, 34.25000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1292.18005, 30.61000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1296.44995, 26.33000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1300.42004, 22.88000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1304.47998, 19.09000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8557, -1370.90002, -44.78000, 11.64000,   0.00000, 0.00000, 45.25000);
	CreateDynamicObject(8558, -1370.90002, -44.78000, 11.64000,   0.00000, 0.00000, 45.25000);
	CreateDynamicObject(8558, -1374.67004, -48.38000, 11.97000,   0.00000, 7.19000, 45.25000);
	CreateDynamicObject(8558, -1378.38000, -51.93000, 12.95000,   0.00000, 14.39000, 45.25000);
	CreateDynamicObject(8558, -1381.97998, -55.36000, 14.56000,   0.00000, 21.59000, 45.25000);
	CreateDynamicObject(8558, -1385.41003, -58.62000, 16.79000,   0.00000, 28.79000, 45.25000);
	CreateDynamicObject(8558, -1388.60999, -61.65000, 19.59000,   0.00000, 36.00000, 45.25000);
	CreateDynamicObject(8558, -1391.55005, -64.41000, 22.92000,   0.00000, 43.20000, 45.25000);
	CreateDynamicObject(8558, -1394.16003, -66.86000, 26.72000,   0.00000, 50.40000, 45.25000);
	CreateDynamicObject(8558, -1396.43005, -68.94000, 30.95000,   0.00000, 57.60000, 45.25000);
	CreateDynamicObject(8558, -1398.30005, -70.63000, 35.53000,   0.00000, 64.80000, 45.25000);
	CreateDynamicObject(8558, -1399.75000, -71.89000, 40.39000,   0.00000, 72.00000, 45.25000);
	CreateDynamicObject(8558, -1400.76001, -72.72000, 45.45000,   0.00000, 79.19000, 45.25000);
	CreateDynamicObject(8558, -1401.31995, -73.08000, 50.63000,   0.00000, 86.39000, 45.25000);
	CreateDynamicObject(8558, -1401.42004, -72.99000, 55.85000,   0.00000, 93.59000, 45.25000);
	CreateDynamicObject(8558, -1401.06006, -72.42000, 61.04000,   0.00000, 100.79000, 45.25000);
	CreateDynamicObject(8558, -1400.25000, -71.40000, 66.10000,   0.00000, 107.99000, 45.25000);
	CreateDynamicObject(8558, -1398.98999, -69.94000, 70.96000,   0.00000, 115.19000, 45.25000);
	CreateDynamicObject(8558, -1397.31995, -68.05000, 75.53000,   0.00000, 122.39000, 45.25000);
	CreateDynamicObject(8558, -1395.26001, -65.77000, 79.76000,   0.00000, 129.59000, 45.25000);
	CreateDynamicObject(8558, -1392.83997, -63.13000, 83.57000,   0.00000, 136.78999, 45.25000);
	CreateDynamicObject(8558, -1390.09998, -60.18000, 86.90000,   0.00000, 143.99001, 45.25000);
	CreateDynamicObject(8558, -1387.09998, -56.94000, 89.70000,   0.00000, 151.19000, 45.25000);
	CreateDynamicObject(8558, -1383.87000, -53.49000, 91.92000,   0.00000, 158.39000, 45.25000);
	CreateDynamicObject(8558, -1380.46997, -49.86000, 93.54000,   0.00000, 165.59000, 45.25000);
	CreateDynamicObject(8558, -1376.95996, -46.12000, 94.52000,   0.00000, 172.78999, 45.25000);
	CreateDynamicObject(8558, -1373.39001, -42.32000, 94.84000,   0.00000, 179.99001, 45.25000);
	CreateDynamicObject(8558, -1369.81006, -38.51000, 94.52000,   0.00000, 187.19000, 45.25000);
	CreateDynamicObject(8558, -1366.30005, -34.77000, 93.54000,   0.00000, 194.39000, 45.25000);
	CreateDynamicObject(8558, -1362.90002, -31.14000, 91.92000,   0.00000, 201.59000, 45.25000);
	CreateDynamicObject(8558, -1359.67004, -27.69000, 89.70000,   0.00000, 208.78999, 45.25000);
	CreateDynamicObject(8558, -1356.67004, -24.46000, 86.90000,   0.00000, 215.99001, 45.25000);
	CreateDynamicObject(8558, -1353.93005, -21.50000, 83.57000,   0.00000, 223.19000, 45.25000);
	CreateDynamicObject(8558, -1351.51001, -18.86000, 79.76000,   0.00000, 230.39000, 45.24000);
	CreateDynamicObject(8558, -1349.44995, -16.58000, 75.53000,   0.00000, 237.59000, 45.25000);
	CreateDynamicObject(8558, -1347.78003, -14.70000, 70.96000,   0.00000, 244.78999, 45.25000);
	CreateDynamicObject(8558, -1346.53003, -13.23000, 66.10000,   0.00000, 251.99001, 45.25000);
	CreateDynamicObject(8558, -1345.70996, -12.21000, 61.04000,   0.00000, 259.19000, 45.25000);
	CreateDynamicObject(8558, -1345.34998, -11.65000, 55.85000,   0.00000, 266.39001, 45.25000);
	CreateDynamicObject(8558, -1345.44995, -11.55000, 50.63000,   0.00000, 273.59000, 45.25000);
	CreateDynamicObject(8558, -1346.01001, -11.91000, 45.45000,   0.00000, 280.79001, 45.25000);
	CreateDynamicObject(8558, -1347.02002, -12.74000, 40.39000,   0.00000, 287.98999, 45.25000);
	CreateDynamicObject(8558, -1348.47998, -14.01000, 35.53000,   0.00000, 295.19000, 45.25000);
	CreateDynamicObject(8558, -1350.34998, -15.70000, 30.95000,   0.00000, 302.39001, 45.25000);
	CreateDynamicObject(8558, -1352.60999, -17.78000, 26.72000,   0.00000, 309.60001, 45.25000);
	CreateDynamicObject(8558, -1355.22998, -20.22000, 22.92000,   0.00000, 316.79999, 45.25000);
	CreateDynamicObject(8558, -1358.16003, -22.98000, 19.59000,   0.00000, 324.00000, 45.25000);
	CreateDynamicObject(8558, -1361.35999, -26.01000, 16.79000,   0.00000, 331.20001, 45.25000);
	CreateDynamicObject(8558, -1364.79004, -29.27000, 14.56000,   0.00000, 338.39999, 45.25000);
	CreateDynamicObject(8558, -1368.39001, -32.70000, 12.95000,   0.00000, 345.60001, 45.25000);
	CreateDynamicObject(8558, -1372.09998, -36.25000, 11.97000,   0.00000, 352.79999, 45.25000);
	CreateDynamicObject(8558, -1375.87000, -39.85000, 11.64000,   0.00000, 360.00000, 45.25000);
	CreateDynamicObject(18647, -1353.07996, -33.95000, 13.17000,   0.00000, 0.00000, 45.25000);
	CreateDynamicObject(18648, -1356.60999, -30.46000, 13.17000,   0.00000, 0.00000, 46.00000);
	CreateDynamicObject(1318, -1275.09998, 43.66000, 13.09000,   0.00000, 90.00000, 45.99000);
	CreateDynamicObject(2036, -1183.65002, 10.79000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2035, -1183.70996, 10.10000, 13.17000,   0.00000, 0.00000, 48.00000);
	CreateDynamicObject(2044, -1183.06006, 10.47000, 13.20000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2045, -1184.33997, 9.97000, 13.27000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2061, -1184.46997, 8.51000, 13.44000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2064, -1224.08997, 52.11000, 13.76000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6976, -1196.14001, 194.64000, 4.32000,   0.00000, 0.00000, 314.73999);
	CreateDynamicObject(12990, -1209.42004, 206.96001, 0.10000,   0.00000, 0.00000, 46.00000);
	CreateDynamicObject(18766, -1651.06006, -230.75999, 10.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1660.93005, -230.75000, 10.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1662.00000, -227.14999, 10.66000,   0.00000, 0.00000, 44.00000);
	CreateDynamicObject(18766, -1654.90002, -220.28999, 10.66000,   0.00000, 0.00000, 43.99000);
	CreateDynamicObject(18766, -1650.55005, -216.13000, 10.66000,   0.00000, 0.00000, 43.99000);
	CreateDynamicObject(18766, -1651.59998, -212.50999, 10.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1660.77002, -212.53000, 10.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18772, -1293.28003, -94.87000, 88.53000,   324.00000, 0.00000, 316.00000);
	CreateDynamicObject(18772, -1433.65002, -240.22000, 235.36000,   323.98999, 0.00000, 315.98999);
	CreateDynamicObject(8558, -1209.31995, -11.27000, 13.14000,   0.00000, 342.00000, 46.00000);
	CreateDynamicObject(8558, -1209.31995, -11.27000, 13.14000,   0.00000, 342.00000, 46.00000);
	CreateDynamicObject(8558, -1205.93994, -7.78000, 15.07000,   0.00000, 334.79001, 46.00000);
	CreateDynamicObject(8558, -1202.76001, -4.49000, 17.58000,   0.00000, 327.59000, 46.00000);
	CreateDynamicObject(8558, -1199.82996, -1.45000, 20.65000,   0.00000, 320.39001, 45.99000);
	CreateDynamicObject(8558, -1197.18005, 1.28000, 24.23000,   0.00000, 313.19000, 46.00000);
	CreateDynamicObject(8558, -1192.92004, 5.69000, 32.67000,   0.00000, 298.79001, 46.00000);
	CreateDynamicObject(8558, -1191.38000, 7.29000, 37.39000,   0.00000, 291.59000, 45.99000);
	CreateDynamicObject(8558, -1190.26001, 8.45000, 42.36000,   0.00000, 284.39001, 46.00000);
	CreateDynamicObject(8558, -1189.57996, 9.16000, 47.50000,   0.00000, 277.19000, 46.00000);
	CreateDynamicObject(8558, -1189.34998, 9.39000, 52.71000,   0.00000, 269.98999, 46.00000);
	CreateDynamicObject(8558, -1189.57996, 9.16000, 57.92000,   0.00000, 262.79001, 46.00000);
	CreateDynamicObject(8558, -1190.26001, 8.45000, 63.06000,   0.00000, 255.59000, 46.00000);
	CreateDynamicObject(8558, -1191.38000, 7.29000, 68.02000,   0.00000, 248.39000, 46.00000);
	CreateDynamicObject(8558, -1657.64001, -166.61000, 11.69000,   358.00000, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1212.89001, -7.84000, 13.14000,   0.00000, 341.98999, 45.99000);
	CreateDynamicObject(8558, -1209.51001, -4.35000, 15.07000,   0.00000, 334.79001, 45.99000);
	CreateDynamicObject(8558, -1206.32996, -1.05000, 17.58000,   0.00000, 327.59000, 45.99000);
	CreateDynamicObject(8558, -1203.40002, 1.98000, 20.65000,   0.00000, 320.39001, 45.99000);
	CreateDynamicObject(8558, -1200.75000, 4.72000, 24.23000,   0.00000, 313.19000, 45.99000);
	CreateDynamicObject(8558, -1198.43994, 7.11000, 28.26000,   0.00000, 305.98999, 45.99000);
	CreateDynamicObject(8558, -1196.48999, 9.13000, 32.67000,   0.00000, 298.79001, 45.99000);
	CreateDynamicObject(8558, -1194.94995, 10.73000, 37.40000,   0.00000, 291.59000, 45.99000);
	CreateDynamicObject(8558, -1193.82996, 11.89000, 42.36000,   0.00000, 284.39001, 45.99000);
	CreateDynamicObject(8558, -1193.15002, 12.59000, 47.50000,   0.00000, 277.19000, 45.99000);
	CreateDynamicObject(8558, -1192.92004, 12.83000, 52.71000,   0.00000, 269.98999, 45.99000);
	CreateDynamicObject(8558, -1193.15002, 12.59000, 57.92000,   0.00000, 262.79001, 45.99000);
	CreateDynamicObject(8558, -1193.82996, 11.89000, 63.06000,   0.00000, 255.59000, 45.99000);
	CreateDynamicObject(8558, -1194.94995, 10.73000, 68.02000,   0.00000, 248.39000, 45.99000);
	CreateDynamicObject(18859, -1481.48999, 69.91000, 24.18000,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(18859, -1473.70996, 61.90000, 62.00000,   90.00000, 179.59000, 225.39000);
	CreateDynamicObject(18822, -1490.84998, -37.74000, 24.73000,   0.00000, 291.98999, 316.00000);
	CreateDynamicObject(18809, -1519.63000, -9.97000, 52.81000,   312.00000, 0.00000, 46.00000);
	CreateDynamicObject(18809, -1546.29004, 15.74000, 86.16000,   311.98999, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1572.94995, 41.46000, 119.52000,   311.98999, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1599.60999, 67.18000, 152.87000,   311.98001, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1626.26001, 92.90000, 186.23000,   311.98001, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1652.92004, 118.62000, 219.58000,   311.97000, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1679.57996, 144.35001, 252.94000,   311.97000, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1706.23999, 170.07001, 286.29001,   311.95999, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1732.89001, 195.78999, 319.64999,   311.95999, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1759.55005, 221.50999, 353.00000,   311.95001, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1786.20996, 247.23000, 386.35999,   311.95001, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1812.87000, 272.95001, 419.70999,   311.94000, 0.00000, 45.99000);
	CreateDynamicObject(18778, -1468.43005, -59.32000, 14.76000,   358.00000, 0.00000, 225.99001);
	CreateDynamicObject(18778, -1463.45996, -64.13000, 18.56000,   15.99000, 0.00000, 225.99001);
	CreateDynamicObject(8558, -1212.89001, -7.84000, 13.14000,   0.00000, 341.98999, 45.99000);
	CreateDynamicObject(8558, -1657.64001, -166.61000, 11.69000,   358.00000, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1661.25000, -170.32001, 12.41000,   346.00000, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1664.67004, -173.84000, 14.20000,   334.00000, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1667.76001, -177.00999, 16.97000,   322.00000, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1670.39001, -179.70000, 20.60000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1672.63000, -182.03000, 24.45000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1674.87000, -184.35001, 28.30000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1677.12000, -186.67999, 32.15000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1679.35999, -189.00000, 36.00000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1681.60999, -191.33000, 39.85000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1683.84998, -193.64999, 43.70000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1686.09998, -195.98000, 47.55000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1688.33997, -198.30000, 51.40000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1690.58997, -200.63000, 55.25000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1692.82996, -202.95000, 59.10000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1695.06995, -205.28000, 62.95000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1697.31995, -207.60001, 66.80000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1699.56006, -209.92999, 70.65000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1701.81006, -212.25000, 74.50000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1704.05005, -214.58000, 78.35000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1706.30005, -216.89999, 82.20000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1708.54004, -219.23000, 86.05000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1710.78003, -221.56000, 89.90000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1713.03003, -223.88000, 93.75000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1715.27002, -226.21001, 97.60000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1717.52002, -228.53000, 101.45000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1719.76001, -230.86000, 105.30000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1722.01001, -233.17999, 109.15000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1724.25000, -235.50999, 113.00000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1726.50000, -237.83000, 116.85000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1728.73999, -240.16000, 120.70000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1730.97998, -242.48000, 124.55000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1733.22998, -244.81000, 128.39999,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1735.46997, -247.13000, 132.25000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1737.71997, -249.46001, 136.10001,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1739.95996, -251.78000, 139.95000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1742.20996, -254.11000, 143.80000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1744.44995, -256.42999, 147.64999,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1746.68994, -258.76001, 151.50000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1748.93994, -261.07999, 155.35001,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1751.18005, -263.41000, 159.20000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1753.43005, -265.73001, 163.05000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1755.67004, -268.06000, 166.89999,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1757.92004, -270.38000, 170.75000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1760.16003, -272.70999, 174.60001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1762.41003, -275.04001, 178.45000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1764.65002, -277.35999, 182.30000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1766.89001, -279.69000, 186.14999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1769.14001, -282.01001, 190.00000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1771.38000, -284.34000, 193.85001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1773.63000, -286.66000, 197.70000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1775.87000, -288.98999, 201.55000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1778.10999, -291.31000, 205.39999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1780.35999, -293.64001, 209.25000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1782.59998, -295.95999, 213.10001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1784.84998, -298.29001, 216.95000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1787.08997, -300.60999, 220.80000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1789.32996, -302.94000, 224.64999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1791.57996, -305.26001, 228.50000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1793.81995, -307.59000, 232.35001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1796.06995, -309.91000, 236.20000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1798.31006, -312.23999, 240.05000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1800.56006, -314.56000, 243.89999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1802.80005, -316.89001, 247.75000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1805.04004, -319.20999, 251.60001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1807.29004, -321.54001, 255.45000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1809.53003, -323.85999, 259.29999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1811.78003, -326.19000, 263.14999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1814.02002, -328.51001, 267.00000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1816.26001, -330.84000, 270.85001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1818.51001, -333.16000, 274.70001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1820.75000, -335.48999, 278.54999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1823.00000, -337.82001, 282.39999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1825.23999, -340.14001, 286.25000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1827.48999, -342.47000, 290.10001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1829.72998, -344.79001, 293.95001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1831.96997, -347.12000, 297.79999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1834.21997, -349.44000, 301.64999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1836.45996, -351.76999, 305.50000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1838.70996, -354.09000, 309.35001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1840.94995, -356.42001, 313.20001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1843.18994, -358.73999, 317.04999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1845.43994, -361.07001, 320.89999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1847.68005, -363.39001, 324.75000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1849.93005, -365.72000, 328.60001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1852.17004, -368.04001, 332.45001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1854.28003, -370.22000, 333.85001,   359.98999, 359.98001, 315.75000);
	CreateDynamicObject(8558, -1857.80005, -373.84000, 333.85001,   359.98999, 359.98001, 315.75000);
	CreateDynamicObject(8558, -1861.31995, -377.45001, 333.85001,   359.98999, 359.98001, 315.75000);
	CreateDynamicObject(8558, -1864.83997, -381.07001, 333.85001,   359.98999, 359.98001, 315.75000);
	CreateDynamicObject(8558, -1868.34998, -384.67999, 333.85001,   359.98999, 359.98001, 315.75000);
	CreateDynamicObject(8558, -1871.87000, -388.29999, 333.85001,   359.98001, 359.98001, 315.75000);
	CreateDynamicObject(8558, -1875.39001, -391.91000, 333.85001,   359.98001, 359.98001, 315.73999);
	CreateDynamicObject(18780, -1612.93994, -134.58000, 24.80000,   0.00000, 0.00000, 44.74000);
	CreateDynamicObject(18779, -1799.23999, -284.14001, 233.61000,   0.00000, 310.00000, 226.00000);
	CreateDynamicObject(710, -1445.20996, 76.02000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1430.66003, 90.58000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1416.10999, 105.15000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1401.55005, 119.71000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1387.00000, 134.28000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1372.44995, 148.84000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1357.90002, 163.41000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1343.33997, 177.97000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1328.79004, 192.53999, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1314.23999, 207.10001, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1299.68005, 221.67000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1285.13000, 236.23000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1270.57996, 250.80000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1226.92004, 294.48999, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1212.37000, 309.06000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1197.81006, 323.62000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1183.26001, 338.19000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1168.70996, 352.75000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1154.15002, 367.32001, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1139.59998, 381.88000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(714, -1382.91003, 56.17000, 13.12000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1438.06006, 83.28000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1423.82996, 97.54000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1409.59998, 111.79000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1395.37000, 126.04000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1381.14001, 140.28999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1366.90002, 154.55000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1352.67004, 168.80000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1338.43994, 183.05000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1324.20996, 197.30000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1309.97998, 211.56000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1295.75000, 225.81000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1281.51001, 240.06000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1267.28003, 254.31000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1224.58997, 297.07001, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1210.35999, 311.32001, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1196.12000, 325.57999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1181.89001, 339.82999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1167.66003, 354.07999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1153.43005, 368.32999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1139.19995, 382.57999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1198.28003, 265.57999, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1183.82996, 280.44000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1168.65002, 295.45999, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1153.55005, 309.82001, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1139.43994, 323.26001, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1125.30005, 338.07999, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1110.43005, 353.04001, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1138.83997, 324.67999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1124.35999, 338.89999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1109.88000, 353.39999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1152.44995, 311.20001, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1167.15002, 296.69000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1181.89001, 282.01001, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1195.81995, 267.53000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18781, -1563.70996, -30.07000, 23.12000,   0.00000, 0.00000, 44.98000);
	CreateDynamicObject(18786, -1487.93994, -186.69000, 15.49000,   0.00000, 0.00000, 225.25000);
	CreateDynamicObject(18786, -1476.63000, -175.25000, 24.32000,   0.00000, 28.00000, 225.24001);
	CreateDynamicObject(18801, -1232.37000, 254.89999, 35.52000,   0.00000, 0.00000, 319.98999);
	CreateDynamicObject(18778, -1236.71997, 274.01001, 14.74000,   11.99000, 0.00000, 45.99000);
	CreateDynamicObject(18778, -1240.68994, 277.85001, 19.64000,   27.99000, 0.00000, 45.99000);
	CreateDynamicObject(18830, -1720.20996, -309.00000, 16.47000,   359.98999, 202.00000, 359.98999);
	CreateDynamicObject(18830, -1720.19995, -297.54999, 16.47000,   359.98999, 201.99001, 359.98999);
	CreateDynamicObject(18830, -1710.07996, -218.64999, 16.47000,   359.98999, 201.99001, 315.23999);
	CreateDynamicObject(18772, -1354.19995, 193.89000, 41.64000,   0.00000, 0.00000, 45.99000);
	CreateDynamicObject(18777, -1429.50000, 294.26999, 15.63000,   0.00000, 0.00000, 224.00000);
	CreateDynamicObject(18778, -1446.52002, 282.48999, 10.38000,   16.00000, 0.00000, 223.75000);
	CreateDynamicObject(18778, -1451.31995, 287.50000, 6.13000,   3.74000, 0.00000, 223.74001);
	CreateDynamicObject(710, -1458.00000, 281.29001, 21.54000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1444.67004, 293.73001, 21.32000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1346.52002, 292.19000, 8.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1356.40002, 292.19000, 8.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1366.29004, 292.17999, 8.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1376.18005, 292.17001, 8.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1386.06006, 292.17001, 8.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1346.52002, 292.19000, 13.53000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1346.52002, 292.19000, 18.51000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1346.52002, 292.19000, 23.48000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1346.52002, 292.19000, 28.46000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1356.40002, 292.19000, 13.53000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1356.40002, 292.19000, 18.51000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1356.40002, 292.17999, 23.48000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1356.40002, 292.17999, 28.46000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1366.29004, 292.17999, 13.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1366.29004, 292.17999, 18.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1366.29004, 292.17999, 23.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1366.29004, 292.17999, 28.46000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1376.18005, 292.17001, 13.51000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1376.18005, 292.17001, 18.53000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1376.18005, 292.17001, 23.51000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1376.18005, 292.17001, 28.46000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1386.06006, 292.17001, 13.51000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1386.06006, 292.17001, 18.48000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1386.06006, 292.17001, 23.48000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1386.06006, 292.17001, 28.46000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18758, -1365.87000, 299.51999, 8.11000,   0.00000, 0.00000, 270.23999);
	CreateDynamicObject(18766, -1370.38000, 296.57001, 8.56000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18755, -1365.91003, 299.48001, 8.12000,   0.00000, 0.00000, 270.48999);
	CreateDynamicObject(18766, -1361.41003, 296.60999, 8.56000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, -1370.31006, 296.57001, 13.56000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, -1370.31006, 296.57001, 18.56000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, -1370.31006, 296.57001, 23.56000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, -1370.30005, 296.57001, 28.46000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, -1361.48999, 296.60001, 13.53000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, -1361.48999, 296.60001, 18.51000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, -1361.48999, 296.60001, 23.48000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, -1361.48999, 296.60001, 28.46000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18756, -1365.81006, 303.31000, 8.15000,   0.00000, 0.00000, 90.75000);
	CreateDynamicObject(18757, -1365.78003, 303.31000, 8.14000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18766, -1365.89001, 301.09000, 13.53000,   0.00000, 0.00000, 0.25000);
	CreateDynamicObject(18766, -1365.89001, 301.07999, 18.48000,   0.00000, 0.00000, 0.24000);
	CreateDynamicObject(18766, -1365.89001, 301.07999, 23.43000,   0.00000, 0.00000, 0.24000);
	CreateDynamicObject(18758, -1365.87000, 299.51999, 27.74000,   0.00000, 0.00000, 270.23999);
	CreateDynamicObject(18766, -1365.87000, 299.10001, 31.38000,   270.00000, 180.00000, 180.00000);
	CreateDynamicObject(18766, -1365.87000, 294.35001, 31.38000,   270.00000, 179.99001, 179.99001);
	CreateDynamicObject(18757, -1365.80005, 303.32999, 27.89000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18756, -1365.84998, 303.31000, 27.90000,   0.00000, 0.00000, 90.74000);
	CreateDynamicObject(18766, -1365.90002, 304.01999, 25.43000,   270.00000, 179.99001, 179.99001);
	CreateDynamicObject(18766, -1365.90002, 308.95001, 25.43000,   270.00000, 179.99001, 179.99001);
	CreateDynamicObject(18766, -1365.90002, 313.88000, 25.43000,   270.00000, 179.99001, 179.99001);
	CreateDynamicObject(18766, -1365.91003, 318.81000, 25.43000,   270.00000, 179.99001, 179.99001);
	CreateDynamicObject(18766, -1365.91003, 323.73999, 25.43000,   270.00000, 179.99001, 179.99001);
	CreateDynamicObject(18771, -1360.95996, 307.56000, -23.96000,   0.00000, 0.00000, 89.75000);
	CreateDynamicObject(18778, -1458.39001, 316.78000, 8.63000,   20.00000, 0.00000, 90.00000);
	CreateDynamicObject(18778, -1463.41003, 316.78000, 15.13000,   41.99000, 0.00000, 90.00000);
	CreateDynamicObject(18778, -1465.58997, 316.81000, 20.93000,   53.48000, 0.00000, 90.00000);
	CreateDynamicObject(18781, -1468.82996, 394.66000, 31.11000,   0.00000, 0.00000, 91.50000);
	CreateDynamicObject(3279, -1348.18005, 340.41000, 28.68000,   0.00000, 0.00000, 89.25000);
	CreateDynamicObject(3279, -1348.14001, 439.53000, 29.08000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(16641, -1485.45996, 294.42999, 53.99000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3092, -1445.39001, 77.31000, 14.51000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, -1386.64001, 60.51000, 13.99000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, -1388.06995, 57.23000, 13.99000,   0.00000, 0.00000, 32.00000);
	CreateDynamicObject(869, -1388.43005, 53.27000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1386.15002, 51.82000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1382.28003, 50.30000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1379.22998, 51.45000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1377.43005, 55.10000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1377.77002, 57.55000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1380.92004, 60.85000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1383.52002, 61.55000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1379.27002, 59.30000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1376.88000, 53.75000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1380.63000, 52.50000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1383.97998, 50.95000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1387.88000, 55.75000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1387.38000, 59.05000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(17310, -1181.48999, -75.65000, 18.66000,   0.19000, 141.74001, 44.64000);
	CreateDynamicObject(19262, -1647.73999, -366.64001, 17.88000,   0.00000, 0.00000, 335.98999);
	CreateDynamicObject(18784, -1210.00000, -270.14001, 15.64000,   0.00000, 0.00000, 88.99000);
	CreateDynamicObject(18784, -1178.21997, -270.70999, 15.64000,   0.00000, 0.00000, 88.99000);
	CreateDynamicObject(18784, -1209.73999, -255.06000, 24.14000,   0.00000, 330.00000, 88.99000);
	CreateDynamicObject(18784, -1177.94995, -255.74001, 24.14000,   0.00000, 329.98999, 88.98000);
	CreateDynamicObject(18784, -1177.78003, -245.77000, 37.92000,   0.00000, 311.23999, 88.98000);
	CreateDynamicObject(18784, -1209.58997, -245.08000, 37.92000,   0.00000, 311.23999, 88.98000);
	CreateDynamicObject(18784, -1177.50000, -228.94000, 37.92000,   0.00000, 311.23999, 268.98001);
	CreateDynamicObject(18784, -1177.31995, -217.58000, 22.22000,   0.00000, 329.98999, 268.98001);
	CreateDynamicObject(18784, -1177.16003, -205.16000, 15.42000,   0.00000, 0.00000, 269.48999);
	CreateDynamicObject(18784, -1209.28003, -228.16000, 37.92000,   0.00000, 311.23001, 268.97000);
	CreateDynamicObject(18784, -1209.06995, -216.85001, 22.29000,   0.00000, 329.98999, 268.98001);
	CreateDynamicObject(18784, -1208.92004, -204.03000, 15.42000,   0.00000, 0.00000, 269.48999);
	CreateDynamicObject(3851, -1583.39001, -147.42999, 15.49000,   0.00000, 0.00000, 358.98001);
	CreateDynamicObject(3851, -1583.39001, -147.42999, 23.29000,   0.00000, 0.00000, 358.97000);
	CreateDynamicObject(3851, -1583.39001, -147.42999, 31.09000,   0.00000, 0.00000, 358.95999);
	CreateDynamicObject(3851, -1583.39001, -147.42999, 38.89000,   0.00000, 0.00000, 358.95001);
	CreateDynamicObject(3851, -1583.39001, -147.42999, 46.69000,   0.00000, 0.00000, 358.94000);
	CreateDynamicObject(3851, -1583.39001, -147.42999, 54.49000,   0.00000, 0.00000, 358.92999);
	CreateDynamicObject(3851, -1588.19995, -144.53999, 15.49000,   0.00000, 0.00000, 118.97000);
	CreateDynamicObject(3851, -1588.32996, -150.17999, 23.26643,   0.00000, 0.00000, 58.98000);
	CreateDynamicObject(3851, -1578.66003, -156.00999, 15.49000,   0.00000, 0.00000, 58.98000);
	CreateDynamicObject(3851, -1578.66003, -156.00999, 19.39000,   0.00000, 0.00000, 58.98000);
	CreateDynamicObject(3851, -1578.65002, -156.00000, 23.29000,   0.00000, 0.00000, 58.97000);
	CreateDynamicObject(3851, -1578.65002, -156.00000, 27.19000,   0.00000, 0.00000, 58.98000);
	CreateDynamicObject(3851, -1578.65002, -156.00000, 31.09000,   0.00000, 0.00000, 58.98000);
	CreateDynamicObject(3851, -1578.65002, -156.00000, 34.99000,   0.00000, 0.00000, 58.98000);
	CreateDynamicObject(3851, -1578.65002, -156.00000, 38.89000,   0.00000, 0.00000, 58.97000);
	CreateDynamicObject(3851, -1578.65002, -156.00000, 42.79000,   0.00000, 0.00000, 58.98000);
	CreateDynamicObject(3851, -1578.65002, -156.00000, 46.69000,   0.00000, 0.00000, 58.98000);
	CreateDynamicObject(3851, -1578.65002, -156.00000, 50.59000,   0.00000, 0.00000, 58.98000);
	CreateDynamicObject(3851, -1578.65002, -156.00000, 54.49000,   0.00000, 0.00000, 58.98000);
	CreateDynamicObject(3851, -1574.12000, -164.55000, 15.49000,   0.00000, 0.00000, 356.98001);
	CreateDynamicObject(3851, -1574.12000, -164.55000, 19.39000,   0.00000, 0.00000, 356.97000);
	CreateDynamicObject(3851, -1574.12000, -164.55000, 23.29000,   0.00000, 0.00000, 356.97000);
	CreateDynamicObject(3851, -1574.12000, -164.55000, 27.19000,   0.00000, 0.00000, 356.97000);
	CreateDynamicObject(3851, -1574.12000, -164.55000, 31.09000,   0.00000, 0.00000, 356.97000);
	CreateDynamicObject(3851, -1574.12000, -164.55000, 34.99000,   0.00000, 0.00000, 356.97000);
	CreateDynamicObject(3851, -1574.10999, -164.55000, 38.89000,   0.00000, 0.00000, 356.97000);
	CreateDynamicObject(3851, -1574.10999, -164.55000, 42.79000,   0.00000, 0.00000, 356.97000);
	CreateDynamicObject(3851, -1574.10999, -164.55000, 46.69000,   0.00000, 0.00000, 356.95999);
	CreateDynamicObject(3851, -1574.10999, -164.55000, 50.59000,   0.00000, 0.00000, 356.95999);
	CreateDynamicObject(3851, -1579.53003, -172.56000, 15.49000,   0.00000, 0.00000, 294.97000);
	CreateDynamicObject(3851, -1579.53003, -172.56000, 19.39000,   0.00000, 0.00000, 294.97000);
	CreateDynamicObject(3851, -1579.53003, -172.56000, 23.29000,   0.00000, 0.00000, 294.97000);
	CreateDynamicObject(3851, -1579.53003, -172.56000, 27.19000,   0.00000, 0.00000, 294.97000);
	CreateDynamicObject(3851, -1579.53003, -172.56000, 31.09000,   0.00000, 0.00000, 294.97000);
	CreateDynamicObject(3851, -1579.53003, -172.56000, 34.99000,   0.00000, 0.00000, 294.97000);
	CreateDynamicObject(3851, -1579.53003, -172.56000, 38.89000,   0.00000, 0.00000, 294.97000);
	CreateDynamicObject(3851, -1579.53003, -172.56000, 42.79000,   0.00000, 0.00000, 294.95999);
	CreateDynamicObject(3851, -1579.53003, -172.56000, 46.69000,   0.00000, 0.00000, 294.95999);
	CreateDynamicObject(5291, -1457.02002, -186.63000, 20.83000,   0.00000, 0.00000, 163.75000);
	CreateDynamicObject(5291, -1446.18005, -149.47000, 11.73000,   0.00000, 0.00000, 163.74001);
	CreateDynamicObject(2064, -1433.96997, -128.97000, 25.06000,   0.00000, 0.00000, 254.00000);
	CreateDynamicObject(2064, -1428.29004, -127.21000, 25.06000,   0.00000, 0.00000, 159.99001);
	CreateDynamicObject(1636, -1431.68005, -125.89000, 24.52000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1636, -1432.53003, -126.08000, 24.55000,   0.00000, 0.00000, 44.00000);
	CreateDynamicObject(1636, -1436.56006, -128.17000, 25.72000,   14.21000, 355.87000, 73.00000);
	CreateDynamicObject(16364, -1754.41003, -524.37000, 1.81000,   0.00000, 0.00000, 269.25000);
	CreateDynamicObject(16770, -1433.31006, -139.30000, 26.00000,   0.00000, 0.00000, 163.75000);
	CreateDynamicObject(2035, -1435.22998, -131.94000, 25.38000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2036, -1435.56995, -133.52000, 25.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2036, -1435.01001, -134.73000, 25.57000,   0.01000, 91.00000, 76.99000);
	CreateDynamicObject(2044, -1436.98999, -137.89000, 25.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2044, -1436.79004, -137.63000, 25.39000,   0.00000, 0.00000, 296.00000);
	CreateDynamicObject(1654, -1434.65002, -133.41000, 25.74000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(17324, -1285.32996, 66.50000, 13.14000,   0.00000, 0.00000, 224.00000);
	CreateDynamicObject(1458, -1283.38000, 77.77000, 13.37000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(10281, -1294.12000, 75.75000, 21.06000,   0.00000, 0.00000, 224.00000);
	CreateDynamicObject(1583, -1297.63000, 68.96000, 13.17000,   0.00000, 0.00000, 314.00000);
	CreateDynamicObject(1584, -1296.20996, 67.52000, 13.17000,   0.00000, 0.00000, 314.00000);
	CreateDynamicObject(1585, -1294.88000, 66.10000, 13.17000,   0.00000, 0.00000, 314.00000);
	CreateDynamicObject(18740, -1209.52002, 154.42999, 13.19000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18786, -1460.96997, -15.53000, 16.04000,   0.00000, 3.99000, 313.98999);
	CreateDynamicObject(18786, -1470.25000, -5.89000, 25.06000,   0.00000, 33.99000, 313.98999);
	CreateDynamicObject(18766, -1563.78003, -132.87000, 15.77000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1563.78003, -132.87000, 20.72000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1559.17004, -128.28000, 15.77000,   0.00000, 0.00000, 268.50000);
	CreateDynamicObject(18766, -1555.31006, -124.16000, 18.27000,   0.00000, 310.00000, 178.24001);
	CreateDynamicObject(17310, -1586.25000, -81.10000, 18.29000,   0.18000, 139.74001, 44.65000);
	CreateDynamicObject(18755, -1365.91003, 299.48001, 27.80000,   0.00000, 0.00000, 269.98999);
	CreateDynamicObject(5990, -1483.62000, 20.85000, 10.65000,   89.68000, 0.02000, 225.03999);
	CreateDynamicObject(5990, -1535.38000, -30.99000, 10.65000,   89.68000, 0.01000, 225.03000);
	CreateDynamicObject(5990, -1564.39001, -59.89000, 10.65000,   89.68000, 0.01000, 225.03000);
	CreateDynamicObject(5990, -1440.09998, 64.35000, 10.65000,   89.68000, 0.01000, 225.03000);
	CreateDynamicObject(5990, -1388.92004, 115.59000, 10.65000,   89.68000, 0.01000, 225.03000);
	CreateDynamicObject(5990, -1328.93005, 175.64999, 10.65000,   89.68000, 0.01000, 225.03000);
	CreateDynamicObject(5990, -1270.59998, 233.61000, 10.65000,   89.68000, 0.01000, 225.03000);
	CreateDynamicObject(5990, -1213.13000, 291.34000, 10.65000,   89.68000, 0.01000, 225.03000);
	CreateDynamicObject(5990, -1167.43994, 336.95999, 10.65000,   89.68000, 0.01000, 225.03000);
	CreateDynamicObject(18801, -1245.30005, 240.42000, 35.52000,   0.00000, 0.00000, 319.98001);
	CreateDynamicObject(18809, -1097.92004, 85.71000, 24.92000,   0.00000, 270.00000, 117.98000);
	CreateDynamicObject(18822, -1188.64001, 205.11000, 61.64000,   89.74000, 90.00000, 210.23000);
	CreateDynamicObject(18822, -963.10999, 442.39001, 61.63000,   89.74000, 90.00000, 346.97000);
	CreateDynamicObject(18820, -893.84003, 243.63000, 61.58000,   270.00000, 180.69000, 186.44000);
	CreateDynamicObject(18809, -898.94000, 293.17999, 61.56000,   0.00000, 270.00000, 95.99000);
	CreateDynamicObject(18809, -784.56000, 370.60001, 53.89000,   0.00000, 270.00000, 29.98000);
	CreateDynamicObject(18809, -909.38000, 392.32001, 61.56000,   0.00000, 270.00000, 95.99000);
	CreateDynamicObject(18809, -1056.48999, 464.85001, 61.58000,   0.00000, 270.00000, 180.48000);
	CreateDynamicObject(18818, -922.37000, 441.07999, 61.61000,   90.00000, 180.67999, 275.29999);
	CreateDynamicObject(18822, -1008.07001, 459.89999, 61.63000,   89.74000, 90.00000, 161.96001);
	CreateDynamicObject(18809, -1106.28003, 464.41000, 61.58000,   0.00000, 270.00000, 180.48000);
	CreateDynamicObject(18809, -1156.43994, 463.98999, 53.64000,   0.00000, 288.00000, 180.48000);
	CreateDynamicObject(18809, -1203.83997, 463.60001, 38.26000,   0.00000, 287.98999, 180.47000);
	CreateDynamicObject(18809, -1251.26001, 463.23999, 22.88000,   0.00000, 287.98999, 180.47000);
	CreateDynamicObject(18809, -1267.43005, 463.09000, 17.63000,   0.00000, 287.98999, 180.47000);
	CreateDynamicObject(18789, -1026.55005, 467.66000, 12.85000,   0.00000, 0.00000, 225.75000);
	CreateDynamicObject(18809, -943.37000, 238.59000, 61.56000,   0.00000, 270.00000, 5.99000);
	CreateDynamicObject(18809, -992.91998, 233.37000, 61.56000,   0.00000, 270.00000, 5.98000);
	CreateDynamicObject(18809, -1042.51001, 228.17000, 61.56000,   0.00000, 270.00000, 5.98000);
	CreateDynamicObject(18809, -1092.10999, 222.99001, 61.59000,   0.00000, 270.00000, 5.98000);
	CreateDynamicObject(18809, -1141.71997, 217.78999, 61.59000,   0.00000, 270.00000, 5.98000);
	CreateDynamicObject(18809, -1225.20996, 173.33000, 61.59000,   0.00000, 270.00000, 45.98000);
	CreateDynamicObject(18809, -1259.82996, 137.48000, 61.59000,   0.00000, 270.00000, 45.98000);
	CreateDynamicObject(18778, -1385.62000, 464.50000, 7.68000,   11.99000, 0.00000, 90.49000);
	CreateDynamicObject(18778, -1391.83997, 464.45001, 13.03000,   25.98000, 0.00000, 90.49000);
	CreateDynamicObject(18809, -844.42999, 248.73000, 61.54000,   0.00000, 270.00000, 5.98000);
	CreateDynamicObject(18809, -794.82001, 253.92000, 51.82000,   0.00000, 291.98999, 5.98000);
	CreateDynamicObject(18809, -748.89001, 258.72000, 33.16000,   0.00000, 291.98999, 5.98000);
	CreateDynamicObject(18809, -703.34003, 263.48999, 14.64000,   0.00000, 291.98999, 5.98000);
	CreateDynamicObject(18789, -1220.93994, 418.13000, 7.55000,   0.00000, 355.98999, 313.98999);
	CreateDynamicObject(18789, -921.88000, 575.09003, 12.85000,   0.00000, 0.00000, 225.74001);
	CreateDynamicObject(18789, -817.25000, 682.50000, 12.85000,   0.00000, 0.00000, 225.74001);
	CreateDynamicObject(18824, -1170.56006, 75.30000, 23.75000,   308.88000, 307.20001, 220.28000);
	CreateDynamicObject(18824, -1141.96997, 54.64000, 42.78000,   316.94000, 74.46000, 273.09000);
	CreateDynamicObject(18824, -1134.25000, 10.81000, 36.73000,   287.51999, 335.20999, 3.24000);
	CreateDynamicObject(18824, -1097.21997, 0.71000, 28.67000,   276.81000, 331.45001, 90.63000);
	CreateDynamicObject(18822, -1081.00000, 40.30000, 25.76000,   271.98999, 0.00000, 187.00000);
	CreateDynamicObject(18822, -1114.42004, 131.38000, 25.71000,   271.98999, 0.00000, 5.74000);
	CreateDynamicObject(18822, -1101.48999, 176.28999, 27.43000,   271.98999, 0.00000, 321.98999);
	CreateDynamicObject(18809, -1063.46997, 206.50999, 28.24000,   0.00000, 270.00000, 30.98000);
	CreateDynamicObject(18809, -1020.71997, 232.20000, 28.24000,   0.00000, 270.00000, 30.98000);
	CreateDynamicObject(18776, -998.34003, 245.78000, 26.19000,   348.00000, 359.73999, 299.44000);
	CreateDynamicObject(18776, -995.12000, 247.60001, 27.39000,   3.74000, 359.73999, 299.51001);
	CreateDynamicObject(18822, -941.58002, 279.95001, 53.70000,   0.00000, 246.00000, 30.00000);
	CreateDynamicObject(18822, -905.53998, 300.76999, 78.18000,   0.00000, 64.49000, 29.99000);
	CreateDynamicObject(18822, -865.03003, 324.14001, 81.06000,   0.00000, 108.48000, 29.99000);
	CreateDynamicObject(18822, -826.75000, 346.25000, 60.07000,   0.00000, 290.48001, 29.98000);
	CreateDynamicObject(18809, -904.15997, 342.75000, 61.56000,   0.00000, 270.00000, 95.98000);
	CreateDynamicObject(18809, -741.32001, 395.57001, 53.89000,   0.00000, 270.00000, 29.98000);
	CreateDynamicObject(18809, -698.14001, 420.51001, 53.89000,   0.00000, 270.00000, 29.98000);
	CreateDynamicObject(18809, -654.94000, 445.44000, 53.89000,   0.00000, 270.00000, 29.98000);
	CreateDynamicObject(18781, -1578.23999, -44.34000, 23.12000,   0.00000, 0.00000, 44.98000);
	CreateDynamicObject(18801, -627.51001, 450.12000, 71.82000,   0.00000, 0.00000, 38.00000);
	CreateDynamicObject(18801, -613.72998, 435.81000, 71.82000,   0.00000, 0.00000, 37.99000);
	CreateDynamicObject(18778, -606.91998, 428.60999, 50.51000,   0.00000, 359.50000, 302.00000);
	CreateDynamicObject(18778, -600.76001, 432.48999, 54.66000,   15.99000, 359.47000, 302.14001);
	CreateDynamicObject(18770, -1220.34998, -232.84000, -52.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18770, -1220.50000, -240.17999, -52.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18770, -1198.34998, -233.11000, -52.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18770, -1198.45996, -240.50000, -52.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18770, -1188.69995, -241.05000, -52.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18770, -1188.56006, -233.64999, -52.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18770, -1166.57996, -233.74001, -52.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18770, -1166.70996, -241.10001, -52.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18770, -1067.89001, -215.03999, 22.08000,   284.00000, 0.00000, 272.00000);
	CreateDynamicObject(18770, -1067.94995, -213.06000, 22.08000,   283.98999, 0.00000, 271.98999);
	CreateDynamicObject(18770, -1068.02002, -211.12000, 22.08000,   283.98999, 0.00000, 271.98999);
	CreateDynamicObject(17310, -1173.52002, -67.62000, 48.54000,   359.85999, 79.74000, 45.22000);
	CreateDynamicObject(18771, -1334.34998, 455.64001, -22.62000,   0.00000, 0.00000, 185.99001);
	CreateDynamicObject(18766, -1253.48999, 489.57999, 16.73000,   90.00000, 179.07001, 270.92999);
	CreateDynamicObject(18766, -1253.47998, 485.87000, 16.73000,   90.00000, 179.07001, 270.92001);
	CreateDynamicObject(11367, -1367.48999, -49.76000, -9.72000,   0.00000, 0.00000, 134.78000);
	CreateDynamicObject(19333, -1376.58997, -146.25053, 23.51070,   0.00000, 0.00000, -23.93999);
	CreateDynamicObject(13604, -1303.13074, -138.02460, 14.36000,   0.00000, 0.00000, 3.71000);
	CreateDynamicObject(19419, -1244.09998, 22.16000, 14.09000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18649, -1221.81995, -20.98000, 13.17000,   0.00000, 0.00000, 317.98999);
	CreateDynamicObject(18646, -1248.93005, -36.62000, 20.40000,   312.00000, 0.00000, 110.00000);
	CreateDynamicObject(18857, -1370.92004, -216.44000, 16.27000,   0.00000, 214.00000, 348.00000);
	CreateDynamicObject(18857, -1387.01001, -213.02000, 27.36000,   0.00000, 213.99001, 347.98999);
	CreateDynamicObject(18857, -1403.22998, -209.58000, 38.54000,   0.00000, 213.99001, 347.98999);
	CreateDynamicObject(18777, -1278.57996, 93.08000, 15.64000,   0.00000, 0.00000, 44.74000);
	CreateDynamicObject(18830, -1352.90002, -254.24001, 15.72000,   0.00000, 212.00000, 45.25000);
	CreateDynamicObject(18830, -1361.31995, -245.99001, 15.77000,   0.00000, 211.99001, 45.24000);
	CreateDynamicObject(18786, -1334.55005, 85.94000, 14.64000,   0.00000, 3.99000, 277.98999);
	CreateDynamicObject(18786, -1336.57996, 100.26000, 24.19000,   0.00000, 33.99000, 277.98999);
	CreateDynamicObject(18984, -1545.29004, -163.24001, 18.17000,   0.00000, 0.49000, 315.23999);
	CreateDynamicObject(619, -1226.52002, 39.51000, 13.98000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18848, -1185.50000, 7.87000, 12.58000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18717, -1270.41003, 44.95000, 11.44000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18717, -1274.21997, 48.60000, 11.44000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1280.00000, 34.37000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1284.42004, 29.87000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1288.15002, 26.26000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1292.03003, 22.31000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1295.81995, 18.20000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1299.60999, 14.49000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1284.22998, 38.61000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1288.67004, 34.25000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1292.18005, 30.61000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1296.44995, 26.33000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1300.42004, 22.88000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18690, -1304.47998, 19.09000, 11.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8557, -1370.90002, -44.78000, 11.64000,   0.00000, 0.00000, 45.25000);
	CreateDynamicObject(8558, -1370.90002, -44.78000, 11.64000,   0.00000, 0.00000, 45.25000);
	CreateDynamicObject(8558, -1374.67004, -48.38000, 11.97000,   0.00000, 7.19000, 45.25000);
	CreateDynamicObject(8558, -1378.38000, -51.93000, 12.95000,   0.00000, 14.39000, 45.25000);
	CreateDynamicObject(8558, -1381.97998, -55.36000, 14.56000,   0.00000, 21.59000, 45.25000);
	CreateDynamicObject(8558, -1385.41003, -58.62000, 16.79000,   0.00000, 28.79000, 45.25000);
	CreateDynamicObject(8558, -1388.60999, -61.65000, 19.59000,   0.00000, 36.00000, 45.25000);
	CreateDynamicObject(8558, -1391.55005, -64.41000, 22.92000,   0.00000, 43.20000, 45.25000);
	CreateDynamicObject(8558, -1394.16003, -66.86000, 26.72000,   0.00000, 50.40000, 45.25000);
	CreateDynamicObject(8558, -1396.43005, -68.94000, 30.95000,   0.00000, 57.60000, 45.25000);
	CreateDynamicObject(8558, -1398.30005, -70.63000, 35.53000,   0.00000, 64.80000, 45.25000);
	CreateDynamicObject(8558, -1399.75000, -71.89000, 40.39000,   0.00000, 72.00000, 45.25000);
	CreateDynamicObject(8558, -1400.76001, -72.72000, 45.45000,   0.00000, 79.19000, 45.25000);
	CreateDynamicObject(8558, -1401.31995, -73.08000, 50.63000,   0.00000, 86.39000, 45.25000);
	CreateDynamicObject(8558, -1401.42004, -72.99000, 55.85000,   0.00000, 93.59000, 45.25000);
	CreateDynamicObject(8558, -1401.06006, -72.42000, 61.04000,   0.00000, 100.79000, 45.25000);
	CreateDynamicObject(8558, -1400.25000, -71.40000, 66.10000,   0.00000, 107.99000, 45.25000);
	CreateDynamicObject(8558, -1398.98999, -69.94000, 70.96000,   0.00000, 115.19000, 45.25000);
	CreateDynamicObject(8558, -1397.31995, -68.05000, 75.53000,   0.00000, 122.39000, 45.25000);
	CreateDynamicObject(8558, -1395.26001, -65.77000, 79.76000,   0.00000, 129.59000, 45.25000);
	CreateDynamicObject(8558, -1392.83997, -63.13000, 83.57000,   0.00000, 136.78999, 45.25000);
	CreateDynamicObject(8558, -1390.09998, -60.18000, 86.90000,   0.00000, 143.99001, 45.25000);
	CreateDynamicObject(8558, -1387.09998, -56.94000, 89.70000,   0.00000, 151.19000, 45.25000);
	CreateDynamicObject(8558, -1383.87000, -53.49000, 91.92000,   0.00000, 158.39000, 45.25000);
	CreateDynamicObject(8558, -1380.46997, -49.86000, 93.54000,   0.00000, 165.59000, 45.25000);
	CreateDynamicObject(8558, -1376.95996, -46.12000, 94.52000,   0.00000, 172.78999, 45.25000);
	CreateDynamicObject(8558, -1373.39001, -42.32000, 94.84000,   0.00000, 179.99001, 45.25000);
	CreateDynamicObject(8558, -1369.81006, -38.51000, 94.52000,   0.00000, 187.19000, 45.25000);
	CreateDynamicObject(8558, -1366.30005, -34.77000, 93.54000,   0.00000, 194.39000, 45.25000);
	CreateDynamicObject(8558, -1362.90002, -31.14000, 91.92000,   0.00000, 201.59000, 45.25000);
	CreateDynamicObject(8558, -1359.67004, -27.69000, 89.70000,   0.00000, 208.78999, 45.25000);
	CreateDynamicObject(8558, -1356.67004, -24.46000, 86.90000,   0.00000, 215.99001, 45.25000);
	CreateDynamicObject(8558, -1353.93005, -21.50000, 83.57000,   0.00000, 223.19000, 45.25000);
	CreateDynamicObject(8558, -1351.51001, -18.86000, 79.76000,   0.00000, 230.39000, 45.24000);
	CreateDynamicObject(8558, -1349.44995, -16.58000, 75.53000,   0.00000, 237.59000, 45.25000);
	CreateDynamicObject(8558, -1347.78003, -14.70000, 70.96000,   0.00000, 244.78999, 45.25000);
	CreateDynamicObject(8558, -1346.53003, -13.23000, 66.10000,   0.00000, 251.99001, 45.25000);
	CreateDynamicObject(8558, -1345.70996, -12.21000, 61.04000,   0.00000, 259.19000, 45.25000);
	CreateDynamicObject(8558, -1345.34998, -11.65000, 55.85000,   0.00000, 266.39001, 45.25000);
	CreateDynamicObject(8558, -1345.44995, -11.55000, 50.63000,   0.00000, 273.59000, 45.25000);
	CreateDynamicObject(8558, -1346.01001, -11.91000, 45.45000,   0.00000, 280.79001, 45.25000);
	CreateDynamicObject(8558, -1347.02002, -12.74000, 40.39000,   0.00000, 287.98999, 45.25000);
	CreateDynamicObject(8558, -1348.47998, -14.01000, 35.53000,   0.00000, 295.19000, 45.25000);
	CreateDynamicObject(8558, -1350.34998, -15.70000, 30.95000,   0.00000, 302.39001, 45.25000);
	CreateDynamicObject(8558, -1352.60999, -17.78000, 26.72000,   0.00000, 309.60001, 45.25000);
	CreateDynamicObject(8558, -1355.22998, -20.22000, 22.92000,   0.00000, 316.79999, 45.25000);
	CreateDynamicObject(8558, -1358.16003, -22.98000, 19.59000,   0.00000, 324.00000, 45.25000);
	CreateDynamicObject(8558, -1361.35999, -26.01000, 16.79000,   0.00000, 331.20001, 45.25000);
	CreateDynamicObject(8558, -1364.79004, -29.27000, 14.56000,   0.00000, 338.39999, 45.25000);
	CreateDynamicObject(8558, -1368.39001, -32.70000, 12.95000,   0.00000, 345.60001, 45.25000);
	CreateDynamicObject(8558, -1372.09998, -36.25000, 11.97000,   0.00000, 352.79999, 45.25000);
	CreateDynamicObject(8558, -1375.87000, -39.85000, 11.64000,   0.00000, 360.00000, 45.25000);
	CreateDynamicObject(18647, -1353.07996, -33.95000, 13.17000,   0.00000, 0.00000, 45.25000);
	CreateDynamicObject(18648, -1356.60999, -30.46000, 13.17000,   0.00000, 0.00000, 46.00000);
	CreateDynamicObject(1318, -1275.09998, 43.66000, 13.09000,   0.00000, 90.00000, 45.99000);
	CreateDynamicObject(2036, -1183.65002, 10.79000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2035, -1183.70996, 10.10000, 13.17000,   0.00000, 0.00000, 48.00000);
	CreateDynamicObject(2044, -1183.06006, 10.47000, 13.20000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2045, -1184.33997, 9.97000, 13.27000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2061, -1184.46997, 8.51000, 13.44000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2064, -1224.08997, 52.11000, 13.76000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6976, -1196.14001, 194.64000, 4.32000,   0.00000, 0.00000, 314.73999);
	CreateDynamicObject(12990, -1209.42004, 206.96001, 0.10000,   0.00000, 0.00000, 46.00000);
	CreateDynamicObject(18766, -1651.06006, -230.75999, 10.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1660.93005, -230.75000, 10.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1662.00000, -227.14999, 10.66000,   0.00000, 0.00000, 44.00000);
	CreateDynamicObject(18766, -1654.90002, -220.28999, 10.66000,   0.00000, 0.00000, 43.99000);
	CreateDynamicObject(18766, -1650.55005, -216.13000, 10.66000,   0.00000, 0.00000, 43.99000);
	CreateDynamicObject(18766, -1651.59998, -212.50999, 10.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1660.77002, -212.53000, 10.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18772, -1293.28003, -94.87000, 88.53000,   324.00000, 0.00000, 316.00000);
	CreateDynamicObject(18772, -1433.65002, -240.22000, 235.36000,   323.98999, 0.00000, 315.98999);
	CreateDynamicObject(8558, -1209.31995, -11.27000, 13.14000,   0.00000, 342.00000, 46.00000);
	CreateDynamicObject(8558, -1209.31995, -11.27000, 13.14000,   0.00000, 342.00000, 46.00000);
	CreateDynamicObject(8558, -1205.93994, -7.78000, 15.07000,   0.00000, 334.79001, 46.00000);
	CreateDynamicObject(8558, -1202.76001, -4.49000, 17.58000,   0.00000, 327.59000, 46.00000);
	CreateDynamicObject(8558, -1199.82996, -1.45000, 20.65000,   0.00000, 320.39001, 45.99000);
	CreateDynamicObject(8558, -1197.18005, 1.28000, 24.23000,   0.00000, 313.19000, 46.00000);
	CreateDynamicObject(8558, -1192.92004, 5.69000, 32.67000,   0.00000, 298.79001, 46.00000);
	CreateDynamicObject(8558, -1191.38000, 7.29000, 37.39000,   0.00000, 291.59000, 45.99000);
	CreateDynamicObject(8558, -1190.26001, 8.45000, 42.36000,   0.00000, 284.39001, 46.00000);
	CreateDynamicObject(8558, -1189.57996, 9.16000, 47.50000,   0.00000, 277.19000, 46.00000);
	CreateDynamicObject(8558, -1189.34998, 9.39000, 52.71000,   0.00000, 269.98999, 46.00000);
	CreateDynamicObject(8558, -1189.57996, 9.16000, 57.92000,   0.00000, 262.79001, 46.00000);
	CreateDynamicObject(8558, -1190.26001, 8.45000, 63.06000,   0.00000, 255.59000, 46.00000);
	CreateDynamicObject(8558, -1191.38000, 7.29000, 68.02000,   0.00000, 248.39000, 46.00000);
	CreateDynamicObject(8558, -1657.64001, -166.61000, 11.69000,   358.00000, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1212.89001, -7.84000, 13.14000,   0.00000, 341.98999, 45.99000);
	CreateDynamicObject(8558, -1209.51001, -4.35000, 15.07000,   0.00000, 334.79001, 45.99000);
	CreateDynamicObject(8558, -1206.32996, -1.05000, 17.58000,   0.00000, 327.59000, 45.99000);
	CreateDynamicObject(8558, -1203.40002, 1.98000, 20.65000,   0.00000, 320.39001, 45.99000);
	CreateDynamicObject(8558, -1200.75000, 4.72000, 24.23000,   0.00000, 313.19000, 45.99000);
	CreateDynamicObject(8558, -1198.43994, 7.11000, 28.26000,   0.00000, 305.98999, 45.99000);
	CreateDynamicObject(8558, -1196.48999, 9.13000, 32.67000,   0.00000, 298.79001, 45.99000);
	CreateDynamicObject(8558, -1194.94995, 10.73000, 37.40000,   0.00000, 291.59000, 45.99000);
	CreateDynamicObject(8558, -1193.82996, 11.89000, 42.36000,   0.00000, 284.39001, 45.99000);
	CreateDynamicObject(8558, -1193.15002, 12.59000, 47.50000,   0.00000, 277.19000, 45.99000);
	CreateDynamicObject(8558, -1192.92004, 12.83000, 52.71000,   0.00000, 269.98999, 45.99000);
	CreateDynamicObject(8558, -1193.15002, 12.59000, 57.92000,   0.00000, 262.79001, 45.99000);
	CreateDynamicObject(8558, -1193.82996, 11.89000, 63.06000,   0.00000, 255.59000, 45.99000);
	CreateDynamicObject(8558, -1194.94995, 10.73000, 68.02000,   0.00000, 248.39000, 45.99000);
	CreateDynamicObject(18859, -1481.48999, 69.91000, 24.18000,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(18859, -1473.70996, 61.90000, 62.00000,   90.00000, 179.59000, 225.39000);
	CreateDynamicObject(18822, -1490.84998, -37.74000, 24.73000,   0.00000, 291.98999, 316.00000);
	CreateDynamicObject(18809, -1519.63000, -9.97000, 52.81000,   312.00000, 0.00000, 46.00000);
	CreateDynamicObject(18809, -1546.29004, 15.74000, 86.16000,   311.98999, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1572.94995, 41.46000, 119.52000,   311.98999, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1599.60999, 67.18000, 152.87000,   311.98001, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1626.26001, 92.90000, 186.23000,   311.98001, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1652.92004, 118.62000, 219.58000,   311.97000, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1679.57996, 144.35001, 252.94000,   311.97000, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1706.23999, 170.07001, 286.29001,   311.95999, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1732.89001, 195.78999, 319.64999,   311.95999, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1759.55005, 221.50999, 353.00000,   311.95001, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1786.20996, 247.23000, 386.35999,   311.95001, 0.00000, 45.99000);
	CreateDynamicObject(18809, -1812.87000, 272.95001, 419.70999,   311.94000, 0.00000, 45.99000);
	CreateDynamicObject(18778, -1468.43005, -59.32000, 14.76000,   358.00000, 0.00000, 225.99001);
	CreateDynamicObject(18778, -1463.45996, -64.13000, 18.56000,   15.99000, 0.00000, 225.99001);
	CreateDynamicObject(8558, -1212.89001, -7.84000, 13.14000,   0.00000, 341.98999, 45.99000);
	CreateDynamicObject(8558, -1657.64001, -166.61000, 11.69000,   358.00000, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1661.25000, -170.32001, 12.41000,   346.00000, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1664.67004, -173.84000, 14.20000,   334.00000, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1667.76001, -177.00999, 16.97000,   322.00000, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1670.39001, -179.70000, 20.60000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1672.63000, -182.03000, 24.45000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1674.87000, -184.35001, 28.30000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1677.12000, -186.67999, 32.15000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1679.35999, -189.00000, 36.00000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1681.60999, -191.33000, 39.85000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1683.84998, -193.64999, 43.70000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1686.09998, -195.98000, 47.55000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1688.33997, -198.30000, 51.40000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1690.58997, -200.63000, 55.25000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1692.82996, -202.95000, 59.10000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1695.06995, -205.28000, 62.95000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1697.31995, -207.60001, 66.80000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1699.56006, -209.92999, 70.65000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1701.81006, -212.25000, 74.50000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1704.05005, -214.58000, 78.35000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1706.30005, -216.89999, 82.20000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1708.54004, -219.23000, 86.05000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1710.78003, -221.56000, 89.90000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1713.03003, -223.88000, 93.75000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1715.27002, -226.21001, 97.60000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1717.52002, -228.53000, 101.45000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1719.76001, -230.86000, 105.30000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1722.01001, -233.17999, 109.15000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1724.25000, -235.50999, 113.00000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1726.50000, -237.83000, 116.85000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1728.73999, -240.16000, 120.70000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1730.97998, -242.48000, 124.55000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1733.22998, -244.81000, 128.39999,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1735.46997, -247.13000, 132.25000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1737.71997, -249.46001, 136.10001,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1739.95996, -251.78000, 139.95000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1742.20996, -254.11000, 143.80000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1744.44995, -256.42999, 147.64999,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1746.68994, -258.76001, 151.50000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1748.93994, -261.07999, 155.35001,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1751.18005, -263.41000, 159.20000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1753.43005, -265.73001, 163.05000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1755.67004, -268.06000, 166.89999,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1757.92004, -270.38000, 170.75000,   309.98999, 359.98999, 315.73999);
	CreateDynamicObject(8558, -1760.16003, -272.70999, 174.60001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1762.41003, -275.04001, 178.45000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1764.65002, -277.35999, 182.30000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1766.89001, -279.69000, 186.14999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1769.14001, -282.01001, 190.00000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1771.38000, -284.34000, 193.85001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1773.63000, -286.66000, 197.70000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1775.87000, -288.98999, 201.55000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1778.10999, -291.31000, 205.39999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1780.35999, -293.64001, 209.25000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1782.59998, -295.95999, 213.10001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1784.84998, -298.29001, 216.95000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1787.08997, -300.60999, 220.80000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1789.32996, -302.94000, 224.64999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1791.57996, -305.26001, 228.50000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1793.81995, -307.59000, 232.35001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1796.06995, -309.91000, 236.20000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1798.31006, -312.23999, 240.05000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1800.56006, -314.56000, 243.89999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1802.80005, -316.89001, 247.75000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1805.04004, -319.20999, 251.60001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1807.29004, -321.54001, 255.45000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1809.53003, -323.85999, 259.29999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1811.78003, -326.19000, 263.14999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1814.02002, -328.51001, 267.00000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1816.26001, -330.84000, 270.85001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1818.51001, -333.16000, 274.70001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1820.75000, -335.48999, 278.54999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1823.00000, -337.82001, 282.39999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1825.23999, -340.14001, 286.25000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1827.48999, -342.47000, 290.10001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1829.72998, -344.79001, 293.95001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1831.96997, -347.12000, 297.79999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1834.21997, -349.44000, 301.64999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1836.45996, -351.76999, 305.50000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1838.70996, -354.09000, 309.35001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1840.94995, -356.42001, 313.20001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1843.18994, -358.73999, 317.04999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1845.43994, -361.07001, 320.89999,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1847.68005, -363.39001, 324.75000,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1849.93005, -365.72000, 328.60001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1852.17004, -368.04001, 332.45001,   309.98999, 359.98001, 315.73999);
	CreateDynamicObject(8558, -1854.28003, -370.22000, 333.85001,   359.98999, 359.98001, 315.75000);
	CreateDynamicObject(8558, -1857.80005, -373.84000, 333.85001,   359.98999, 359.98001, 315.75000);
	CreateDynamicObject(8558, -1861.31995, -377.45001, 333.85001,   359.98999, 359.98001, 315.75000);
	CreateDynamicObject(8558, -1864.83997, -381.07001, 333.85001,   359.98999, 359.98001, 315.75000);
	CreateDynamicObject(8558, -1868.34998, -384.67999, 333.85001,   359.98999, 359.98001, 315.75000);
	CreateDynamicObject(8558, -1871.87000, -388.29999, 333.85001,   359.98001, 359.98001, 315.75000);
	CreateDynamicObject(8558, -1875.39001, -391.91000, 333.85001,   359.98001, 359.98001, 315.73999);
	CreateDynamicObject(18780, -1612.93994, -134.58000, 24.80000,   0.00000, 0.00000, 44.74000);
	CreateDynamicObject(18779, -1799.23999, -284.14001, 233.61000,   0.00000, 310.00000, 226.00000);
	CreateDynamicObject(710, -1445.20996, 76.02000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1430.66003, 90.58000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1416.10999, 105.15000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1401.55005, 119.71000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1387.00000, 134.28000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1372.44995, 148.84000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1357.90002, 163.41000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1343.33997, 177.97000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1328.79004, 192.53999, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1314.23999, 207.10001, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1299.68005, 221.67000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1285.13000, 236.23000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1270.57996, 250.80000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1226.92004, 294.48999, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1212.37000, 309.06000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1197.81006, 323.62000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1183.26001, 338.19000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1168.70996, 352.75000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1154.15002, 367.32001, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1139.59998, 381.88000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(714, -1382.91003, 56.17000, 13.12000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1438.06006, 83.28000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1423.82996, 97.54000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1409.59998, 111.79000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1395.37000, 126.04000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1381.14001, 140.28999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1366.90002, 154.55000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1352.67004, 168.80000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1338.43994, 183.05000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1324.20996, 197.30000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1309.97998, 211.56000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1295.75000, 225.81000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1281.51001, 240.06000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1267.28003, 254.31000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1224.58997, 297.07001, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1210.35999, 311.32001, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1196.12000, 325.57999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1181.89001, 339.82999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1167.66003, 354.07999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1153.43005, 368.32999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1139.19995, 382.57999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1198.28003, 265.57999, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1183.82996, 280.44000, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1168.65002, 295.45999, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1153.55005, 309.82001, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1139.43994, 323.26001, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1125.30005, 338.07999, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1110.43005, 353.04001, 28.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1138.83997, 324.67999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1124.35999, 338.89999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1109.88000, 353.39999, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1152.44995, 311.20001, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1167.15002, 296.69000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1181.89001, 282.01001, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(716, -1195.81995, 267.53000, 13.24000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18781, -1563.70996, -30.07000, 23.12000,   0.00000, 0.00000, 44.98000);
	CreateDynamicObject(18786, -1487.93994, -186.69000, 15.49000,   0.00000, 0.00000, 225.25000);
	CreateDynamicObject(18786, -1476.63000, -175.25000, 24.32000,   0.00000, 28.00000, 225.24001);
	CreateDynamicObject(18801, -1232.37000, 254.89999, 35.52000,   0.00000, 0.00000, 319.98999);
	CreateDynamicObject(18778, -1236.71997, 274.01001, 14.74000,   11.99000, 0.00000, 45.99000);
	CreateDynamicObject(18778, -1240.68994, 277.85001, 19.64000,   27.99000, 0.00000, 45.99000);
	CreateDynamicObject(18830, -1720.20996, -309.00000, 16.47000,   359.98999, 202.00000, 359.98999);
	CreateDynamicObject(18830, -1720.19995, -297.54999, 16.47000,   359.98999, 201.99001, 359.98999);
	CreateDynamicObject(18830, -1710.07996, -218.64999, 16.47000,   359.98999, 201.99001, 315.23999);
	CreateDynamicObject(18772, -1354.19995, 193.89000, 41.64000,   0.00000, 0.00000, 45.99000);
	CreateDynamicObject(18777, -1429.50000, 294.26999, 15.63000,   0.00000, 0.00000, 224.00000);
	CreateDynamicObject(18778, -1446.52002, 282.48999, 10.38000,   16.00000, 0.00000, 223.75000);
	CreateDynamicObject(18778, -1451.31995, 287.50000, 6.13000,   3.74000, 0.00000, 223.74001);
	CreateDynamicObject(710, -1458.00000, 281.29001, 21.54000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, -1444.67004, 293.73001, 21.32000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1346.52002, 292.19000, 8.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1356.40002, 292.19000, 8.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1366.29004, 292.17999, 8.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1376.18005, 292.17001, 8.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1386.06006, 292.17001, 8.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1346.52002, 292.19000, 13.53000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1346.52002, 292.19000, 18.51000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1346.52002, 292.19000, 23.48000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1346.52002, 292.19000, 28.46000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1356.40002, 292.19000, 13.53000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1356.40002, 292.19000, 18.51000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1356.40002, 292.17999, 23.48000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1356.40002, 292.17999, 28.46000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1366.29004, 292.17999, 13.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1366.29004, 292.17999, 18.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1366.29004, 292.17999, 23.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1366.29004, 292.17999, 28.46000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1376.18005, 292.17001, 13.51000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1376.18005, 292.17001, 18.53000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1376.18005, 292.17001, 23.51000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1376.18005, 292.17001, 28.46000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1386.06006, 292.17001, 13.51000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1386.06006, 292.17001, 18.48000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1386.06006, 292.17001, 23.48000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1386.06006, 292.17001, 28.46000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18758, -1365.87000, 299.51999, 8.11000,   0.00000, 0.00000, 270.23999);
	CreateDynamicObject(18766, -1370.38000, 296.57001, 8.56000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18755, -1365.91003, 299.48001, 8.12000,   0.00000, 0.00000, 270.48999);
	CreateDynamicObject(18766, -1361.41003, 296.60999, 8.56000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, -1370.31006, 296.57001, 13.56000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, -1370.31006, 296.57001, 18.56000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, -1370.31006, 296.57001, 23.56000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, -1370.30005, 296.57001, 28.46000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, -1361.48999, 296.60001, 13.53000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, -1361.48999, 296.60001, 18.51000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, -1361.48999, 296.60001, 23.48000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, -1361.48999, 296.60001, 28.46000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18756, -1365.81006, 303.31000, 8.15000,   0.00000, 0.00000, 90.75000);
	CreateDynamicObject(18757, -1365.78003, 303.31000, 8.14000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18766, -1365.89001, 301.09000, 13.53000,   0.00000, 0.00000, 0.25000);
	CreateDynamicObject(18766, -1365.89001, 301.07999, 18.48000,   0.00000, 0.00000, 0.24000);
	CreateDynamicObject(18766, -1365.89001, 301.07999, 23.43000,   0.00000, 0.00000, 0.24000);
	CreateDynamicObject(18758, -1365.87000, 299.51999, 27.74000,   0.00000, 0.00000, 270.23999);
	CreateDynamicObject(18766, -1365.87000, 299.10001, 31.38000,   270.00000, 180.00000, 180.00000);
	CreateDynamicObject(18766, -1365.87000, 294.35001, 31.38000,   270.00000, 179.99001, 179.99001);
	CreateDynamicObject(18757, -1365.80005, 303.32999, 27.89000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18756, -1365.84998, 303.31000, 27.90000,   0.00000, 0.00000, 90.74000);
	CreateDynamicObject(18766, -1365.90002, 304.01999, 25.43000,   270.00000, 179.99001, 179.99001);
	CreateDynamicObject(18766, -1365.90002, 308.95001, 25.43000,   270.00000, 179.99001, 179.99001);
	CreateDynamicObject(18766, -1365.90002, 313.88000, 25.43000,   270.00000, 179.99001, 179.99001);
	CreateDynamicObject(18766, -1365.91003, 318.81000, 25.43000,   270.00000, 179.99001, 179.99001);
	CreateDynamicObject(18766, -1365.91003, 323.73999, 25.43000,   270.00000, 179.99001, 179.99001);
	CreateDynamicObject(18771, -1360.95996, 307.56000, -23.96000,   0.00000, 0.00000, 89.75000);
	CreateDynamicObject(18778, -1458.39001, 316.78000, 8.63000,   20.00000, 0.00000, 90.00000);
	CreateDynamicObject(18778, -1463.41003, 316.78000, 15.13000,   41.99000, 0.00000, 90.00000);
	CreateDynamicObject(18778, -1465.58997, 316.81000, 20.93000,   53.48000, 0.00000, 90.00000);
	CreateDynamicObject(18781, -1468.82996, 394.66000, 31.11000,   0.00000, 0.00000, 91.50000);
	CreateDynamicObject(3279, -1348.18005, 340.41000, 28.68000,   0.00000, 0.00000, 89.25000);
	CreateDynamicObject(3279, -1348.14001, 439.53000, 29.08000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(16641, -1485.45996, 294.42999, 53.99000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3092, -1445.39001, 77.31000, 14.51000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, -1386.64001, 60.51000, 13.99000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, -1388.06995, 57.23000, 13.99000,   0.00000, 0.00000, 32.00000);
	CreateDynamicObject(869, -1388.43005, 53.27000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1386.15002, 51.82000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1382.28003, 50.30000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1379.22998, 51.45000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1377.43005, 55.10000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1377.77002, 57.55000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1380.92004, 60.85000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1383.52002, 61.55000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1379.27002, 59.30000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1376.88000, 53.75000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1380.63000, 52.50000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1383.97998, 50.95000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1387.88000, 55.75000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(869, -1387.38000, 59.05000, 13.99000,   0.00000, 0.00000, 31.99000);
	CreateDynamicObject(17310, -1181.48999, -75.65000, 18.66000,   0.19000, 141.74001, 44.64000);
	CreateDynamicObject(19262, -1647.73999, -366.64001, 17.88000,   0.00000, 0.00000, 335.98999);
	CreateDynamicObject(18784, -1210.00000, -270.14001, 15.64000,   0.00000, 0.00000, 88.99000);
	CreateDynamicObject(18784, -1178.21997, -270.70999, 15.64000,   0.00000, 0.00000, 88.99000);
	CreateDynamicObject(18784, -1209.73999, -255.06000, 24.14000,   0.00000, 330.00000, 88.99000);
	CreateDynamicObject(18784, -1177.94995, -255.74001, 24.14000,   0.00000, 329.98999, 88.98000);
	CreateDynamicObject(18784, -1177.78003, -245.77000, 37.92000,   0.00000, 311.23999, 88.98000);
	CreateDynamicObject(18784, -1209.58997, -245.08000, 37.92000,   0.00000, 311.23999, 88.98000);
	CreateDynamicObject(18784, -1177.50000, -228.94000, 37.92000,   0.00000, 311.23999, 268.98001);
	CreateDynamicObject(18784, -1177.31995, -217.58000, 22.22000,   0.00000, 329.98999, 268.98001);
	CreateDynamicObject(18784, -1177.16003, -205.16000, 15.42000,   0.00000, 0.00000, 269.48999);
	CreateDynamicObject(18784, -1209.28003, -228.16000, 37.92000,   0.00000, 311.23001, 268.97000);
	CreateDynamicObject(18784, -1209.06995, -216.85001, 22.29000,   0.00000, 329.98999, 268.98001);
	CreateDynamicObject(18784, -1208.92004, -204.03000, 15.42000,   0.00000, 0.00000, 269.48999);
	CreateDynamicObject(3851, -1536.75891, -195.94061, 13.16299,   0.00000, 90.00000, -45.00000);
	CreateDynamicObject(5291, -1457.02002, -186.63000, 20.83000,   0.00000, 0.00000, 163.75000);
	CreateDynamicObject(5291, -1446.18005, -149.47000, 11.73000,   0.00000, 0.00000, 163.74001);
	CreateDynamicObject(2064, -1433.96997, -128.97000, 25.06000,   0.00000, 0.00000, 254.00000);
	CreateDynamicObject(2064, -1428.29004, -127.21000, 25.06000,   0.00000, 0.00000, 159.99001);
	CreateDynamicObject(1636, -1431.68005, -125.89000, 24.52000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1636, -1432.53003, -126.08000, 24.55000,   0.00000, 0.00000, 44.00000);
	CreateDynamicObject(1636, -1436.56006, -128.17000, 25.72000,   14.21000, 355.87000, 73.00000);
	CreateDynamicObject(16364, -1754.41003, -524.37000, 1.81000,   0.00000, 0.00000, 269.25000);
	CreateDynamicObject(16770, -1433.31006, -139.30000, 26.00000,   0.00000, 0.00000, 163.75000);
	CreateDynamicObject(2035, -1435.22998, -131.94000, 25.38000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2036, -1435.56995, -133.52000, 25.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2036, -1435.01001, -134.73000, 25.57000,   0.01000, 91.00000, 76.99000);
	CreateDynamicObject(2044, -1436.98999, -137.89000, 25.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2044, -1436.79004, -137.63000, 25.39000,   0.00000, 0.00000, 296.00000);
	CreateDynamicObject(1654, -1434.65002, -133.41000, 25.74000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(17324, -1285.32996, 66.50000, 13.14000,   0.00000, 0.00000, 224.00000);
	CreateDynamicObject(1458, -1283.38000, 77.77000, 13.37000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(10281, -1294.12000, 75.75000, 21.06000,   0.00000, 0.00000, 224.00000);
	CreateDynamicObject(1583, -1297.63000, 68.96000, 13.17000,   0.00000, 0.00000, 314.00000);
	CreateDynamicObject(1584, -1296.20996, 67.52000, 13.17000,   0.00000, 0.00000, 314.00000);
	CreateDynamicObject(1585, -1294.88000, 66.10000, 13.17000,   0.00000, 0.00000, 314.00000);
	CreateDynamicObject(18740, -1209.52002, 154.42999, 13.19000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18786, -1460.96997, -15.53000, 16.04000,   0.00000, 3.99000, 313.98999);
	CreateDynamicObject(18786, -1470.25000, -5.89000, 25.06000,   0.00000, 33.99000, 313.98999);
	CreateDynamicObject(18766, -1563.78003, -132.87000, 15.77000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1563.78003, -132.87000, 20.72000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, -1559.17004, -128.28000, 15.77000,   0.00000, 0.00000, 268.50000);
	CreateDynamicObject(18766, -1555.31006, -124.16000, 18.27000,   0.00000, 310.00000, 178.24001);
	CreateDynamicObject(17310, -1586.25000, -81.10000, 18.29000,   0.18000, 139.74001, 44.65000);
	CreateDynamicObject(18755, -1365.91003, 299.48001, 27.80000,   0.00000, 0.00000, 269.98999);
	CreateDynamicObject(5990, -1483.62000, 20.85000, 10.65000,   89.68000, 0.02000, 225.03999);
	CreateDynamicObject(5990, -1535.38000, -30.99000, 10.65000,   89.68000, 0.01000, 225.03000);
	CreateDynamicObject(5990, -1564.39001, -59.89000, 10.65000,   89.68000, 0.01000, 225.03000);
	CreateDynamicObject(5990, -1440.09998, 64.35000, 10.65000,   89.68000, 0.01000, 225.03000);
	CreateDynamicObject(5990, -1388.92004, 115.59000, 10.65000,   89.68000, 0.01000, 225.03000);
	CreateDynamicObject(5990, -1328.93005, 175.64999, 10.65000,   89.68000, 0.01000, 225.03000);
	CreateDynamicObject(5990, -1270.59998, 233.61000, 10.65000,   89.68000, 0.01000, 225.03000);
	CreateDynamicObject(5990, -1213.13000, 291.34000, 10.65000,   89.68000, 0.01000, 225.03000);
	CreateDynamicObject(5990, -1167.43994, 336.95999, 10.65000,   89.68000, 0.01000, 225.03000);
	CreateDynamicObject(18809, -1097.92004, 85.71000, 24.92000,   0.00000, 270.00000, 117.98000);
	CreateDynamicObject(18822, -1188.64001, 205.11000, 61.64000,   89.74000, 90.00000, 210.23000);
	CreateDynamicObject(18822, -963.10999, 442.39001, 61.63000,   89.74000, 90.00000, 346.97000);
	CreateDynamicObject(18820, -893.84003, 243.63000, 61.58000,   270.00000, 180.69000, 186.44000);
	CreateDynamicObject(18809, -898.94000, 293.17999, 61.56000,   0.00000, 270.00000, 95.99000);
	CreateDynamicObject(18809, -784.56000, 370.60001, 53.89000,   0.00000, 270.00000, 29.98000);
	CreateDynamicObject(18809, -909.38000, 392.32001, 61.56000,   0.00000, 270.00000, 95.99000);
	CreateDynamicObject(18809, -1056.48999, 464.85001, 61.58000,   0.00000, 270.00000, 180.48000);
	CreateDynamicObject(18818, -922.37000, 441.07999, 61.61000,   90.00000, 180.67999, 275.29999);
	CreateDynamicObject(18822, -1008.07001, 459.89999, 61.63000,   89.74000, 90.00000, 161.96001);
	CreateDynamicObject(18809, -1106.28003, 464.41000, 61.58000,   0.00000, 270.00000, 180.48000);
	CreateDynamicObject(18809, -1156.43994, 463.98999, 53.64000,   0.00000, 288.00000, 180.48000);
	CreateDynamicObject(18809, -1203.83997, 463.60001, 38.26000,   0.00000, 287.98999, 180.47000);
	CreateDynamicObject(18809, -1251.26001, 463.23999, 22.88000,   0.00000, 287.98999, 180.47000);
	CreateDynamicObject(18809, -1267.43005, 463.09000, 17.63000,   0.00000, 287.98999, 180.47000);
	CreateDynamicObject(18789, -1026.55005, 467.66000, 12.85000,   0.00000, 0.00000, 225.75000);
	CreateDynamicObject(18809, -943.37000, 238.59000, 61.56000,   0.00000, 270.00000, 5.99000);
	CreateDynamicObject(18809, -992.91998, 233.37000, 61.56000,   0.00000, 270.00000, 5.98000);
	CreateDynamicObject(18809, -1042.51001, 228.17000, 61.56000,   0.00000, 270.00000, 5.98000);
	CreateDynamicObject(18809, -1092.10999, 222.99001, 61.59000,   0.00000, 270.00000, 5.98000);
	CreateDynamicObject(18809, -1141.71997, 217.78999, 61.59000,   0.00000, 270.00000, 5.98000);
	CreateDynamicObject(18809, -1225.20996, 173.33000, 61.59000,   0.00000, 270.00000, 45.98000);
	CreateDynamicObject(18809, -1259.82996, 137.48000, 61.59000,   0.00000, 270.00000, 45.98000);
	CreateDynamicObject(18778, -1385.62000, 464.50000, 7.68000,   11.99000, 0.00000, 90.49000);
	CreateDynamicObject(18778, -1391.83997, 464.45001, 13.03000,   25.98000, 0.00000, 90.49000);
	CreateDynamicObject(18809, -844.42999, 248.73000, 61.54000,   0.00000, 270.00000, 5.98000);
	CreateDynamicObject(18809, -794.82001, 253.92000, 51.82000,   0.00000, 291.98999, 5.98000);
	CreateDynamicObject(18809, -748.89001, 258.72000, 33.16000,   0.00000, 291.98999, 5.98000);
	CreateDynamicObject(18809, -703.34003, 263.48999, 14.64000,   0.00000, 291.98999, 5.98000);
	CreateDynamicObject(18789, -1220.93994, 418.13000, 7.55000,   0.00000, 355.98999, 313.98999);
	CreateDynamicObject(18789, -921.88000, 575.09003, 12.85000,   0.00000, 0.00000, 225.74001);
	CreateDynamicObject(18789, -817.25000, 682.50000, 12.85000,   0.00000, 0.00000, 225.74001);
	CreateDynamicObject(18824, -1170.56006, 75.30000, 23.75000,   308.88000, 307.20001, 220.28000);
	CreateDynamicObject(18824, -1141.96997, 54.64000, 42.78000,   316.94000, 74.46000, 273.09000);
	CreateDynamicObject(18824, -1134.25000, 10.81000, 36.73000,   287.51999, 335.20999, 3.24000);
	CreateDynamicObject(18824, -1097.21997, 0.71000, 28.67000,   276.81000, 331.45001, 90.63000);
	CreateDynamicObject(18822, -1081.00000, 40.30000, 25.76000,   271.98999, 0.00000, 187.00000);
	CreateDynamicObject(18822, -1114.42004, 131.38000, 25.71000,   271.98999, 0.00000, 5.74000);
	CreateDynamicObject(18822, -1101.48999, 176.28999, 27.43000,   271.98999, 0.00000, 321.98999);
	CreateDynamicObject(18809, -1063.46997, 206.50999, 28.24000,   0.00000, 270.00000, 30.98000);
	CreateDynamicObject(18809, -1020.71997, 232.20000, 28.24000,   0.00000, 270.00000, 30.98000);
	CreateDynamicObject(18776, -998.34003, 245.78000, 26.19000,   348.00000, 359.73999, 299.44000);
	CreateDynamicObject(18776, -995.12000, 247.60001, 27.39000,   3.74000, 359.73999, 299.51001);
	CreateDynamicObject(18822, -941.58002, 279.95001, 53.70000,   0.00000, 246.00000, 30.00000);
	CreateDynamicObject(18822, -905.53998, 300.76999, 78.18000,   0.00000, 64.49000, 29.99000);
	CreateDynamicObject(18822, -865.03003, 324.14001, 81.06000,   0.00000, 108.48000, 29.99000);
	CreateDynamicObject(18822, -826.75000, 346.25000, 60.07000,   0.00000, 290.48001, 29.98000);
	CreateDynamicObject(18809, -904.15997, 342.75000, 61.56000,   0.00000, 270.00000, 95.98000);
	CreateDynamicObject(18809, -741.32001, 395.57001, 53.89000,   0.00000, 270.00000, 29.98000);
	CreateDynamicObject(18809, -698.14001, 420.51001, 53.89000,   0.00000, 270.00000, 29.98000);
	CreateDynamicObject(18809, -654.94000, 445.44000, 53.89000,   0.00000, 270.00000, 29.98000);
	CreateDynamicObject(18781, -1578.23999, -44.34000, 23.12000,   0.00000, 0.00000, 44.98000);
	CreateDynamicObject(18801, -627.51001, 450.12000, 71.82000,   0.00000, 0.00000, 38.00000);
	CreateDynamicObject(18801, -613.72998, 435.81000, 71.82000,   0.00000, 0.00000, 37.99000);
	CreateDynamicObject(18778, -606.91998, 428.60999, 50.51000,   0.00000, 359.50000, 302.00000);
	CreateDynamicObject(18778, -600.76001, 432.48999, 54.66000,   15.99000, 359.47000, 302.14001);
	CreateDynamicObject(18770, -1220.34998, -232.84000, -52.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18770, -1220.50000, -240.17999, -52.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18770, -1198.34998, -233.11000, -52.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18770, -1198.45996, -240.50000, -52.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18770, -1188.69995, -241.05000, -52.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18770, -1188.56006, -233.64999, -52.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18770, -1166.57996, -233.74001, -52.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18770, -1166.70996, -241.10001, -52.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18770, -1067.89001, -215.03999, 22.08000,   284.00000, 0.00000, 272.00000);
	CreateDynamicObject(18770, -1067.94995, -213.06000, 22.08000,   283.98999, 0.00000, 271.98999);
	CreateDynamicObject(18770, -1068.02002, -211.12000, 22.08000,   283.98999, 0.00000, 271.98999);
	CreateDynamicObject(17310, -1173.52002, -67.62000, 48.54000,   359.85999, 79.74000, 45.22000);
	CreateDynamicObject(18771, -1334.34998, 455.64001, -22.62000,   0.00000, 0.00000, 185.99001);
	CreateDynamicObject(18766, -1253.48999, 489.57999, 16.73000,   90.00000, 179.07001, 270.92999);
	CreateDynamicObject(18766, -1253.47998, 485.87000, 16.73000,   90.00000, 179.07001, 270.92001);
	CreateDynamicObject(11367, -1367.48999, -49.76000, -9.72000,   0.00000, 0.00000, 134.78000);
	CreateDynamicObject(19419, -1244.09998, 22.16000, 14.09000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18779, 1874.42004, -2292.61011, 22.31000,   0.00000, 0.00000, 4.00000);
	CreateDynamicObject(6959, 2025.33997, -2286.16992, 24.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6959, 2025.22998, -2246.12012, 24.56000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18788, 1986.35999, -2294.80005, 16.80000,   0.00000, 340.00000, 0.00000);
	CreateDynamicObject(18788, 1986.26001, -2269.52002, 16.80000,   0.00000, 340.00000, 0.00000);
	CreateDynamicObject(18790, 1910.18994, -2284.55005, 10.80000,   0.00000, 0.00000, 272.00000);
	CreateDynamicObject(18801, 1680.45996, -2593.95996, 34.90000,   0.00000, 0.00000, 2.00000);
	CreateDynamicObject(18750, 1892.55005, -2281.42993, 19.70000,   87.99000, 0.00000, 92.00000);
	CreateDynamicObject(18789, 1945.81995, -2279.67993, 42.92000,   0.00000, 0.00000, 4.00000);
	CreateDynamicObject(18779, 1865.32996, -2292.90991, 31.06000,   0.00000, 26.00000, 4.00000);
	CreateDynamicObject(18779, 1862.31995, -2293.03003, 38.06000,   0.00000, 44.00000, 3.99000);
	CreateDynamicObject(18779, 1861.65002, -2292.68994, 51.56000,   0.00000, 77.99000, 3.99000);
	CreateDynamicObject(18795, 2039.44995, -2272.44995, 42.36000,   0.00000, 0.00000, 6.00000);
	CreateDynamicObject(18795, 2077.68994, -2277.53003, 42.36000,   0.00000, 0.00000, 354.00000);
	CreateDynamicObject(18795, 2113.11011, -2293.02002, 42.36000,   0.00000, 0.00000, 334.00000);
	CreateDynamicObject(18795, 2142.39990, -2319.72998, 42.36000,   0.00000, 0.00000, 316.00000);
	CreateDynamicObject(18795, 2161.90991, -2354.14990, 42.36000,   0.00000, 0.00000, 297.98999);
	CreateDynamicObject(18795, 2169.78003, -2393.00000, 42.36000,   0.00000, 0.00000, 279.98999);
	CreateDynamicObject(18795, 2165.35010, -2432.13989, 42.36000,   0.00000, 0.00000, 261.98999);
	CreateDynamicObject(18795, 2150.02002, -2469.04004, 42.36000,   0.00000, 0.00000, 247.99001);
	CreateDynamicObject(18778, 2139.65991, -2482.42993, 44.73000,   0.00000, 0.00000, 140.00000);
	CreateDynamicObject(18778, 2137.16992, -2485.57007, 47.23000,   18.00000, 0.00000, 140.00000);
	CreateDynamicObject(18789, 1911.88000, -2406.95996, 35.92000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18809, 1911.97998, -2506.33008, 41.15000,   270.00000, 180.00000, 180.00000);
	CreateDynamicObject(18809, 1911.96997, -2556.35010, 41.15000,   270.00000, 179.99001, 179.99001);
	CreateDynamicObject(18826, 1896.62000, -2592.42993, 40.61000,   272.00000, 180.00000, 272.00000);
	CreateDynamicObject(18826, 1863.46997, -2573.93994, 40.61000,   272.00000, 179.99001, 96.00000);
	CreateDynamicObject(18825, 1848.75000, -2596.41992, 57.10000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18829, 1848.68994, -2560.56006, 69.38000,   278.00000, 180.00000, 180.00000);
	CreateDynamicObject(1632, 1850.40002, -2537.60010, 62.49000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1632, 1846.65002, -2537.44995, 62.49000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18789, 1906.16003, -2161.78003, 35.92000,   0.00000, 0.00000, 91.99000);
	CreateDynamicObject(18789, 1903.25000, -2074.65991, 35.92000,   0.00000, 0.00000, 91.99000);
	CreateDynamicObject(18779, 1895.20996, -2004.54004, 45.96000,   0.00000, 0.00000, 272.00000);
	CreateDynamicObject(18779, 1894.84998, -1997.78003, 52.21000,   0.00000, 20.00000, 272.00000);
	CreateDynamicObject(18779, 1894.98999, -1992.97998, 61.21000,   0.00000, 40.00000, 272.00000);
	CreateDynamicObject(18779, 1895.06006, -1991.85999, 68.96000,   0.00000, 57.99000, 272.00000);
	CreateDynamicObject(18789, 1903.69995, -2090.37988, 52.12000,   0.00000, 0.00000, 91.99000);
	CreateDynamicObject(18778, 1905.97998, -2163.04004, 53.68000,   0.00000, 0.00000, 182.00000);
	CreateDynamicObject(18778, 1906.18005, -2167.11011, 55.93000,   14.00000, 0.00000, 182.00000);
	CreateDynamicObject(18779, 1814.39001, -2418.51001, 21.80000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18789, 1715.03003, -2413.36011, 31.42000,   0.00000, 0.00000, 179.99001);
	CreateDynamicObject(18779, 1635.45996, -2419.15991, 40.10000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18844, 1621.97998, -2413.25000, 99.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18859, 2120.95996, -2450.85010, 23.92000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18859, 2072.95996, -2450.90991, 23.92000,   0.00000, 0.00000, 360.00000);
	CreateDynamicObject(18859, 2072.95996, -2450.90991, 23.92000,   0.00000, 0.00000, 360.00000);
	CreateDynamicObject(18859, 2072.21997, -2597.48999, 23.92000,   0.00000, 0.00000, 179.99001);
	CreateDynamicObject(18859, 2072.21997, -2597.48999, 23.92000,   0.00000, 0.00000, 179.99001);
	CreateDynamicObject(18859, 2112.18994, -2597.52002, 23.92000,   0.00000, 0.00000, 179.99001);
	CreateDynamicObject(18859, 2112.18994, -2597.52002, 23.92000,   0.00000, 0.00000, 179.99001);
	CreateDynamicObject(18753, 2086.06006, -2529.58008, 13.05000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18859, 2047.56006, -2597.64990, 23.92000,   0.00000, 0.00000, 179.99001);
	CreateDynamicObject(18859, 2047.56006, -2597.64990, 23.92000,   0.00000, 0.00000, 179.99001);
	CreateDynamicObject(18859, 2047.91003, -2450.92993, 23.92000,   0.00000, 0.00000, 359.98999);
	CreateDynamicObject(18859, 2047.91003, -2450.92993, 23.92000,   0.00000, 0.00000, 359.98999);
	CreateDynamicObject(18785, 2013.56006, -2541.02002, 11.05000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18785, 2013.66003, -2560.06006, 11.05000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18785, 2013.44995, -2521.33008, 11.05000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18785, 2013.55005, -2501.51001, 11.05000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18785, 2013.57996, -2481.78003, 11.05000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18859, 2123.50000, -2564.68994, 23.92000,   0.00000, 0.00000, 269.98999);
	CreateDynamicObject(18859, 2123.50000, -2564.68994, 23.92000,   0.00000, 0.00000, 269.98999);
	CreateDynamicObject(18859, 2123.46997, -2516.12012, 23.92000,   0.00000, 0.00000, 269.98999);
	CreateDynamicObject(18859, 2123.46997, -2516.12012, 23.92000,   0.00000, 0.00000, 269.98999);
	CreateDynamicObject(18859, 2123.46997, -2467.90991, 23.92000,   0.00000, 0.00000, 269.98999);
	CreateDynamicObject(18859, 2123.46997, -2467.90991, 23.92000,   0.00000, 0.00000, 269.98999);
	CreateDynamicObject(18781, 1999.40002, -2440.59009, 23.27000,   0.00000, 0.00000, 272.00000);
	CreateDynamicObject(18781, 2002.76001, -2608.28003, 23.27000,   0.00000, 0.00000, 269.98999);
	CreateDynamicObject(19073, 1442.77002, -2493.87988, 13.30000,   358.00000, 0.00000, 270.00000);
	CreateDynamicObject(19073, 1427.04004, -2494.02002, 17.80000,   349.98999, 0.00000, 270.00000);
	CreateDynamicObject(19073, 1405.96997, -2493.85010, 23.80000,   341.98999, 0.00000, 269.98999);
	CreateDynamicObject(19073, 1347.35999, -2493.98999, 33.14000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19073, 1288.10999, -2494.06006, 33.14000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19073, 1228.90002, -2494.13989, 33.14000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19073, 1169.59998, -2494.26001, 33.14000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1632, 1154.92004, -2509.38989, 34.44000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1632, 1149.85999, -2509.43994, 37.69000,   18.00000, 0.00000, 90.00000);
	CreateDynamicObject(1632, 1147.06995, -2509.37988, 41.69000,   42.00000, 0.00000, 90.00000);
	CreateDynamicObject(1632, 1146.04004, -2509.30005, 47.44000,   70.00000, 0.00000, 90.00000);
	CreateDynamicObject(1632, 1142.43994, -2500.82007, 34.44000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1632, 1142.39001, -2497.40991, 34.44000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1632, 1140.02002, -2480.97998, 34.44000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1632, 1139.95996, -2477.44995, 34.44000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1225, 1144.81006, -2491.72998, 33.54000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1144.83997, -2489.44995, 33.54000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1144.55005, -2487.42993, 33.54000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1146.43994, -2486.09009, 33.54000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1146.80005, -2489.52002, 33.54000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1146.67004, -2488.10010, 33.54000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1146.94995, -2491.11011, 33.54000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19073, 1047.68005, -2493.46997, 33.14000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19073, 988.07001, -2493.50000, 33.14000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1655, 959.75000, -2499.07007, 34.44000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 955.46997, -2499.11011, 37.44000,   22.00000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 952.17999, -2499.03003, 41.94000,   39.99000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 950.94000, -2499.18994, 47.44000,   67.99000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 951.62000, -2498.87988, 53.19000,   81.99000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 960.53998, -2488.70996, 34.44000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 956.14001, -2488.77002, 37.44000,   21.99000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 953.00000, -2488.78003, 41.94000,   39.99000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 951.94000, -2488.63989, 47.44000,   67.99000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 952.85999, -2488.75000, 53.19000,   81.99000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 960.54999, -2478.67993, 34.44000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 956.00000, -2478.72998, 37.44000,   21.99000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 952.62000, -2478.79004, 41.94000,   39.99000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 951.20001, -2478.84009, 47.44000,   67.99000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 951.96002, -2478.58008, 53.19000,   81.99000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 960.33002, -2508.48999, 34.44000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 955.72998, -2508.71997, 37.44000,   21.99000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 952.34003, -2508.73999, 41.94000,   39.99000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 951.23999, -2508.92993, 47.44000,   67.99000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 951.84998, -2509.02002, 53.19000,   81.99000, 0.00000, 90.00000);
	CreateDynamicObject(19073, 994.09998, -2493.58008, 43.89000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19073, 1032.00000, -2493.37012, 56.46000,   26.00000, 0.00000, 270.00000);
	CreateDynamicObject(19073, 1078.81995, -2493.16992, 79.41000,   26.00000, 0.00000, 270.00000);
	CreateDynamicObject(19071, 1136.85999, -2492.95996, 92.46000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19071, 1194.26001, -2493.11011, 92.46000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19071, 1252.92004, -2493.23999, 92.46000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 1282.07996, -2478.16992, 93.26000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1655, 1282.21997, -2487.95996, 93.26000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1655, 1282.31006, -2498.26001, 93.26000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1655, 1281.93005, -2508.26001, 93.26000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18750, 1787.93005, -2632.17993, 52.52000,   87.99000, 0.00000, 180.00000);
	CreateDynamicObject(18806, 1418.18005, -2583.62988, 9.55000,   0.00000, 2.00000, 0.00000);
	CreateDynamicObject(18845, 1557.17004, -2619.34009, 52.55000,   0.00000, 0.00000, 86.00000);
	CreateDynamicObject(18845, 1557.17004, -2619.34009, 52.55000,   0.00000, 0.00000, 86.00000);
	CreateDynamicObject(1660, 1557.18994, -2611.62988, 10.30000,   0.00000, 0.00000, 178.00000);
	CreateDynamicObject(16304, 1766.65002, -2542.96997, 17.23000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18801, 1681.28003, -2491.40991, 34.90000,   0.00000, 0.00000, 2.00000);
	CreateDynamicObject(18825, 1723.76001, -2403.67993, 33.13000,   0.00000, 0.00000, 268.00000);
	CreateDynamicObject(18836, 1723.41003, -2439.07007, 49.16000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18836, 1723.41003, -2439.07007, 49.16000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18836, 1723.39001, -2483.52002, 49.16000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18836, 1723.39001, -2483.52002, 49.16000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16401, 1723.50000, -2507.10010, 44.23000,   0.00000, 356.00000, 270.00000);
	CreateDynamicObject(16401, 1723.50000, -2507.10010, 44.23000,   0.00000, 356.00000, 270.00000);
	CreateDynamicObject(18862, 1939.50000, -2385.61011, 17.48000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18855, 1853.44995, -2362.62012, 49.12000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18841, 1881.02002, -2361.96997, 23.05000,   -4.00000, 91.00000, 89.17000);
	CreateDynamicObject(18983, 1934.67004, -2361.98999, 80.89000,   0.00000, 0.00000, 270.79999);
	CreateDynamicObject(18983, 2033.94995, -2360.60010, 80.89000,   0.00000, 0.00000, 270.79999);
	CreateDynamicObject(18833, 2108.40991, -2364.05005, 78.37000,   84.00000, 0.00000, 249.00000);
	CreateDynamicObject(18833, 2145.12988, -2395.06006, 73.40000,   84.00000, 0.00000, 210.67000);
	CreateDynamicObject(18833, 2153.53003, -2442.44995, 68.38000,   84.00000, 0.00000, 169.42999);
	CreateDynamicObject(18778, 2146.58008, -2460.19995, 63.28000,   0.00000, 0.00000, 140.00000);
	CreateDynamicObject(18855, 1899.60999, -2511.89990, 49.12000,   0.00000, 0.00000, 88.61000);
	CreateDynamicObject(18825, 1784.82996, -2645.05005, 33.10000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18779, 1955.53003, -2638.64990, 21.80000,   0.00000, 0.00000, 89.79000);
	CreateDynamicObject(18779, 1944.47998, -2638.50000, 21.80000,   0.00000, 0.00000, 90.09000);
	CreateDynamicObject(18779, 1955.47998, -2645.86011, 28.24000,   0.00000, 25.00000, 90.00000);
	CreateDynamicObject(18779, 1944.52002, -2645.63989, 28.24000,   0.00000, 25.00000, 90.00000);
	CreateDynamicObject(18779, 1955.39001, -2651.35010, 48.78000,   0.00000, 62.00000, 90.00000);
	CreateDynamicObject(18779, 1944.40002, -2651.22998, 48.78000,   0.00000, 62.00000, 90.00000);
	CreateDynamicObject(18779, 1955.33997, -2643.94995, 67.18000,   0.00000, 98.00000, 90.00000);
	CreateDynamicObject(18779, 1944.42004, -2643.86011, 67.18000,   0.00000, 98.00000, 90.00000);
	CreateDynamicObject(18450, 1940.89001, -2589.25000, 56.64000,   0.00000, 0.00000, 87.98000);
	CreateDynamicObject(18450, 1956.43994, -2589.81006, 56.64000,   0.00000, 0.00000, 87.98000);
	CreateDynamicObject(18450, 1959.22998, -2512.12988, 56.64000,   0.00000, 0.00000, 87.98000);
	CreateDynamicObject(18450, 1943.52002, -2510.52002, 56.64000,   0.00000, 0.00000, 87.98000);
	CreateDynamicObject(18779, 1940.81006, -2411.09009, 65.85000,   0.00000, 0.00000, 268.42999);
	CreateDynamicObject(18779, 1956.93005, -2412.09009, 65.85000,   0.00000, 0.00000, 268.42999);
	CreateDynamicObject(18450, 1946.18005, -2431.55005, 56.64000,   0.00000, 0.00000, 87.98000);
	CreateDynamicObject(18450, 1962.01001, -2432.37012, 56.64000,   0.00000, 0.00000, 87.98000);
	CreateDynamicObject(18772, 1426.79004, -2357.07007, 53.22000,   18.00000, 0.00000, 41.00000);
	CreateDynamicObject(18772, 1272.00000, -2179.10010, 129.89000,   18.00000, 0.00000, 41.00000);
	CreateDynamicObject(18785, 1188.90002, -2081.73999, 168.53000,   0.00000, 0.00000, 41.19000);
	CreateDynamicObject(18778, 1511.04004, -2452.39990, 13.64000,   0.00000, 0.00000, 221.34000);
	CreateDynamicObject(18778, 1513.43005, -2455.04004, 15.35000,   18.00000, 0.00000, 221.00000);
	CreateDynamicObject(18843, 1448.67004, -2444.00000, 82.69000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18779, 1455.85999, -2454.19995, 22.40000,   0.00000, 0.00000, 331.51001);
	CreateDynamicObject(18778, 1663.50000, -2539.44995, 13.90000,   0.00000, 0.00000, 89.32000);
	CreateDynamicObject(18778, 1663.35999, -2545.42993, 13.90000,   0.00000, 0.00000, 89.32000);
	CreateDynamicObject(18450, 1390.54614, 1835.85339, 17.47820,   0.00000, 346.00000, 90.00000);
	CreateDynamicObject(18450, 1395.48914, 1842.85303, 131.23630,   0.00000, 178.00000, 92.00012);
	CreateDynamicObject(18450, 1390.57104, 1849.60181, 21.97583,   0.37590, -22.36488, 89.93614);
	CreateDynamicObject(18450, 1390.64404, 1861.71790, 28.03740,   0.73898, -30.90176, 89.95274);
	CreateDynamicObject(18450, 1390.76318, 1872.17102, 35.40242,   1.07551, -39.52920, 90.04473);
	CreateDynamicObject(18450, 1390.92603, 1880.93091, 43.81039,   1.37250, -48.22256, 90.20163);
	CreateDynamicObject(18450, 1391.13049, 1887.96667, 53.00081,   1.61961, -57.02762, 90.40859);
	CreateDynamicObject(18450, 1391.37439, 1893.24817, 62.71320,   1.81031, -66.06388, 90.64846);
	CreateDynamicObject(18450, 1391.65540, 1896.74463, 72.68706,   1.94226, -75.51881, 90.90489);
	CreateDynamicObject(18450, 1391.97119, 1898.42554, 82.66189,   2.01601, -85.63019, 91.16727);
	CreateDynamicObject(18450, 1392.31982, 1898.26050, 92.37720,   2.02911, -96.64338, 91.43728);
	CreateDynamicObject(18450, 1392.69885, 1896.21887, 101.57250,   1.96277, -108.72168, 91.72773);
	CreateDynamicObject(18450, 1393.10620, 1892.27026, 109.98729,   1.77605, -121.80117, 92.03368);
	CreateDynamicObject(18450, 1393.53955, 1886.38403, 117.36108,   1.44748, -135.45717, 92.29005);
	CreateDynamicObject(18450, 1393.99683, 1878.52979, 123.43336,   1.03984, -148.94431, 92.40385);
	CreateDynamicObject(18450, 1394.47559, 1868.67676, 127.94366,   0.65584, -161.47847, 92.35718);
	CreateDynamicObject(18450, 1394.97375, 1856.79480, 130.63147,   0.32161, -172.54694, 92.20809);
	CreateDynamicObject(18450, 1422.38684, 1872.63379, 18.57066,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18450, 1396.25110, 1829.14099, 129.51091,   -2.04128, 167.03780, 94.07224);
	CreateDynamicObject(18450, 1397.44604, 1817.91064, 125.59360,   -4.59915, 154.02831, 95.65853);
	CreateDynamicObject(18450, 1399.00757, 1809.07507, 119.80217,   -7.42303, 139.46828, 96.35898);
	CreateDynamicObject(18450, 1400.86914, 1802.54736, 112.45443,   -9.98734, 124.42606, 96.01451);
	CreateDynamicObject(18450, 1402.96411, 1798.24084, 103.86819,   -11.84389, 110.08090, 94.86289);
	CreateDynamicObject(18450, 1405.22595, 1796.06873, 94.36125,   -12.87488, 97.13316, 93.30227);
	CreateDynamicObject(18450, 1407.58826, 1795.94397, 84.25141,   -13.18480, 85.67039, 91.64005);
	CreateDynamicObject(18450, 1409.98438, 1797.77991, 73.85649,   -12.92234, 75.41322, 90.05269);
	CreateDynamicObject(18450, 1412.34778, 1801.48975, 63.49429,   -12.20317, 65.96692, 88.63886);
	CreateDynamicObject(18450, 1414.61194, 1806.98669, 53.48261,   -11.10164, 56.94920, 87.46913);
	CreateDynamicObject(18450, 1416.71045, 1814.18372, 44.13926,   -9.66585, 48.03503, 86.61490);
	CreateDynamicObject(18450, 1418.57654, 1822.99426, 35.78204,   -7.93901, 38.97364, 86.16113);
	CreateDynamicObject(18450, 1420.14368, 1833.33130, 28.72877,   -5.98327, 29.60672, 86.20519);
	CreateDynamicObject(18450, 1421.34558, 1845.10815, 23.29724,   -3.90178, 19.89556, 86.83894);
	CreateDynamicObject(18450, 1422.11548, 1858.23792, 19.80527,   -1.84719, 9.94534, 88.11356);
	CreateDynamicObject(1634, 1418.86499, 1911.60547, 20.21172,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1422.59448, 1911.58167, 20.21172,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1426.32446, 1911.65100, 20.21172,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(9076, 1477.43213, 1570.13062, 10.15530,   0.00000, 0.00000, 278.00000);
	CreateDynamicObject(9076, 1478.44824, 1555.19971, 10.15530,   0.00000, 0.00000, 89.99805);
	CreateDynamicObject(18449, 1260.13672, 1537.00439, 59.97919,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1327.14905, 1536.82568, 15.39647,   11.00000, 0.00000, 90.00000);
	CreateDynamicObject(18449, 1253.54736, 1537.85571, 27.14001,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(18449, 1255.97937, 1537.31628, 85.57513,   0.00000, 180.00000, 180.00000);
	CreateDynamicObject(18449, 1233.76929, 1537.84314, 28.50101,   -1.51905, -8.44829, 179.85294);
	CreateDynamicObject(18449, 1218.05688, 1537.80872, 32.23278,   -2.73796, -19.13010, 179.23396);
	CreateDynamicObject(18449, 1206.38806, 1537.75720, 37.80848,   -3.19789, -33.27675, 178.24962);
	CreateDynamicObject(18449, 1198.74109, 1537.69360, 44.70128,   -2.21434, -52.63306, 177.79471);
	CreateDynamicObject(18449, 1195.09387, 1537.62268, 52.38433,   -0.57021, -78.17709, 179.80264);
	CreateDynamicObject(18449, 1195.42456, 1537.54932, 60.33081,   -0.84121, -106.29655, -178.93214);
	CreateDynamicObject(18449, 1199.71130, 1537.47839, 68.01386,   -2.71347, -130.23624, -177.42111);
	CreateDynamicObject(18449, 1207.93201, 1537.41479, 74.90666,   -3.39675, -148.09756, -178.21616);
	CreateDynamicObject(18449, 1220.06494, 1537.36328, 80.48237,   -2.78694, -161.36792, -179.23891);
	CreateDynamicObject(18449, 1236.08801, 1537.32886, 84.21413,   -1.52561, -171.65335, -179.85378);
	CreateDynamicObject(18449, 1331.62817, 1536.99866, 59.97919,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18449, 1476.09229, 1538.03174, 59.67234,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1368.94568, 1540.58557, 61.62025,   11.00000, 0.00000, 270.00000);
	CreateDynamicObject(1634, 1368.93628, 1536.68506, 61.62025,   11.00000, 0.00000, 270.00000);
	CreateDynamicObject(1634, 1368.92847, 1533.38477, 61.62025,   11.00000, 0.00000, 270.00000);
	CreateDynamicObject(13641, 1518.42224, 1538.02356, 61.51503,   0.00000, 352.00000, 358.00000);
	CreateDynamicObject(7980, 1613.36230, 1629.70422, 11.80728,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(7980, 1619.08191, 1629.80640, 22.12302,   0.00000, 332.00000, 0.00000);
	CreateDynamicObject(7980, 1621.69885, 1629.84607, 30.65657,   0.00000, 317.99377, 0.00000);
	CreateDynamicObject(12956, 1436.49329, 1525.47339, 12.50350,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1655, 1439.12317, 1445.52600, 11.12042,   10.99731, 0.00000, 269.99951);
	CreateDynamicObject(1634, 1474.56116, 1522.18347, 11.10982,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1478.51953, 1522.10669, 11.10982,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1482.64917, 1522.08569, 11.10982,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1482.56799, 1527.06238, 15.13668,   30.99988, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1479.03198, 1527.06567, 15.13668,   30.99792, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1475.24841, 1527.10522, 15.13668,   30.99792, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1474.50574, 1527.21143, 15.13668,   30.99792, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1481.86584, 1598.23816, 11.10982,   0.00000, 0.00000, 179.99951);
	CreateDynamicObject(1634, 1477.86523, 1598.20605, 11.10982,   0.00000, 0.00000, 179.99451);
	CreateDynamicObject(1634, 1473.86523, 1598.17480, 11.10982,   0.00000, 0.00000, 179.99451);
	CreateDynamicObject(1634, 1477.73657, 1592.80444, 16.07045,   30.99988, 0.00000, 180.00000);
	CreateDynamicObject(1634, 1481.84143, 1592.93079, 15.86665,   30.99792, 0.00000, 179.99451);
	CreateDynamicObject(1634, 1473.85950, 1592.84546, 16.06298,   30.99792, 0.00000, 179.99451);
	CreateDynamicObject(18449, 1478.13916, 1505.54529, 48.55842,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1655, 1477.87122, 1470.37402, 50.20228,   10.99731, 0.00000, 179.99951);
	CreateDynamicObject(1225, 1471.69812, 1590.03455, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1474.23071, 1590.32568, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1477.06958, 1590.07666, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1481.10608, 1590.18494, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1481.10547, 1590.18457, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1483.85413, 1590.12280, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1483.76367, 1586.12402, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1480.76514, 1586.19141, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1477.01648, 1586.27563, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1474.26697, 1586.33716, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1472.01770, 1586.38745, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1471.92212, 1582.13879, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1474.05298, 1581.98657, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1476.61963, 1582.18457, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1480.30371, 1582.42041, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1483.88403, 1582.42847, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1473.59949, 1532.93689, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1477.08032, 1532.87842, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1480.23633, 1532.68164, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1484.04346, 1532.76172, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1483.86926, 1536.33704, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1480.06201, 1536.25684, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1477.13708, 1536.35950, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1473.65503, 1536.41748, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1473.52515, 1539.43506, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1476.68066, 1539.23828, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1480.16235, 1539.18018, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 1483.87561, 1539.02795, 10.21826,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(7586, 1433.31641, 1624.85254, 11.65432,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(5644, 1595.83691, 1450.04590, 63.22105,   0.00000, 77.98926, 0.00000);
	CreateDynamicObject(5644, 1610.03125, 1450.33203, 70.72105,   0.00000, 43.98926, 0.00000);
	CreateDynamicObject(5644, 1640.81738, 1449.95020, 84.45485,   0.00000, 87.98950, 0.00000);
	CreateDynamicObject(1634, 1697.38147, 1454.96814, 71.57805,   11.00000, 0.00000, 270.00000);
	CreateDynamicObject(16776, 1498.24451, 1212.00818, 9.82031,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(16776, 1498.74609, 1231.28076, 9.82031,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(16776, 1498.94507, 1250.17871, 9.82031,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(16776, 1460.71411, 1249.68677, 9.82031,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(16776, 1461.02075, 1230.60974, 9.82031,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(16776, 1460.85681, 1212.34705, 9.82031,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(7392, 1544.38696, 1214.80200, 38.70095,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3666, 1492.15845, 1257.13940, 10.26714,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3666, 1492.17932, 1247.42041, 10.26714,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3666, 1492.29883, 1233.91016, 10.26714,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3666, 1492.19482, 1214.38330, 10.26714,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3666, 1466.96899, 1213.22388, 10.26714,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3666, 1467.17334, 1236.00879, 10.26714,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3666, 1466.76587, 1255.76245, 10.26714,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3666, 1466.76563, 1255.76172, 10.26714,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8546, 1325.63831, 1402.34070, 76.67526,   0.00000, 173.99994, 182.00000);
	CreateDynamicObject(8546, 1307.13501, 1403.25098, 6.51329,   0.00000, 0.00000, 182.00000);
	CreateDynamicObject(8546, 1293.29370, 1402.75012, 7.39311,   -0.42068, -7.70370, -177.90283);
	CreateDynamicObject(8546, 1281.71399, 1402.29639, 9.87105,   -0.73922, -16.96787, -177.87662);
	CreateDynamicObject(8546, 1272.33984, 1401.89221, 13.70480,   -0.89616, -28.10259, -177.86499);
	CreateDynamicObject(8546, 1265.11511, 1401.54041, 18.65205,   -0.90664, -41.28720, -177.78159);
	CreateDynamicObject(8546, 1259.98364, 1401.24341, 24.47052,   -0.95687, -56.34241, -177.69041);
	CreateDynamicObject(8546, 1256.88928, 1401.00391, 30.91789,   -1.11080, -72.54617, -177.80446);
	CreateDynamicObject(8546, 1255.77600, 1400.82446, 37.75188,   -1.18303, -88.78986, -177.96220);
	CreateDynamicObject(8546, 1256.58740, 1400.70764, 44.73016,   -1.22234, -104.09916, -177.90555);
	CreateDynamicObject(8546, 1259.26770, 1400.65601, 51.61045,   -1.34547, -118.01398, -177.76073);
	CreateDynamicObject(8546, 1263.76050, 1400.67236, 58.15044,   -1.47130, -130.52667, -177.73560);
	CreateDynamicObject(8546, 1270.00977, 1400.75916, 64.10783,   -1.49502, -141.83235, -177.83516);
	CreateDynamicObject(8546, 1277.95935, 1400.91895, 69.24033,   -1.38467, -152.14836, -177.98193);
	CreateDynamicObject(8546, 1287.55310, 1401.15442, 73.30562,   -1.15179, -161.64059, -178.10732);
	CreateDynamicObject(8546, 1298.73499, 1401.46814, 76.06140,   -0.82334, -170.41306, -178.16652);
	CreateDynamicObject(8546, 1311.44873, 1401.86267, 77.26539,   -0.42971, -178.52275, -178.13432);
	CreateDynamicObject(6342, 1326.64575, 1253.48486, 42.88171,   21.98587, 270.80774, 179.84302);
	CreateDynamicObject(6342, 1326.44165, 1265.87109, 25.08413,   6.00000, 270.00430, 179.99475);
	CreateDynamicObject(5644, 1663.88672, 1450.25098, 85.20485,   0.00000, 87.98950, 0.00000);
	CreateDynamicObject(5644, 1681.35742, 1449.68164, 85.70485,   0.00000, 87.99500, 0.00000);
	CreateDynamicObject(1634, 1697.36206, 1451.08752, 71.57805,   10.99731, 0.00000, 270.00000);
	CreateDynamicObject(1634, 1697.36499, 1447.33691, 71.57805,   10.99731, 0.00000, 270.00000);
	CreateDynamicObject(1634, 1701.81824, 1447.45642, 76.22837,   30.99988, 0.00000, 270.00000);
	CreateDynamicObject(1634, 1701.83301, 1450.96472, 76.22837,   30.99792, 0.00000, 270.00000);
	CreateDynamicObject(1634, 1701.88647, 1454.97107, 76.22837,   30.99792, 0.00000, 270.00000);
	CreateDynamicObject(18449, 1772.27856, 1451.98474, 73.90931,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(18449, 1836.90723, 1452.09094, 73.90931,   0.00000, 0.00000, 179.99451);
	CreateDynamicObject(3080, 1876.19873, 1454.27759, 75.55317,   11.00000, 0.00000, 270.00000);
	CreateDynamicObject(3080, 1876.28857, 1450.20874, 75.55317,   11.00000, 0.00000, 270.00000);
	CreateDynamicObject(1634, 1429.54980, 1310.71814, 11.11763,   1.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1433.54980, 1310.64160, 11.11763,   0.99976, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1406.57703, 1337.99219, 11.11763,   0.99976, 0.00000, 270.00000);
	CreateDynamicObject(1634, 1406.47083, 1333.98511, 11.11763,   0.99426, 0.00000, 270.00000);
	CreateDynamicObject(1634, 1436.23254, 1364.23059, 11.11763,   0.98877, 0.00000, 182.00000);
	CreateDynamicObject(1634, 1432.36401, 1364.24329, 11.11763,   0.98877, 0.00000, 181.99951);
	CreateDynamicObject(1634, 1457.53638, 1337.70056, 11.11763,   0.98877, 0.00000, 89.99951);
	CreateDynamicObject(1634, 1457.41418, 1333.72449, 11.11763,   0.98328, 0.00000, 89.99902);
	CreateDynamicObject(1634, 1450.95093, 1333.66333, 15.06288,   11.00000, 0.00000, 89.99451);
	CreateDynamicObject(1634, 1450.92224, 1337.67065, 15.06288,   10.99731, 0.00000, 89.99451);
	CreateDynamicObject(1634, 1436.56799, 1356.69373, 15.64936,   10.99731, 0.00000, 181.99451);
	CreateDynamicObject(1634, 1429.67065, 1317.27466, 15.38223,   14.99731, 0.00000, 359.99451);
	CreateDynamicObject(1634, 1413.63342, 1337.94055, 15.32232,   10.99731, 0.00000, 269.99451);
	CreateDynamicObject(1634, 1446.18750, 1333.59595, 20.28843,   30.99988, 0.00000, 89.99451);
	CreateDynamicObject(1634, 1446.06848, 1337.60193, 20.28843,   30.99792, 0.00000, 89.99451);
	CreateDynamicObject(1634, 1436.73950, 1351.42651, 21.15483,   30.99792, 0.00000, 181.99451);
	CreateDynamicObject(1634, 1432.56018, 1356.58997, 15.64936,   10.99731, 0.00000, 181.99402);
	CreateDynamicObject(1634, 1413.60132, 1333.87073, 15.32232,   10.99731, 0.00000, 269.98901);
	CreateDynamicObject(1634, 1433.62256, 1317.23657, 15.38223,   14.99634, 0.00000, 359.98901);
	CreateDynamicObject(1634, 1432.79028, 1351.26709, 21.15483,   30.99792, 0.00000, 181.99402);
	CreateDynamicObject(1634, 1418.65063, 1338.04309, 20.68060,   30.99792, 0.00000, 271.99402);
	CreateDynamicObject(1634, 1418.69336, 1333.91992, 20.68060,   30.99792, 0.00000, 271.98853);
	CreateDynamicObject(1634, 1429.65930, 1322.31750, 21.52233,   34.99792, 0.00000, 359.98853);
	CreateDynamicObject(1634, 1433.64246, 1322.27295, 21.52233,   34.99792, 0.00000, 359.98352);
	CreateDynamicObject(5435, 1479.73352, 1238.42969, 9.91098,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(5435, 1551.88135, 1125.94421, 59.25956,   281.99997, 0.00000, 352.00000);
	CreateDynamicObject(5435, 1479.65930, 1222.16687, 10.63035,   -3.25401, -5.21277, -90.72253);
	CreateDynamicObject(5435, 1479.57263, 1207.59351, 12.64457,   -6.58341, -10.72733, -91.34734);
	CreateDynamicObject(5435, 1479.67786, 1194.60364, 15.73785,   -10.08862, -16.48750, -91.70779);
	CreateDynamicObject(5435, 1480.17896, 1183.09155, 19.69437,   -13.92300, -22.41129, -91.60735);
	CreateDynamicObject(5435, 1481.28003, 1172.95117, 24.29832,   -18.29380, -28.37668, -90.82210);
	CreateDynamicObject(5435, 1483.18555, 1164.07666, 29.33389,   -23.44513, -34.18147, -89.10597);
	CreateDynamicObject(5435, 1486.09937, 1156.36218, 34.58527,   -29.60151, -39.46945, -86.20416);
	CreateDynamicObject(5435, 1490.22583, 1149.70166, 39.83665,   -36.85030, -43.65165, -81.88411);
	CreateDynamicObject(5435, 1495.76904, 1143.98938, 44.87222,   -44.98637, -45.92323, -75.97697);
	CreateDynamicObject(5435, 1502.93298, 1139.11938, 49.47617,   -53.45175, -45.45655, -68.36549);
	CreateDynamicObject(5435, 1511.92212, 1134.98572, 53.43269,   -61.51290, -41.58522, -58.82040);
	CreateDynamicObject(5435, 1522.94043, 1131.48267, 56.52597,   -68.55112, -33.62917, -46.67527);
	CreateDynamicObject(5435, 1536.19214, 1128.50403, 58.54020,   -74.16151, -20.37399, -30.45189);
	CreateDynamicObject(5435, 1626.93298, 1198.85010, 46.04002,   326.00000, 0.00000, 88.00000);
	CreateDynamicObject(5435, 1575.22815, 1122.87988, 58.80622,   -76.39716, 10.36532, 3.55896);
	CreateDynamicObject(5435, 1592.98059, 1121.44226, 57.59126,   -74.01312, 21.18920, 18.71514);
	CreateDynamicObject(5435, 1605.92822, 1122.13037, 55.83228,   -69.72131, 30.44816, 38.93142);
	CreateDynamicObject(5435, 1614.86084, 1125.44348, 53.74689,   -61.88891, 31.22461, 61.82161);
	CreateDynamicObject(5435, 1620.56787, 1131.88037, 51.55270,   -52.34438, 22.00216, 79.65260);
	CreateDynamicObject(5435, 1623.83899, 1141.94043, 49.46731,   -45.62482, 13.03682, 88.50555);
	CreateDynamicObject(5435, 1625.46387, 1156.12268, 47.70833,   -41.22116, 7.04369, 90.94196);
	CreateDynamicObject(5435, 1626.23193, 1174.92627, 46.49337,   -37.55764, 2.95390, 90.17860);
	CreateDynamicObject(5435, 1626.34814, 1295.24609, 45.46729,   324.00000, 0.00000, 92.00000);
	CreateDynamicObject(5435, 1622.98816, 1389.45007, 45.21729,   323.99780, 0.00000, 91.99951);
	CreateDynamicObject(1634, 1454.03674, 1627.15601, 11.11763,   3.00000, 0.00000, 90.00000);
	CreateDynamicObject(1634, 1453.92627, 1623.11816, 11.11763,   2.99927, 0.00000, 90.00000);
	CreateDynamicObject(1634, 1409.33496, 1625.86816, 11.11763,   2.99927, 0.00000, 272.00000);
	CreateDynamicObject(1634, 1409.48889, 1622.08875, 11.11763,   2.99927, 0.00000, 271.99951);
	CreateDynamicObject(1634, 1435.42322, 1648.87122, 11.11763,   2.99927, 0.00000, 181.99951);
	CreateDynamicObject(1634, 1431.66675, 1648.76782, 11.11763,   2.99927, 0.00000, 181.99951);
	CreateDynamicObject(7586, 1432.83582, 1337.03979, 19.15432,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(7586, 1433.24182, 1337.56995, 6.65432,   0.00000, 180.00000, 180.00000);
	CreateDynamicObject(1634, 1511.21509, 1559.26953, 11.11204,   11.00000, 0.00000, 90.00000);
	CreateDynamicObject(1634, 1511.17944, 1562.64014, 11.11763,   10.99731, 0.00000, 90.00000);
	CreateDynamicObject(1634, 1442.00427, 1566.01355, 11.11030,   10.99731, 0.00000, 270.00000);
	CreateDynamicObject(1634, 1441.97217, 1562.25366, 11.11030,   10.99731, 0.00000, 270.00000);
	CreateDynamicObject(1634, 1447.81055, 1566.11121, 17.22915,   30.99988, 0.00000, 270.00000);
	CreateDynamicObject(1634, 1447.83618, 1562.36035, 17.22915,   30.99792, 0.00000, 270.00000);
	CreateDynamicObject(1634, 1506.38818, 1559.28235, 16.43618,   30.99792, 0.00000, 90.00000);
	CreateDynamicObject(1634, 1506.41675, 1563.03979, 16.43618,   30.99792, 0.00000, 90.00000);
	CreateDynamicObject(3437, 1457.98804, 1590.72449, 9.58011,   270.00000, 180.40350, 180.40350);
	CreateDynamicObject(3437, 1457.94189, 1579.74414, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1457.75830, 1564.67163, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1457.50354, 1527.67676, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1457.49719, 1504.63440, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1457.44031, 1431.37927, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1457.56641, 1401.65710, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1457.57373, 1376.79736, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1496.97095, 1375.22388, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1496.94409, 1405.86792, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1497.24768, 1429.53259, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1497.14063, 1460.90625, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1497.35938, 1503.23633, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1497.02563, 1530.25378, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1497.43982, 1557.57581, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1497.55139, 1584.56140, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1497.54346, 1609.75208, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1497.28467, 1634.80603, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1497.54077, 1663.50562, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1457.31323, 1664.91638, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1457.66858, 1639.43591, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1407.62903, 1669.49902, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1407.52173, 1633.93970, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1407.27222, 1601.45728, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1407.38501, 1572.20349, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1407.25916, 1547.26978, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1407.11194, 1521.75562, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1407.23669, 1495.56274, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1407.41504, 1436.95898, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1407.99463, 1410.91309, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1407.73706, 1382.40918, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1407.87622, 1351.89136, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1408.54541, 1313.92407, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1370.09741, 1316.46387, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1369.27441, 1348.31177, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1369.77832, 1382.49170, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1370.50940, 1436.77966, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1370.49011, 1468.71069, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1370.55078, 1505.87866, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1370.82153, 1553.06299, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1370.96033, 1608.60266, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(3437, 1370.35608, 1648.80969, 9.58011,   270.00000, 180.40100, 180.40100);
	CreateDynamicObject(7392, 1499.68274, 1437.38708, 39.23547,   0.00000, 0.00000, 96.00000);
	CreateDynamicObject(13679, 1601.03015, 1330.54443, 7.92378,   0.00000, 0.00000, 146.00000);
	CreateDynamicObject(1597, 1592.45007, 1311.78467, 12.49862,   0.00000, 0.00000, 94.00000);
	CreateDynamicObject(1597, 1613.58875, 1314.73047, 12.48611,   0.00000, 0.00000, 181.99902);
	CreateDynamicObject(1597, 1582.11389, 1340.56360, 12.50420,   0.00000, 0.00000, 171.99402);
	CreateDynamicObject(3507, 1580.97766, 1334.83386, 9.85245,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3507, 1582.15747, 1347.38086, 9.85723,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3507, 1588.46570, 1350.40588, 9.85569,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3507, 1585.81396, 1311.02954, 9.84772,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3507, 1602.88611, 1311.32190, 9.83043,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3507, 1602.19495, 1351.78430, 9.84176,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3507, 1614.61230, 1352.22205, 9.82290,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3507, 1630.36938, 1353.58923, 9.80733,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(5400, 1636.90100, 1247.44861, 32.14613,   25.97717, 2.22473, 269.02222);
	CreateDynamicObject(5400, 1643.72095, 1247.21716, 34.89613,   35.96884, 2.47125, 268.54504);
	CreateDynamicObject(5400, 1651.32410, 1247.09668, 39.14613,   49.94760, 3.10287, 267.61731);
	CreateDynamicObject(5400, 1654.61169, 1247.15283, 41.14613,   69.89014, 5.80597, 264.53406);
	CreateDynamicObject(5400, 1657.20264, 1246.83533, 46.14613,   77.82278, 9.48251, 260.70520);
	CreateDynamicObject(5400, 1660.44751, 1246.52466, 52.14613,   79.82211, 168.65881, 101.13889);
	CreateDynamicObject(5400, 1659.94263, 1246.28369, 59.64613,   67.93036, 174.69196, 94.88635);
	CreateDynamicObject(6066, 1580.80933, 1365.46094, 12.35898,   0.00000, 0.00000, 222.00000);
	CreateDynamicObject(1634, 1369.27039, 1280.42297, 11.11763,   6.00000, 0.00000, 92.00000);
	CreateDynamicObject(1634, 1369.08313, 1284.24036, 11.11763,   5.99854, 0.00000, 91.99951);
	CreateDynamicObject(1634, 1365.69177, 1280.32617, 13.86763,   17.99854, 0.00000, 91.99951);
	CreateDynamicObject(1634, 1365.53577, 1284.14685, 13.86763,   17.99561, 0.00000, 91.99402);
	CreateDynamicObject(13592, 1557.70740, 1491.98120, 19.49870,   6.00000, 0.00000, 48.00000);
	CreateDynamicObject(13592, 1553.86206, 1498.23511, 21.74870,   5.99854, 0.00000, 47.99927);
	CreateDynamicObject(13592, 1550.06714, 1505.23315, 24.24870,   5.99854, 0.00000, 47.99927);
	CreateDynamicObject(1634, 1550.91626, 1515.28882, 16.23542,   1.99512, 4.00244, 313.86044);
	CreateDynamicObject(1634, 1553.15967, 1512.93665, 15.98542,   1.97943, 8.00140, 309.71863);
	CreateDynamicObject(6875, 1505.87976, 1801.79980, -1.67969,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(8397, 1315.44055, 1463.55530, 19.87298,   0.00000, 0.00000, 88.00000);
	CreateDynamicObject(1634, 1329.48865, 1462.84998, 11.11763,   0.00000, 0.00000, 88.00000);
	CreateDynamicObject(1634, 1323.85730, 1463.08069, 14.68789,   14.00000, 0.00000, 87.99500);
	CreateDynamicObject(1634, 1320.09363, 1463.31946, 19.93789,   39.99661, 0.00000, 87.98950);
	CreateDynamicObject(1634, 1318.34363, 1463.26465, 26.43789,   57.99570, 0.00000, 87.98401);
	CreateDynamicObject(1634, 1318.35449, 1463.23755, 32.43790,   69.99133, 0.00000, 87.97852);
	CreateDynamicObject(1634, 1524.43640, 1776.38696, 11.11763,   4.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1527.94360, 1776.39380, 11.11763,   3.99902, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1524.49915, 1781.88074, 14.98668,   15.99658, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1528.25684, 1781.85742, 14.98668,   15.99609, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1528.15942, 1785.25537, 19.23668,   33.99609, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1524.42957, 1785.27124, 19.23668,   33.99170, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1524.38379, 1787.26953, 25.23668,   57.99170, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1528.15271, 1787.29395, 25.23668,   57.99133, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1528.25818, 1787.47742, 31.48668,   69.99133, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1524.18933, 1787.57019, 31.48668,   69.98840, 0.00000, 0.00000);
	CreateDynamicObject(6875, 1506.17822, 1848.21948, -1.67969,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1634, 1493.33618, 1733.05908, 11.11763,   3.99902, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1497.36719, 1733.04663, 11.11763,   3.99902, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1501.39844, 1733.03394, 11.11763,   3.99902, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1501.42358, 1738.03955, 14.86763,   17.99902, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1497.41553, 1738.10913, 14.86763,   17.99561, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1493.29297, 1738.22754, 14.86763,   17.99561, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1493.31470, 1741.07837, 18.86763,   35.99561, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1497.43652, 1740.95898, 18.86763,   35.99121, 0.00000, 0.00000);
	CreateDynamicObject(1634, 1501.07715, 1740.97510, 18.86763,   35.99121, 0.00000, 0.00000);
	CreateDynamicObject(18449, 1503.42993, 1890.22815, 29.66620,   0.00000, 0.00000, 82.00000);
	CreateDynamicObject(18449, 1560.03931, 1984.67126, 49.81285,   42.00000, 0.00000, 330.00000);
	CreateDynamicObject(18449, 1506.02271, 1915.64868, 30.18550,   5.00112, -3.15229, 86.39642);
	CreateDynamicObject(18449, 1507.08118, 1938.70532, 32.05344,   8.17133, -6.22624, 89.19108);
	CreateDynamicObject(18449, 1507.65881, 1958.81177, 34.75778,   11.62686, -9.46539, 89.78549);
	CreateDynamicObject(18449, 1508.80957, 1975.38196, 37.96395,   15.75705, -13.31746, 86.69727);
	CreateDynamicObject(18449, 1511.58704, 1987.82959, 41.33740,   21.48330, -18.33798, 75.77357);
	CreateDynamicObject(18449, 1517.04492, 1995.56860, 44.54357,   30.61871, -22.01690, 47.61025);
	CreateDynamicObject(18449, 1526.23718, 1998.01257, 47.24791,   39.34055, -15.05847, 7.67725);
	CreateDynamicObject(18449, 1540.21741, 1994.57556, 49.11585,   41.74654, -5.71232, -17.64396);
	CreateDynamicObject(18450, 1340.39819, 1618.84570, 12.38069,   0.00000, 12.00000, 318.00000);
	CreateDynamicObject(18450, 1285.16125, 1668.56714, 28.13069,   0.00000, 11.99707, 317.99927);
	CreateDynamicObject(18450, 1235.71655, 1713.13403, 42.23069,   0.00000, 11.99707, 317.99927);
	CreateDynamicObject(18450, 1177.15295, 1765.85510, 50.50688,   0.00000, 359.99707, 317.99927);
	CreateDynamicObject(1634, 1145.51733, 1790.89294, 52.14592,   4.00000, 0.00000, 50.00000);
	CreateDynamicObject(1634, 1148.00879, 1794.02148, 52.14592,   3.99902, 0.00000, 49.99878);
	CreateDynamicObject(1634, 1141.23059, 1794.55835, 56.15101,   15.99902, 0.00000, 49.99878);
	CreateDynamicObject(1634, 1144.04102, 1797.46899, 55.89592,   15.99609, 0.00000, 49.99878);
	CreateDynamicObject(1634, 1138.02502, 1797.38098, 62.40101,   41.99609, 0.00000, 49.99875);
	CreateDynamicObject(1634, 1140.63379, 1800.41211, 62.40101,   41.99524, 0.00000, 49.99329);
	CreateDynamicObject(1634, 1137.43481, 1797.78857, 69.65101,   69.99036, 0.00000, 49.99329);
	CreateDynamicObject(18449, 1228.70667, 1720.83167, 81.98105,   0.00000, 0.00000, 318.00000);
	CreateDynamicObject(1634, 1139.98608, 1800.90991, 69.65101,   69.98840, 0.00000, 49.99329);
	CreateDynamicObject(18449, 1177.95715, 1766.37610, 81.94183,   0.00000, 0.00000, 317.99927);
	CreateDynamicObject(1634, 1259.48206, 1696.76038, 83.62212,   6.00000, 0.00000, 225.99998);
	CreateDynamicObject(1634, 1254.48438, 1691.85840, 83.62212,   5.99854, 0.00000, 225.99976);
	CreateDynamicObject(1634, 1256.62573, 1693.95825, 83.62212,   5.99854, 0.00000, 225.99976);
	CreateDynamicObject(6189, 1671.93030, 1551.27197, 6.14041,   0.00000, 0.00000, 88.00000);
	CreateDynamicObject(1634, 1582.76941, 1559.82373, 11.11763,   4.00000, 0.00000, 268.00000);
	CreateDynamicObject(1634, 1582.54883, 1555.70508, 11.11763,   3.99902, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1587.21851, 1555.57739, 14.61763,   17.99902, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1587.36401, 1559.45630, 14.61763,   17.99561, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1732.59375, 1556.92639, 21.94554,   13.99561, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1732.47070, 1552.92773, 21.94554,   13.99109, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1736.96851, 1552.78931, 26.94554,   29.99109, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1737.09082, 1556.78711, 26.94554,   29.98718, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1739.83948, 1556.70251, 32.94554,   49.98718, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1739.71582, 1552.70410, 32.94554,   49.98230, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1739.71582, 1552.70410, 39.69554,   79.98233, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1739.83887, 1556.70215, 39.69554,   79.98047, 0.00000, 267.99500);
	CreateDynamicObject(6189, 1665.32495, 1550.01709, 29.14041,   0.00000, 0.00000, 87.99500);
	CreateDynamicObject(1634, 1599.17969, 1558.99707, 44.94554,   4.00000, 0.00000, 88.00000);
	CreateDynamicObject(1634, 1599.40723, 1562.99487, 44.94554,   3.99902, 0.00000, 88.00000);
	CreateDynamicObject(1634, 1593.44641, 1563.20618, 49.94554,   23.99902, 0.00000, 88.00000);
	CreateDynamicObject(1634, 1593.23938, 1559.15259, 49.94554,   23.99414, 0.00000, 88.00000);
	CreateDynamicObject(1634, 1589.89441, 1559.02148, 56.94554,   49.99414, 0.00000, 88.00000);
	CreateDynamicObject(1634, 1589.95972, 1563.19116, 56.94554,   49.99329, 0.00000, 88.00000);
	CreateDynamicObject(1634, 1590.36511, 1562.94946, 65.15651,   81.99097, 0.00000, 88.00000);
	CreateDynamicObject(1634, 1590.21558, 1558.92114, 65.15651,   81.99097, 0.00000, 88.00000);
	CreateDynamicObject(6189, 1666.41687, 1550.04993, 53.39041,   0.00000, 0.00000, 87.99500);
	CreateDynamicObject(6189, 1666.58594, 1550.78040, 78.34041,   0.00000, 0.00000, 87.99500);
	CreateDynamicObject(1634, 1730.31677, 1557.61633, 69.19554,   4.00000, 0.00000, 268.00000);
	CreateDynamicObject(1634, 1730.17200, 1553.61157, 69.19554,   3.99902, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1735.92566, 1553.51306, 73.44554,   17.99902, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1736.06921, 1557.51733, 73.44554,   17.99561, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1740.01721, 1557.34656, 79.19554,   41.99561, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1739.84656, 1553.39685, 79.19554,   41.99524, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1741.36255, 1557.47754, 86.44554,   63.99524, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1741.15356, 1553.44336, 86.44554,   63.98987, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1738.69092, 1553.47778, 94.69554,   84.00000, 180.00000, 87.99493);
	CreateDynamicObject(1634, 1738.67212, 1557.61646, 94.94554,   83.99597, 179.99451, 87.98950);
	CreateDynamicObject(6189, 1666.58594, 1550.78027, 101.84041,   0.00000, 0.00000, 87.99500);
	CreateDynamicObject(1634, 1600.66577, 1559.32690, 94.14554,   4.00000, 0.00000, 86.00000);
	CreateDynamicObject(1634, 1600.93457, 1563.31641, 94.14554,   3.99902, 0.00000, 85.99548);
	CreateDynamicObject(1634, 1595.19861, 1563.70386, 98.89554,   23.99902, 0.00000, 85.99548);
	CreateDynamicObject(1634, 1594.92871, 1559.71289, 98.89554,   23.99414, 0.00000, 85.99548);
	CreateDynamicObject(1634, 1591.89380, 1559.91919, 104.64554,   47.99414, 0.00000, 85.99548);
	CreateDynamicObject(1634, 1592.08752, 1563.98474, 104.64554,   47.99377, 0.00000, 85.99548);
	CreateDynamicObject(1634, 1591.60034, 1564.09985, 111.39554,   71.99377, 0.00000, 85.99548);
	CreateDynamicObject(1634, 1591.40564, 1560.03381, 111.39554,   71.99341, 0.00000, 85.99548);
	CreateDynamicObject(1634, 1593.89587, 1559.69910, 117.89554,   82.00000, 180.00000, 265.99548);
	CreateDynamicObject(1634, 1594.16846, 1563.51794, 117.89554,   81.99646, 179.99451, 265.99548);
	CreateDynamicObject(6189, 1666.47546, 1551.00452, 125.46040,   0.00000, 0.00000, 87.99500);
	CreateDynamicObject(1634, 1731.13342, 1556.68066, 117.54076,   4.00000, 0.00000, 268.00000);
	CreateDynamicObject(1634, 1736.65210, 1556.48218, 122.29076,   25.99902, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1740.62659, 1556.43250, 129.54076,   45.99365, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1741.17896, 1556.51465, 137.79076,   73.98880, 0.00000, 267.99500);
	CreateDynamicObject(1634, 1601.58325, 1550.36035, 141.26553,   4.00000, 0.00000, 86.00000);
	CreateDynamicObject(1634, 1601.90405, 1554.13037, 141.26553,   3.99902, 0.00000, 85.99548);
	CreateDynamicObject(1634, 1596.37036, 1554.58447, 145.51553,   19.99902, 0.00000, 85.99548);
	CreateDynamicObject(1634, 1595.75098, 1550.62378, 145.76553,   19.99512, 0.00000, 85.99548);
	CreateDynamicObject(5644, 1610.03125, 1450.33203, 70.72105,   0.00000, 43.98926, 0.00000);
	CreateDynamicObject(5644, 1580.34277, 1450.33350, 59.72105,   0.00000, 77.98645, 0.00000);
	CreateDynamicObject(5644, 1564.29187, 1450.40015, 56.22105,   0.00000, 77.98645, 0.00000);
	CreateDynamicObject(5644, 1542.43359, 1450.27991, 51.97105,   0.00000, 77.98645, 0.00000);
	CreateDynamicObject(5644, 1526.04370, 1449.96692, 48.47054,   0.00000, 77.98645, 0.00000);
	CreateDynamicObject(5644, 1506.11572, 1449.83203, 44.22054,   0.00000, 77.98645, 0.00000);
	CreateDynamicObject(5644, 1481.91992, 1449.89429, 38.97054,   0.00000, 77.98645, 0.00000);
	CreateDynamicObject(1655, 1439.12427, 1453.31348, 11.12042,   10.99731, 0.00000, 269.99451);
	CreateDynamicObject(7980, 1621.47168, 1629.88281, 41.42074,   0.00000, 300.00000, 0.00000);
	CreateDynamicObject(13604, -1304.82532, -120.40343, 14.36000,   0.00000, 0.00000, 3.71000);
	CreateDynamicObject(13604, -1324.62024, -122.41131, 14.36000,   0.00000, 0.00000, 3.71000);
	CreateDynamicObject(13604, -1322.88989, -140.05603, 14.36000,   0.00000, 0.00000, 3.71000);
	CreateDynamicObject(13604, -1314.48413, -130.16603, 14.36000,   0.00000, 0.00000, 3.71000);
	CreateDynamicObject(3851, -1528.81372, -188.06879, 13.65254,   5.00000, 90.00000, -45.00000);
	CreateDynamicObject(3851, -1521.01489, -180.23520, 15.11669,   10.00000, 90.00000, -45.00000);
	CreateDynamicObject(3851, -1513.45923, -172.68036, 17.48227,   15.00000, 90.00000, -45.00000);
	CreateDynamicObject(3851, -1505.95154, -165.19403, 20.83647,   20.00000, 90.00000, -45.00000);
	CreateDynamicObject(3851, -1508.67444, -162.33369, 20.83647,   20.00000, 90.00000, -45.00000);
	CreateDynamicObject(3851, -1516.19690, -169.84703, 17.48227,   15.00000, 90.00000, -45.00000);
	CreateDynamicObject(3851, -1523.75610, -177.37440, 15.11669,   10.00000, 90.00000, -45.00000);
	CreateDynamicObject(3851, -1531.60999, -185.24580, 13.65254,   5.00000, 90.00000, -45.00000);
	CreateDynamicObject(3851, -1539.53296, -193.13940, 13.16299,   0.00000, 90.00000, -45.00000);
	CreateDynamicObject(3851, -1498.59094, -157.84352, 25.14711,   25.00000, 90.00000, -45.00000);
	CreateDynamicObject(3851, -1501.32983, -155.00952, 25.11489,   25.00000, 90.00000, -45.00000);
	CreateDynamicObject(3851, -1598.68152, -147.18404, 15.14190,   0.00000, 0.00000, -271.19949);
	CreateDynamicObject(3851, -1598.68152, -147.18401, 19.14190,   0.00000, 0.00000, -271.19949);
	CreateDynamicObject(3851, -1598.68152, -147.18401, 23.14190,   0.00000, 0.00000, -271.19949);
	CreateDynamicObject(3851, -1598.68152, -147.18401, 27.14190,   0.00000, 0.00000, -271.19949);
	CreateDynamicObject(3851, -1598.68152, -147.18401, 31.14190,   0.00000, 0.00000, -271.19949);
	CreateDynamicObject(3851, -1598.68152, -147.18401, 35.14190,   0.00000, 0.00000, -271.19949);
	CreateDynamicObject(3851, -1598.68152, -147.18401, 39.14190,   0.00000, 0.00000, -271.19949);
	CreateDynamicObject(3851, -1598.68152, -147.18401, 43.14190,   0.00000, 0.00000, -271.19949);
	CreateDynamicObject(3851, -1598.68152, -147.18401, 47.14190,   0.00000, 0.00000, -271.19949);
	CreateDynamicObject(3851, -1598.68152, -147.18401, 51.14190,   0.00000, 0.00000, -271.19949);
	CreateDynamicObject(3851, -1598.68152, -147.18401, 55.14190,   0.00000, 0.00000, -271.19949);
	CreateDynamicObject(3851, -1598.68152, -147.18401, 58.56645,   0.00000, 0.00000, -271.19949);
	CreateDynamicObject(3851, -1578.65002, -156.00000, 58.46685,   0.00000, 0.00000, 58.98000);
	CreateDynamicObject(3851, -1574.10999, -164.55000, 54.59000,   0.00000, 0.00000, 356.95999);
	CreateDynamicObject(3851, -1574.10999, -164.55000, 58.49315,   0.00000, 0.00000, 356.95999);
	CreateDynamicObject(3851, -1579.53003, -172.56000, 50.69000,   0.00000, 0.00000, 294.95999);
	CreateDynamicObject(3851, -1579.53003, -172.56000, 54.69000,   0.00000, 0.00000, 294.95999);
	CreateDynamicObject(3851, -1579.53003, -172.56000, 58.49987,   0.00000, 0.00000, 294.95999);
	CreateDynamicObject(3851, -1588.19995, -144.53999, 23.39000,   0.00000, 0.00000, 118.97000);
	CreateDynamicObject(3851, -1588.19995, -144.53999, 30.89000,   0.00000, 0.00000, 118.97000);
	CreateDynamicObject(3851, -1588.19995, -144.53999, 38.89000,   0.00000, 0.00000, 118.97000);
	CreateDynamicObject(3851, -1588.19995, -144.53999, 46.68180,   0.00000, 0.00000, 118.97000);
	CreateDynamicObject(3851, -1588.19995, -144.53999, 54.48190,   0.00000, 0.00000, 118.97000);
	CreateDynamicObject(3851, -1588.32996, -150.17999, 31.07230,   0.00000, 0.00000, 58.98000);
	CreateDynamicObject(3851, -1588.32996, -150.17999, 38.86891,   0.00000, 0.00000, 58.98000);
	CreateDynamicObject(3851, -1588.32996, -150.17999, 46.69400,   0.00000, 0.00000, 58.98000);
	CreateDynamicObject(3851, -1588.32996, -150.17999, 54.52205,   0.00000, 0.00000, 58.98000);
	CreateDynamicObject(3851, -1588.32996, -150.17999, 15.48392,   0.00000, 0.00000, 58.98000);

	CreateVehicle(522, 1618.9456, 1340.5533, 10.5998, 133.9939, -1, -1, 100);
	CreateVehicle(522, 1608.4335, 1317.6643, 10.4966, 47.9939, -1, -1, 100);
	CreateVehicle(522, 1614.1049, 1340.8472, 10.5998, 133.9893, -1, -1, 100);
	CreateVehicle(522, 1622.0487, 1339.2003, 10.5998, 133.9893, -1, -1, 100);
	CreateVehicle(522, 1624.1356, 1338.0684, 10.5998, 133.9893, -1, -1, 100);
	CreateVehicle(522, 1626.4811, 1336.9244, 10.5998, 133.9893, -1, -1, 100);
	CreateVehicle(522, 1604.9115, 1317.2081, 10.5325, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1600.6405, 1317.6924, 10.5758, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1595.7892, 1316.9497, 10.5859, 47.9938, -1, -1, 100);
	CreateVehicle(411, 1591.3405, 1337.9967, 10.7757, 145.9999, -1, -1, 100);
	CreateVehicle(411, 1598.2251, 1339.0538, 10.5216, 145.9973, -1, -1, 100);
	CreateVehicle(411, 1604.6415, 1338.9509, 10.7493, 145.9973, -1, -1, 100);
	CreateVehicle(411, 1610.2174, 1338.9041, 10.4515, 145.9973, -1, -1, 100);
	CreateVehicle(522, 1202.1270, 1743.5657, 55.7667, 0.0000, -1, -1, 100);
	CreateVehicle(522, 1592.1636, 1315.7946, 10.5844, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1588.6014, 1315.9205, 10.5796, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1578.7615, 1278.2063, 10.4729, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1575.9723, 1277.6901, 10.4729, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1573.2073, 1276.5323, 10.4729, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1569.5096, 1457.4437, 10.4861, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1573.7668, 1455.2113, 10.4879, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1577.2980, 1438.6525, 10.5036, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1431.9819, 1494.2094, 14.3898, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1424.7700, 1499.4043, 10.4807, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1419.5891, 1504.1763, 10.4807, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1416.2106, 1501.6895, 10.4807, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1334.2333, 1511.7632, 10.4807, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1332.4301, 1513.4811, 9.8487, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1331.9537, 1513.0499, 9.8487, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1329.6564, 1510.8053, 9.8487, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1348.5459, 1586.5166, 10.4807, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1350.3905, 1589.2211, 10.4807, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1353.5991, 1594.3645, 10.4807, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1415.7300, 1574.5095, 10.4807, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1416.6620, 1575.1478, 10.4807, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1417.7375, 1575.8203, 10.4807, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1539.9041, 1662.8739, 10.4807, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1543.6248, 1657.5063, 10.4807, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1547.0823, 1647.2633, 10.4807, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1571.2549, 1550.4436, 10.4807, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1568.3214, 1549.8037, 10.4807, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1566.8035, 1548.8137, 10.4807, 47.9938, -1, -1, 100);
	CreateVehicle(522, 1567.2533, 1545.7222, 10.4807, 47.9938, -1, -1, 100);
}

DerbyMapOne()
{
	CreateDynamicObject(3458,4117.0000000,1901.8000000,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (1)
	CreateDynamicObject(3458,4157.2998000,1901.8000000,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (2)
	CreateDynamicObject(3458,4137.3999000,1924.5000000,0.0000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1) (3)
	CreateDynamicObject(3458,4137.2002000,1879.1000000,0.0000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1) (4)
	CreateDynamicObject(3458,4197.7002000,1901.8000000,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (6)
	CreateDynamicObject(3458,4076.8999000,1901.8000500,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (7)
	CreateDynamicObject(3458,4137.3999000,1964.8000000,0.0000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1) (8)
	CreateDynamicObject(3458,4137.2002000,1838.8000000,0.0000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1) (9)
	CreateDynamicObject(3458,4151.0000000,1888.3000000,0.0000000,0.0000000,0.0000000,45.0000000); //object(vgncarshade1) (13)
	CreateDynamicObject(3458,4123.7998000,1915.4000000,0.0000000,0.0000000,0.0000000,45.0000000); //object(vgncarshade1) (14)
	CreateDynamicObject(3458,4150.0000000,1916.1000000,0.0000000,0.0000000,0.0000000,312.0000000); //object(vgncarshade1) (16)
	CreateDynamicObject(3458,4123.3999000,1889.5000000,0.0000000,0.0000000,0.0000000,311.9950000); //object(vgncarshade1) (17)
	CreateDynamicObject(3458,4059.3000000,1924.5000000,0.0000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1) (18)
	CreateDynamicObject(3458,4080.8000000,1942.1000000,8.7000000,0.0000000,25.0000000,180.0000000); //object(vgncarshade1) (19)
	CreateDynamicObject(3458,4118.6001000,1942.0000000,17.1000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (20)
	CreateDynamicObject(3458,4215.2998000,1924.4000000,0.0000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1) (21)
	CreateDynamicObject(3458,4193.8999000,1942.0000000,8.7000000,0.0000000,25.0000000,0.0000000); //object(vgncarshade1) (22)
	CreateDynamicObject(3458,4156.0000000,1942.0000000,17.1000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (23)
	CreateDynamicObject(3458,4137.2998000,1919.4000000,17.1000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1) (24)
	CreateDynamicObject(3458,4059.2000000,1879.1000000,0.0000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1) (25)
	CreateDynamicObject(3458,4215.2998000,1879.1000000,0.0000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1) (26)
	CreateDynamicObject(3458,4193.7998000,1861.9000000,8.7000000,0.0000000,24.9990000,0.0000000); //object(vgncarshade1) (27)
	CreateDynamicObject(3458,4156.0000000,1861.9000000,17.1000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (28)
	CreateDynamicObject(3458,4118.3999000,1861.8000000,17.1000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (29)
	CreateDynamicObject(3458,4080.6001000,1861.8000000,8.7000000,0.0000000,24.9990000,179.9950000); //object(vgncarshade1) (30)
	CreateDynamicObject(3458,4137.2998000,1880.8000000,17.1000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1) (31)
	CreateDynamicObject(3458,4157.3999000,1987.4000000,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (32)
	CreateDynamicObject(3458,4197.7002000,1987.4000000,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (33)
	CreateDynamicObject(3458,4117.2998000,1987.4000000,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (34)
	CreateDynamicObject(3458,4076.8999000,1987.4000000,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (35)
	CreateDynamicObject(3458,4059.3000000,1964.7000000,0.0000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1) (36)
	CreateDynamicObject(3458,4215.3999000,1964.8000000,0.0000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1) (37)
	CreateDynamicObject(3458,4215.2002000,1839.2000000,0.0000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1) (38)
	CreateDynamicObject(3458,4059.2000000,1838.7000000,0.0000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1) (39)
	CreateDynamicObject(3458,4076.8000000,1816.5000000,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (40)
	CreateDynamicObject(3458,4117.2002000,1816.5000000,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (41)
	CreateDynamicObject(3458,4157.6001000,1816.5000000,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (42)
	CreateDynamicObject(3458,4197.7002000,1816.5000000,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (43)
	CreateDynamicObject(3458,4122.6001000,1859.9000000,0.0000000,0.0000000,0.0000000,44.9950000); //object(vgncarshade1) (48)
	CreateDynamicObject(3458,4094.1001000,1831.4000000,0.0000000,0.0000000,0.0000000,44.9950000); //object(vgncarshade1) (50)
	CreateDynamicObject(3458,4150.1001000,1859.8000000,0.0000000,0.0000000,0.0000000,311.9950000); //object(vgncarshade1) (52)
	CreateDynamicObject(3458,4176.3999000,1830.6000000,0.0000000,0.0000000,0.0000000,311.9950000); //object(vgncarshade1) (53)
	CreateDynamicObject(3458,4081.7000000,1926.1000000,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (55)
	CreateDynamicObject(3458,4081.8000000,1877.0000000,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (56)
	CreateDynamicObject(3458,4192.6001000,1926.4000000,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (57)
	CreateDynamicObject(3458,4192.7002000,1877.2000000,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (58)
	CreateDynamicObject(1633,4174.7002000,1877.2000000,2.5000000,0.0000000,0.0000000,90.0000000); //object(landjump) (1)
	CreateDynamicObject(1633,4172.6001000,1926.4000000,2.5000000,0.0000000,0.0000000,90.0000000); //object(landjump) (2)
	CreateDynamicObject(1633,4099.6001000,1926.1000000,2.5000000,0.0000000,0.0000000,270.0000000); //object(landjump) (3)
	CreateDynamicObject(1633,4099.7998000,1876.9000000,2.5000000,0.0000000,0.0000000,270.0000000); //object(landjump) (4)
	CreateDynamicObject(3458,4114.5000000,1901.0000000,17.1000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (59)
	CreateDynamicObject(3458,4159.3999000,1901.1000000,17.1000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1) (60)
	CreateDynamicObject(1225,4137.1001000,1901.8000000,1.9000000,0.0000000,0.0000000,0.0000000); //object(barrel4) (1)
	return 1;
}

DerbyMapTwo()
{
	CreateDynamicObject(11539,-2209.6604000,-2281.1428200,836.7436500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(11539,-2284.0747100,-2333.2922400,837.3580900,0.0000000,0.0000000,31.0903900); //
	CreateDynamicObject(11539,-2322.9340800,-2463.1513700,837.7861300,0.0000000,0.0000000,70.9013100); //
	CreateDynamicObject(11539,-2257.8479000,-2587.5542000,837.5777600,0.0000000,0.0000000,118.0583700); //
	CreateDynamicObject(11539,-2164.0112300,-2625.4379900,837.3714600,0.0000000,0.0000000,153.4776300); //
	CreateDynamicObject(11539,-2059.5898400,-2592.2785600,837.1672400,0.0000000,0.0000000,194.6129600); //
	CreateDynamicObject(11539,-2015.1872600,-2457.0178200,836.0965600,0.0000000,0.0000000,252.6912100); //
	CreateDynamicObject(11539,-2041.7316900,-2370.0041500,836.3100600,0.0000000,0.0000000,274.7724600); //
	CreateDynamicObject(11539,-2097.5947300,-2302.1152300,836.5258200,0.0000000,0.0000000,300.7997100); //
	CreateDynamicObject(2000,2776.4235800,-2383.7893100,15.2005800,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(11539,-2014.6065700,-2456.0092800,836.0965600,0.0000000,0.0000000,252.6912100); //
	CreateDynamicObject(8357,-2172.1242700,-2376.0600600,812.4869400,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(8357,-2172.1643100,-2506.4316400,812.4923700,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(8357,-2215.1347700,-2476.4265100,812.4959700,0.0000000,0.0000000,-84.0000000); //
	CreateDynamicObject(8357,-2090.1362300,-2463.2810100,812.5159900,0.0000000,0.0000000,-84.0000000); //
	CreateDynamicObject(19913,-2254.4418900,-2480.1655300,815.0745200,0.0000000,0.0000000,-84.0000000); //
	CreateDynamicObject(19913,-2085.0869100,-2463.6652800,815.4921900,0.0000000,0.0000000,-84.0000000); //
	CreateDynamicObject(19913,-2171.2043500,-2551.1001000,815.6727300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19913,-2174.3793900,-2387.3598600,815.4498900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3458,-2141.6220700,-2499.2011700,810.9780900,0.0000000,0.0000000,-135.0000000); //
	CreateDynamicObject(3458,-2140.7690400,-2437.9995100,810.9566000,0.0000000,0.0000000,-33.0000000); //
	CreateDynamicObject(3458,-2200.7331500,-2441.7858900,810.9674100,0.0000000,0.0000000,-127.0000000); //
	CreateDynamicObject(3458,-2203.3901400,-2507.7636700,810.9774200,0.0000000,0.0000000,-40.0000000); //
	CreateDynamicObject(3458,-2125.2453600,-2512.0693400,810.9901700,0.0000000,0.0000000,-40.0000000); //
	CreateDynamicObject(19129,-2104.5236800,-2530.7622100,812.4619800,0.0000000,0.0000000,-40.0000000); //
	CreateDynamicObject(3458,-2216.2946800,-2430.5585900,810.9830900,0.0000000,0.0000000,-40.0000000); //
	CreateDynamicObject(3458,-2215.4294400,-2521.2294900,810.9989000,0.0000000,0.0000000,-127.0000000); //
	CreateDynamicObject(3458,-2132.7573200,-2422.2590300,810.9575200,0.0000000,0.0000000,-120.0000000); //
	CreateDynamicObject(19129,-2118.9106400,-2397.6257300,812.4202900,0.0000000,0.0000000,-33.0000000); //
	CreateDynamicObject(19129,-2237.4694800,-2414.1406300,812.4815100,0.0000000,0.0000000,-40.0000000); //
	CreateDynamicObject(19129,-2227.5046400,-2537.8183600,812.4989000,0.0000000,0.0000000,-40.0000000); //
	CreateDynamicObject(3458,-2198.7817400,-2536.8574200,811.0354000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3458,-2235.7873500,-2512.1706500,810.9932300,0.0000000,0.0000000,-76.0000000); //
	CreateDynamicObject(3458,-2102.9726600,-2501.9765600,810.9976800,0.0000000,0.0000000,-91.0000000); //
	CreateDynamicObject(3458,-2135.3923300,-2531.9487300,811.0009200,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3458,-2142.7441400,-2395.5957000,810.9395800,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3458,-2112.9902300,-2425.6420900,810.9592900,0.0000000,0.0000000,-84.0000000); //
	CreateDynamicObject(3458,-2208.7238800,-2411.7688000,810.9675300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3458,-2238.6574700,-2443.2138700,811.0194700,0.0000000,0.0000000,-91.0000000); //
	CreateDynamicObject(3458,-2139.7954100,-2466.8579100,816.6707200,0.0000000,25.0000000,4.0000000); //
	CreateDynamicObject(19129,-2167.2312000,-2469.0556600,826.5172100,0.0000000,0.0000000,4.0000000); //
	CreateDynamicObject(3458,-2194.6606400,-2471.5102500,816.6770000,0.0000000,-25.0000000,4.0000000); //
	CreateDynamicObject(3458,-2170.4221200,-2444.0607900,825.0524300,0.0000000,0.0000000,-84.0000000); //
	CreateDynamicObject(3458,-2165.6953100,-2493.6433100,825.0515100,0.0000000,0.0000000,-84.0000000); //
	CreateDynamicObject(19129,-2164.8330100,-2516.5278300,826.5484000,0.0000000,0.0000000,4.0000000); //
	CreateDynamicObject(19129,-2172.3076200,-2421.9304200,826.5363200,0.0000000,0.0000000,4.0000000); //
	return 1;
}

DerbyMapThree()
{
	CreateDynamicObject(3458,-3464.8999000,297.0000000,0.0000000,0.0000000,0.0000000,0.0000000); //object(vgncarshade1)(1)
	CreateDynamicObject(3458,-3447.3000500,274.2000100,0.0000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1)(2)
	CreateDynamicObject(3458,-3464.8999000,251.3999900,0.0000000,0.0000000,0.0000000,180.0000000); //object(vgncarshade1)(3)
	CreateDynamicObject(3458,-3482.5000000,274.2000100,0.0000000,0.0000000,0.0000000,269.9950000); //object(vgncarshade1)(4)
	CreateDynamicObject(3458,-3505.1999500,251.3999900,0.0000000,0.0000000,0.0000000,359.9890000); //object(vgncarshade1)(5)
	CreateDynamicObject(3458,-3522.8000500,274.1000100,0.0000000,0.0000000,0.0000000,89.9840000); //object(vgncarshade1)(6)
	CreateDynamicObject(3458,-3505.1999500,297.0000000,0.0000000,0.0000000,0.0000000,179.9840000); //object(vgncarshade1)(7)
	CreateDynamicObject(8663,-3572.1992200,342.0996100,18.7000000,0.0000000,0.0000000,0.0000000); //object(triadcasno01_lvs)(1)
	CreateDynamicObject(8663,-3574.5000000,211.2998000,18.7000000,0.0000000,0.0000000,90.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(3458,-3482.5000000,238.1000100,3.4000000,0.0000000,342.0000000,269.9890000); //object(vgncarshade1)(8)
	CreateDynamicObject(3458,-3464.8999000,216.8000000,9.5000000,0.0000000,0.0000000,179.9840000); //object(vgncarshade1)(9)
	CreateDynamicObject(3458,-3447.3000500,239.5000000,9.5000000,0.0000000,0.0000000,269.9840000); //object(vgncarshade1)(10)
	CreateDynamicObject(3458,-3470.0000000,257.1000100,9.5000000,0.0000000,0.0000000,359.9780000); //object(vgncarshade1)(11)
	CreateDynamicObject(3458,-3487.6001000,234.3999900,9.5000000,0.0000000,0.0000000,89.9780000); //object(vgncarshade1)(12)
	CreateDynamicObject(3458,-3470.0000000,257.1000100,9.5000000,0.0000000,0.0000000,359.9780000); //object(vgncarshade1)(18)
	CreateDynamicObject(3458,-3469.9980500,262.3141500,9.8280400,7.2000000,0.0000000,359.9780000); //object(vgncarshade1)(13)
	CreateDynamicObject(3458,-3469.9960900,267.4460400,10.8070100,14.4000000,0.0000000,359.9780000); //object(vgncarshade1)(14)
	CreateDynamicObject(3458,-3469.9941400,272.4147900,12.4214500,21.6000000,0.0000000,359.9780000); //object(vgncarshade1)(15)
	CreateDynamicObject(3458,-3469.9924300,277.1420300,14.6459200,28.8000000,0.0000000,359.9780000); //object(vgncarshade1)(16)
	CreateDynamicObject(3458,-3469.9907200,281.5531600,17.4453200,36.0000000,0.0000000,359.9780000); //object(vgncarshade1)(17)
	CreateDynamicObject(3458,-3469.9890100,285.5786700,20.7755100,43.2000000,0.0000000,359.9780000); //object(vgncarshade1)(19)
	CreateDynamicObject(3458,-3469.9877900,289.1550600,24.5839700,50.4000000,0.0000000,359.9780000); //object(vgncarshade1)(20)
	CreateDynamicObject(3458,-3469.9865700,292.2259200,28.8106300,57.6000000,0.0000000,359.9780000); //object(vgncarshade1)(21)
	CreateDynamicObject(3458,-3469.9856000,294.7428000,33.3888500,64.8000000,0.0000000,359.9780000); //object(vgncarshade1)(22)
	CreateDynamicObject(3458,-3469.9848600,296.6660800,38.2464300,72.0000000,0.0000000,359.9780000); //object(vgncarshade1)(23)
	CreateDynamicObject(3458,-3469.9843700,297.9653300,43.3067400,79.2000000,0.0000000,359.9780000); //object(vgncarshade1)(24)
	CreateDynamicObject(3458,-3469.9841300,298.6201200,48.4899900,86.4000000,0.0000000,359.9780000); //object(vgncarshade1)(25)
	CreateDynamicObject(3458,-3469.9841300,298.6201200,53.7144300,93.6000000,0.0000000,359.9780000); //object(vgncarshade1)(26)
	CreateDynamicObject(3458,-3469.9843700,297.9653300,58.8976800,100.8000000,0.0000000,359.9780000); //object(vgncarshade1)(27)
	CreateDynamicObject(3458,-3469.9848600,296.6660800,63.9579900,108.0000000,0.0000000,359.9780000); //object(vgncarshade1)(28)
	CreateDynamicObject(3458,-3469.9856000,294.7428300,68.8155700,115.2000000,0.0000000,359.9780000); //object(vgncarshade1)(29)
	CreateDynamicObject(3458,-3469.9865700,292.2259200,73.3937800,122.4000000,0.0000000,359.9780000); //object(vgncarshade1)(30)
	CreateDynamicObject(3458,-3469.9877900,289.1550900,77.6204500,129.6000000,0.0000000,359.9780000); //object(vgncarshade1)(31)
	CreateDynamicObject(3458,-3469.9890100,285.5787000,81.4289100,136.8000000,0.0000000,359.9780000); //object(vgncarshade1)(32)
	CreateDynamicObject(3458,-3469.9907200,281.5531900,84.7590900,144.0000000,0.0000000,359.9780000); //object(vgncarshade1)(33)
	CreateDynamicObject(3458,-3469.9924300,277.1420600,87.5585000,151.2000000,0.0000000,359.9780000); //object(vgncarshade1)(34)
	CreateDynamicObject(3458,-3469.9941400,272.4148300,89.7829700,158.4000000,0.0000000,359.9780000); //object(vgncarshade1)(35)
	CreateDynamicObject(3458,-3469.9960900,267.4460800,91.3974200,165.6000000,0.0000000,359.9780000); //object(vgncarshade1)(36)
	CreateDynamicObject(3458,-3469.9980500,262.3141800,92.3763800,172.8000000,0.0000000,359.9780000); //object(vgncarshade1)(37)
	CreateDynamicObject(3458,-3470.0000000,257.1000400,92.7044300,180.0000000,0.0000000,359.9780000); //object(vgncarshade1)(38)
	CreateDynamicObject(3458,-3470.0019500,251.8858900,92.3763900,187.2000000,0.0000000,359.9780000); //object(vgncarshade1)(39)
	CreateDynamicObject(3458,-3470.0039100,246.7540000,91.3974300,194.4000000,0.0000000,359.9780000); //object(vgncarshade1)(40)
	CreateDynamicObject(3458,-3470.0058600,241.7852500,89.7829900,201.6000000,0.0000000,359.9780000); //object(vgncarshade1)(41)
	CreateDynamicObject(3458,-3470.0075700,237.0580100,87.5585300,208.8000000,0.0000000,359.9780000); //object(vgncarshade1)(42)
	CreateDynamicObject(3458,-3470.0092800,232.6468800,84.7591400,216.0000000,0.0000000,359.9780000); //object(vgncarshade1)(43)
	CreateDynamicObject(3458,-3470.0109900,228.6213700,81.4289600,223.2000000,0.0000000,359.9780000); //object(vgncarshade1)(44)
	CreateDynamicObject(3458,-3470.0122100,225.0449800,77.6205000,230.4000000,0.0000000,359.9780000); //object(vgncarshade1)(45)
	CreateDynamicObject(3458,-3470.0134300,221.9741200,73.3938400,237.6000000,0.0000000,359.9780000); //object(vgncarshade1)(46)
	CreateDynamicObject(3458,-3470.0144000,219.4572100,68.8156200,244.8000000,0.0000000,359.9780000); //object(vgncarshade1)(47)
	CreateDynamicObject(3458,-3470.0151400,217.5339700,63.9580700,252.0000000,0.0000000,359.9780000); //object(vgncarshade1)(48)
	CreateDynamicObject(3458,-3470.0156200,216.2347000,58.8977500,259.2000000,0.0000000,359.9780000); //object(vgncarshade1)(49)
	CreateDynamicObject(3458,-3470.0158700,215.5799000,53.7144800,266.4000000,0.0000000,359.9780000); //object(vgncarshade1)(50)
	CreateDynamicObject(3458,-3470.0158700,215.5798800,48.4900300,273.6000000,0.0000000,359.9780000); //object(vgncarshade1)(51)
	CreateDynamicObject(3458,-3470.0156200,216.2346800,43.3067700,280.8000000,0.0000000,359.9780000); //object(vgncarshade1)(52)
	CreateDynamicObject(3458,-3470.0151400,217.5339500,38.2464400,288.0000000,0.0000000,359.9780000); //object(vgncarshade1)(53)
	CreateDynamicObject(3458,-3470.0144000,219.4572000,33.3888600,295.2000000,0.0000000,359.9780000); //object(vgncarshade1)(54)
	CreateDynamicObject(3458,-3470.0134300,221.9740900,28.8106400,302.4000000,0.0000000,359.9780000); //object(vgncarshade1)(55)
	CreateDynamicObject(3458,-3470.0122100,225.0449500,24.5839600,309.6000000,0.0000000,359.9780000); //object(vgncarshade1)(56)
	CreateDynamicObject(3458,-3470.0109900,228.6213400,20.7755000,316.8000000,0.0000000,359.9780000); //object(vgncarshade1)(57)
	CreateDynamicObject(3458,-3470.0092800,232.6468500,17.4453000,324.0000000,0.0000000,359.9780000); //object(vgncarshade1)(58)
	CreateDynamicObject(3458,-3470.0075700,237.0580100,14.6459000,331.2000000,0.0000000,359.9780000); //object(vgncarshade1)(59)
	CreateDynamicObject(3458,-3470.0058600,241.7852500,12.4214400,338.4000000,0.0000000,359.9780000); //object(vgncarshade1)(60)
	CreateDynamicObject(3458,-3470.0039100,246.7540000,10.8070000,345.6000000,0.0000000,359.9780000); //object(vgncarshade1)(61)
	CreateDynamicObject(3458,-3470.0019500,251.8859300,9.8280400,352.8000000,0.0000000,359.9780000); //object(vgncarshade1)(62)
	CreateDynamicObject(3458,-3470.0000000,257.1000700,9.5000000,360.0000000,0.0000000,359.9780000); //object(vgncarshade1)(63)
	CreateDynamicObject(3458,-3470.1001000,257.1000100,9.5000000,0.0000000,180.0000000,359.9780000); //object(vgncarshade1)(64)
	CreateDynamicObject(3458,-3470.0000000,257.1000100,9.5000000,0.0000000,0.0000000,359.9780000); //object(vgncarshade1)(65)
	CreateDynamicObject(3458,-3469.9980500,262.3141500,9.8280400,7.2000000,0.0000000,359.9780000); //object(vgncarshade1)(66)
	CreateDynamicObject(3458,-3469.9960900,267.4460400,10.8070100,14.4000000,0.0000000,359.9780000); //object(vgncarshade1)(67)
	CreateDynamicObject(3458,-3469.9941400,272.4147900,12.4214500,21.6000000,0.0000000,359.9780000); //object(vgncarshade1)(68)
	CreateDynamicObject(3458,-3469.9924300,277.1420300,14.6459200,28.8000000,0.0000000,359.9780000); //object(vgncarshade1)(69)
	CreateDynamicObject(3458,-3469.9907200,281.5531600,17.4453200,36.0000000,0.0000000,359.9780000); //object(vgncarshade1)(70)
	CreateDynamicObject(3458,-3469.9890100,285.5786700,20.7755100,43.2000000,0.0000000,359.9780000); //object(vgncarshade1)(71)
	CreateDynamicObject(3458,-3469.9877900,289.1550600,24.5839700,50.4000000,0.0000000,359.9780000); //object(vgncarshade1)(72)
	CreateDynamicObject(3458,-3469.9865700,292.2259200,28.8106300,57.6000000,0.0000000,359.9780000); //object(vgncarshade1)(73)
	CreateDynamicObject(3458,-3469.9856000,294.7428000,33.3888500,64.8000000,0.0000000,359.9780000); //object(vgncarshade1)(74)
	CreateDynamicObject(3458,-3469.9848600,296.6660800,38.2464300,72.0000000,0.0000000,359.9780000); //object(vgncarshade1)(75)
	CreateDynamicObject(3458,-3469.9843700,297.9653300,43.3067400,79.2000000,0.0000000,359.9780000); //object(vgncarshade1)(76)
	CreateDynamicObject(3458,-3469.9841300,298.6201200,48.4899900,86.4000000,0.0000000,359.9780000); //object(vgncarshade1)(77)
	CreateDynamicObject(3458,-3469.9841300,298.6201200,53.7144300,93.6000000,0.0000000,359.9780000); //object(vgncarshade1)(78)
	CreateDynamicObject(3458,-3469.9843700,297.9653300,58.8976800,100.8000000,0.0000000,359.9780000); //object(vgncarshade1)(79)
	CreateDynamicObject(3458,-3469.9848600,296.6660800,63.9579900,108.0000000,0.0000000,359.9780000); //object(vgncarshade1)(80)
	CreateDynamicObject(3458,-3469.9856000,294.7428300,68.8155700,115.2000000,0.0000000,359.9780000); //object(vgncarshade1)(81)
	CreateDynamicObject(3458,-3469.9865700,292.2259200,73.3937800,122.4000000,0.0000000,359.9780000); //object(vgncarshade1)(82)
	CreateDynamicObject(3458,-3469.9877900,289.1550900,77.6204500,129.6000000,0.0000000,359.9780000); //object(vgncarshade1)(83)
	CreateDynamicObject(3458,-3469.9890100,285.5787000,81.4289100,136.8000000,0.0000000,359.9780000); //object(vgncarshade1)(84)
	CreateDynamicObject(3458,-3469.9907200,281.5531900,84.7590900,144.0000000,0.0000000,359.9780000); //object(vgncarshade1)(85)
	CreateDynamicObject(3458,-3469.9924300,277.1420600,87.5585000,151.2000000,0.0000000,359.9780000); //object(vgncarshade1)(86)
	CreateDynamicObject(3458,-3469.9941400,272.4148300,89.7829700,158.4000000,0.0000000,359.9780000); //object(vgncarshade1)(87)
	CreateDynamicObject(3458,-3469.9960900,267.4460800,91.3974200,165.6000000,0.0000000,359.9780000); //object(vgncarshade1)(88)
	CreateDynamicObject(3458,-3469.9980500,262.3134800,92.3763800,172.7980000,0.0000000,359.9730000); //object(vgncarshade1)(89)
	CreateDynamicObject(3458,-3470.0000000,257.0996100,92.7044300,180.0000000,0.0000000,359.9780000); //object(vgncarshade1)(90)
	CreateDynamicObject(3458,-3470.0019500,251.8858900,92.3763900,187.2000000,0.0000000,359.9780000); //object(vgncarshade1)(91)
	CreateDynamicObject(3458,-3470.0039100,246.7540000,91.3974300,194.4000000,0.0000000,359.9780000); //object(vgncarshade1)(92)
	CreateDynamicObject(3458,-3470.0058600,241.7852500,89.7829900,201.6000000,0.0000000,359.9780000); //object(vgncarshade1)(93)
	CreateDynamicObject(3458,-3470.0075700,237.0580100,87.5585300,208.8000000,0.0000000,359.9780000); //object(vgncarshade1)(94)
	CreateDynamicObject(3458,-3470.0092800,232.6468800,84.7591400,216.0000000,0.0000000,359.9780000); //object(vgncarshade1)(95)
	CreateDynamicObject(3458,-3470.0109900,228.6213700,81.4289600,223.2000000,0.0000000,359.9780000); //object(vgncarshade1)(96)
	CreateDynamicObject(3458,-3470.0122100,225.0449800,77.6205000,230.4000000,0.0000000,359.9780000); //object(vgncarshade1)(97)
	CreateDynamicObject(3458,-3470.0134300,221.9741200,73.3938400,237.6000000,0.0000000,359.9780000); //object(vgncarshade1)(98)
	CreateDynamicObject(3458,-3470.0144000,219.4572100,68.8156200,244.8000000,0.0000000,359.9780000); //object(vgncarshade1)(99)
	CreateDynamicObject(3458,-3470.0151400,217.5339700,63.9580700,252.0000000,0.0000000,359.9780000); //object(vgncarshade1)(100)
	CreateDynamicObject(3458,-3470.0156200,216.2347000,58.8977500,259.2000000,0.0000000,359.9780000); //object(vgncarshade1)(101)
	CreateDynamicObject(3458,-3470.0158700,215.5799000,53.7144800,266.4000000,0.0000000,359.9780000); //object(vgncarshade1)(102)
	CreateDynamicObject(3458,-3470.0158700,215.5798800,48.4900300,273.6000000,0.0000000,359.9780000); //object(vgncarshade1)(103)
	CreateDynamicObject(3458,-3470.0156200,216.2346800,43.3067700,280.8000000,0.0000000,359.9780000); //object(vgncarshade1)(104)
	CreateDynamicObject(3458,-3470.0151400,217.5339500,38.2464400,288.0000000,0.0000000,359.9780000); //object(vgncarshade1)(105)
	CreateDynamicObject(3458,-3470.0144000,219.4572000,33.3888600,295.2000000,0.0000000,359.9780000); //object(vgncarshade1)(106)
	CreateDynamicObject(3458,-3470.0134300,221.9740900,28.8106400,302.4000000,0.0000000,359.9780000); //object(vgncarshade1)(107)
	CreateDynamicObject(3458,-3470.0122100,225.0449500,24.5839600,309.6000000,0.0000000,359.9780000); //object(vgncarshade1)(108)
	CreateDynamicObject(3458,-3470.0109900,228.6213400,20.7755000,316.8000000,0.0000000,359.9780000); //object(vgncarshade1)(109)
	CreateDynamicObject(3458,-3470.0092800,232.6468500,17.4453000,324.0000000,0.0000000,359.9780000); //object(vgncarshade1)(110)
	CreateDynamicObject(3458,-3470.0075700,237.0580100,14.6459000,331.2000000,0.0000000,359.9780000); //object(vgncarshade1)(111)
	CreateDynamicObject(3458,-3470.0058600,241.7852500,12.4214400,338.4000000,0.0000000,359.9780000); //object(vgncarshade1)(112)
	CreateDynamicObject(3458,-3470.0039100,246.7540000,10.8070000,345.6000000,0.0000000,359.9780000); //object(vgncarshade1)(113)
	CreateDynamicObject(3458,-3470.0019500,251.8859300,9.8280400,352.8000000,0.0000000,359.9780000); //object(vgncarshade1)(114)
	CreateDynamicObject(3458,-3470.0000000,257.1000700,9.5000000,360.0000000,0.0000000,359.9780000); //object(vgncarshade1)(115)
	CreateDynamicObject(3458,-3492.6999500,234.3000000,9.5000000,0.0000000,0.0000000,89.9780000); //object(vgncarshade1)(116)
	CreateDynamicObject(3458,-3487.6001000,234.3999900,-1.1000000,0.0000000,90.0000000,269.9780000); //object(vgncarshade1)(117)
	CreateDynamicObject(3458,-3488.6999500,235.2000000,-4.0000000,0.0000000,90.0000000,179.9730000); //object(vgncarshade1)(118)
	CreateDynamicObject(3458,-3488.6999500,240.3000000,-6.4000000,0.0000000,90.0000000,179.9730000); //object(vgncarshade1)(119)
	CreateDynamicObject(3458,-3488.6999500,245.3999900,-8.2000000,0.0000000,90.0000000,179.9730000); //object(vgncarshade1)(120)
	CreateDynamicObject(3458,-3492.6992200,274.7998000,9.5000000,0.0000000,0.0000000,89.9730000); //object(vgncarshade1)(121)
	CreateDynamicObject(3458,-3470.0981400,262.1384000,9.7829500,6.4290000,180.0000000,359.9780000); //amt 3458(122)
	CreateDynamicObject(3458,-3470.0961900,267.1134300,10.6282400,12.8570000,180.0000000,359.9780000); //amt 3458(123)
	CreateDynamicObject(3458,-3470.0944800,271.9625500,12.0252500,19.2860000,180.0000000,359.9780000); //amt 3458(124)
	CreateDynamicObject(3458,-3470.0925300,276.6247900,13.9564000,25.7140000,180.0000000,359.9780000); //amt 3458(125)
	CreateDynamicObject(3458,-3470.0908200,281.0414400,16.3974100,32.1430000,180.0000000,359.9780000); //amt 3458(126)
	CreateDynamicObject(3458,-3470.0893600,285.1570400,19.3175800,38.5710000,180.0000000,359.9780000); //amt 3458(127)
	CreateDynamicObject(3458,-3470.0878900,288.9198000,22.6801900,45.0000000,180.0000000,359.9780000); //amt 3458(128)
	CreateDynamicObject(3458,-3470.0866700,292.2824100,26.4429600,51.4290000,180.0000000,359.9780000); //amt 3458(129)
	CreateDynamicObject(3458,-3470.0854500,295.2025800,30.5585600,57.8570000,180.0000000,359.9780000); //amt 3458(130)
	CreateDynamicObject(3458,-3470.0844700,297.6436200,34.9752300,64.2860000,180.0000000,359.9780000); //amt 3458(131)
	CreateDynamicObject(3458,-3470.0837400,299.5747700,39.6374400,70.7140000,180.0000000,359.9780000); //amt 3458(132)
	CreateDynamicObject(3458,-3470.0832500,300.9717700,44.4865600,77.1430000,180.0000000,359.9780000); //amt 3458(133)
	CreateDynamicObject(3458,-3470.0830100,301.8170500,49.4616000,83.5710000,180.0000000,359.9780000); //amt 3458(134)
	CreateDynamicObject(3458,-3470.0827600,302.1000100,54.5000000,90.0000000,80.3360000,99.6420000); //amt 3458(135)
	CreateDynamicObject(3458,-3470.0830100,301.8170500,59.5384000,83.5710000,0.0000000,179.9780000); //amt 3458(136)
	CreateDynamicObject(3458,-3470.0832500,300.9717700,64.5134400,77.1430000,0.0000000,179.9780000); //amt 3458(137)
	CreateDynamicObject(3458,-3470.0837400,299.5747700,69.3625600,70.7140000,0.0000000,179.9780000); //amt 3458(138)
	CreateDynamicObject(3458,-3470.0844700,297.6436200,74.0247700,64.2860000,0.0000000,179.9780000); //amt 3458(139)
	CreateDynamicObject(3458,-3470.0854500,295.2025800,78.4414400,57.8570000,0.0000000,179.9780000); //amt 3458(140)
	CreateDynamicObject(3458,-3470.0866700,292.2824100,82.5570400,51.4290000,0.0000000,179.9780000); //amt 3458(141)
	CreateDynamicObject(3458,-3470.0878900,288.9198000,86.3198100,45.0000000,0.0000000,179.9780000); //amt 3458(142)
	CreateDynamicObject(3458,-3470.0893600,285.1570400,89.6824200,38.5710000,0.0000000,179.9780000); //amt 3458(143)
	CreateDynamicObject(3458,-3470.0908200,281.0414400,92.6025900,32.1430000,0.0000000,179.9780000); //amt 3458(144)
	CreateDynamicObject(3458,-3470.0925300,276.6247900,95.0436000,25.7140000,0.0000000,179.9780000); //amt 3458(145)
	CreateDynamicObject(3458,-3470.0944800,271.9625500,96.9747500,19.2860000,0.0000000,179.9780000); //amt 3458(146)
	CreateDynamicObject(3458,-3470.0961900,267.1134300,98.3717600,12.8570000,0.0000000,179.9780000); //amt 3458(147)
	CreateDynamicObject(3458,-3470.0981400,262.1384000,99.2170500,6.4290000,0.0000000,179.9780000); //amt 3458(148)
	CreateDynamicObject(3458,-3470.1001000,257.1000100,99.5000000,0.0000000,0.0000000,179.9780000); //amt 3458(149)
	CreateDynamicObject(3458,-3470.1020500,252.0616000,99.2170500,353.5710000,0.0000000,179.9780000); //amt 3458(150)
	CreateDynamicObject(3458,-3470.1040000,247.0865600,98.3717600,347.1430000,0.0000000,179.9780000); //amt 3458(151)
	CreateDynamicObject(3458,-3470.1057100,242.2374600,96.9747500,340.7140000,0.0000000,179.9780000); //amt 3458(152)
	CreateDynamicObject(3458,-3470.1076700,237.5752400,95.0436000,334.2860000,0.0000000,179.9780000); //amt 3458(153)
	CreateDynamicObject(3458,-3470.1093700,233.1585700,92.6025900,327.8570000,0.0000000,179.9780000); //amt 3458(154)
	CreateDynamicObject(3458,-3470.1108400,229.0429700,89.6824200,321.4290000,0.0000000,179.9780000); //amt 3458(155)
	CreateDynamicObject(3458,-3470.1123000,225.2802000,86.3198100,315.0000000,0.0000000,179.9780000); //amt 3458(156)
	CreateDynamicObject(3458,-3470.1135300,221.9176000,82.5570400,308.5710000,0.0000000,179.9780000); //amt 3458(157)
	CreateDynamicObject(3458,-3470.1147500,218.9974200,78.4414400,302.1430000,0.0000000,179.9780000); //amt 3458(158)
	CreateDynamicObject(3458,-3470.1157200,216.5564100,74.0247700,295.7140000,0.0000000,179.9780000); //amt 3458(159)
	CreateDynamicObject(3458,-3470.1164600,214.6252600,69.3625600,289.2860000,0.0000000,179.9780000); //amt 3458(160)
	CreateDynamicObject(3458,-3470.1169400,213.2282600,64.5134400,282.8570000,0.0000000,179.9780000); //amt 3458(161)
	CreateDynamicObject(3458,-3470.1171900,212.3829700,59.5384000,276.4290000,0.0000000,179.9780000); //amt 3458(162)
	CreateDynamicObject(3458,-3470.1174300,212.1000100,54.5000000,270.0000000,80.3360000,260.3140000); //amt 3458(163)
	CreateDynamicObject(3458,-3470.1171900,212.3829700,49.4616000,276.4290000,180.0000000,359.9780000); //amt 3458(164)
	CreateDynamicObject(3458,-3470.1169400,213.2282600,44.4865600,282.8570000,180.0000000,359.9780000); //amt 3458(165)
	CreateDynamicObject(3458,-3470.1164600,214.6252600,39.6374400,289.2860000,180.0000000,359.9780000); //amt 3458(166)
	CreateDynamicObject(3458,-3470.1157200,216.5564100,34.9752300,295.7140000,180.0000000,359.9780000); //amt 3458(167)
	CreateDynamicObject(3458,-3470.1147500,218.9974200,30.5585600,302.1430000,180.0000000,359.9780000); //amt 3458(168)
	CreateDynamicObject(3458,-3470.1135300,221.9176000,26.4429600,308.5710000,180.0000000,359.9780000); //amt 3458(169)
	CreateDynamicObject(3458,-3470.1123000,225.2802000,22.6801900,315.0000000,180.0000000,359.9780000); //amt 3458(170)
	CreateDynamicObject(3458,-3470.1108400,229.0429700,19.3175800,321.4290000,180.0000000,359.9780000); //amt 3458(171)
	CreateDynamicObject(3458,-3470.1093700,233.1585700,16.3974100,327.8570000,180.0000000,359.9780000); //amt 3458(172)
	CreateDynamicObject(3458,-3470.1076700,237.5752400,13.9564000,334.2860000,180.0000000,359.9780000); //amt 3458(173)
	CreateDynamicObject(3458,-3470.1057100,242.2374600,12.0252500,340.7140000,180.0000000,359.9780000); //amt 3458(174)
	CreateDynamicObject(3458,-3470.1040000,247.0865600,10.6282400,347.1430000,180.0000000,359.9780000); //amt 3458(175)
	CreateDynamicObject(3458,-3470.1020500,252.0616000,9.7829500,353.5710000,180.0000000,359.9780000); //amt 3458(176)
	CreateDynamicObject(3458,-3470.1001000,257.1000100,9.5000000,0.0000000,180.0000000,359.9780000); //amt 3458(177)
	CreateDynamicObject(3458,-3487.8000500,246.2000000,-11.0000000,0.0000000,90.0000000,89.9730000); //object(vgncarshade1)(122)
	CreateDynamicObject(3458,-3487.1001000,245.2000000,-11.0000000,0.0000000,90.0000000,359.9670000); //object(vgncarshade1)(123)
	CreateDynamicObject(3458,-3486.8999000,240.2000000,-9.0000000,0.0000000,90.0000000,359.9670000); //object(vgncarshade1)(124)
	CreateDynamicObject(3458,-3486.8000500,235.0000000,-7.6000000,0.0000000,90.0000000,359.9670000); //object(vgncarshade1)(125)
	CreateDynamicObject(3458,-3470.0000000,284.3999900,9.5000000,0.0000000,0.0000000,179.9780000); //object(vgncarshade1)(126)
	CreateDynamicObject(3458,-3447.3000500,279.8999900,9.5000000,0.0000000,0.0000000,269.9730000); //object(vgncarshade1)(127)
	CreateDynamicObject(3458,-3470.0000000,297.6000100,9.5000000,0.0000000,0.0000000,179.9730000); //object(vgncarshade1)(128)
	CreateDynamicObject(3458,-3510.3999000,297.6000100,9.5000000,0.0000000,0.0000000,179.9730000); //object(vgncarshade1)(129)
	CreateDynamicObject(3458,-3528.1001000,274.8999900,9.5000000,0.0000000,0.0000000,269.9730000); //object(vgncarshade1)(130)
	CreateDynamicObject(3458,-3510.5000000,257.2000100,9.4000000,0.0000000,0.0000000,359.9670000); //object(vgncarshade1)(131)
	CreateDynamicObject(3458,-3447.2998000,319.7998000,0.0000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1)(132)
	CreateDynamicObject(3458,-3424.5996100,337.5000000,0.0000000,0.0000000,0.0000000,179.9950000); //object(vgncarshade1)(133)
	CreateDynamicObject(3458,-3407.0000000,314.7999900,0.0000000,0.0000000,0.0000000,269.9950000); //object(vgncarshade1)(134)
	CreateDynamicObject(3458,-3424.6992200,292.0996100,0.0000000,0.0000000,0.0000000,359.9840000); //object(vgncarshade1)(135)
	CreateDynamicObject(3458,-3407.0000000,274.0996100,-0.1000000,0.0000000,0.0000000,89.9840000); //object(vgncarshade1)(136)
	CreateDynamicObject(3458,-3424.5996100,251.3994100,0.0000000,0.0000000,0.0000000,179.9840000); //object(vgncarshade1)(137)
	CreateDynamicObject(3458,-3440.5000000,291.8999900,-2.8000000,0.0000000,16.0000000,359.9840000); //object(vgncarshade1)(138)
	CreateDynamicObject(3458,-3441.5000000,291.8999900,-1.8000000,0.0000000,11.9960000,359.9780000); //object(vgncarshade1)(139)
	CreateDynamicObject(3458,-3441.8000500,291.8999900,-4.2000000,0.0000000,23.9960000,359.9780000); //object(vgncarshade1)(140)
	CreateDynamicObject(3458,-3442.5000000,291.8999900,-5.0000000,0.0000000,27.9940000,359.9780000); //object(vgncarshade1)(141)
	CreateDynamicObject(3458,-3443.8000500,291.8999900,-6.0000000,0.0000000,33.9930000,359.9780000); //object(vgncarshade1)(142)
	CreateDynamicObject(973,-3495.1992200,290.5996100,11.8000000,0.0000000,0.0000000,270.0000000); //object(sub_roadbarrier)(1)
	CreateDynamicObject(8663,-3493.6992200,125.6992200,18.7000000,0.0000000,0.0000000,90.0000000); //object(triadcasno01_lvs)(3)
	CreateDynamicObject(8663,-3362.1001000,181.6000100,18.7000000,0.0000000,0.0000000,270.0000000); //object(triadcasno01_lvs)(4)
	CreateDynamicObject(8663,-3323.5000000,276.7999900,3.6000000,0.0000000,0.0000000,270.0000000); //object(triadcasno01_lvs)(5)
	CreateDynamicObject(3458,-3470.0000000,337.3994100,0.0000000,0.0000000,0.0000000,179.9950000); //object(vgncarshade1)(143)
	CreateDynamicObject(3458,-3492.6999500,319.7000100,0.0000000,0.0000000,0.0000000,269.9950000); //object(vgncarshade1)(143)
	CreateDynamicObject(8663,-3574.3999000,236.2000000,-38.0000000,0.0000000,90.0000000,0.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3574.3999000,236.2000000,10.1000000,0.0000000,90.0000000,0.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3574.3999000,236.2000000,89.6000000,0.0000000,90.0000000,0.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3533.8999000,162.7000000,89.6000000,0.0000000,90.0000000,90.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3413.3999000,162.8999900,66.1000000,0.0000000,90.0000000,90.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3365.3000500,192.5000000,66.1000000,0.0000000,90.0000000,180.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3341.1999500,254.6000100,66.1000000,0.0000000,90.0000000,179.9950000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3537.6001000,238.3999900,150.0000000,0.0000000,180.0000000,0.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3416.3000500,245.6000100,130.0000000,0.0000000,179.9950000,0.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3308.1999500,291.2999900,130.0000000,0.0000000,179.9950000,0.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3468.5000000,222.0000000,150.6000100,0.0000000,179.9950000,0.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3423.1999500,162.3000000,85.9000000,0.0000000,90.0000000,90.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3525.1999500,472.2000100,18.7000000,0.0000000,0.0000000,270.0000000); //object(triadcasno01_lvs)(1)
	CreateDynamicObject(8663,-3392.8999000,484.3999900,18.7000000,0.0000000,0.0000000,0.0000000); //object(triadcasno01_lvs)(1)
	CreateDynamicObject(8663,-3459.0000000,509.5000000,18.7000000,0.0000000,0.0000000,270.0000000); //object(triadcasno01_lvs)(1)
	CreateDynamicObject(8663,-3307.3999000,395.2999900,18.7000000,0.0000000,0.0000000,270.0000000); //object(triadcasno01_lvs)(1)
	CreateDynamicObject(8663,-3338.0000000,343.7999900,36.0000000,0.0000000,90.0000000,179.9950000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3338.0000000,343.7999900,91.6000000,0.0000000,90.0000000,179.9950000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3339.5000000,416.8999900,91.6000000,0.0000000,90.0000000,179.9950000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3351.8000500,432.1000100,91.6000000,0.0000000,90.0000000,269.9950000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3475.3000500,440.3999900,91.6000000,0.0000000,90.0000000,269.9890000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3548.8000500,432.6000100,91.6000000,0.0000000,90.0000000,269.9890000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3587.1999500,353.2000100,91.6000000,0.0000000,90.0000000,359.9890000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3587.1999500,331.8999900,107.0000000,0.0000000,90.0000000,359.9840000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3587.1999500,331.8999900,2.6000000,0.0000000,90.0000000,359.9840000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3601.8000500,395.6000100,27.6000000,0.0000000,90.0000000,269.9890000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3513.3000500,317.7999900,150.0000000,0.0000000,179.9950000,90.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3511.3000500,395.2000100,150.0000000,0.0000000,179.9950000,90.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3418.6999500,395.5000000,150.0000000,0.0000000,179.9950000,90.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(8663,-3417.5000000,337.2999900,150.0000000,0.0000000,179.9950000,90.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(3458,-3406.8999000,360.2999900,0.0000000,0.0000000,0.0000000,269.9950000); //object(vgncarshade1)(133)
	CreateDynamicObject(3458,-3418.0000000,383.0000000,0.0000000,0.0000000,0.0000000,359.9840000); //object(vgncarshade1)(133)
	CreateDynamicObject(3458,-3447.3999000,348.7999900,-0.1000000,0.0000000,0.0000000,90.0000000); //object(vgncarshade1)(132)
	CreateDynamicObject(3458,-3492.6999500,359.8999900,0.0000000,0.0000000,0.0000000,269.9890000); //object(vgncarshade1)(143)
	CreateDynamicObject(3458,-3475.1001000,382.5000000,0.0000000,0.0000000,0.0000000,359.9890000); //object(vgncarshade1)(143)
	CreateDynamicObject(3458,-3492.6001000,405.2000100,0.0000000,0.0000000,0.0000000,89.9840000); //object(vgncarshade1)(143)
	CreateDynamicObject(3458,-3469.8999000,422.8999900,0.0000000,0.0000000,0.0000000,179.9840000); //object(vgncarshade1)(143)
	CreateDynamicObject(3458,-3447.1001000,416.2999900,0.0000000,0.0000000,0.0000000,269.9840000); //object(vgncarshade1)(143)
	CreateDynamicObject(1634,-3447.3000500,368.6000100,2.4000000,0.0000000,0.0000000,0.0000000); //object(landjump2)(1)
	CreateDynamicObject(1634,-3459.3999000,382.3999900,2.5000000,0.0000000,0.0000000,270.0000000); //object(landjump2)(2)
	CreateDynamicObject(1634,-3447.3000500,399.6000100,2.5000000,0.0000000,0.0000000,179.9950000); //object(landjump2)(3)
	CreateDynamicObject(1634,-3439.1999500,382.8999900,2.5000000,0.0000000,0.0000000,89.9950000); //object(landjump2)(4)
	CreateDynamicObject(3458,-3487.6001000,274.7999900,9.4000000,0.0000000,0.0000000,89.9730000); //object(vgncarshade1)(121)
	CreateDynamicObject(973,-3495.1999500,290.6000100,12.7000000,0.0000000,0.0000000,270.0000000); //object(sub_roadbarrier)(1)
	CreateDynamicObject(973,-3495.1999500,290.6000100,13.5000000,0.0000000,0.0000000,270.0000000); //object(sub_roadbarrier)(1)
	CreateDynamicObject(3458,-3470.0000000,257.1000100,88.7000000,90.0000000,0.0000000,179.9730000); //object(vgncarshade1)(90)
	CreateDynamicObject(3458,-3470.0000000,257.1000100,83.6000000,90.0000000,0.0000000,179.9730000); //object(vgncarshade1)(90)
	CreateDynamicObject(3458,-3470.0000000,257.0996100,83.6000000,90.0000000,0.0000000,359.9730000); //object(vgncarshade1)(90)
	CreateDynamicObject(3458,-3470.0000000,257.1000100,88.7000000,90.0000000,0.0000000,359.9670000); //object(vgncarshade1)(90)
	CreateDynamicObject(9132,-3523.5000000,331.6000100,42.0000000,0.0000000,0.0000000,0.0000000); //object(triadcasign_lvs)(1)
	CreateDynamicObject(3533,-3334.6001000,347.8999900,9.0000000,0.0000000,0.0000000,0.0000000); //object(trdpillar01)(1)
	CreateDynamicObject(3533,-3508.0996100,322.0000000,27.1000000,0.0000000,0.0000000,0.0000000); //object(trdpillar01)(2)
	CreateDynamicObject(8663,-3535.8000500,126.0000000,42.9000000,0.0000000,0.0000000,90.0000000); //object(triadcasno01_lvs)(3)
	CreateDynamicObject(8663,-3572.6999500,161.6000100,1.0000000,0.0000000,90.0000000,0.0000000); //object(triadcasno01_lvs)(2)
	CreateDynamicObject(3533,-3405.0996100,243.0000000,9.9000000,0.0000000,0.0000000,0.0000000); //object(trdpillar01)(3)
	CreateDynamicObject(3533,-3485.3000500,442.8999900,9.9000000,0.0000000,0.0000000,0.0000000); //object(trdpillar01)(4)
	CreateDynamicObject(3533,-3504.8999000,442.8999900,9.9000000,0.0000000,0.0000000,0.0000000); //object(trdpillar01)(5)
	CreateDynamicObject(3533,-3494.8999000,442.5000000,9.9000000,0.0000000,0.0000000,0.0000000); //object(trdpillar01)(6)
	CreateDynamicObject(3533,-3441.3999000,442.5000000,9.9000000,0.0000000,0.0000000,0.0000000); //object(trdpillar01)(7)
	CreateDynamicObject(3533,-3425.5000000,442.5000000,9.9000000,0.0000000,0.0000000,0.0000000); //object(trdpillar01)(8)
	CreateDynamicObject(3458,-3426.6999500,405.7000100,0.0000000,0.0000000,0.0000000,89.9840000); //object(vgncarshade1)(133)
	CreateDynamicObject(3458,-3449.5000000,422.8999900,-0.1000000,0.0000000,0.0000000,179.9840000); //object(vgncarshade1)(133)
	return 1;
}

/////////////////////////////////// EXTRA //////////////////////////////////////

AntiDeAMX()
{
    new a[][] =
    {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a
}

WasteDeAMXersTime()
{
    new b;
    #emit load.pri b
    #emit stor.pri b
}

CMD:derbymapone(playerid, params[])
{
	SetPlayerPos(playerid, -2209.6604000,-2281.1428200,840.000000);
	return 1;
}


CMD:derbymaptwo(playerid, params[])
{
	SetPlayerPos(playerid, 3652.0610400,-2041.8200700,455.000000);
	return 1;
}
