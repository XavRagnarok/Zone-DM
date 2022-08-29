#include <a_samp>
#include <streamer>

#define FILTERSCRIPT

public OnFilterScriptInit()
{
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

new God[MAX_PLAYERS],
Text3D:GodMode[MAX_PLAYERS];

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp("/god", cmdtext, true, 10) == 0)
	{
		if(God[playerid] == 0)
		{
			SetPlayerHealth(playerid, 99999);
			GameTextForPlayer(playerid,"~g~God mode ~w~on",4500,3);
			God[playerid] = 1;
			GodMode[playerid] = CreateDynamic3DTextLabel("{00FF00}[God Mode]", -1, 0.0, 0.0, -0.9, 20, playerid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 25.0);
		}
		else if(God[playerid] == 1)
		{
			SetPlayerHealth(playerid, 100);
			GameTextForPlayer(playerid,"~g~God mode ~w~off",4500,3);
			God[playerid] = 0;
			DestroyDynamic3DTextLabel(GodMode[playerid]);
		}
		return 1;
	}
	
	if(strcmp("/godmoded", cmdtext, true, 10) == 0)
	{
		new str[200], str2[200];
		for(new i=0; i < MAX_PLAYERS; i++)
		{
		    if(IsPlayerConnected(i))
		    {
				if(God[i] == 1)
				{
				    format(str, sizeof(str), "%s(%d)\n", GetName(i), i);
				    strcat(str2, str);
				}
				else SendClientMessage(playerid, 0xFFFFFFFF, "There are no players using godmod");
			}
		}
		ShowPlayerDialog(playerid, 10000, DIALOG_STYLE_MSGBOX, "God Moded Players", str2, "OK", "");
		return 1;
	}
	return 0;
}

public OnPlayerGiveDamage(playerid, damagedid)
{
	if(God[damagedid] == 1) return GameTextForPlayer(playerid,"~g~Player has god mode",4500,3);
	return 1;
}

public OnPlayerSpawn(playerid) //Just to avoid bugs
{
	if(God[playerid] == 1)
	{
	    SetPlayerHealth(playerid, 99999);
	}
	return 1;
}

stock GetName(playerid)
{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, Name, sizeof(Name));
	return Name;
}
