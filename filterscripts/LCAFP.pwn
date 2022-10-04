#define FILTERSCRIPT
 
#include <a_samp>
#include <ZCMD>
#include <foreach>
#include <sscanf2>
 
#define GREEN 0x33ff33ff
#define COLOR_RED 0xFF0000FF
 
 
public OnFilterScriptInit()
{
    print("\n--------------------------------------");
    print("    Command Pack FilterScript Loaded    ");
    print("--------------------------------------\n");
    return 1;
}
 
stock GetName(playerid)
{
    new playerName[MAX_PLAYER_NAME];
 
    GetPlayerName(playerid, playerName, sizeof(playerName));
 
    return playerName;
}
 
new pms[MAX_PLAYERS],
pPM[MAX_PLAYERS];
 
public OnFilterScriptExit()
{
    return 1;
}
 
public OnPlayerConnect(playerid)
{
    new str[250];
    format(str, sizeof(str), "%s(%d) has joined the server", GetName(playerid),playerid);
    SendClientMessageToAll(GREEN, str);
    return 1;
}
 
public OnPlayerDisconnect(playerid, reason)
{
    new str[250];
    switch(reason)
    {
        case 0: format(str, sizeof(str), "%s(%d) has left the server (Lost Connection)", GetName(playerid), playerid);
        case 1: format(str, sizeof(str), "%s(%d) has left the server (Leaving)", GetName(playerid), playerid);
        case 2: format(str, sizeof(str), "%s(%d) has left the server (Kicked/Banned)", GetName(playerid), playerid);
    }
    return 1;
}
 
public OnPlayerSpawn(playerid)
{
    return 1;
}
 
public OnPlayerDeath(playerid, killerid, reason)
{
    SendDeathMessage(killerid, playerid, reason);
    if(killerid == INVALID_PLAYER_ID) return GameTextForPlayer(playerid,"Wasted", 6000, 2);
    return 1;
}
 
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
    new str[250],str2[250],str3[250];
    format(str, sizeof(str),"%s(%d) just poked %s(%d)",GetName(playerid),playerid,GetName(clickedplayerid),clickedplayerid);
    SendClientMessageToAll(GREEN, str);
 
    format(str2, sizeof(str2),"%s(%d) poked you",GetName(playerid), playerid);
    SendClientMessage(clickedplayerid, GREEN, str2);
   
    format(str3, sizeof(str3),"You just poked %s(%d)",GetName(clickedplayerid), clickedplayerid);
    SendClientMessage(playerid, GREEN, str3);
    return 1;
}
 
CMD:go(playerid, params[])
{
    new str[128], id,Float:x, Float:y, Float:z;
    {
        if(sscanf(params, "u", id)) return GameTextForPlayer(playerid,"~g~/go~w~~n~(id)",4500,4);
        if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid,"~g~player is not connected",4500,4);
        if(GetPlayerState(id) == PLAYER_STATE_WASTED) return GameTextForPlayer(playerid,"~g~player is not spawned",4500,3);
        GetPlayerPos(id, x, y, z);
        format(str, sizeof(str), "You have teleported to %s (/go)", GetName(id));
        SendClientMessage(playerid, GREEN, str);
        format(str, sizeof(str), "%s(%d) has teleported to you (/go)", GetName(playerid), playerid);
        SendClientMessage(id, GREEN, str);
        SetPlayerInterior(playerid, GetPlayerInterior(id));
        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
        if(GetPlayerState(playerid) == 2)
        {
            SetVehiclePos(GetPlayerVehicleID(playerid), x+3, y, z);
            LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(id));
            SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetPlayerVirtualWorld(id));
        }
        else SetPlayerPos(playerid, x+2, y, z+3);
    }
    return 1;
}
 
CMD:pms(playerid,params[])
{
    if(pms[playerid] == 0)
    {
        pms[playerid] = 1;
        GameTextForPlayer(playerid,"~g~Personal messages ~w~on",4500,3);
    }
    else if(pms[playerid] == 1)
    {
        pms[playerid] = 0;
        GameTextForPlayer(playerid,"~g~Personal messages ~w~off",4500,3);
    }
    return 1;
}
 
CMD:pm(playerid, params[])
{
    new id, str[500], ip[16];
    if(sscanf(params, "us[500]", id, params)) return GameTextForPlayer(playerid,"~g~/pm [id] [text]",4500,3);
    if(id == INVALID_PLAYER_ID) return GameTextForPlayer(playerid,"~g~Player is not connected",4500,3);
    if(pms[id] == 0) return GameTextForPlayer(playerid,"~g~Player has ~w~Disabled ~g~their pms",4500,3);
    if(pms[playerid] == 0) return GameTextForPlayer(playerid,"~g~You have ~w~ disabled ~g~your pms~n~~w~type /pms to enable pms",4500,3);
    GetPlayerIp(playerid, ip, sizeof(ip));
    format(str, sizeof(str), "PM to %s(%d): %s", GetName(id), id, params);
    SendClientMessage(playerid, COLOR_RED, str);
    pPM[playerid] = id;
    pPM[id] = playerid;
    format(str, sizeof(str), "PM from %s(%d): %s", GetName(playerid), playerid, params);
    SendClientMessage(id, COLOR_RED, str);
    return 1;
}
 
CMD:r(playerid, params[])
{
    new str[128], ip[16],id = pPM[playerid];
    if(id == -1) return GameTextForPlayer(playerid,"~g~Player is not connected",4500,3);
    if(!IsPlayerConnected(id)) return GameTextForPlayer(playerid,"~g~Player is not connected",4500,3);
    GetPlayerIp(playerid, ip, sizeof(ip));
    if(IsPlayerConnected(id))
    {
        if(isnull(params)) return GameTextForPlayer(playerid,"~g~/r ~n~~w~(text)",4500,3);
        format(str, sizeof(str), "PM to %s(%d): %s", GetName(id), id, params);
        SendClientMessage(playerid, COLOR_RED, str);
        format(str, sizeof(str), "PM from %s(%d): %s", GetName(playerid), playerid, params);
        SendClientMessage(id, COLOR_RED, str);
    }
    else return GameTextForPlayer(playerid,"~g~Player is not connected",4500,3);
    return 1;
}
 
CMD:lock(playerid,params[])
{
            new engine, lights, alarm, doors, bonnet, boot, objective;
            new vehicleid = GetPlayerVehicleID(playerid);
            if(IsPlayerInAnyVehicle(playerid))
            {
                    if(GetPlayerVehicleSeat(playerid) == 0)
                    {
                        GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
                        if(doors == 1)
                        {
                            GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
                            SetVehicleParamsEx(vehicleid,engine,lights,alarm,false,bonnet,boot,objective);
                            GameTextForPlayer(playerid,"Vehicle ~w~Unlocked",2000,6);
                            return 1;
                        }
                        else
                        SetVehicleParamsEx(vehicleid,engine,lights,alarm,true,bonnet,boot,objective);
                        GameTextForPlayer(playerid,"~g~Vehicle ~w~Locked",4500,3);
                    }
                    else GameTextForPlayer(playerid,"~g~you need to drive a vehicle",4500,3);
            }
            else
            GameTextForPlayer(playerid,"~g~you need to drive a vehicle",4500,3);
            return 1;
}
 
CMD:hydraulics(playerid, params[])
{
    if(!IsPlayerInAnyVehicle(playerid)) return GameTextForPlayer(playerid,"~g~you need to drive a vehicle",4500,3);
    if(GetVehicleComponentInSlot(GetPlayerVehicleID(playerid),GetVehicleComponentType(1087)) != 1087)
    {
        AddVehicleComponent(GetPlayerVehicleID(playerid), 1087);
        GameTextForPlayer(playerid,"~g~hydraulics ~w~added",4500,3);
    }
    else if(GetVehicleComponentInSlot(GetPlayerVehicleID(playerid),GetVehicleComponentType(1087)) == 1087)
    {
        RemoveVehicleComponent(GetPlayerVehicleID(playerid),1087);
        GameTextForPlayer(playerid,"~g~hydraulics ~w~removed",4500,3);
    }
    return 1;
}
 
CMD:dive(playerid,params[])
{
    new hight;
    new Float:x,Float:y,Float:z;
    GetPlayerPos(playerid,x,y,z);
    if(sscanf(params,"i",hight))
    {
        SetPlayerPos(playerid, x, y, z+1000);
        GivePlayerWeapon(playerid, 46, 1);
        GameTextForPlayer(playerid,"~g~Skydive", 4500, 3);
    }
    else
    {
        SetPlayerPos(playerid,x,y,z+hight);
        if(hight >= 10)
        {
            GameTextForPlayer(playerid,"~g~Skydive",4500,3);
        }
    }
    return 1;
}
