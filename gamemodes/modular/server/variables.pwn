// all variables will be displayed here

#define COLOR_WHITE (0xffffffFF)
#define COLOR_RED (0xdb1a1aFF)
#define COLOR_BLUE (0x2265d8FF)
#define COLOR_YELLOW (0xdfe52eFF)
#define COLOR_YELLOWD (0xc0c52cFF)
#define COLOR_CYAN (0x1fe0ddFF)
#define COL_GREEN (0x00FF00FF)
#define COLOR_GREY (0xa8a8a3FF)

#define SCM SendClientMessage
#define function:%0(%1) forward %0(%1); public %0(%1)
#define SCMex SendClientMessageEx
#define SCMall SendClientMessageToAll

#define SCRIPT_VERSION "Ragnarok's script adventure"

#define MAX_VEHICLE_SAVE_SLOTS 5

// race related

#define MAX_RACES 			2
#define MAX_CHECKS 			40

#define DIALOG_UNUSED 		0

#define RACE_VIRTUALWORLD 	1

//////////////////////////////////////////////////////////////

new pPM[MAX_PLAYERS],
aduty[MAX_PLAYERS];

new ddm, sdm, spas;

new Text3D:textlabelstrddm,
	Text3D:textlabelstrsdm,
	Text3D:textlabelstrspasdm
;

new Float:markx, Float:marky, Float:markz, Float:marka, markplaced, mark;

new activecount;

// =====================REGISTER/LOGGING STUFF===================

new joinskin = mS_INVALID_LISTID;

new PlayerLogin[MAX_PLAYERS];

////////////////////////////////////////////////////////////////

//========================Related to cbug=================

#define MAX_SLOTS 48

new NotMoving[MAX_PLAYERS];
new WeaponID[MAX_PLAYERS];
new CheckCrouch[MAX_PLAYERS];
new Ammo[MAX_PLAYERS][MAX_SLOTS];

///////////////////////////////////////////////////////////

//=========================Dynamic pickups================
/*
new ddmpickup;
new sdmpickup;
new spasdmpickup;
*/
//////////////////////////////////////////////////////////

//========================Actors==========================

new 
	actorddm,
	actorsdm,
	actorspasdm
;

//================================Dialogs==================

enum // dialog ids
{
	DIALOG_REGISTER,
	DIALOG_LOGIN,
	DIALOG_HELP,
	DIALOG_ACCOUNT,

	// dm related
	DIALOG_DM,
	DIALOG_CONFIRMDDM,
	DIALOG_CONFIRMSDM,
	DIALOG_CONFIRMSPASDM,

	// vehicle save related
	DIALOG_VEHICLE_SAVE_SLOTS,
	DIALOG_VEHICLE_SAVE_SLOT_INPUT1,
	DIALOG_VEHICLE_SAVE_SLOT_INPUT2,
	DIALOG_VEHICLE_SAVE_SLOT_INPUT3,
	DIALOG_VEHICLE_SAVE_SLOT_INPUT4,
	DIALOG_VEHICLE_SAVE_SLOT_INPUT5,

	// admin related
	DIALOG_ADMINS,

	// RACE RELATED
	DIALOG_RACE

};

////////////////////////////////////////////////////////////

//=======================Account Data Stuff========================

enum P_ACCOUNT_DATA
{
    pDBID,
    pAccName[60],
    pSkin,
    bool:pLoggedin,
    pAdmin,
    pCash,
    pScore,
    PMS
}
new PlayerInfo[MAX_PLAYERS][P_ACCOUNT_DATA];

/////////////////////////////////////////////////////////////////////

// =====================DM stuff===============================

new dm[MAX_PLAYERS];
new Streak[MAX_PLAYERS];
new PlayerText3D:Info[MAX_PLAYERS];

new Float:DERandomSpawn[][4] =
{
    {1412.6399,-1.7875,1000.9244,95.5046},
    {1412.7356,-42.7349,1000.9214,89.5512},
    {1363.8529,-42.1017,1000.9207,270.9495},
    {1367.4900,-1.9307,1000.9219,268.4427}
};

new Float:SDMRandomSpawn[][12] =
{
    {300.4181,186.8386,1007.1719,93.8678}, // 1
    {286.3044,168.6592,1007.1719,0.8220}, // 2
    {275.9715,186.5869,1007.1719,177.3853}, // 3
    {299.6944,191.1874,1007.1719,90.8204}, // 4
	{268.0913,185.5582,1008.1719,2.8939}, // 5
	{246.2515,185.3819,1008.1719,323.0249}, // 6
	{237.9388,140.1041,1003.0234,0.5944}, // 7
	{208.3848,142.4332,1003.0234,271.8859}, // 8
	{230.2381,181.7928,1003.0313,90.1527}, // 9
	{211.3380,187.8945,1003.0313,179.4331}, // 10
	{189.5367,158.4363,1003.0234,272.9816}, // 11
	{189.3243,179.1608,1003.0234,269.0112} // 12
	
};

new Float:SPASRandomSpawn[][4] =
{
    {1412.6399,-1.7875,1000.9244,92.5395},
    {1413.1160,-44.3621,1000.9224,88.4661},
    {1361.5558,-44.6068,1000.9238,271.7444},
    {1361.5341,-0.1599,1000.9219,265.7913}
};
////////////////////////////////////////////////////////////////

//======================Statics==============================

new const vehicleNames[212][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Article Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Article Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stuntplane", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Petrol Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Article Trailer 3", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

new aWeaponNames[][32] = {
	{"Fist"}, // 0
	{"Brass Knuckles"}, // 1
	{"Golf Club"}, // 2
	{"Night Stick"}, // 3
	{"Knife"}, // 4
	{"Baseball Bat"}, // 5
	{"Shovel"}, // 6
	{"Pool Cue"}, // 7
	{"Katana"}, // 8
	{"Chainsaw"}, // 9
	{"Purple Dildo"}, // 10
	{"Vibrator"}, // 11
	{"Vibrator"}, // 12
	{"Vibrator"}, // 13
	{"Flowers"}, // 14
	{"Cane"}, // 15
	{"Grenade"}, // 16
	{"Teargas"}, // 17
	{"Molotov"}, // 18
	{" "}, // 19
	{" "}, // 20
	{" "}, // 21
	{"Colt 45"}, // 22
	{"Silenced Pistol"}, // 23
	{"Deagle"}, // 24
	{"Shotgun"}, // 25
	{"Sawns"}, // 26
	{"Spas"}, // 27
	{"Uzi"}, // 28
	{"MP5"}, // 29
	{"AK47"}, // 30
	{"M4"}, // 31
	{"Tec9"}, // 32
	{"Country Rifle"}, // 33
	{"Sniper Rifle"}, // 34
	{"Rocket Launcher"}, // 35
	{"Heat-Seeking Rocket Launcher"}, // 36
	{"Flamethrower"}, // 37
	{"Minigun"}, // 38
	{"Satchel Charge"}, // 39
	{"Detonator"}, // 40
	{"Spray Can"}, // 41
	{"Fire Extinguisher"}, // 42
	{"Camera"}, // 43
	{"Night Vision Goggles"}, // 44
	{"Infrared Vision Goggles"}, // 45
	{"Parachute"}, // 46
	{"Fake Pistol"} // 47
};

new const WeaponNames[55][] =
{
		{"Punch"},{"Brass Knuckles"},{"Golf Club"},{"Nite Stick"},{"Knife"},{"Baseball Bat"},{"Shovel"},{"Pool Cue"},{"Katana"},{"Chainsaw"},{"Purple Dildo"},
		{"Smal White Vibrator"},{"Large White Vibrator"},{"Silver Vibrator"},{"Flowers"},{"Cane"},{"Grenade"},{"Tear Gas"},{"Molotov Cocktail"},
		{""},{""},{""}, // Empty spots for ID 19-20-21 (invalid weapon id's)
		{"9mm"},{"Silenced 9mm"},{"Deagle"},{"Shotgun"},{"Sawn-off"},{"Spas"},{"Micro SMG"},{"MP5"},{"AK-47"},{"M4"},{"Tec9"},
		{"Rifle"},{"Sniper"},{"RPG"},{"HS Rocket"},{"Flame-thrower"},{"Minigun"},{"Satchel Charge"},{"Detonator"},
		{"Spraycan"},{"Fire Extinguisher"},{"Camera"},{"Nightvision Goggles"},{"Thermal Goggles"},{"Parachute"}, {"Fake Pistol"},{""}, {"Vehicle"}, {"Helicopter Blades"},
		{"Explosion"}, {""}, {"Suicide"}, {"Collision"}
};

//=================================================================


// RACE RELATED
enum RACE_playerInfo
{
	RACE_playerUsername[MAX_PLAYER_NAME],
	
	RACE_playerVehicle,
	
	RACE_playerPosition,
	RACE_playerCheckpointsPassed,
	RACE_playerTimeTookToFinish,

    Text:RACE_textdrawBar,
	Text:RACE_textdrawBox,
	Text:RACE_textdrawTitle,
	Text:RACE_textdrawName,
	Text:RACE_textdrawPosition,
	Text:RACE_textdrawCheckpoint,
	Text:RACE_textdrawTimeLeft,
	Text:RACE_textdrawSpeed,

    bool:RACE_isPlayerInRace,
	
	Text:RACE_textdrawTip,
	Text:RACE_textdrawTip2
};

enum RACE_raceInfo
{
	raceName[24],

	raceVehicleID,
	raceMaxCheckpoints,
	raceInterior,
	raceDistance,
	raceRecord,
	raceRecordPlaced,
	raceRecordHolder[24],
	
	Float:raceSpawnPositionX,
	Float:raceSpawnPositionY,
	Float:raceSpawnPositionZ,
	Float:raceSpawnPositionA,

	Float:raceCheckpointPositionX,
	Float:raceCheckpointPositionY,
	Float:raceCheckpointPositionZ
};

new	
	RACE_pInfo[MAX_PLAYERS][RACE_playerInfo],
	
	RACE_rInfo[MAX_RACES][MAX_CHECKS][RACE_raceInfo],

    RACE_loadedRaces = 0,
	RACE_runningID,

	RACE_playersInEvent = 0,
	RACE_playersLeft = 0,
	RACE_playersSpawned = 0,

	RACE_timeLeft,
	RACE_timerCounter,

	RACE_countdownTimer,
	RACE_checkRaceTimer,

	RACE_checkpoints[MAX_CHECKS],
	
	RACE_spawnSlots[16] = {-1, ...},

 	bool:RACE_isRaceStarted = false,
	bool:RACE_isRaceInLobby = false,
	
	RACE_globalString[144]
;

//////////////////////////////////////////////////////////////////

// Vehicle Save  Related

enum P_VEHICLE_SAVE_DATA
{
    Slotname1,
    Slotname2,
    Slotname3,
    Slotname4,
    Slotname5
};
new VehicleInfo[MAX_PLAYERS][P_VEHICLE_SAVE_DATA];