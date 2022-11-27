// player events public


public OnPlayerRequestClass(playerid, classid)
{
	if(PlayerInfo[playerid][pLoggedin] == false)
		{
	    SetSpawnInfo(playerid, 0, 0, 563.3157, 3315.2559, 0, 269.15, 0, 0, 0, 0, 0, 0 );
	    TogglePlayerSpectating(playerid, true);
     	TogglePlayerSpectating(playerid, false);
        SetPlayerCamera(playerid);
        return 1;
		}

	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 384.3023,-2080.2852,7.8301,0.1614,0,0,0,0,0,0);
	SpawnPlayer(playerid);

	return 0;
}

public OnPlayerConnect(playerid)
{
	{
		new line[124];
		format(line, sizeof(line), "{a8a8a3}%s(%d) has joined the server",GetName(playerid),playerid);
		SendClientMessageToAll(0xFFFFFFFF, line);
	}
    SetPlayerCamera(playerid);
	ResetPlayer(playerid);

	new existcheck[248];

	mysql_format(ourConnection, existcheck, sizeof(existcheck), "SELECT * FROM accounts WHERE acc_name = '%e'", ReturnName(playerid));
    mysql_tquery(ourConnection, existcheck, "LogPlayerIn", "i", playerid);

    // RACE RELATED

    GetPlayerName(playerid, RACE_pInfo[playerid][RACE_playerUsername], MAX_PLAYER_NAME);
	
	RACE_resetPlayerVariables(playerid);
	
	#if defined RACE_OnPlayerConnect
        RACE_OnPlayerConnect(playerid);
    #endif

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	{
		new line[124];
		switch(reason) 
		{
		    case 0: format(line, sizeof(line), "%s(%d) has left the server. (Lost Connection)", GetName(playerid), playerid);
		    case 1: format(line, sizeof(line), "%s(%d) has left the server. (Leaving)", GetName(playerid), playerid);
		    case 2: format(line, sizeof(line), "%s(%d) has left the server. (Kicked)", GetName(playerid), playerid);
		}
		SendClientMessageToAll(0xFFFFFFFF, line);
	}

	SavePlayerData(playerid);

	{
		dm[playerid] = 0;
		Streak[playerid] = 0;
		for(new i; i < 6; i++)
		{
	    	DeletePlayer3DTextLabel(playerid, Info[playerid]);
		}
	}

	// RACE RELATED

	if(RACE_pInfo[playerid][RACE_isPlayerInRace])
	{
		RACE_playerExitEvent(playerid);
	}
	
	#if defined RACE_OnPlayerDisconnect
        RACE_OnPlayerDisconnect(playerid, reason);
    #endif
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
		SPASDM(playerid);
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	SendDeathMessage(killerid, playerid, reason);
    if(dm[killerid] >= 1)
	{
		new str[200], gunname[32], streak[MAX_PLAYERS];
		
		GetWeaponName(reason, gunname, sizeof(gunname));
		format(str, sizeof(str), "You Killed %s by using %s", GetName(playerid), gunname);
		SendClientMessage(killerid, COLOR_RED, str);
		SetPlayerScore(killerid, GetPlayerScore(killerid)+1);
		PlayerPlaySound(killerid, 17802, 0.0, 0.0, 0.0);
		Streak[playerid] = 0;
		streak[killerid] = 1;
		Streak[killerid]++;

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

	// RACE RELATED

	if(RACE_pInfo[playerid][RACE_isPlayerInRace])
	{
		RACE_playerExitEvent(playerid);
	}
	
	#if defined RACE_OnPlayerDeath
        RACE_OnPlayerDeath(playerid, killerid, reason);
    #endif
	return 1;
}

public OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart)
{
    if(issuerid != INVALID_PLAYER_ID && dm[issuerid] == 2 && weapon == 34 && bodypart == 9)
    {
        SetPlayerHealth(playerid, 0);
        PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid && issuerid,"~r~Headshot",2000, 3);
	}
	PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0);

	if(aduty[playerid] == 1)
	{
		return 0;
	}
    return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{

	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(RACE_pInfo[playerid][RACE_isPlayerInRace])
	{
	    return 0;
	}
	
	#if defined RACE_OnPlayerExitVehicle
        RACE_OnPlayerExitVehicle(playerid, vehicleid);
    #endif
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	// RACE RELATED
	if(RACE_pInfo[playerid][RACE_isPlayerInRace])
	{
		if(oldstate == PLAYER_STATE_DRIVER)
		{
            PutPlayerInVehicle(playerid, RACE_pInfo[playerid][RACE_playerVehicle], 0);
		}
	}
	
	#if defined RACE_OnPlayerStateChange
        RACE_OnPlayerStateChange(playerid, newstate, oldstate);
    #endif
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(RACE_pInfo[playerid][RACE_isPlayerInRace])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {			
			RACE_pInfo[playerid][RACE_playerCheckpointsPassed]++;
		    RACE_checkpoints[RACE_pInfo[playerid][RACE_playerCheckpointsPassed]]++;
			RACE_pInfo[playerid][RACE_playerPosition] = RACE_checkpoints[RACE_pInfo[playerid][RACE_playerCheckpointsPassed]];

			if(RACE_pInfo[playerid][RACE_playerCheckpointsPassed] == RACE_rInfo[RACE_runningID][0][raceMaxCheckpoints])
			{
				RACE_playersLeft--;

				DisablePlayerRaceCheckpoint(playerid);
				DisablePlayerCheckpoint(playerid);

				RACE_playerFinishedTheRace(playerid);

				PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
			}
			else
			{
				new
					i = RACE_pInfo[playerid][RACE_playerCheckpointsPassed],
					runID = RACE_runningID
				;

                DisablePlayerCheckpoint(playerid);
				DisablePlayerRaceCheckpoint(playerid);

				if(RACE_rInfo[runID][0][raceMaxCheckpoints] - 1 == i)
				{
					SetPlayerRaceCheckpoint(playerid, 1, RACE_rInfo[runID][i][raceCheckpointPositionX], RACE_rInfo[runID][i][raceCheckpointPositionY], RACE_rInfo[runID][i][raceCheckpointPositionZ], RACE_rInfo[runID][i + 1][raceCheckpointPositionX], RACE_rInfo[runID][i + 1][raceCheckpointPositionY], RACE_rInfo[runID][i + 1][raceCheckpointPositionZ], 7.0);
				}
				else
				{
					SetPlayerRaceCheckpoint(playerid, 0, RACE_rInfo[runID][i][raceCheckpointPositionX], RACE_rInfo[runID][i][raceCheckpointPositionY], RACE_rInfo[runID][i][raceCheckpointPositionZ], RACE_rInfo[runID][i + 1][raceCheckpointPositionX], RACE_rInfo[runID][i + 1][raceCheckpointPositionY], RACE_rInfo[runID][i + 1][raceCheckpointPositionZ], 7.0);

					SetPlayerCheckpoint(playerid, RACE_rInfo[runID][i + 1][raceCheckpointPositionX], RACE_rInfo[runID][i + 1][raceCheckpointPositionY], RACE_rInfo[runID][i + 1][raceCheckpointPositionZ], 0.0);
				}

                RACE_globalString[0] = '\0';
				format(RACE_globalString, sizeof(RACE_globalString), "~g~Position:~w~ %d/%d", RACE_pInfo[playerid][RACE_playerPosition], RACE_playersInEvent);
				TextDrawSetString(RACE_pInfo[playerid][RACE_textdrawPosition], RACE_globalString);

				format(RACE_globalString, sizeof(RACE_globalString), "~g~Checkpoint:~w~ %d/%d", i, RACE_rInfo[runID][0][raceMaxCheckpoints]);
				TextDrawSetString(RACE_pInfo[playerid][RACE_textdrawCheckpoint], RACE_globalString);

				PlayerPlaySound(playerid, 1138,0.0,0.0,0.0);
			}

	  		if(RACE_playersLeft == 0)
			{
				RACE_finishEvent(0);
			}
		}
	}
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerModelSelection(playerid, response, listid, modelid)
{
    if(listid == joinskin)
	{
	if(!response)
		return ShowModelSelectionMenu(playerid, joinskin, "please pick a skin you want to use");


	SetCameraBehindPlayer(playerid);
	SetPlayerSkin(playerid, modelid);
	SetSpawnInfo(playerid, 0, modelid, 223.0138,-1872.2523,4.4400,1.4446,0,0,0,0,0,0);
	SpawnPlayer(playerid);
	}
	return 1;
}