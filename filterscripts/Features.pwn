#include <a_samp>

#define FILTERSCRIPT

public OnFilterScriptInit()
{
	print("  FilterScript Loaded");
	return 1;
}

public OnFilterScriptExit()
{
    print("  FilterScript UnLoaded");
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid == INVALID_PLAYER_ID)
	{
		GameTextForPlayer(playerid,"Wasted",6000,2);
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	if(killerid != INVALID_PLAYER_ID)
	{
		SendClientMessage(killerid, 0xFFFFFF, "You destroyed a vehicle");
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
    SetVehicleParamsEx(vehicleid,true,lights,alarm,doors,bonnet,boot,objective);
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
    SetVehicleParamsEx(vehicleid,false,lights,alarm,doors,bonnet,boot,objective);
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
    PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
    PlayerPlaySound(playerid,1134,0.0,0.0,0.0);
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
    PlayerPlaySound(playerid,1134,0.0,0.0,0.0);
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	if(!success)
	{
		printf("Failed Rcon Login Attempt From IP: %s", ip);
		printf("Entered Password: %s", password);
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	new str[150],str2[150], str3[150];

	format(str, sizeof(str),"%s(%d) poked you", GetName(playerid), playerid);
	format(str2, sizeof(str2),"You poked %s(%d)", GetName(clickedplayerid), clickedplayerid);
	format(str3, sizeof(str3),"%s(%d) poked %s(%d)", GetName(playerid), playerid, GetName(clickedplayerid), clickedplayerid);
	
	SendClientMessage(clickedplayerid, 0xFFFFFF, str);
	SendClientMessage(playerid, 0xFFFFFF, str2);
	
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(i != playerid && i != INVALID_PLAYER_ID)
		{
			SendClientMessage(i, 0xFFFFFF, str3);
		}
	}
	return 1;
}

stock GetName(playerid)
{
	new playerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playerName, sizeof(playerName));
	return playerName;
}
