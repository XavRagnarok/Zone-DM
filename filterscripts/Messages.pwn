#include <a_samp>
#include <ZCMD>
#include <sscanf2>
//===============================(DEFINES)======================================
#define FILTERSCRIPT
//-------------------------------(Config)---------------------------------------

#define CONNECT_MESSAGES_COLOR 0xFFFFFFFF
#define DISCONNECT_MESSAGES_COLOR 0xFFFFFFFF

//--------------------------------(Colors)--------------------------------------

#define COL_WHITE "{FFFFFF}"
#define COL_GREEN "{00FF00}"

#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xFF0000FF
#define COLOR_AQUA 0x00FFFFFF

//==================================(STOCKS)====================================

stock GetName(playerid)
{
	new Name[50];
	GetPlayerName(playerid, Name, sizeof(Name));
	return Name;
}

//==================================(VARIABLES)=================================

new VehicleNames[212][] = {
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
VehicleModel[MAX_PLAYERS],
Pms[MAX_PLAYERS],
Pm[MAX_PLAYERS];

//===============================(PUBLIC FUNCTIONS)=============================

public OnFilterScriptInit()
{
	print("Stunt Filterscript Loaded");
	return 1;
}

public OnFilterScriptExit()
{
	print("Stunt Filterscript Unloaded");
	return 1;
}

public OnPlayerConnect(playerid)
{
	new str[64];
	format(str, sizeof(str),"%s(%d) has connected to the server (Ping: %i)",GetName(playerid), playerid, GetPlayerPing(playerid));
	SendClientMessageToAll(CONNECT_MESSAGES_COLOR, str);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new str[64],
    DisconnectReason[3][] =
    {
        "Timeout/Crash",
        "Leaving",
        "Kicked/Banned"
    };

    format(str, sizeof(str), "%s left the server (%s).", GetName(playerid), DisconnectReason[reason]);
    SendClientMessageToAll(DISCONNECT_MESSAGES_COLOR, str);
    return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new str[50], str2[50];
	SendDeathMessage(killerid, playerid, reason);
	format(str, sizeof(str),"You killed ~n~~w~%s~n~~n~~g~+1 Score", GetName(playerid));
	GameTextForPlayer(killerid, str, 4500, 3);
	SetPlayerScore(playerid, GetPlayerScore(playerid) + 1);

	format(str2, sizeof(str2),"You got killed by ~n~~w~%s", GetName(killerid));
	GameTextForPlayer(playerid, str, 4500, 3);
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	GameTextForPlayer(killerid,"~r~You have destroyed a vehicle", 4500,3);
	return 1;
}

public OnPlayerText(playerid, text[])
{
    new aText[128],
    ChatBubble[MAX_CHATBUBBLE_LENGTH+1];
    format(aText, sizeof(aText), "{%06x}%s(%d):(FFFFFF) %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text);
    format(ChatBubble, MAX_CHATBUBBLE_LENGTH, "%s", text);
    SetPlayerChatBubble(playerid, ChatBubble, COLOR_WHITE, 35.0,10000);
    SendClientMessageToAll(COLOR_WHITE, aText);
    return 0;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
        if(!success)
	{
	    GameTextForPlayer(playerid, "~w~Unknown Command",4500,3);
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	    new string[32];
	    VehicleModel[playerid] = GetVehicleModel(vehicleid);
	    format(string,sizeof(string),"~g~%s",VehicleNames[VehicleModel[playerid]-400]);
	    GameTextForPlayer(playerid,string,2000,1);
	    return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	GameTextForPlayer(playerid, "~g~Vehicle Exit", 1500, 3);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
	    new string[32];
	    VehicleModel[playerid] = GetVehicleModel(GetPlayerVehicleID(playerid));
	    format(string,sizeof(string),"~g~%s",VehicleNames[VehicleModel[playerid]-400]);
	    GameTextForPlayer(playerid,string,2000,1);
        return 1;
    }
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	SendClientMessage(playerid, COLOR_AQUA, "Vehicle Modded");
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	SendClientMessage(playerid, COLOR_AQUA, "Vehicle Painted");
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	SendClientMessage(playerid, COLOR_AQUA, "Vehicle Resprayed");
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	if(!success)
	{
		new fip[20];
        for(new i = GetPlayerPoolSize(); i != -1; --i)
        {
            GetPlayerIp(i, fip, sizeof(fip));
            if(!strcmp(ip, fip, true))
            {
                SendClientMessage(i, COLOR_RED,"Don't try to login as rcon admin if you dont know the password,or you will be banned.");
            }
        }
	}
	return 0;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	new str[50], str2[50];
	format(str, sizeof(str),"You poked %s(%d)",GetName(clickedplayerid), clickedplayerid);
	SendClientMessage(playerid, COLOR_GREEN, str);
	format(str2, sizeof(str2),"You got poked by %s(%d)",GetName(playerid),playerid);
	SendClientMessage(clickedplayerid, COLOR_GREEN, str);
	return 1;
}

//================================(COMMANDS)====================================

CMD:pms(playerid,params[])
{
	if(Pms[playerid] == 0)
	{
	    Pms[playerid] = 1;
        GameTextForPlayer(playerid,"~g~Personal messages ~w~on",4500,3);
    }
    else if(Pms[playerid] == 1)
    {
        Pms[playerid] = 0;
        GameTextForPlayer(playerid,"~g~Personal messages ~w~off",4500,3);
    }
    return 1;
}

CMD:pm(playerid, params[])
{
	new id, str[128];
	if(sscanf(params, "us[128]", id, params)) return GameTextForPlayer(playerid,"~g~/pm [id] [text]",4500,3);
	if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid,"~g~Player is not connected",4500,3);
        if(Pms[id] == 0) return GameTextForPlayer(playerid,"~g~Player has ~w~Disabled ~g~their pms",4500,3);
        if(Pms[playerid] == 0) return GameTextForPlayer(playerid,"~g~You have ~w~ disabled ~g~pms~n~~w~type /pms to enable pms",4500,3);
	format(str, sizeof(str), "PM to %s(%d): %s", GetName(id), id, params);
	SendClientMessage(playerid, COLOR_RED, str);
        Pm[playerid] = id;
        Pm[id] = playerid;
	format(str, sizeof(str), "PM from %s(%d): %s", GetName(playerid), playerid, params);
	SendClientMessage(id, COLOR_RED, str);
	SendClientMessage(id, COLOR_RED,"/r to reply");
	return 1;
}

CMD:r(playerid, params[])
{
    new str[128],id = Pm[playerid];
    if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid,"~g~Player is not connected",4500,3);
    if(!IsPlayerConnected(id)) return GameTextForPlayer(playerid,"~g~Player is not connected",4500,3);
    if(isnull(params)) return GameTextForPlayer(playerid,"~g~/r ~n~~w~(text)",4500,3);
    format(str, sizeof(str), "PM to %s(%d): %s", GetName(id), id, params);
    SendClientMessage(playerid, COLOR_RED, str);
    format(str, sizeof(str), "PM from %s(%d): %s", GetName(playerid), playerid, params);
    SendClientMessage(id, COLOR_RED, str);
    return 1;
}

CMD:announce(playerid,params[])
{
  new text[60];
  if(IsPlayerAdmin(playerid))
  {
	  if(sscanf(params,"s[60]",text)) return GameTextForPlayer(playerid,"~g~/announce~n~~w~(text)",4500,3);
	  GameTextForAll(text,3000,5);
  }
  return 1;
}
