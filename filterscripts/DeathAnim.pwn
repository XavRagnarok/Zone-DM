#include <a_samp>
#include <zcmd>

#define FILTERSCRIPT
forward Death(playerid);

public OnFilterScriptInit()
{
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public Death(playerid)
{
	SpawnPlayer(playerid);
	SetPlayerHealth(playerid, 100);
	return 1;
}

public OnPlayerUpdate(playerid)
{
	new Float:Health;
	GetPlayerHealth(playerid, Health);
	if(Health <= 5)
	{
        ApplyAnimation(playerid, "PED", "KO_shot_stom", 4.1, 1, 1, 1, 1, 1, 1);
	    SetTimerEx("Death", 3170, false, "i", playerid);
	}
	return 1;
}
