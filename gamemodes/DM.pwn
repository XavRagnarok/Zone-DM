// This is very dope script we are making for Ragnarok because he wants test his coding skills at newbie level
// Server name is Zones DM

#include <a_samp>
#include <a_mysql>
#include <zcmd>
#include <sscanf2>
#include <mSelection>
#include <a_players>
#include <a_vehicles>
#include <float>
#include <foreach>
#include <k_functions>
#include <string>
#include <streamer>




#define COLOR_WHITE (0xffffffFF)
#define COLOR_RED (0xdb1a1aFF)
#define COLOR_BLUE (0x2265d8FF)
#define COLOR_YELLOW (0xdfe52eFF)
#define COLOR_YELLOWD (0xc0c52cFF)
#define COLOR_CYAN (0x1fe0ddFF)
#define COL_GREEN (0x00FF00FF)
#define COLOR_GREY (0xa8a8a3FF)
#define COLOR_ERROR 0xE60000FF
#define COLOR_SKYBLUE 0x00B6FFFF

#define SCM SendClientMessage
#define function:%0(%1) forward %0(%1); public %0(%1)
#define SCMex SendClientMessageEx
#define SCMall SendClientMessageToAll

#define SCRIPT_VERSION "Script Adventure 1.0.1.1"

new pms[MAX_PLAYERS],
pPM[MAX_PLAYERS],
aduty[MAX_PLAYERS];

//======radio system==========
new Radio_on[MAX_PLAYERS];
new Radio_viewing[MAX_PLAYERS];
new Text:Radio[28];

stock HideRadioTextdraws(playerid)
{
	TextDrawHideForPlayer(playerid,Radio[0]);
	TextDrawHideForPlayer(playerid,Radio[1]);
	TextDrawHideForPlayer(playerid,Radio[2]);
	TextDrawHideForPlayer(playerid,Radio[3]);
	Radio_viewing[playerid] =0;
	return 1;
}

//========================Related to cbug=================

#define MAX_SLOTS 48

new NotMoving[MAX_PLAYERS];
new WeaponID[MAX_PLAYERS];
new CheckCrouch[MAX_PLAYERS];
new Ammo[MAX_PLAYERS][MAX_SLOTS];

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


//=========================Dynamic pickups================

new ddmpickup;
new sdmpickup;
new sosdmpickup;

//================================Dialogs==================

#define DIALOG_REGISTER 0
#define DIALOG_LOGIN 1
#define DIALOG_HELP 2
#define DIALOG_ACCOUNT 3
#define DIALOG_DM 4
#define DIALOG_CONFIRMDDM 5
#define DIALOG_CONFIRMSDM 6
#define DIALOG_CONFIRMSOSDM 7


//================MySQL Connection:=========================

new ourConnection;

#define SQL_HOSTNAME "127.0.0.1"
#define SQL_USERNAME "Main"
#define SQL_DATABASE "sampserver"
#define SQL_PASSWORD "87654321"

//===========================================================

//======================Statics==============================

static stock g_arrVehicleNames[][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Cruiser", "SFPD Cruiser", "LVPD Cruiser",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

//=================================================================



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
}
new PlayerInfo[MAX_PLAYERS][P_ACCOUNT_DATA];

// =====================REGISTER/LOGGING STUFF===================

new joinskin = mS_INVALID_LISTID;

new PlayerLogin[MAX_PLAYERS];
//===============================================================



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

new Float:SOSRandomSpawn[][4] =
{
    {1412.6399,-1.7875,1000.9244,92.5395},
    {1413.1160,-44.3621,1000.9224,88.4661},
    {1361.5558,-44.6068,1000.9238,271.7444},
    {1361.5341,-0.1599,1000.9219,265.7913}
};

new Float:ONESHOTRandomSpawn[][11] =
{
	{2170.1328,1618.9799,999.9766,270.9527},
	{2193.5625,1625.3717,999.9714,182.3944},
	{2205.4951,1609.6262,999.9727,0.8093},
	{2218.2554,1613.4342,999.9827,1.0042},
	{2224.3579,1615.2388,999.9706,181.3352},
	{2228.4014,1592.6238,999.9617,87.8489},
	{2217.0471,1574.6781,999.9698,273.0486},
	{2205.7659,1580.9912,999.9803,357.6592},
	{2187.9590,1591.9135,999.9769,180.5735},
	{2174.3879,1577.9302,999.9678,2.4242},
	{2178.0503,1601.6470,999.9765,88.5473}
};




//===============================================================


main()
{
	print("\n-------------------------------------");
	print("This is the sick script we are making");
	print("---------------------------------------\n");
}

public OnGameModeInit()
{
    DisableInteriorEnterExits();

    ourConnection = mysql_connect(SQL_HOSTNAME, SQL_USERNAME, SQL_DATABASE, SQL_PASSWORD);

    if(mysql_errno() !=0)
        printf ("[DATABASE]: Connection failed to MySQL", SQL_DATABASE);
    else printf ("[DATABASE]: Connection established to MySQL", SQL_DATABASE);

    joinskin = LoadModelSelectionMenu("skins.txt");

 	SetGameModeText("friends zone");
 	
 	ddmpickup = CreateDynamicPickup(1318, 2, 238.7231,-1882.8654,4.4767, -1, -1, -1, 100.0, -1, 0);
 	
 	CreateDynamic3DTextLabel("Press ~k~~VEHICLE_ENTER_EXIT~", -1, 238.7231,-1882.8654,4.4767, 5.0, -1, -1, 1, -1, -1, -1, 5.0);
 	
 	sdmpickup = CreateDynamicPickup(1318, 2, 236.1373,-1882.9423,4.4698, -1, -1, -1, 100.0, -1, 0);
 	
    CreateDynamic3DTextLabel("Press ~k~~VEHICLE_ENTER_EXIT~", -1, 236.1373,-1882.9423,4.4698, 5.0, -1, -1, 1, -1, -1, -1, 5.0);
    
	sosdmpickup = CreateDynamicPickup(1318, 2, 233.6071,-1883.0021,4.4685, -1, -1, -1, 100.0, -1, 0);
    
    CreateDynamic3DTextLabel("Press ~k~~VEHICLE_ENTER_EXIT~", -1, 233.6071,-1883.0021,4.4685, 5.0, -1, -1, 1, -1, -1, -1, 5.0);
 	
 	//====radiosystem===
	Radio[0] = TextDrawCreate(118.000000, 122.000000, "~l~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~N~~N~~N~");
	TextDrawAlignment(Radio[0], 2);
	TextDrawBackgroundColor(Radio[0], 255);
	TextDrawFont(Radio[0], 1);
	TextDrawLetterSize(Radio[0], 0.500000, 1.000000);
	TextDrawColor(Radio[0], -1);
	TextDrawSetOutline(Radio[0], 0);
	TextDrawSetProportional(Radio[0], 1);
	TextDrawSetShadow(Radio[0], 1);
	TextDrawUseBox(Radio[0], 1);
	TextDrawBoxColor(Radio[0], 0x00000045);
	TextDrawTextSize(Radio[0], -1.000000, 212.000000);
	TextDrawSetSelectable(Radio[0], 0);

	Radio[1] = TextDrawCreate(120.000000, 131.000000, "~g~Radio");
	TextDrawAlignment(Radio[1], 2);
	TextDrawBackgroundColor(Radio[1], 255);
	TextDrawFont(Radio[1], 3);
	TextDrawLetterSize(Radio[1], 0.460000, 1.299999);
	TextDrawColor(Radio[1], -1);
	TextDrawSetOutline(Radio[1], 1);
	TextDrawSetProportional(Radio[1], 1);
	TextDrawSetSelectable(Radio[1], 0);

	Radio[2] = TextDrawCreate(34.5, 155.000000, "~y~1 ~w~- CNR Radio ~N~~Y~2 ~W~- Chinese~N~~Y~3 ~W~- French~N~~Y~4 ~W~- Brazilian~N~~Y~5 ~W~- Indian~N~~Y~6 ~W~- Asian~N~~Y~7 ~W~- European~N~~Y~8 ~W~- Japanese~N~~Y~9 ~W~- Anime~N~~Y~10 ~W~- ~R~~H~OFF");
	TextDrawAlignment(Radio[2], 1);
	TextDrawBoxColor(Radio[2], 255);
	TextDrawFont(Radio[2], 1);
	TextDrawLetterSize(Radio[2], 0.230000, 1.000000);
	TextDrawColor(Radio[2], -1);
	TextDrawSetOutline(Radio[2], 1);
	TextDrawSetProportional(Radio[2], 1);
	TextDrawSetSelectable(Radio[2], 0);

	Radio[3] = TextDrawCreate(121.000000, 250.000000, "~w~Press ~y~F6 ~w~(~y~T~w~) And Select A Number~n~~w~Press ~y~LMB ~w~ To Close This Box");
	TextDrawAlignment(Radio[3], 2);
	TextDrawBackgroundColor(Radio[3], 255);
	TextDrawFont(Radio[3], 1);
	TextDrawLetterSize(Radio[3], 0.230000, 1.000000);
	TextDrawColor(Radio[3], -1);
	TextDrawSetOutline(Radio[3], 1);
	TextDrawSetProportional(Radio[3], 1);
	TextDrawSetSelectable(Radio[3], 0);

	return 1;
}

public OnGameModeExit()
{
	mysql_close(ourConnection);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if(PlayerInfo[playerid][pLoggedin] == false)
		{
	    SetSpawnInfo(playerid, 0, 0, 563.3157, 3315.2559, 0, 269.15, 0, 0, 0, 0, 0, 0 );
	    TogglePlayerSpectating(playerid, true);
     	TogglePlayerSpectating(playerid, false);
        SetPlayerCamera(playerid);
        return 1;
		}

	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 223.0138,-1872.2523,4.4400,1.4446,0,0,0,0,0,0);
	SpawnPlayer(playerid);


	return 0;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success)
	{
		return SCM(playerid, COLOR_GREY, "The cmd does not exist, please use /help");
	}
	return 1;
}


public OnPlayerConnect(playerid)
{
	{
		new line[124];
		format(line, sizeof(line), "{a8a8a3}%s(%d) has joined the server",GetName(playerid),playerid);
		SendClientMessageToAll(0xFFFFFFFF, line);
	}
    SetPlayerCamera(playerid);
	ResetPlayer(playerid);
	dm[playerid] = 0;
	Streak[playerid] = 0;

	new existcheck[248];

	mysql_format(ourConnection, existcheck, sizeof(existcheck), "SELECT * FROM accounts WHERE acc_name = '%e'", ReturnName(playerid));
    mysql_tquery(ourConnection, existcheck, "LogPlayerIn", "i", playerid);

	RemoveBuildingForPlayer(playerid, 1775, 2209.9063, 1607.1953, 1000.0547, 0.25);
	RemoveBuildingForPlayer(playerid, 1776, 2202.4531, 1617.0078, 1000.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 1776, 2209.2422, 1621.2109, 1000.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 1776, 2222.3672, 1602.6406, 1000.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 1775, 2222.2031, 1606.7734, 1000.0547, 0.25);

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	{
	new line[124];
	switch(reason) {
    case 0: format(line, sizeof(line), "%s(%d) has left the server. (Lost Connection)", GetName(playerid), playerid);
    case 1: format(line, sizeof(line), "%s(%d) has left the server. (Leaving)", GetName(playerid), playerid);
    case 2: format(line, sizeof(line), "%s(%d) has left the server. (Kicked)", GetName(playerid), playerid);
	}
	SendClientMessageToAll(0xFFFFFFFF, line);
	}
	{
		new insert[128];

		PlayerInfo[playerid][pCash] = GetPlayerMoney(playerid);

		mysql_format(ourConnection, insert, sizeof(insert), "UPDATE accounts SET Cash = %i WHERE acc_dbid = %i",PlayerInfo[playerid][pCash] , PlayerInfo[playerid][pDBID]);
		mysql_tquery(ourConnection, insert);
	}

	{
		dm[playerid] = 0;
		Streak[playerid] = 0;
		for(new i; i < 6; i++)
		{
	    	DeletePlayer3DTextLabel(playerid, Info[playerid]);
		}
	}
	
	{
		new insert[130];

		PlayerInfo[playerid][pScore] = GetPlayerScore(playerid);

		mysql_format(ourConnection, insert, sizeof(insert), "UPDATE accounts SET Score = %i WHERE acc_dbid = %i",PlayerInfo[playerid][pScore] , PlayerInfo[playerid][pDBID]);
		mysql_tquery(ourConnection, insert);
	}

	{
		new insert[300];

		PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);

		mysql_format(ourConnection, insert, sizeof(insert), "UPDATE accounts SET Skin = %i WHERE acc_dbid = %i", PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pDBID]);
		mysql_tquery(ourConnection, insert);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(dm[playerid] == 1)
	{
		DDM(playerid);
	}
	if(dm[playerid] == 2)
	{
		SDM(playerid);
	}
	if(dm[playerid] == 3)
	{
		SOSDM(playerid);
	}
	if(dm[playerid] == 4)
	{
		oneshot(playerid);
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    if(dm[killerid] >= 1)
	{
		new str[200];
		format(str, sizeof(str), "~r~You killed~n~%s~n~~r~1 Score", GetName(playerid));
		GameTextForPlayer(killerid, str, 4500, 3);
		SetPlayerScore(killerid, GetPlayerScore(playerid) + 1);
		PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
		Streak[killerid] = 0;

		if(Streak[killerid] != 8)
		{
		    Streak[killerid]++;
		}

		if(Streak[killerid] >= 3)
		{
			format(str, sizeof(str),"[DEATHMATCH] %d(%d) is on a Killing Spree!", GetName(killerid), killerid);
			SendClientMessageToAll(COLOR_RED ,str);
			GameTextForPlayer(killerid, "~r~Killing spree", 4500, 1);
		}
		if(Streak[killerid] >= 4)
		{
			format(str, sizeof(str),"[DEATHMATCH] %d(%d) has done a Quadrakill!", GetName(killerid), killerid);
			SendClientMessageToAll(COLOR_RED ,str);
			GameTextForPlayer(killerid, "~r~Quadrakill", 4500, 1);
		}
		if(Streak[killerid] >= 5)
		{
			format(str, sizeof(str),"[DEATHMATCH] %d(%d) has done a Pentakill!", GetName(killerid), killerid);
			SendClientMessageToAll(COLOR_RED ,str);
			GameTextForPlayer(killerid, "~r~Pentakill", 4500, 1);
		}
		if(Streak[killerid] >= 6)
		{
			format(str, sizeof(str),"[DEATHMATCH] %d(%d) is Unstoppable!", GetName(killerid), killerid);
			SendClientMessageToAll(COLOR_RED ,str);
			GameTextForPlayer(killerid, "~r~Unstoppable", 4500, 1);
		}
		if(Streak[killerid] >= 7)
		{
			format(str, sizeof(str),"[DEATHMATCH] %d(%d) is Dominating!", GetName(killerid), killerid);
			SendClientMessageToAll(COLOR_RED ,str);
			GameTextForPlayer(killerid, "~r~Dominating", 4500, 1);
		}
		if(Streak[killerid] >= 8)
		{
			format(str, sizeof(str),"[DEATHMATCH] %d(%d) is Godlike!", GetName(killerid), killerid);
			SendClientMessageToAll(COLOR_RED ,str);
			GameTextForPlayer(killerid, "~r~Godlike!", 4500, 1);
		}
	}
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
    if(issuerid != INVALID_PLAYER_ID && dm[issuerid] == 2 && weaponid == 34 && bodypart == 9)
    {
        SetPlayerHealth(playerid, 0);
        PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid && issuerid,"~r~Headshot",2000, 3);
	}
    return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{

	return 1;
}

public OnPlayerText(playerid, text[])
{
	//=====radio things===
	if(Radio_viewing[playerid] == 1)
	{
		if(isNumeric(text))
		{
			new input = strval(text);
			switch(input)
			{
				case 1:
				{
						SendClientMessage(playerid,COLOR_SKYBLUE,"Radio Started.....This Radio Is Taken From MY tunners.");
						PlayAudioStreamForPlayer(playerid, "https://mytuner-radio.com/radio/samaa-fm-karachi-418279/", 0, 0, 0, 0, 0);
						HideRadioTextdraws(playerid);
						Radio_on[playerid] = 1;
						return 0;
				}
				case 2:
				{
						SendClientMessage(playerid,COLOR_SKYBLUE,"Radio Started.");
						PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=21360", 0, 0, 0, 0, 0);
						HideRadioTextdraws(playerid);
						Radio_on[playerid] = 1;
						return 0;
				}
				case 3:
				{
						SendClientMessage(playerid,COLOR_SKYBLUE,"Radio Started.");
						PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=75934", 0, 0, 0, 0, 0);
						HideRadioTextdraws(playerid);
						Radio_on[playerid] = 1;
						return 0;
				}
				case 4:
				{
						SendClientMessage(playerid,COLOR_SKYBLUE,"Radio Started.");
						PlayAudioStreamForPlayer(playerid, "http://www.shoutcast.com/player/?radname=Today%27s%20Hot%20Country&stationid=331656&coding=MP3#", 0, 0, 0, 0, 0);
						HideRadioTextdraws(playerid);
						Radio_on[playerid] = 1;
						return 0;
				}
				case 5:
				{
						SendClientMessage(playerid,COLOR_SKYBLUE,"Radio Started.");
						PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=848296", 0, 0, 0, 0, 0);
						HideRadioTextdraws(playerid);
						Radio_on[playerid] = 1;
						return 0;
				}
				case 6:
				{
						SendClientMessage(playerid,COLOR_SKYBLUE,"Radio Started.");
						PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=561012", 0, 0, 0, 0, 0);
						HideRadioTextdraws(playerid);
						Radio_on[playerid] = 1;
						return 0;
				}
				case 7:
				{
						SendClientMessage(playerid,COLOR_SKYBLUE,"Radio Started.");
						PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=17399", 0, 0, 0, 0, 0);
						HideRadioTextdraws(playerid);
						Radio_on[playerid] = 1;
						return 0;
				}
				case 8:
				{
						SendClientMessage(playerid,COLOR_SKYBLUE,"Radio Started.");
						PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=17399", 0, 0, 0, 0, 0);
						HideRadioTextdraws(playerid);
						Radio_on[playerid] = 1;
						return 0;
				}
				case 9:
				{
						SendClientMessage(playerid,COLOR_SKYBLUE,"Radio Started.");
						PlayAudioStreamForPlayer(playerid, "http://itori.animenfo.com:443/listen.pls", 0, 0, 0, 0, 0);
						HideRadioTextdraws(playerid);
						Radio_on[playerid] = 1;
						return 0;
				}
				case 10:
				{
					if(Radio_on[playerid] == 0) { SendClientMessage(playerid,COLOR_SKYBLUE,"Radio is Already Off"); return 0; }
					if(Radio_on[playerid] == 1)
					{
						SendClientMessage(playerid,COLOR_SKYBLUE,"Radio Off.");
						StopAudioStreamForPlayer(playerid);
						HideRadioTextdraws(playerid);
						Radio_on[playerid] = 0;
						return 0;
					}

				}
				default :
				{
					SendClientMessage(playerid, COLOR_ERROR,"Invalid Selection.");
					return 0;
				}
			}
		}
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
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
	return 1;
}

public OnObjectMoved(objectid)
{
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

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
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
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys & KEY_FIRE) && (oldkeys & KEY_CROUCH) && !((oldkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) || (oldkeys & KEY_FIRE) && (newkeys & KEY_CROUCH) && !((newkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) ) {
        switch(GetPlayerWeapon(playerid)) {
		    case 23..25, 27, 29..34, 41: {
		        if(Ammo[playerid][GetPlayerWeapon(playerid)] > GetPlayerAmmo(playerid)) {
					OnPlayerCBug(playerid);
				}
				return 1;
			}
		}
	}

	if(CheckCrouch[playerid] == 1) {
		switch(WeaponID[playerid]) {
		    case 23..25, 27, 29..34, 41: {
		    	if((newkeys & KEY_CROUCH) && !((newkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK ) {
		    		if(Ammo[playerid][GetPlayerWeapon(playerid)] > GetPlayerAmmo(playerid)) {
						OnPlayerCBug(playerid);
					}
		    	}
		    }
		}
	}

	//if(newkeys & KEY_CROUCH || (oldkeys & KEY_CROUCH)) return 1;

	else if(((newkeys & KEY_FIRE) && (newkeys & KEY_HANDBRAKE) && !((newkeys & KEY_SPRINT) || (newkeys & KEY_JUMP))) ||
	(newkeys & KEY_FIRE) && !((newkeys & KEY_SPRINT) || (newkeys & KEY_JUMP)) ||
	(NotMoving[playerid] && (newkeys & KEY_FIRE) && (newkeys & KEY_HANDBRAKE)) ||
	(NotMoving[playerid] && (newkeys & KEY_FIRE)) ||
	(newkeys & KEY_FIRE) && (oldkeys & KEY_CROUCH) && !((oldkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) ||
	(oldkeys & KEY_FIRE) && (newkeys & KEY_CROUCH) && !((newkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) ) {
		SetTimerEx("CrouchCheck", 3000, 0, "d", playerid);
		CheckCrouch[playerid] = 1;
		WeaponID[playerid] = GetPlayerWeapon(playerid);
		Ammo[playerid][GetPlayerWeapon(playerid)] = GetPlayerAmmo(playerid);
		return 1;
	}

	//=== radio system===
	if (newkeys & KEY_FIRE)
    {
	   	if(Radio_viewing[playerid] == 1)
	   	{
	   		HideRadioTextdraws(playerid);
	   	}
    }
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
    new	string_3D[256];
	format(string_3D, sizeof(string_3D), "{FFFFFF}Ping: {FDE39D}%d\n{FFFFFF}FPS: {FDE39D}%d",GetPlayerPing(playerid), GetPlayerFPS(playerid));
	for(new i, j = GetMaxPlayers(); i != j; i++)
	{
		UpdatePlayer3DTextLabelText(i, Info[playerid], -1, string_3D);
	}

	new Keys, ud, lr;
	GetPlayerKeys(playerid, Keys, ud, lr);
	if(CheckCrouch[playerid] == 1) {
		switch(WeaponID[playerid]) {
		    case 23..25, 27, 29..34, 41: {
		    	if((Keys & KEY_CROUCH) && !((Keys & KEY_FIRE) || (Keys & KEY_HANDBRAKE)) && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK ) {
		    		if(Ammo[playerid][GetPlayerWeapon(playerid)] > GetPlayerAmmo(playerid)) {
						OnPlayerCBug(playerid);
					}
		    	}
		    	//else SendClientMessage(playerid, COLOR_RED, "Failed in onplayer update");
		    }
		}
	}

	if(!ud && !lr) { NotMoving[playerid] = 1; /*OnPlayerKeyStateChange(playerid, Keys, 0);*/ }
	else { NotMoving[playerid] = 0; /*OnPlayerKeyStateChange(playerid, Keys, 0);*/ }
	return 1;
}

forward OnPlayerCBug(playerid);
public OnPlayerCBug(playerid) {
	/*new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, sizeof(playername));
	new str2[128];
	format(str2, sizeof(str2), "Automatic system has kicked you for Crouch bugging with weapon (%s!)", aWeaponNames[WeaponID[playerid]]);
	SendClientMessage(playerid, COLOR_RED, str2);
	CheckCrouch[playerid] = 0;
	Kick(playerid);*/
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, sizeof(playername));
	new str2[128];
	format(str2, sizeof(str2), "Automatic system has slapped you for Crouch bugging with weapon (%s!)", aWeaponNames[WeaponID[playerid]]);
	SendClientMessageToAll(COLOR_RED, str2);
	new Float:Pos[3];
	GetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]);
	SetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]+2.5);
	PlayerPlaySound(playerid,1190,0.0,0.0,0.0);
	CheckCrouch[playerid] = 0;
	return 1;
}

forward CrouchCheck(playerid);
public CrouchCheck(playerid) {
	CheckCrouch[playerid] = 0;
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

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DIALOG_REGISTER:
	    {
			if(!response)
			    return Kick(playerid);

			new insert[256];

			if(strlen(inputtext) > 128 || strlen(inputtext) < 3)
			    return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration page", "{ffffff}Your password length should be in between {ff0000}3 - 128\nPlease enter a new password in the space given below:\nthank you!", "Register", "Close");

			mysql_format(ourConnection, insert, sizeof(insert), "INSERT INTO accounts (acc_name, acc_pass, register_ip, register_date) VALUES('%e', sha1('%e'), '%e', '%e')", ReturnName(playerid), inputtext, ReturnIP(playerid), ReturnDate());
			mysql_tquery(ourConnection, insert, "OnPlayerRegister", "i", playerid);
		}
		case DIALOG_LOGIN:
		{
		    if (!response)
			{
				SendClientMessage(playerid, COLOR_RED, "You were kicked for not logging in.");
				return KickEx(playerid);
			}

			new continueCheck[211];

			mysql_format(ourConnection, continueCheck, sizeof(continueCheck), "SELECT acc_dbid FROM accounts WHERE acc_name = '%e' AND acc_pass = sha1('%e') LIMIT 1", ReturnName(playerid), inputtext);

			mysql_tquery(ourConnection, continueCheck, "LoggingIn", "i", playerid);
			return 1;
		}
	}
    
    if(dialogid == DIALOG_DM)
	{
		if(response)
		{
            if(listitem == 0)
            {
				new string[128];
				if(dm[playerid] == 1 || dm[playerid] == 2 || dm[playerid] == 3 || dm[playerid] == 4) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500, 3);
				DDM(playerid);
				format(string, sizeof(string), "%s(%d) has joined the Deagle Deathmatch", GetName(playerid), playerid);
				SCMall(COLOR_BLUE, string);
	        }
            if(listitem == 1)
            {
            	new string[128];
				if(dm[playerid] == 3 || dm[playerid] == 2 || dm[playerid] == 1 || dm[playerid] == 4) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500,3);
				SOSDM(playerid);
				format(string, sizeof(string), "%s(%d) has joined the Sawn Off Shotgun Deathmatch", GetName(playerid), playerid);
				SCMall(COLOR_BLUE, string);
	        }
            if(listitem == 2)
            {
            	new string[128];
				if(dm[playerid] == 2 || dm[playerid] == 3 || dm[playerid] == 4 || dm[playerid] == 1) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500, 3);
				SDM(playerid);
				format(string, sizeof(string), "%s(%d) has joined the Sniper Deathmatch", GetName(playerid), playerid);
				SCMall(COLOR_BLUE, string);
	        }
	        if(listitem == 3)
	       	{
	       		new string[128];
				if(dm[playerid] == 4 || dm[playerid] == 3 || dm[playerid] == 2 || dm[playerid] == 1) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500,3);
				oneshot(playerid);
				format(string, sizeof(string), "%s(%d) has joined the One Shot Deathmatch (/oneshot)", GetName(playerid), playerid);
				SCMall(COLOR_BLUE, string);
	        }
	    }
    }
    if(dialogid == 5)
    {
        if(response == 1)
        {
            new string[128];
			DDM(playerid);
			format(string, sizeof(string), "%s(%d) has joined the Deagle Deathmatch", GetName(playerid), playerid);
	    	SCMall(COLOR_BLUE, string);
        }
        else if(response == 0)
        {
            SCM(playerid, COLOR_RED, "You have Chosen Not to enter inside Deagle Deathmatch");
        }
    }
    if(dialogid == 6)
    {
        if(response == 1)
        {
            new string[128];
			SDM(playerid);
			format(string, sizeof(string), "%s(%d) has joined the Sniper Deathmatch", GetName(playerid), playerid);
	    	SCMall(COLOR_BLUE, string);
        }
        else if(response == 0)
        {
            SCM(playerid, COLOR_RED, "You have Chosen Not to enter inside Sniper Deathmatch");
        }
    }
    if(dialogid == 7)
    {
        if(response == 1)
        {
            new string[128];
			SOSDM(playerid);
			format(string, sizeof(string), "%s(%d) has joined the Sawn off Shotgun Deathmatch", GetName(playerid), playerid);
	    	SCMall(COLOR_BLUE, string);
        }
        else if(response == 0)
        {
            SCM(playerid, COLOR_RED, "You have Chosen Not to enter inside Sawn off Shotgun Deathmatch");
        }
    }

	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerModelSelection(playerid, response, listid, modelid)
{
    if(listid == joinskin)
	{
	if(!response)
		return ShowModelSelectionMenu(playerid, joinskin, "please pick a skin you want to use");


	SetCameraBehindPlayer(playerid);
	SetPlayerSkin(playerid, modelid);
	SetSpawnInfo(playerid, 0, modelid, 223.0138,-1872.2523,4.4400,1.4446,0,0,0,0,0,0);
	SpawnPlayer(playerid);
	}
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	if(pickupid == ddmpickup)
	{
	    ShowPlayerDialog(playerid, 5, DIALOG_STYLE_MSGBOX, "Confirmation", "{ffffff}Are you sure you want to join {ff0000}Deagle Deathmatch ?", "Yes", "{ff0000}NO");

	}
	if(pickupid == sdmpickup)
	{
     	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_MSGBOX, "Confirmation", "{ffffff}Are you sure you want to join {ff0000}Sniper Deathmatch ?", "Yes", "{ff0000}No");
	}
	if(pickupid == sosdmpickup)
	{
	    ShowPlayerDialog(playerid, 7, DIALOG_STYLE_MSGBOX, "Confirmation", "{ffffff}Are you sure you want to join {ff0000}Sawn Off Shotgun Deathmatch ?", "Yes", "{ff0000}No");
	}

	return 1;
}

//================================ANTICHEAT RELATED STUFF=====================




//=================================Commands================================


CMD:pms(playerid,params[])
{
    if(pms[playerid] == 0)
    {
        pms[playerid] = 1;
        SCM(playerid, COLOR_CYAN, "Your PMS is set to ON");
    }
    else if(pms[playerid] == 1)
    {
        pms[playerid] = 0;
        SCM(playerid, COLOR_CYAN, "Your PMS is set OFF");
    }
    return 1;
}

CMD:pm(playerid, params[])
{
    new id, str[500], ip[16];
    
    if(sscanf(params, "us[500]", id, params))
 	{
		return SCM(playerid, COLOR_RED, "Usage: /pm [id] [text]");
	}
	
	if(id == INVALID_PLAYER_ID)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}
	
	if(pms[id] == 0)
	{
		return SCM(playerid, COLOR_RED, "Player has Disabled their pms");
	}
	
	if(pms[playerid] == 0)
	{
 		SCM(playerid,COLOR_RED, "You have disabled your pms");
		return SCM(playerid, COLOR_RED, "Type /pms to enable your pms");
	}
	
	GetPlayerIp(playerid, ip, sizeof(ip));
    format(str, sizeof(str), "PM to %s(%d): %s", GetName(id), id, params);
    SCM(playerid, COLOR_YELLOW, str);
    pPM[playerid] = id;
    pPM[id] = playerid;
    format(str, sizeof(str), "PM from %s(%d): %s", GetName(playerid), playerid, params);
    SCM(id, COLOR_YELLOWD, str);
    return 1;
}

CMD:r(playerid, params[])
{
    new str[128], ip[16],id = pPM[playerid];
    
    if(id == -1)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}
	
	if(!IsPlayerConnected(id))
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}

	GetPlayerIp(playerid, ip, sizeof(ip));
	
    if(IsPlayerConnected(id))
    {
        if(isnull(params))
		{
			return SCM(playerid, COLOR_RED, "Usage: /r (text)");
		}
	    format(str, sizeof(str), "PM to %s(%d): %s", GetName(id), id, params);
        SCM(playerid, COLOR_YELLOW, str);
        format(str, sizeof(str), "PM from %s(%d): %s", GetName(playerid), playerid, params);
        SCM(id, COLOR_YELLOWD, str);
    }
    else return SCM(playerid, COLOR_RED, "Player is not connected");
    return 1;
}

CMD:jetpack(playerid, params[])
{
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USEJETPACK);
	return 1;
}

CMD:kill(playerid, params[])
{
	SetPlayerHealth(playerid, 0);
	return 1;
}

CMD:skin(playerid, params[])
{
	new skinid;

	if(sscanf(params, "i", skinid))
	    return SCM(playerid, COLOR_RED, "Usage: /skin [ID]");

	if(skinid < 1 || skinid > 300)
	{
		return SCM(playerid, COLOR_RED, "Please choose a skin from 1 - 300");
	}

	SetPlayerSkin(playerid, skinid);

	return 1;
}

CMD:w(playerid, params[])
{
	new weaponid, ammo;

	if(sscanf(params, "ii", weaponid, ammo))
	    return SCM(playerid, COLOR_RED, "Usage: /w [ID], [AMMO]");

	if(weaponid < 1 || weaponid > 46 || weaponid == 18)
	    return SCM(playerid, COLOR_RED, "[SERVER]: You have specified a invalid weapon");

	if(ammo < 1)
	    return SCM(playerid, COLOR_RED, "[SERVER]: You have specified invalid ammo amount");

	GivePlayerWeapon(playerid, weaponid, ammo);

	SCM(playerid, COLOR_CYAN, "Enjoy your Weapon, prick");

	return 1;
}

CMD:arm(playerid, params[])
{
    new amount;

    if(sscanf(params, "i", amount))
        return SCM(playerid, COLOR_RED, "Usage: /arm [0-100]");

    if(amount < 0 || amount > 100)
        return SCM(playerid, COLOR_RED, "You have specified invalid amount");

    SetPlayerArmour(playerid, amount);

    SCM(playerid, COLOR_CYAN, "You have been given an armour");

    return 1;
}

CMD:v(playerid, params[])
{
	new vehicleid;
	new Float:X, Float:Y, Float:Z;

	GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);

	if(sscanf(params, "i", vehicleid))
	    return SCM(playerid, COLOR_RED, "Usage: /v [vehicle id 400-611]");

	if(vehicleid < 400 || vehicleid > 611)
	    return SCM(playerid, COLOR_RED, "[SERVER]: Invalid ID");

 	CreateVehicle(vehicleid, X, Y, Z, 2.0, 0, 0, 0, 0);

	SCMex(playerid, COLOR_CYAN, "You have Successfully spawned a vehicle (%i)", vehicleid);

	return 1;
}

CMD:help(playerid, params[])
{
    ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_LIST, "Click any following section to get help", "1) Account\n2) Rules\n3) VIP", "Select", "Close");

	return 1;
}

CMD:banshee(playerid,params[])
{
	new Float:X, Float:Y, Float:Z;

	GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
	CreateVehicle(429, X, Y, Z, 2.0, random(100), random(100), 0, 0);
	return 1;
}

//Admin related commands

CMD:setadmin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2 || IsPlayerAdmin(playerid))
	{
		new playerb, adminlvl, insert[128];

		if(sscanf(params, "ui", playerb, adminlvl))
	        return SCM(playerid, COLOR_RED, "Usage: /setadmin [id/name] [Level 1-2]");

        if(playerb == INVALID_PLAYER_ID)
			return SCM(playerid, COLOR_RED, "player is not connected");
		if(playerb == playerid)
			return SCM(playerid, COLOR_RED, "You cannot set yourself an admin level");

  		if(adminlvl < 1 || adminlvl > 2)
   			return SCM(playerid, COLOR_RED, "[SERVER]: Invalid Admin Level");

		SCMex(playerid, COLOR_CYAN, "You've just made %s admin level (%i)", ReturnName(playerb), adminlvl);
		SCMex(playerb, COLOR_CYAN, "You've just been made admin level (%i) by an Admin", adminlvl, ReturnName(playerid));

		PlayerInfo[playerb][pAdmin] = adminlvl;

		mysql_format(ourConnection, insert, sizeof(insert), "UPDATE accounts SET Admin = %i WHERE acc_dbid = %i", adminlvl, PlayerInfo[playerb][pDBID]);
		mysql_tquery(ourConnection, insert);
	}
	else return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");

	return 1;
}

CMD:radmin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2 || IsPlayerAdmin(playerid))
	{
		new playerb, insert[128];

		if(sscanf(params, "ui", playerb))
	        return SCM(playerid, COLOR_RED, "Usage: /radmin [id/name]");

        if(playerb == INVALID_PLAYER_ID)
			return SCM(playerid, COLOR_RED, "player is not connected");

		if(playerb == playerid)
			return SCM(playerid, COLOR_RED, "You cannot remove yourself as admin");

		SCMex(playerid, COLOR_CYAN, "You've just now removed admin permissions from %s", ReturnName(playerb));
		SCMex(playerb, COLOR_RED, "Admin permissions has been taken from you");

		mysql_format(ourConnection, insert, sizeof(insert), "UPDATE accounts SET Admin = 0 WHERE acc_dbid = %i", PlayerInfo[playerb][pDBID]);
		mysql_tquery(ourConnection, insert);
	}
	else return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");
	return 1;
}

CMD:aduty(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		if(aduty[playerid] == 1) 
		{	
			aduty[playerid] = 0;
			SetPlayerHealth(playerid,100.0);
			SetPlayerChatBubble(playerid," ",0xFF0000FF, 100.0, 1000);
			new string[128];
			format(string,sizeof(string),"{ff0000}[Administrator]%s is now off duty", ReturnName(playerid));
			SendClientMessageToAll(-1,string);
			return 1;
		}

		aduty[playerid] = 1;
		SetPlayerHealth(playerid,100000);
		SetPlayerChatBubble(playerid,"Administrator",-1,100.0,99999999);
		new string[128];
		format(string,sizeof(string),"{ff0000}[Administrator]%s is on duty", ReturnName(playerid));
		SendClientMessageToAll(-1,string);
	}

	else return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");

	return 1;
}

CMD:setap(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1)
	    return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");

	if(aduty[playerid] == 0)
	{
		return SCM(playerid, COLOR_RED,"You are not on admin duty");
	}

	new playerb, amount;

	if(sscanf(params, "ui", playerb, amount))
	    return SCM(playerid, COLOR_RED, "Usage: /setap [name/id] [amount 0-100]");
	    
    if(playerb == INVALID_PLAYER_ID)
		return GameTextForPlayer(playerid,"~g~player is not connected",4500,4);

	if(amount < 0 || amount > 100)
	    return SCM(playerid, COLOR_RED, "[SERVER]: Invalid armour amount");

	SCMex(playerid, COLOR_CYAN, "You've just given an armour to %s with an amount of ( %i )", ReturnName(playerb), amount);
	SCMex(playerb, COLOR_CYAN, "You've just been given an armour from admin with an amount of ( %i )", amount);

	SetPlayerArmour(playerb, amount);

	return 1;
}

CMD:agcash(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
	{
	    return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");
	}

	if(aduty[playerid] == 0)
	{
		return SCM(playerid, COLOR_RED,"You are not on admin duty");
	}

	new playerb, cash;

	if(sscanf(params, "ui", playerb, cash))
	{
		return SCM(playerid, COLOR_RED, "Usage: /agcash [name/id] [amount]");
	}
	
	if(playerb == INVALID_PLAYER_ID)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}

 	SCMex(playerid, COLOR_RED, "AdminCmd: You have given $%i cash to %s using admin cmd", cash, ReturnName(playerb));
 	SCMex(playerid, COLOR_CYAN, "AdminCmd: You have received $%i cash from an Admin", cash);

 	GivePlayerMoney(playerb, cash);
	return 1;
}

CMD:arcash(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
	{
	    return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");
	}

	if(aduty[playerid] == 0)
	{
		return SCM(playerid, COLOR_RED,"You are not on admin duty");
	}

	new playerb, cash;

	if(sscanf(params, "ui", playerb, cash))
	{
		return SCM(playerid, COLOR_RED, "Usage: /arcash [name/id] [amount]");
	}
	
	if(playerb == INVALID_PLAYER_ID)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}

 	SCMex(playerid, COLOR_RED, "AdminCmd: You have taken $%i cash from %s using admin cmd", cash, ReturnName(playerb));
 	SCMex(playerid, COLOR_CYAN, "AdminCmd: Your $%i cash has been taken from you from an Admin", cash);

 	GivePlayerMoney(playerb, - cash);
	return 1;
}

CMD:agscore(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
	{
	    return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");
	}

	if(aduty[playerid] == 0)
	{
		return SCM(playerid, COLOR_RED,"You are not on admin duty");
	}

	new playerb, score;
	new oscore = GetPlayerScore(playerid);

	if(sscanf(params, "ui", playerb, score))
	{
	    return SCM(playerid, COLOR_RED, "Usage: /agscore [name/id] [score 1 - 100000]");
	}
	
	if(playerb == INVALID_PLAYER_ID)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}
	
	if(score < 1 || score > 100000)
	{
	    return SCM(playerid, COLOR_RED, "You have put an invalid score");
	}

	SCMex(playerid, COLOR_RED, "AdminCmd: You have given %i score to %s using admin cmd", score, ReturnName(playerb));
	SCMex(playerid, COLOR_CYAN, "AdminCmd: You have been given %i score by an Admin", score);

	SetPlayerScore(playerb, oscore + score);
	return 1;
}

CMD:arscore(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
	{
	    return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");
	}

	if(aduty[playerid] == 0)
	{
		return SCM(playerid, COLOR_RED,"You are not on admin duty");
	}

	new playerb, score;
	new oscore = GetPlayerScore(playerid);
	
    if(sscanf(params, "ui", playerb, score))
	{
	    return SCM(playerid, COLOR_RED, "Usage: /arscore [name/id] [score 1 - 100000]");
	}
	
	if(playerb == INVALID_PLAYER_ID)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}
	
	if(score < 0  || score > 100000)
	{
	    return SCM(playerid, COLOR_RED, "You have put an invalid score");
	}

	SCMex(playerid, COLOR_RED, "AdminCmd: You have removed %i score from %s using admin cmd", score, ReturnName(playerb));
	SCMex(playerid, COLOR_CYAN, "AdminCmd: %i score has been removed from you by an Admin", score);

	SetPlayerScore(playerb, oscore - score);
	return 1;
}

CMD:kick(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1)
	    return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");

	if(aduty[playerid] == 0)
	{
		return SCM(playerid, COLOR_RED,"You are not on admin duty");
	}

	new playerb, reason[80];
	if(sscanf(params, "us[80]", playerb, reason))
	    return SCM(playerid, COLOR_RED, "Usage: /kick [id/name] [reason]");

    if(playerb == INVALID_PLAYER_ID)
		return SCM(playerid, COLOR_RED, "Player is not connected");

	SCMex(playerid, COLOR_CYAN, "You've just kicked %s Reason: %s", ReturnName(playerb), reason);
	SCMex(playerb, COLOR_RED, "You've just got kicked by an Admin");
	SCMex(playerb, COLOR_RED, "Reason: %s", reason);
	KickEx(playerb);
	return 1;
}

//Deathmatch related commands

CMD:ddm(playerid, params[])
{
	new string[128];
	if(dm[playerid] == 1 || dm[playerid] == 2 || dm[playerid] == 3 || dm[playerid] == 4) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500, 3);
	DDM(playerid);
	format(string, sizeof(string), "%s(%d) has joined the Deagle Deathmatch", GetName(playerid), playerid);
	SCMall(COLOR_BLUE, string);
	return 1;
}

CMD:sdm(playerid, params[])
{
	new string[128];
	if(dm[playerid] == 2 || dm[playerid] == 3 || dm[playerid] == 4 || dm[playerid] == 1) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500, 3);
	SDM(playerid);
	format(string, sizeof(string), "%s(%d) has joined the Sniper Deathmatch", GetName(playerid), playerid);
	SCMall(COLOR_BLUE, string);
	return 1;
}

CMD:sosdm(playerid, params[])
{
	new string[128];
	if(dm[playerid] == 3 || dm[playerid] == 2 || dm[playerid] == 1 || dm[playerid] == 4) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500,3);
	SOSDM(playerid);
	format(string, sizeof(string), "%s(%d) has joined the Sawn Off Shotgun Deathmatch", GetName(playerid), playerid);
	SCMall(COLOR_BLUE, string);
	return 1;
}

CMD:oneshot(playerid, param[])
{
	new string[128];
	if(dm[playerid] == 4 || dm[playerid] == 3 || dm[playerid] == 2 || dm[playerid] == 1) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500,3);
	oneshot(playerid);
	format(string, sizeof(string), "%s(%d) has joined the One Shot Deathmatch (/oneshot)", GetName(playerid), playerid);
	SCMall(COLOR_BLUE, string);
	return 1;
}

CMD:leavedm(playerid, params[])
{
	if(dm[playerid] == 0) return GameTextForPlayer(playerid,"~g~You are not in deathmatch", 4500, 3);
	LeaveDM(playerid);
	return 1;
}

CMD:dm(playerid, params[])
{
    new string[500];
    new ddm, sdm, sos, Oneshot;
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
		{
	        if(dm[i] == 1)
         	{
				ddm++;
			}
			if(dm[i] == 2)
			{
				sdm++;
			}
			if(dm[i] == 3)
			{
				sos++;
			}
			if(dm[i] == 4)
			{
				Oneshot++;
			}
		}
	}
	format(string,sizeof(string),
	"Maps\tPlayers\n\
	{fccf03}Deagle (/ddm)\t{5bc906}%d\n\
	{fc9803}Sawn-Off Shotgun (/sosdm)\t{5bc906}%d\n\
	{c606c9}Sniper (/sdm)\t{5bc906}%d\n\
	{ffffff}OneShot (/oneshot)\t{5bc906}%d",ddm,sos,sdm,Oneshot);
	ShowPlayerDialog(playerid, DIALOG_DM, DIALOG_STYLE_TABLIST_HEADERS, "Deathmatch",string, "Select","Cancel");

	return 1;
}

//==============================teleports=========================

CMD:ls(playerid, params[])
{
	SetPlayerPos(playerid, 1519.6636, -1679.0535, 12.8015);
	return 1;
}

CMD:lobby(playerid, params[])
{
	SetPlayerPos(playerid, 223.0138,-1872.2523,4.4400);
	return 1;
}

CMD:lvpd(playerid, params[])
{
	SetPlayerInterior(playerid, 3);
	SetPlayerPos(playerid, 288.745971,169.350997,1007.171875);
	return 1;
}

CMD:os(playerid, params[])
{
	SetPlayerInterior(playerid, 1);
	SetPlayerVirtualWorld(playerid, 10);
	SetPlayerPos(playerid, 2169.461181,1618.798339,999.976562);
	return 1;
}

//=============================Animations======================

CMD:handsup(playerid, params[])
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
	SCM(playerid, COLOR_GREY, "[SERVER]: To stop animation please use cmd (/sa) or press (F)");
	return 1;
}

CMD:dance(playerid, params[])
{
	new danceid;

	if(sscanf(params, "i", danceid))
	    return SCM(playerid, COLOR_RED, "Usage: /dance [1-4]");

	if(danceid == 1)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
		SCM(playerid, COLOR_GREY, "[SERVER]: To stop animation please use cmd (/sa) or press (F)");
		return 1;
	}
 	if(danceid == 2)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
		SCM(playerid, COLOR_GREY, "[SERVER]: To stop animation please use cmd (/sa) or press (F)");
		return 1;
	}

	if(danceid == 3)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
		SCM(playerid, COLOR_GREY, "[SERVER]: To stop animation please use cmd (/sa) or press (F)");
		return 1;
	}

	if(danceid == 4)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
		SCM(playerid, COLOR_GREY, "[SERVER]: To stop animation please use cmd (/sa) or press (F)");
		return 1;
	}

	if(danceid < 1 || danceid > 4)
	    return SCM(playerid, COLOR_RED, "Usage: /dance [1-4]");

	return 1;
}

CMD:sa(playerid, params[])
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	return 1;
}

// ==================================Stock Values============================

stock DDM(playerid)
{
    new str[100];
	format(str,sizeof(str),"%s(%d) joined the deagle deathmatch",GetName(playerid), playerid);
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
		{
			if(dm[i] == 1)
			{
			    SendClientMessage(i, COLOR_BLUE, str);
			}
		}
	}

	for(new i; i < 6; i++) //Just to avoid bugs
	{
	    DeletePlayer3DTextLabel(playerid, Info[playerid]);
	}
	Info[playerid] = CreatePlayer3DTextLabel(playerid, "Ping: 0\nFPS: 0", -1, 0.0, 0.0, 0.35, 30.0, playerid, INVALID_VEHICLE_ID, 0);

	new rand = random(sizeof(DERandomSpawn));
	dm[playerid] = 1;
	SetPlayerArmour(playerid, 100);
	SetPlayerHealth(playerid, 100);
	SetCameraBehindPlayer(playerid);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid, 1);
	SetPlayerVirtualWorld(playerid, 10);
	GivePlayerWeapon(playerid, 24, 999999);
	SetPlayerPos(playerid, DERandomSpawn[rand][0], DERandomSpawn[rand][1],DERandomSpawn[rand][2]);
	SetPlayerFacingAngle(playerid, DERandomSpawn[rand][3]);
	PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	GameTextForPlayer(playerid,"~w~/leavedm ~g~to exit",5000,1);
	return 1;
}

stock SDM(playerid)
{
    new str[100];
	format(str,sizeof(str),"%s(%d) joined the sniper deathmatch",GetName(playerid), playerid);
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
		{
			if(dm[i] == 2)
			{
			    SendClientMessage(i, COLOR_BLUE, str);
			}
		}
	}

	for(new i; i < 6; i++) //Just to avoid bugs
	{
	    DeletePlayer3DTextLabel(playerid, Info[playerid]);
	}
	Info[playerid] = CreatePlayer3DTextLabel(playerid, "Ping: 0\nFPS: 0", -1, 0.0, 0.0, 0.35, 30.0, playerid, INVALID_VEHICLE_ID, 0);

	new rand = random(sizeof(SDMRandomSpawn));
	dm[playerid] = 2;
	SetPlayerArmour(playerid, 100);
	SetPlayerHealth(playerid, 100);
	SetPlayerPos(playerid, SDMRandomSpawn[rand][0], SDMRandomSpawn[rand][1],SDMRandomSpawn[rand][2]);
	SetPlayerFacingAngle(playerid, SDMRandomSpawn[rand][3]);
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	SetPlayerInterior(playerid, 3);
	SetPlayerVirtualWorld(playerid, 11);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, 34, 999999);
	GameTextForPlayer(playerid,"~w~/leavedm ~g~to exit",5000,1);
	return 1;
}

stock SOSDM(playerid)
{
    new str[100];
	format(str,sizeof(str),"%s(%d) joined the sawn-off shotgun deathmatch",GetName(playerid), playerid);
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
		{
			if(dm[i] == 3)
			{
			    SendClientMessage(i, COLOR_BLUE, str);
			}
		}
	}

	for(new i; i < 6; i++) //Just to avoid bugs
	{
	    DeletePlayer3DTextLabel(playerid, Info[playerid]);
	}
	Info[playerid] = CreatePlayer3DTextLabel(playerid, "Ping: 0\nFPS: 0", -1, 0.0, 0.0, 0.35, 30.0, playerid, INVALID_VEHICLE_ID, 0);

	new rand = random(sizeof(SOSRandomSpawn));
	dm[playerid] = 3;
	SetPlayerHealth(playerid, 100);
	SetPlayerArmour(playerid, 100);
	SetPlayerPos(playerid, SOSRandomSpawn[rand][0], SOSRandomSpawn[rand][1],SOSRandomSpawn[rand][2]);
	SetPlayerFacingAngle(playerid, SOSRandomSpawn[rand][3]);
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	SetPlayerInterior(playerid, 1);
	SetPlayerVirtualWorld(playerid, 12);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, 26, 999999);
	GameTextForPlayer(playerid,"~w~/leavedm ~g~to exit",5000,1);
	return 1;
}

stock oneshot(playerid)
{
    new str[100];
	format(str,sizeof(str),"%s(%d) joined the One Shot Deathmatch (/oneshot)",GetName(playerid), playerid);
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
		{
			if(dm[i] == 4)
			{
			    SendClientMessage(i, COLOR_BLUE, str);
			}
		}
	}

	for(new i; i < 6; i++) //Just to avoid bugs
	{
	    DeletePlayer3DTextLabel(playerid, Info[playerid]);
	}
	Info[playerid] = CreatePlayer3DTextLabel(playerid, "Ping: 0\nFPS: 0", -1, 0.0, 0.0, 0.35, 30.0, playerid, INVALID_VEHICLE_ID, 0);

	new rand = random(sizeof(ONESHOTRandomSpawn));
	dm[playerid] = 4;
	SetPlayerHealth(playerid, 20);
	SetCameraBehindPlayer(playerid);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid, 1);
	SetPlayerVirtualWorld(playerid, 11);
	GivePlayerWeapon(playerid, 24, 999999);
	SetPlayerPos(playerid, ONESHOTRandomSpawn[rand][0], ONESHOTRandomSpawn[rand][1],ONESHOTRandomSpawn[rand][2]);
	SetPlayerFacingAngle(playerid, ONESHOTRandomSpawn[rand][3]);
	PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	GameTextForPlayer(playerid,"~w~/leavedm ~g~to exit",5000,1);
	return 1;
}

stock LeaveDM(playerid)
{
    new str[100];
	format(str,sizeof(str),"{d6311c}%s(%d) has left the deathmatch",GetName(playerid), playerid);
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
		{
			if(dm[i] >= 1)
			{
			    SendClientMessage(i, COLOR_BLUE, str);
			}
		}
	}

	for(new i; i < 6; i++)
	{
	    DeletePlayer3DTextLabel(playerid, Info[playerid]);
	}

	dm[playerid] = 0;
	SetPlayerHealth(playerid, 100);
	SetPlayerArmour(playerid, 0);
	PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	ResetPlayerWeapons(playerid);
	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 223.0138,-1872.2523,4.4400,1.4446,0,0,0,0,0,0);
	SpawnPlayer(playerid);
	return 1;
}

stock GetPlayerFPS(playerid)
{
	SetPVarInt(playerid, "DrunkL", GetPlayerDrunkLevel(playerid));
	if(GetPVarInt(playerid, "DrunkL") < 100) SetPlayerDrunkLevel(playerid, 2000);
	else
	{
		if(GetPVarInt(playerid, "LDrunkL") != GetPVarInt(playerid, "DrunkL"))
		{
			SetPVarInt(playerid, "FPS", (GetPVarInt(playerid, "LDrunkL") - GetPVarInt(playerid, "DrunkL")));
			SetPVarInt(playerid, "LDrunkL", GetPVarInt(playerid, "DrunkL"));
			if((GetPVarInt(playerid, "FPS") > 0) && (GetPVarInt(playerid, "FPS") < 256)) return GetPVarInt(playerid, "FPS") - 1;
		}
	}
	return 0;
}

stock ReturnName(playerid, underScore = 1)
{
	new playersName[MAX_PLAYER_NAME + 2];
	GetPlayerName(playerid, playersName, sizeof(playersName));

	if(!underScore)
	{
		{
			for(new i = 0, j = strlen(playersName); i < j; i ++)
			{
				if(playersName[i] == '_')
				{
					playersName[i] = ' ';
				}
			}
		}
	}

	return playersName;
}

stock ReturnIP(playerid)
{
	new
		ipAddress[20];

	GetPlayerIp(playerid, ipAddress, sizeof(ipAddress));
	return ipAddress;
}

stock ReturnDate()
{
	new sendString[90], MonthStr[40], month, day, year;
	new hour, minute, second;

	gettime(hour, minute, second);
	getdate(year, month, day);
	switch(month)
	{
	    case 1:  MonthStr = "January";
	    case 2:  MonthStr = "February";
	    case 3:  MonthStr = "March";
	    case 4:  MonthStr = "April";
	    case 5:  MonthStr = "May";
	    case 6:  MonthStr = "June";
	    case 7:  MonthStr = "July";
	    case 8:  MonthStr = "August";
	    case 9:  MonthStr = "September";
	    case 10: MonthStr = "October";
	    case 11: MonthStr = "November";
	    case 12: MonthStr = "December";
	}

	format(sendString, 90, "%s %d, %d %02d:%02d:%02d", MonthStr, day, year, hour, minute, second);
	return sendString;
}

stock KickEx(playerid)
{
	return SetTimerEx("KickTimer", 100, false, "i", playerid);
}

stock SendClientMessageEx(playerid, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[156]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 156
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		SendClientMessage(playerid, color, string);

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}
	return SendClientMessage(playerid, color, str);
}

stock ReturnVehicleName(vehicleid)
{
	new
		model = GetVehicleModel(vehicleid),
		name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}


//===================Functions===========

function:SetPlayerCamera(playerid)
{

	new rand = random(4);

	switch(rand)
	{

	    case 0:
	    {
	        SetPlayerCameraPos(playerid, -2813.0288, -197.5183, 47.1108);
			SetPlayerCameraLookAt(playerid, -2812.4990, -198.3723, 47.0508);
	    }
		case 1:
		{
		    SetPlayerCameraPos(playerid, -2598.4858, 1435.8639, 108.1429);
			SetPlayerCameraLookAt(playerid, -2598.7920, 1436.8192, 108.1929);
		}
		case 2:
		{
		    SetPlayerCameraPos(playerid, 2055.3882, 1182.9683, 66.7956);
			SetPlayerCameraLookAt(playerid, 2056.2783, 1182.4999, 66.7205);
		}
		case 3:
		{
		    SetPlayerCameraPos(playerid, 1388.1973, -955.0184, 92.0558);
			SetPlayerCameraLookAt(playerid, 1388.3502, -954.0233, 92.0557);
		}

	}

	return 1;
}

function:ResetPlayer(playerid)
{
	PlayerLogin[playerid] = 0;
	PlayerInfo[playerid][pDBID] = 0;
    PlayerInfo[playerid][pLoggedin] = false;
    PlayerInfo[playerid][pSkin] = 0;
    PlayerInfo[playerid][pAdmin] = 0;
    PlayerInfo[playerid][pCash] = 0;
    PlayerInfo[playerid][pScore] = 0;

    return 1;
}

function:LogPlayerIn(playerid)
{

	new rows, fields;
	cache_get_data(rows, fields, ourConnection);
	SetPlayerCamera(playerid);
	if(!rows)
	{
	    SCMex(playerid, COLOR_YELLOW, "The user (%s) you're connected with isn't registered", ReturnName(playerid));
	    SCMex(playerid, COLOR_YELLOW, "Please register in order to continue");

        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Welcome to Zone's DM server", "{ffffff}It seems that you are not {ff0000}Registered {ffffff}so kindly please register yourself by entering a new password \nin the space given below:\nthank you!\n\n", "Register", "Close");
		return 1;
	}

	SCMex(playerid, COLOR_YELLOW, "Welcome to Zones DM server!");
	ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Welcome to Zone's DM server", "{ffffff}It seems that you already have an account, so kindly please {ff0000}Login {ffffff}by entering your \npassword in the given section below:\nThank you!\n\n", "Login", "Close");
	return 1;
}

function:OnPlayerRegister(playerid)
{
	PlayerInfo[playerid][pDBID] = cache_insert_id();
	format(PlayerInfo[playerid][pAccName], 32, "%s", ReturnName(playerid));

	new thread[128];

	mysql_format(ourConnection, thread, sizeof(thread), "SELECT * FROM accounts WHERE acc_name = '%e'", ReturnName(playerid));
	mysql_tquery(ourConnection, thread, "Query_LoadAccount", "i", playerid);

	PlayerInfo[playerid][pLoggedin] = true;
}

function:LoggingIn(playerid)
{
	SetPlayerCamera(playerid);
	if(!cache_num_rows())
	{
	    PlayerLogin[playerid]++;
        if(PlayerLogin[playerid] == 3)
		{
			SCM(playerid, COLOR_RED, "[SERVER]: You were kicked for bad password attempts.");
			return KickEx(playerid);
		}
		return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Welcome to Zone's DM server", "{ffffff}You entered the {ff0000}wrong {ffffff}password!\nPlease try again and enter your password in the space given below:\nthank you!", "Login", "Cancel");
	}

    new thread[128];

	mysql_format(ourConnection, thread, sizeof(thread), "SELECT * FROM accounts WHERE acc_name = '%e'", ReturnName(playerid));
	mysql_tquery(ourConnection, thread, "Query_LoadAccount", "i", playerid);

    PlayerInfo[playerid][pDBID] = cache_insert_id();
	format(PlayerInfo[playerid][pAccName], 32, "%s", ReturnName(playerid));

	PlayerInfo[playerid][pLoggedin] = true;
	return 1;
}

function:Query_LoadAccount(playerid)
{
	PlayerInfo[playerid][pAdmin] = cache_get_field_content_int(0, "Admin", ourConnection);
    PlayerInfo[playerid][pDBID] = cache_get_field_content_int(0, "acc_dbid", ourConnection);
    PlayerInfo[playerid][pCash] = cache_get_field_content_int(0, "Cash", ourConnection), GivePlayerMoney(playerid, PlayerInfo[playerid][pCash]);
	PlayerInfo[playerid][pScore] = cache_get_field_content_int(0, "Score", ourConnection), SetPlayerScore(playerid, PlayerInfo[playerid][pScore]);
	PlayerInfo[playerid][pSkin] = cache_get_field_content_int(0, "Skin", ourConnection), SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 223.0138,-1872.2523,4.4400,1.4446,0,0,0,0,0,0), SpawnPlayer(playerid);
	return 1;
}

function:KickTimer(playerid) 
{ 
	return Kick(playerid); 
}

//=====RADIO SCRIPT======

CMD:radio(playerid)
{
	HideRadioTextdraws(playerid);
 	TextDrawShowForPlayer(playerid,Radio[0]);
 	TextDrawShowForPlayer(playerid,Radio[1]);
	TextDrawShowForPlayer(playerid,Radio[2]);
	TextDrawShowForPlayer(playerid,Radio[3]);
	Radio_viewing[playerid] =1;
	return 1;
}
stock isNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
    return 1;
}
//====ends=====
