#if defined _functions_included
	#endinput
#endif
#define _functions_included

#include <a_samp>

/*
native Teleport(playerid, Float:x, Float:y, Float:z, Float:FacingAngle, world, interior, showmessage, const message[], style, sound, camreset, telemessage, const tele name[], const tele command[])
native RemovePlayerWeapon(playerid, weaponid)
native ChatLog(playerid, text[])
native GetIp(playerid)
native GetName(playerid)
native LineContainsIp(string[])
native SetPlayerPosEx(playerid, Float:x, Float:y, Float:z, Float:angle)
native Heal(playerid)
native Armour(playerid)
native Kill(playerid)
native  GodMode(playerid, toggle)
native Crash(playerid)
native Drop(playerid)
native KickAll(playerid)
native Freeze(playerid, toggle)
native Slap(playerid)
native Explode(playerid)
native Disarm(playerid)
native RestartServer()
native GMX()
native LockServer(password[])
native VehicleEngine(vehicleid, toggle)
native VehicleDoors(vehicleid, toggle)
native Teleport(playerid, Float:x, Float:y, Float:z, Float:FacingAngle, world, interior, showmessage, message[], style, sound, camreset, telemessage, telename[], telecommand[])
native ClearChat(playerid, lines)
*/

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
		GivePlayerWeapon(playerid, plyWeapons[slot], plyAmmo[slot]);
	}
}


stock ChatLog(playerid, text[])
{
	 new
	 File:lFile = fopen("Chat Log.txt", io_append),
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

stock GetIp(playerid)
{
    new ip[MAX_PLAYER_NAME];
    GetPlayerIp(playerid, ip, sizeof(ip));
    return ip;
}

stock GetName(playerid)
{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, Name, sizeof(Name));
	return Name;
}

stock LineContainsIp(string[])
{
    new Count;
    for(new i; string[i] != EOS; ++i)
    {
        if(('0' <= string[i] <= '9') || string[i] == '.' || string[i] == ':')
        {
            if((string[i] == '.') && (string[i + 1] != '.') && ('0' <= string[i - 1] <= '9'))
            {
                ++Count;
            }
            continue;
        }
    }
    return (Count > 2);
}

stock SetPlayerPosEx(playerid, Float:x, Float:y, Float:z, Float:angle)
{
    SetPlayerPos(playerid , x , y ,z);
    SetPlayerFacingAngle(playerid, angle);
    return 1;
}

stock Heal(playerid)
{
	SetPlayerHealth(playerid, 100);
	return 1;
}

stock Armour(playerid)
{
	SetPlayerArmour(playerid, 100);
	return 1;
}

stock Kill(playerid)
{
	SetPlayerHealth(playerid, 0);
	return 1;
}

stock GodMode(playerid, toggle)
{
	if(toggle == true)
	{
		ResetPlayerWeapons(playerid);
	    SetPlayerHealth(playerid, 999999);
	}
	else if(toggle == false)
	{
		SetPlayerHealth(playerid, 100);
	}
	return 1;
}

stock Crash(playerid)
{
    new Interior, string[50];
    Interior = GetPlayerInterior(id), SetPlayerInterior(id, Interior), SetPlayerInterior(id, 5), SetPlayerVirtualWorld(id, 5);
    GameTextForPlayer(playerid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 1000, 0);
    GameTextForPlayer(playerid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 2000, 1);
	GameTextForPlayer(playerid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 3000, 2);
	GameTextForPlayer(playerid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 4000, 3);
	GameTextForPlayer(playerid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 4);
	GameTextForPlayer(playerid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 6000, 5);
	GameTextForPlayer(playerid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 7000, 6);
	GameTextForPlayer(playerid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 12000, 6);
	format(string, sizeof(string), "  [CRASH] Crashed Player : %s(%d)", GetName(playerid), playerid);
	print(string);
	return 1;
}

stock Drop(playerid, height)
{
        new Float:x, Float:y, Float:z, id, height;
	GetPlayerPos(id, x, y, z);
	SetPlayerPos(id, x, y, z + height);
	return 1;
}

stock KickAll()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		Kick(i);
	}
	return 1;
}

stock Freeze(playerid, toggle)
{
	if(toggle == true)
	{
	    TogglePlayerControllable(playerid, false);
	}
	else if(toggle == false)
	{
	    TogglePlayerControllable(playerid, true);
	}
	return 1;
}

stock Slap(playerid)
{
	new Float:x, Float:y, Float:z, Float:Health;
	GetPlayerPos(id, x, y, z);
	GetPlayerHealth(id, Health);
	SetPlayerHealth(id, Health-25);
	SetPlayerPos(id, x, y, z+5);
	return 1;
}

stock Explode(playerid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(id, x, y, z);
	CreateExplosion(x, y, z, 7, 1.00);
	return 1;
}

stock Disarm(playerid)
{
	ResetPlayerWeapons(playerid);
	return 1;
}

stock RestartServer()
{
	SendRconCommand("gmx");
}

stock GMX()
{
	SendRconCommand("gmx");
}

stock LockServer(password[])
{
	new str[50];
	format(str,sizeof(str),"password %s", password);
	SendRconCommand(str);
}

stock VehicleEngine(vehicleid, toggle)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
	if(toggle == true)
	{
        GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
        SetVehicleParamsEx(vehicleid,true,lights,alarm,doors,bonnet,boot,objective);
	}
	else if(toggle == false)
	{
        GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
        SetVehicleParamsEx(vehicleid,false,lights,alarm,doors,bonnet,boot,objective);
	}
}

stock VehicleDoors(vehicleid, toggle)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
	if(toggle == true)
	{
        GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
        SetVehicleParamsEx(vehicleid,engine,lights,alarm,true,bonnet,boot,objective);
	}
	else if(toggle == false)
	{
        GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
        SetVehicleParamsEx(vehicleid,engine,lights,alarm,false,bonnet,boot,objective);
	}
}

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

stock ClearChat(playerid, lines)
{
	if(lines == 0) lines = 50;
	for (new i = 0; i < lines; i++)
	{
		SendClientMessage(playerid, 0xFFFFFFFF, " ");
	}
}
