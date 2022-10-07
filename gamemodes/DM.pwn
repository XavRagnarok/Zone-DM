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
#include <bcrypt>




#define COLOR_WHITE (0xffffffFF)
#define COLOR_RED (0xdb1a1aFF)
#define COLOR_BLUE (0x2265d8FF)
#define COLOR_YELLOW (0xdfe52eFF)
#define COLOR_YELLOWD (0xc0c52cFF)
#define COLOR_CYAN (0x1fe0ddFF)
#define COL_GREEN (0x00FF00FF)
#define COLOR_GREY (0xa8a8a3FF)
#define COLOR_ERROR 0xFF8282FF

#define SCM SendClientMessage
#define function:%0(%1) forward %0(%1); public %0(%1)
#define SCMex SendClientMessageEx
#define SCMall SendClientMessageToAll

#define SERVER_NAME "Savline RPG"

new pms[MAX_PLAYERS],
pPM[MAX_PLAYERS];

//=========================Dynamic pickups================

new ddmpickup;
new sdmpickup;
new sosdmpickup;

//================================Dialogs==================
enum //Always use some kind of structure for Dialog IDs.
{
	DIALOG_REGISTER,
	DIALOG_LOGIN,
 	DIALOG_HELP, 
	DIALOG_ACCOUNT, 
	DIALOG_DM,
	DIALOG_CONFIRMDDM, 
	DIALOG_CONFIRMSDM, 
	DIALOG_CONFIRMSOSDM
};


//================MySQL Connection:=========================

#define DB_HOST "localhost" //IP of your host. In case of using it on same pc, use localhost or 127.0.0.1
#define DB_NAME "zonedm" //Name of Database you are gonna use.. I have used login, but change it according to your needs.
#define DB_USER "root" //User name of your MySQL client.
#define DB_PASS "" //Password of your MySQL client.

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

enum e_playerInfo
{
	pMasterID,
	bool:pLoggedIn,
	pCash,
	pSkin,
	pScore,
	pAdmin,
	pPassFailed,
	pKicked
};
new PlayerInfo[MAX_PLAYERS][e_playerInfo];

new MySQL:handle; //This connection handle of data type MySQL is required to carry out Mysql operations.

main()
{
	printf("Login Script Loaded");
}

// =====================REGISTER/LOGGING STUFF===================

new joinskin = mS_INVALID_LISTID;

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
//===============================================================


public OnGameModeInit()
{
    DisableInteriorEnterExits();

    // SQL related

    handle = mysql_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);
	
	if(mysql_errno(handle) == 0) printf("[MYSQL] Connection successful"); //returns number of errors. 0 means no errors..
	else
	{
	    new error[100];
	    mysql_error(error, sizeof(error), handle);
		printf("[MySQL] Connection Failed : %s", error);
	}

	// ===

 	SetGameModeText("friends zone");

 	ddmpickup = CreateDynamicPickup(1318, 2, 238.7231,-1882.8654,4.4767, -1, -1, -1, 100.0, -1, 0);

 	CreateDynamic3DTextLabel("Press ~k~~VEHICLE_ENTER_EXIT~", -1, 238.7231,-1882.8654,4.4767, 5.0, -1, -1, 1, -1, -1, -1, 5.0);

 	sdmpickup = CreateDynamicPickup(1318, 2, 236.1373,-1882.9423,4.4698, -1, -1, -1, 100.0, -1, 0);

    CreateDynamic3DTextLabel("Press ~k~~VEHICLE_ENTER_EXIT~", -1, 236.1373,-1882.9423,4.4698, 5.0, -1, -1, 1, -1, -1, -1, 5.0);

	sosdmpickup = CreateDynamicPickup(1318, 2, 233.6071,-1883.0021,4.4685, -1, -1, -1, 100.0, -1, 0);

    CreateDynamic3DTextLabel("Press ~k~~VEHICLE_ENTER_EXIT~", -1, 233.6071,-1883.0021,4.4685, 5.0, -1, -1, 1, -1, -1, -1, 5.0);

	return 1;
}

public OnGameModeExit()
{
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pLoggedIn]) SavePlayerData(i);
	}
	mysql_close(handle);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 0;
}

public OnPlayerConnect(playerid)
{
	{
		new line[124];
		format(line, sizeof(line), "{a8a8a3}%s(%d) has joined the server",GetName(playerid),playerid);
		SendClientMessageToAll(0xFFFFFFFF, line);
	}
    SetPlayerCamera(playerid);
	dm[playerid] = 0;
	Streak[playerid] = 0;

	ResetPlayerInfo(playerid);

	{
		new query[64];
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pname, sizeof(pname));
		mysql_format(handle, query, sizeof(query), "SELECT COUNT(Name) from `users` where Name = '%s' ", pname);
		mysql_tquery(handle, query, "OnPlayerJoin", "d", playerid);
	}
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
		if(PlayerInfo[playerid][pLoggedIn]){
		SavePlayerData(playerid);
		}
	
		PlayerInfo[playerid][pLoggedIn] = false;
		ResetPlayerInfo(playerid);
	}
	{
		dm[playerid] = 0;
		Streak[playerid] = 0;
		for(new i; i < 6; i++)
		{
	    	DeletePlayer3DTextLabel(playerid, Info[playerid]);
		}
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
			if(response)
			{
			    bcrypt_hash(inputtext, 12, "OnPassHash", "d", playerid);
			}
			else Kick(playerid);
		}
		
		case DIALOG_LOGIN:
		{
			if(response)
			{
				new query[128], pname[MAX_PLAYER_NAME];
				GetPlayerName(playerid, pname, sizeof(pname));
    			SetPVarString(playerid, "Unhashed_Pass",inputtext);
				mysql_format(handle, query, sizeof(query), "SELECT password, Master_ID from `users` WHERE Name = '%s'", pname);
				mysql_tquery(handle, query, "OnPlayerLogin", "d", playerid);
			}
			else Kick(playerid);
		}
	}
	if(dialogid == DIALOG_HELP)
	{
	    if(response)
	    {
	    	if(listitem == 0)
	    	{
	        	return ShowPlayerDialog(playerid, DIALOG_ACCOUNT, DIALOG_STYLE_MSGBOX, "Account info", "UnderConstruction", "Close", "");
	    	}
	    }
	}

    if(dialogid == DIALOG_DM)
	{
		if(response)
		{
            if(listitem == 0)
            {
				DDM(playerid);
	        }
            if(listitem == 1)
            {
				SOSDM(playerid);
	        }
            if(listitem == 2)
            {
				SDM(playerid);
	        }
	    }
    }

    if(dialogid == DIALOG_DM)
	{
		if(response)
		{
            if(listitem == 0)
            {
				DDM(playerid);
	        }
            if(listitem == 1)
            {
				SOSDM(playerid);
	        }
            if(listitem == 2)
            {
				SDM(playerid);
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
	PlayerInfo[playerid][pSkin] = modelid;
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

//Admin related commands

/*
CMD:setadmin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2 || IsPlayerAdmin(playerid))
	{
		new playerb, adminlvl, insert[128];

		if(sscanf(params, "ui", playerb, adminlvl))
	        return SCM(playerid, COLOR_RED, "Usage: /setadmin [id/name] [Level 1-2]");

        if(playerb == INVALID_PLAYER_ID)
			return GameTextForPlayer(playerid,"~g~player is not connected",4500,4);

  		if(adminlvl < 0 || adminlvl > 2)
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
*/
CMD:setap(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1)
	    return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");

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
	if(dm[playerid] == 1 || dm[playerid] == 2 || dm[playerid] == 3) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500, 3);
	DDM(playerid);
	format(string, sizeof(string), "%s(%d) has joined the Deagle Deathmatch", GetName(playerid), playerid);
	SCMall(COLOR_BLUE, string);
	return 1;
}

CMD:sdm(playerid, params[])
{
	new string[128];
	if(dm[playerid] == 2 || dm[playerid] == 3 || dm[playerid] == 1) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500, 3);
	SDM(playerid);
	format(string, sizeof(string), "%s(%d) has joined the Sniper Deathmatch", GetName(playerid), playerid);
	SCMall(COLOR_BLUE, string);
	return 1;
}

CMD:sosdm(playerid, params[])
{
	new string[128];
	if(dm[playerid] == 3 || dm[playerid] == 2 || dm[playerid] == 1) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500,3);
	SOSDM(playerid);
	format(string, sizeof(string), "%s(%d) has joined the Sawn Off Shotgun Deathmatch", GetName(playerid), playerid);
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
    new ddm, sdm, sos;
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
		}
	}
	format(string,sizeof(string),
	"Maps\tPlayers\n\
	{fccf03}Deagle (/ddm)\t{5bc906}%d\n\
	{fc9803}Sawn-Off Shotgun (/sosdm)\t{5bc906}%d\n\
	{c606c9}Sniper (/sdm)\t{5bc906}%d",ddm,sos,sdm);
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

//=============================Animations======================

CMD:handsup(playerid, params[])
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
	SCM(playerid, COLOR_CYAN, "[SERVER]: To stop animation please use cmd (/sa) or press (F)");
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
		SCM(playerid, COLOR_CYAN, "[SERVER]: To stop animation please use cmd (/sa) or press (F)");
		return 1;
	}
 	if(danceid == 2)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
		SCM(playerid, COLOR_CYAN, "[SERVER]: To stop animation please use cmd (/sa) or press (F)");
		return 1;
	}

	if(danceid == 3)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
		SCM(playerid, COLOR_CYAN, "[SERVER]: To stop animation please use cmd (/sa) or press (F)");
		return 1;
	}

	if(danceid == 4)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
		SCM(playerid, COLOR_CYAN, "[SERVER]: To stop animation please use cmd (/sa) or press (F)");
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

SavePlayerData(playerid)
{
	new query[256], pname[MAX_PLAYER_NAME];
 	GetPlayerName(playerid, pname, sizeof(pname));
	mysql_format(handle, query, sizeof(query), "UPDATE `users` set Skin = %d, Score = %d WHERE Master_ID = %d", PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pScore], PlayerInfo[playerid][pMasterID]);
	mysql_query(handle, query);
	printf("Saved %s's data", pname);
	return 1;
}

forward OnPlayerJoin(playerid);
public OnPlayerJoin(playerid)
{
	ResetPlayerInfo(playerid);

	InterpolateCameraPos(playerid, 1332.7262, -1071.3055, 83.0842, 1383.8170, -909.1896, 74.4843, 10000);
	InterpolateCameraLookAt(playerid, 1333.0266, -1070.3523, 83.0337, 1384.1174, -908.2363, 74.4337, 10000);


	if(cache_num_rows()){
		new loginstr[200];
		format(loginstr, sizeof(loginstr), "{FFFFFF}Wazzup, {00FF22}%s{FFFFFF}! You have already registered on our server.\n{FFFFFF}Simply type your password below in order to login.", GetPlayerNameEx(playerid));
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, SERVER_NAME, loginstr, "Login", "Quit");
	}
	else
	{
		new registerstr[200];
		format(registerstr, sizeof(registerstr), "{FFFFFF}Welcome, {00FF22}%s{FFFFFF}! It looks like you are new here.\n{00FF22}Simply type your password below in order to register.", GetPlayerNameEx(playerid));
		
		if(strfind(GetPlayerNameEx(playerid), "_") == -1) {
			SendClientMessage(playerid, COLOR_ERROR, "Your name must be formatted as Firstname_Lastname. Please rejoin with a acceptable name");
			KickPlayer(playerid);
		}
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, SERVER_NAME, registerstr, "Register", "Quit");
	}
	return 1;
}
forward OnPlayerRegister(playerid);
public OnPlayerRegister(playerid)
{
	SendClientMessage(playerid, 0x0033FFFF /*Blue*/, "Thank you for registering! You can now Login");
    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Thank you for registering! You can now Login with\npassword you just used to register.", "Login", "Quit");
	return 1;
}
forward OnPlayerLogin(playerid);
public OnPlayerLogin(playerid)
{
	new pPass[255], unhashed_pass[128];
	GetPVarString(playerid, "Unhashed_Pass",unhashed_pass,sizeof(unhashed_pass));
	if(cache_num_rows())
	{
		cache_get_value_index(0, 0, pPass);
		cache_get_value_index_int(0, 1, PlayerInfo[playerid][pMasterID]);
		bcrypt_check(unhashed_pass, pPass, "OnPassCheck", "dd",playerid, PlayerInfo[playerid][pMasterID]);
  	}
    else printf("ERROR ");
	return 1;
}
forward OnPassHash(playerid);
public OnPassHash(playerid)
{
	new pass[BCRYPT_HASH_LENGTH], query[256], pname[MAX_PLAYER_NAME], pipadress[16];
    GetPlayerIp(playerid, pipadress, sizeof(pipadress));
    GetPlayerName(playerid, pname, sizeof(pname));
    bcrypt_get_hash(pass);
	print("On Pass Hash");
    mysql_format(handle, query, sizeof(query), "INSERT INTO users (Name, Password, RegisteredIP, Register_Timestamp) VALUES ('%e', '%e', '%e', %i);", pname, pass, pipadress);
	mysql_tquery(handle, query, "OnPlayerRegister", "d", playerid);
	return 1;
}

forward OnPassCheck(playerid, DBID);
public OnPassCheck(playerid, DBID)
{
    if(bcrypt_is_equal())
	{
		new query[128];
		mysql_format(handle, query, sizeof(query), "SELECT * FROM users WHERE Master_ID = %d;", DBID);
		mysql_tquery(handle, query, "SetPlayerInfo", "i", playerid);
	}
	else
	{
		if(PlayerInfo[playerid][pPassFailed] >= 3)
		{
			KickPlayer(playerid);
		}

		PlayerInfo[playerid][pPassFailed]++;
		SendClientMessageEx(playerid, COLOR_ERROR, "You have %i/3 login attempts remaining", PlayerInfo[playerid][pPassFailed]);

		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, SERVER_NAME, "{FF2121}You entered an incorrect password!\n{FFFFFF}You have already registered to {00FF22}"SERVER_NAME"{FFFFFF}!\n{FFFFFF}Simply type your password below in order to login.", "Login", "Quit");
	}
	return 1;
}
forward SetPlayerInfo(playerid);
public SetPlayerInfo(playerid)
{
	cache_get_value_index_int(0, 4, PlayerInfo[playerid][pSkin]);
	cache_get_value_index_int(0, 5, PlayerInfo[playerid][pScore]);
	
	PlayerInfo[playerid][pLoggedIn] = true;
	
	SetPlayerScore(playerid, PlayerInfo[playerid][pScore]);
	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 223.0138, -1872.2523, 4.4400, 1.4446 , 0, 0, 0, 0, 0, 0);
	TogglePlayerSpectating(playerid, false);
	TogglePlayerControllable(playerid, true);
	new name[MAX_PLAYER_NAME], str[80];
	GetPlayerName(playerid, name, sizeof(name));
	format(str, sizeof(str), "{00FF22}Welcome to the server, {FFFFFF}%s", name);
	SendClientMessage(playerid, -1, str);
	DeletePVar(playerid, "Unhashed_Pass");
	SpawnPlayer(playerid);
	return 1;
}

ResetPlayerInfo(playerid)
{
	PlayerInfo[playerid][pMasterID] = 0;
	PlayerInfo[playerid][pSkin] = 0;
	PlayerInfo[playerid][pScore] = 0;

	PlayerInfo[playerid][pPassFailed] = 0;
	PlayerInfo[playerid][pKicked] = 0;

	return 1;
}

function:KickTimer(playerid) { return Kick(playerid); }

GetPlayerNameEx(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

forward KickPlayer(playerid);
public KickPlayer(playerid)
{
	if(!PlayerInfo[playerid][pKicked])
	{
	    PlayerInfo[playerid][pKicked] = 1;
	    SetTimerEx("KickPlayer", 500, false, "i", playerid);
	}
	else
	{
	    PlayerInfo[playerid][pKicked] = 0;
	    Kick(playerid);
	}
}

