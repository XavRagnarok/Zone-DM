#include <a_samp>

#define FILTERSCRIPT

forward KickPlayer(playerid);

public OnFilterScriptInit()
{
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	if(vehicleid == 520 || vehicleid == 432 || vehicleid == 425) return DestroyVehicle(vehicleid);
	return 1;
}

public KickPlayer(playerid)
{
	Kick(playerid);
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if(GetPlayerVehicleID(playerid) == 520 || GetPlayerVehicleID(playerid) == 432 || GetPlayerVehicleID(playerid) == 425)
		{
			SendClientMessage(playerid, 0xFFFFFFFF, "You have been kicked (Reason: Using forbidden vehicle");
			SetTimerEx("KickPlayer", 1000, false, "i", playerid);
		}
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	if(!success)
	{
        new playerip[16];
        for(new i=0; i<MAX_PLAYERS; i++)
        {
            GetPlayerIp(i, playerip, sizeof(playerip));
            if(!strcmp(ip, playerip, true))
            {
                Ban(i);
            }
		}
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(GetPlayerWeapon(playerid) == 35 || GetPlayerWeapon(playerid) == 36 || GetPlayerWeapon(playerid) == 38)
	{
			SendClientMessage(playerid, 0xFFFFFFFF, "You have been kicked (Reason: Weapon hack");
			SetTimerEx("KickPlayer", 1000, false, "i", playerid);
	}
	if(GetPlayerSpecialAction(playerid) == 2)
	{
			SendClientMessage(playerid, 0xFFFFFFFF, "You have been kicked (Reason: Using jetpack");
			SetTimerEx("KickPlayer", 1000, false, "i", playerid);
	}
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	new Float:Health;
	GetPlayerHealth(playerid, Health);
	if(Health == 100)
	{
			SendClientMessage(playerid, 0xFFFFFFFF, "You have been kicked (Reason: Health hack");
			SetTimerEx("KickPlayer", 1000, false, "i", playerid);
	}
	return 1;
}
