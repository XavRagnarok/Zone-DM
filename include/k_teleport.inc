#if defined _k_teleport_included
	#endinput
#endif
#define _k_teleport_included

#include <a_samp>

stock GetName(playerid)
{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, Name, sizeof(Name));
	return Name;
}

/*
native Teleport(playerid, Float:x, Float:y, Float:z, Float:FacingAngle, world, interior, showmessage, const message[], style, sound, camreset, telemessage, const tele name[], const tele command[])
*/
stock Teleport(playerid, Float:x, Float:y, Float:z, Float:FacingAngle, world, interior, showmessage, message[], style, sound, camreset, telemessage, telename[], telecommand[])
{
	if(IsPlayerInAnyVehicle(playerid))
	{
	    SetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), FacingAngle);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid), interior);
		SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), world);
	}
	else
	{
		SetPlayerInterior(playerid, interior);
		SetPlayerVirtualWorld(playerid, world);
		SetPlayerPos(playerid, x ,y, z);
		SetPlayerFacingAngle(playerid, FacingAngle);
	}
	if(camreset == 1)
	{
	    SetCameraBehindPlayer(playerid);
	}
	if(telemessage == 1)
	{
		new str[100];
	    format(str, sizeof(str), "%s has teleported to %s (%s)", GetName(playerid), telename, telecommand);
	    SendClientMessageToAll(TeleMessageColor, str);
	}
	if(showmessage == 1)
	{
	    GameTextForPlayer(playerid, message, 2300, style);
	}
	if(sound == 1)
	{
	    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	}
	return 1;
}
