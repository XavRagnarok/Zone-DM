#include <a_samp>
#include <sscanf>

#define FILTERSCRIPT

public OnFilterScriptInit()
{
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

CreatePlayerVehicle(playerid, modelid)
{
    if(GetPlayerInterior(playerid) > 0) return 0;
    new vehicle, Float:x, Float:y, Float:z, Float:angle;
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        vehicle = GetPlayerVehicleID(playerid);
        GetVehiclePos(vehicle, x, y, z);
        GetVehicleZAngle(vehicle, angle);
        DestroyVehicle(vehicle);
    }
    else if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        GetPlayerPos(playerid,x,y,z);
        GetPlayerFacingAngle(playerid,angle);
    }
    vehicle = CreateVehicle(modelid, x, y, z+1, angle, -1, -1, 60);
    LinkVehicleToInterior(vehicle, GetPlayerInterior(playerid));
    SetVehicleVirtualWorld(vehicle, GetPlayerVirtualWorld(playerid));
    PutPlayerInVehicle(playerid, vehicle, 0);
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/v", cmdtext, true, 10) == 0)
	{
		new vehicleid;
        if(sscanf(cmdtext, "u", vehicleid)) return GameTextForPlayer(playerid, "~g~/v~w~~n~(vehicle id)",4500,3);
		CreatePlayerVehicle(playerid, vehicleid);
		return 1;
	}
	return 0;
}
