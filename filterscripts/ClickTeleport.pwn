#include <a_samp> 

#define FILTERSCRIPT 

public OnFilterScriptInit() 
{ 
    return 1; 
} 

public OnFilterScriptExit() 
{ 
    return 1; 
} 

public OnPlayerClickPlayer(playerid, clickedplayerid, source) 
{ 
    new Float:x, Float:y, Float:z; 
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
    { 
        if(GetPlayerInterior(clickedplayerid) >= 1) return SendClientMessage(playerid, 0xFFFFFFFF, "You can teleport to a player inside an interior with a vehicle"); 
        if(clickedplayerid == playerid) return 0; 
        new str[150], vehicleid = GetPlayerVehicleID(playerid); 
        GetPlayerPos(clickedplayerid, x, y, z); 
        SetVehiclePos(vehicleid, x, y, z); 
        LinkVehicleToInterior(vehicleid, GetPlayerInterior(clickedplayerid)); 
        SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(clickedplayerid)); 
        format(str, sizeof(str),"You have teleported to %s(%d)", GetName(clickedplayerid), clickedplayerid); 
        SendClientMessage(playerid, 0xFFFFFFFF, str); 
    } 
    else 
    { 
        new str[150]; 
        GetPlayerPos(clickedplayerid, x, y, z); 
        SetPlayerPos(playerid, x, y, z); 
        SetPlayerInterior(playerid, GetPlayerInterior(clickedplayerid)); 
        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(clickedplayerid)); 
        format(str, sizeof(str),"You have teleported to %s(%d)", GetName(clickedplayerid), clickedplayerid); 
        SendClientMessage(playerid, 0xFFFFFFFF, str); 
    } 
    return 1; 
} 

stock GetName(playerid) 
{ 
    new Name[MAX_PLAYER_NAME]; 
    GetPlayerName(playerid, Name, sizeof(Name)); 
    return Name; 
}  
