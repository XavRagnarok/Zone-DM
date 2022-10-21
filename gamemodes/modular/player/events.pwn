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

	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 223.0138,-1872.2523,4.4400,1.4446,0,0,0,0,0,0);
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
	dm[playerid] = 0;
	Streak[playerid] = 0;

	new existcheck[248];

	mysql_format(ourConnection, existcheck, sizeof(existcheck), "SELECT * FROM accounts WHERE acc_name = '%e'", ReturnName(playerid));
    mysql_tquery(ourConnection, existcheck, "LogPlayerIn", "i", playerid);

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	{
	new line[124];
	switch(reason) {
    case 0: format(line, sizeof(line), "%s(%d) has left the server. (Lost Connection)", GetName(playerid), playerid);
    case 1: format(line, sizeof(line), "%s(%d) has left the server. (Leaving)", GetName(playerid), playerid);
    case 2: format(line, sizeof(line), "%s(%d) has left the server. (Kicked)", GetName(playerid), playerid);
	}
	SendClientMessageToAll(0xFFFFFFFF, line);
	}
	{
		new insert[128];

		PlayerInfo[playerid][pCash] = GetPlayerMoney(playerid);

		mysql_format(ourConnection, insert, sizeof(insert), "UPDATE accounts SET Cash = %i WHERE acc_dbid = %i",PlayerInfo[playerid][pCash] , PlayerInfo[playerid][pDBID]);
		mysql_tquery(ourConnection, insert);
	}

	{
		dm[playerid] = 0;
		Streak[playerid] = 0;
		for(new i; i < 6; i++)
		{
	    	DeletePlayer3DTextLabel(playerid, Info[playerid]);
		}
	}
	
	{
		new insert[130];

		PlayerInfo[playerid][pScore] = GetPlayerScore(playerid);

		mysql_format(ourConnection, insert, sizeof(insert), "UPDATE accounts SET Score = %i WHERE acc_dbid = %i",PlayerInfo[playerid][pScore] , PlayerInfo[playerid][pDBID]);
		mysql_tquery(ourConnection, insert);
	}

	{
		new insert[300];

		PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);

		mysql_format(ourConnection, insert, sizeof(insert), "UPDATE accounts SET Skin = %i WHERE acc_dbid = %i", PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pDBID]);
		mysql_tquery(ourConnection, insert);
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
		GameTextForPlayer(killerid, str, 4500, 3);
		SetPlayerScore(killerid, GetPlayerScore(playerid) + 1);
		PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
		Streak[killerid] = 0;

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
    if(issuerid != INVALID_PLAYER_ID && dm[issuerid] == 2 && weaponid == 34 && bodypart == 9)
    {
        SetPlayerHealth(playerid, 0);
        PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid && issuerid,"~r~Headshot",2000, 3);
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
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
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

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	if(pickupid == ddmpickup)
	{
	    ShowPlayerDialog(playerid, 5, DIALOG_STYLE_MSGBOX, "Confirmation", "{ffffff}Are you sure you want to join {ff0000}Deagle Deathmatch ?", "Yes", "{ff0000}NO");

	}
	if(pickupid == sdmpickup)
	{
     	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_MSGBOX, "Confirmation", "{ffffff}Are you sure you want to join {ff0000}Sniper Deathmatch ?", "Yes", "{ff0000}No");
	}
	if(pickupid == sosdmpickup)
	{
	    ShowPlayerDialog(playerid, 7, DIALOG_STYLE_MSGBOX, "Confirmation", "{ffffff}Are you sure you want to join {ff0000}Sawn Off Shotgun Deathmatch ?", "Yes", "{ff0000}No");
	}

	return 1;
}