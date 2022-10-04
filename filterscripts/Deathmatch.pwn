#include <a_samp>
#include <ZCMD>
#include <foreach>
#include <k_functions>

#define FILTERSCRIPT

#define COL_WHITE  "{FFFFFF}"
#define COL_GREEN "{00FF00}"

#define COLOR_RED 0xFF0000FF
#define COLOR_BLUE 0x0000BBAA

new dm[MAX_PLAYERS];
new Streak[MAX_PLAYERS];
new Hitsound[MAX_PLAYERS];
new PlayerText3D:Info[MAX_PLAYERS];

new Float:DERandomSpawn[][4] =
{
    {1412.6399,-1.7875,1000.9244,95.5046},
    {1412.7356,-42.7349,1000.9214,89.5512},
    {1363.8529,-42.1017,1000.9207,270.9495},
    {1367.4900,-1.9307,1000.9219,268.4427}
};

new Float:SDMRandomSpawn[][4] =
{
    {2227.2725,-1150.5098,1029.7969,357.4864},
    {2236.0046,-1158.0759,1029.7969,269.7291},
    {2247.8481,-1181.2086,1031.7969,177.2949},
    {2235.8110,-1168.4479,1029.7969,269.3925}
};

new Float:SOSRandomSpawn[][4] =
{
    {1412.6399,-1.7875,1000.9244,92.5395},
    {1413.1160,-44.3621,1000.9224,88.4661},
    {1361.5558,-44.6068,1000.9238,271.7444},
    {1361.5341,-0.1599,1000.9219,265.7913}
};

public OnFilterScriptInit()
{
	print("  Deathmatch Filterscript Loaded");
	return 1;
}

public OnFilterScriptExit()
{
	print("  Deathmatch Filterscript UnLoaded");
	return 1;
}

public OnPlayerConnect(playerid)
{
	dm[playerid] = 0;
	Streak[playerid] = 0;
	Hitsound[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	dm[playerid] = 0;
	Streak[playerid] = 0;
	Hitsound[playerid] = 0;
	for(new i; i < 6; i++)
	{
	    DeletePlayer3DTextLabel(playerid, Info[playerid]);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(dm[playerid] == 1)
	{
		DDM(playerid);
	}
	if(dm[playerid] == 2)
	{
		SDM(playerid);
	}
	if(dm[playerid] == 3)
	{
		SOSDM(playerid);
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(dm[killerid] >= 1)
	{
		new str[200];
		format(str, sizeof(str), "~r~You killed~n~%s~n~~r~1 Score", GetName(playerid));
		GameTextForPlayer(playerid, str, 4500, 3);
		SetPlayerScore(playerid, GetPlayerScore(playerid) + 1);
		PlayerPlaySound(killerid, 17802, 0.0, 0.0, 0.0);
		Streak[playerid] = 0;
		
		if(Streak[killerid] != 8)
		{
		    Streak[killerid]++;
		}
		
		if(Streak[killerid] >= 3)
		{
			format(str, sizeof(str),"[DEATHMATCH] %d(%d) is on a Killing Spree!", GetName(killerid), killerid);
			SendClientMessageToAll(COLOR_RED ,str);
			GameTextForPlayer(killerid, "~r~Killing spree", 4500, 1);
		}
		if(Streak[killerid] >= 4)
		{
			format(str, sizeof(str),"[DEATHMATCH] %d(%d) has done a Quadrakill!", GetName(killerid), killerid);
			SendClientMessageToAll(COLOR_RED ,str);
			GameTextForPlayer(killerid, "~r~Quadrakill", 4500, 1);
		}
		if(Streak[killerid] >= 5)
		{
			format(str, sizeof(str),"[DEATHMATCH] %d(%d) has done a Pentakill!", GetName(killerid), killerid);
			SendClientMessageToAll(COLOR_RED ,str);
			GameTextForPlayer(killerid, "~r~Pentakill", 4500, 1);
		}
		if(Streak[killerid] >= 6)
		{
			format(str, sizeof(str),"[DEATHMATCH] %d(%d) is Unstoppable!", GetName(killerid), killerid);
			SendClientMessageToAll(COLOR_RED ,str);
			GameTextForPlayer(killerid, "~r~Unstoppable", 4500, 1);
		}
		if(Streak[killerid] >= 7)
		{
			format(str, sizeof(str),"[DEATHMATCH] %d(%d) is Dominating!", GetName(killerid), killerid);
			SendClientMessageToAll(COLOR_RED ,str);
			GameTextForPlayer(killerid, "~r~Dominating", 4500, 1);
		}
		if(Streak[killerid] >= 8)
		{
			format(str, sizeof(str),"[DEATHMATCH] %d(%d) is Godlike!", GetName(killerid), killerid);
			SendClientMessageToAll(COLOR_RED ,str);
			GameTextForPlayer(killerid, "~r~Godlike!", 4500, 1);
		}
	}
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	if(Hitsound[playerid] == 1)
	{
		PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0);
	}
    if(issuerid != INVALID_PLAYER_ID && dm[issuerid] == 2 && weaponid == 34 && bodypart == 9)
    {
        SetPlayerHealth(playerid, 0);
        PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid && issuerid,"~r~Headshot",2000, 3);
	}
    return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == 100)
	{
		if(response)
		{
            if(listitem == 0)
            {
				DDM(playerid);
	        }
            if(listitem == 1)
            {
				SOSDM(playerid);
	        }
            if(listitem == 2)
            {
				SDM(playerid);
	        }
	    }
    }
	return 1;
}

public OnPlayerUpdate(playerid)
{
	new	string_3D[256];
	format(string_3D, sizeof(string_3D), "{FFFFFF}Ping: {FDE39D}%d\n{FFFFFF}FPS: {FDE39D}%d",GetPlayerPing(playerid), GetPlayerFPS(playerid));
	for(new i, j = GetMaxPlayers(); i != j; i++)
	{
		UpdatePlayer3DTextLabelText(i, Info[playerid], -1, string_3D);
	}
	return 1;
}

stock DDM(playerid)
{
    new str[100];
	format(str,sizeof(str),"%s(%d) joined the deagle deathmatch",GetName(playerid), playerid);
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
		{
			if(dm[i] == 1)
			{
			    SendClientMessage(i, COLOR_BLUE, str);
			}
		}
	}
	
	for(new i; i < 6; i++) //Just to avoid bugs
	{
	    DeletePlayer3DTextLabel(playerid, Info[playerid]);
	}
	Info[playerid] = CreatePlayer3DTextLabel(playerid, "Ping: 0\nFPS: 0", -1, 0.0, 0.0, 0.35, 30.0, playerid, INVALID_VEHICLE_ID, 0);

	new rand = random(sizeof(DERandomSpawn));
	dm[playerid] = 1;
	SetPlayerArmour(playerid, 100);
	SetPlayerHealth(playerid, 100);
	SetCameraBehindPlayer(playerid);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid, 1);
	SetPlayerVirtualWorld(playerid, 10);
	GivePlayerWeapon(playerid, 24, 999999);
	SetPlayerPos(playerid, DERandomSpawn[rand][0], DERandomSpawn[rand][1],DERandomSpawn[rand][2]);
	SetPlayerFacingAngle(playerid, DERandomSpawn[rand][3]);
	PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	GameTextForPlayer(playerid,"~w~/leavedm ~g~to exit",5000,1);
	return 1;
}

stock SDM(playerid)
{
    new str[100];
	format(str,sizeof(str),"%s(%d) joined the sniper deathmatch",GetName(playerid), playerid);
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
		{
			if(dm[i] == 2)
			{
			    SendClientMessage(i, COLOR_BLUE, str);
			}
		}
	}
	
	for(new i; i < 6; i++) //Just to avoid bugs
	{
	    DeletePlayer3DTextLabel(playerid, Info[playerid]);
	}
	Info[playerid] = CreatePlayer3DTextLabel(playerid, "Ping: 0\nFPS: 0", -1, 0.0, 0.0, 0.35, 30.0, playerid, INVALID_VEHICLE_ID, 0);
	
	new rand = random(sizeof(SDMRandomSpawn));
	dm[playerid] = 2;
	SetPlayerArmour(playerid, 100);
	SetPlayerHealth(playerid, 100);
	SetPlayerPos(playerid, SDMRandomSpawn[rand][0], SDMRandomSpawn[rand][1],SDMRandomSpawn[rand][2]);
	SetPlayerFacingAngle(playerid, SDMRandomSpawn[rand][3]);
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	SetPlayerInterior(playerid, 15);
	SetPlayerVirtualWorld(playerid, 11);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, 34, 999999);
	GameTextForPlayer(playerid,"~w~/leavedm ~g~to exit",5000,1);
	return 1;
}

stock SOSDM(playerid)
{
    new str[100];
	format(str,sizeof(str),"%s(%d) joined the sawn-off shotgun deathmatch",GetName(playerid), playerid);
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
		{
			if(dm[i] == 3)
			{
			    SendClientMessage(i, COLOR_BLUE, str);
			}
		}
	}
	
	for(new i; i < 6; i++) //Just to avoid bugs
	{
	    DeletePlayer3DTextLabel(playerid, Info[playerid]);
	}
	Info[playerid] = CreatePlayer3DTextLabel(playerid, "Ping: 0\nFPS: 0", -1, 0.0, 0.0, 0.35, 30.0, playerid, INVALID_VEHICLE_ID, 0);
	
	new rand = random(sizeof(SOSRandomSpawn));
	dm[playerid] = 3;
	SetPlayerHealth(playerid, 100);
	SetPlayerArmour(playerid, 100);
	SetPlayerPos(playerid, SOSRandomSpawn[rand][0], SOSRandomSpawn[rand][1],SOSRandomSpawn[rand][2]);
	SetPlayerFacingAngle(playerid, SOSRandomSpawn[rand][3]);
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	SetPlayerInterior(playerid, 1);
	SetPlayerVirtualWorld(playerid, 12);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, 26, 999999);
	GameTextForPlayer(playerid,"~w~/leavedm ~g~to exit",5000,1);
	return 1;
}

stock LeaveDM(playerid)
{
    new str[100];
	format(str,sizeof(str),"%s(%d) has left the deathmatch",GetName(playerid), playerid);
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
		{
			if(dm[i] >= 1)
			{
			    SendClientMessage(i, COLOR_BLUE, str);
			}
		}
	}
	
	for(new i; i < 6; i++)
	{
	    DeletePlayer3DTextLabel(playerid, Info[playerid]);
	}
	
	dm[playerid] = 0;
	SetPlayerHealth(playerid, 100);
	SetPlayerArmour(playerid, 0);
	PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	ResetPlayerWeapons(playerid);
	SetSpawnInfo(playerid, 0, 0, 223.0138,-1872.2523,4.4400,1.4446,0,0,0,0,0,0);
	SpawnPlayer(playerid);
	return 1;
}

stock GetPlayerFPS(playerid)
{
	SetPVarInt(playerid, "DrunkL", GetPlayerDrunkLevel(playerid));
	if(GetPVarInt(playerid, "DrunkL") < 100) SetPlayerDrunkLevel(playerid, 2000);
	else
	{
		if(GetPVarInt(playerid, "LDrunkL") != GetPVarInt(playerid, "DrunkL"))
		{
			SetPVarInt(playerid, "FPS", (GetPVarInt(playerid, "LDrunkL") - GetPVarInt(playerid, "DrunkL")));
			SetPVarInt(playerid, "LDrunkL", GetPVarInt(playerid, "DrunkL"));
			if((GetPVarInt(playerid, "FPS") > 0) && (GetPVarInt(playerid, "FPS") < 256)) return GetPVarInt(playerid, "FPS") - 1;
		}
	}
	return 0;
}

CMD:ddm(playerid, params[])
{
	if(dm[playerid] == 1 || dm[playerid] == 2 || dm[playerid] == 3) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500, 3);
	DDM(playerid);
	return 1;
}

CMD:sdm(playerid, params[])
{
	if(dm[playerid] == 2 || dm[playerid] == 3 || dm[playerid] == 1) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500, 3);
	SDM(playerid);
	return 1;
}

CMD:sos(playerid, params[])
{
	if(dm[playerid] == 3 || dm[playerid] == 2 || dm[playerid] == 1) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500,3);
	SOSDM(playerid);
	return 1;
}

CMD:leavedm(playerid, params[])
{
	if(dm[playerid] == 0) return GameTextForPlayer(playerid,"~g~You are not in deathmatch", 4500, 3);
	LeaveDM(playerid);
	return 1;
}

CMD:dm(playerid,params[])
{
            new string[500];
			new ddm,
			sdm,
			sos;
			foreach(Player, i)
			{
				if(IsPlayerConnected(i))
				{
                    if(dm[i] == 1)
                    {
						ddm++;
					}
					if(dm[i] == 2)
					{
						sdm++;
					}
					if(dm[i] == 3)
					{
						sos++;
					}
				}
			}
            format(string,sizeof(string),
			""COL_GREEN"Map\t"COL_GREEN"Players\n\
			"COL_WHITE"Deagle (/ddm)\t%d\n\
			Sawn-Off Shotgun (/sosdm)\t%d\n\
			Sniper (/sdm)\t%d",ddm,sos,sdm);
			ShowPlayerDialog(playerid, 100, DIALOG_STYLE_TABLIST_HEADERS, ""COL_GREEN"Deathmatch",string, "Select","Cancel");
	        return 1;
}

CMD:hitsound(playerid, params[])
{
	if(Hitsound[playerid] == 0)
	{
		Hitsound[playerid] = 1;
		GameTextForPlayer(playerid, "~g~Hitsound ~w~on", 4500, 3);
	}
	else if(Hitsound[playerid] == 1)
	{
		Hitsound[playerid] = 0;
		GameTextForPlayer(playerid, "~g~Hitsound ~w~off", 4500, 3);
	}
	return 1;
}
