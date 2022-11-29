// all free for all dm arenas

//Deathmatch related commands

CMD:ddm(playerid, params[])
{
	new string[128];
	if(dm[playerid] == 1 || dm[playerid] == 2 || dm[playerid] == 3) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500, 3);
	DDM(playerid);
	format(string, sizeof(string), "%s(%d) has joined the Deagle Deathmatch", GetName(playerid), playerid);
	SCMall(COLOR_BLUE, string);
	return 1;
}

CMD:sdm(playerid, params[])
{
	new string[128];
	if(dm[playerid] == 2 || dm[playerid] == 3 || dm[playerid] == 1) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500, 3);
	SDM(playerid);
	format(string, sizeof(string), "%s(%d) has joined the Sniper Deathmatch", GetName(playerid), playerid);
	SCMall(COLOR_BLUE, string);
	return 1;
}

CMD:spasdm(playerid, params[])
{
	new string[128];
	if(dm[playerid] == 3 || dm[playerid] == 2 || dm[playerid] == 1) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500,3);
	SPASDM(playerid);
	format(string, sizeof(string), "%s(%d) has joined the Combat Shotgun Deathmatch", GetName(playerid), playerid);
	SCMall(COLOR_BLUE, string);
	return 1;
}

CMD:leavedm(playerid, params[])
{
	if(dm[playerid] == 0) return GameTextForPlayer(playerid,"~g~You are not in deathmatch", 4500, 3);
	LeaveDM(playerid);
	return 1;
}

CMD:dm(playerid, params[])
{
    new string[500];
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
				spas++;
			}
		}
	}
	format(string,sizeof(string),
	"Maps\tPlayers\n\
	{fccf03}Deagle (/ddm)\t{5bc906}%d\n\
	{fc9803}Combat Shotgun (/spasdm)\t{5bc906}%d\n\
	{c606c9}Sniper (/sdm)\t{5bc906}%d",ddm,spas,sdm);
	ShowPlayerDialog(playerid, DIALOG_DM, DIALOG_STYLE_TABLIST_HEADERS, "Deathmatch",string, "Select","Cancel");

	return 1;
}

// ==================================Stock Values============================

stock DDM(playerid)
{
 	for(new i; i < 6; i++) //Just to avoid bugs
	{
	    DeletePlayer3DTextLabel(playerid, Info[playerid]);
	}
	Info[playerid] = CreatePlayer3DTextLabel(playerid, "Ping: 0\nFPS: 0", -1, 0.0, 0.0, 0.35, 30.0, playerid, INVALID_VEHICLE_ID, 0);

	new rand = random(sizeof(DERandomSpawn)), textlabelddmstr[500];
	dm[playerid] = 1;
	SetPlayerArmour(playerid, 100);
	SetPlayerHealth(playerid, 100);
	SetCameraBehindPlayer(playerid);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid, 1);
	SetPlayerVirtualWorld(playerid, 10);
	GivePlayerWeapon(playerid, 24, 999999);
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	SetPlayerPos(playerid, DERandomSpawn[rand][0], DERandomSpawn[rand][1],DERandomSpawn[rand][2]);
	SetPlayerFacingAngle(playerid, DERandomSpawn[rand][3]);
	PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	GameTextForPlayer(playerid,"~w~/leavedm ~g~to exit",5000,1);

	format(textlabelddmstr, sizeof(textlabelddmstr), "players: %d", ddm);
	Update3DTextLabelText(textlabelstrddm, COLOR_WHITE, textlabelddmstr);
	return 1;
}

stock SDM(playerid)
{
   	for(new i; i < 6; i++) //Just to avoid bugs
	{
	    DeletePlayer3DTextLabel(playerid, Info[playerid]);
	}
	Info[playerid] = CreatePlayer3DTextLabel(playerid, "Ping: 0\nFPS: 0", -1, 0.0, 0.0, 0.35, 30.0, playerid, INVALID_VEHICLE_ID, 0);

	new rand = random(sizeof(SDMRandomSpawn)), textlabelsdmstr[500];
	dm[playerid] = 2;
	SetPlayerArmour(playerid, 100);
	SetPlayerHealth(playerid, 100);
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	SetPlayerPos(playerid, SDMRandomSpawn[rand][0], SDMRandomSpawn[rand][1],SDMRandomSpawn[rand][2]);
	SetPlayerFacingAngle(playerid, SDMRandomSpawn[rand][3]);
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	SetPlayerInterior(playerid, 3);
	SetPlayerVirtualWorld(playerid, 11);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, 34, 999999);
	GameTextForPlayer(playerid,"~w~/leavedm ~g~to exit",5000,1);

	format(textlabelsdmstr, sizeof(textlabelsdmstr), "players: %d", sdm);
	Update3DTextLabelText(textlabelstrsdm, COLOR_WHITE, textlabelsdmstr);
	return 1;
}

stock SPASDM(playerid)
{
	for(new i; i < 6; i++) //Just to avoid bugs
	{
	    DeletePlayer3DTextLabel(playerid, Info[playerid]);
	}
	Info[playerid] = CreatePlayer3DTextLabel(playerid, "Ping: 0\nFPS: 0", -1, 0.0, 0.0, 0.35, 30.0, playerid, INVALID_VEHICLE_ID, 0);

	new rand = random(sizeof(SPASRandomSpawn)), textlabelspasdmstr[500];
	dm[playerid] = 3;
	SetPlayerHealth(playerid, 100);
	SetPlayerArmour(playerid, 100);
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	SetPlayerPos(playerid, SPASRandomSpawn[rand][0], SPASRandomSpawn[rand][1],SPASRandomSpawn[rand][2]);
	SetPlayerFacingAngle(playerid, SPASRandomSpawn[rand][3]);
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	SetPlayerInterior(playerid, 1);
	SetPlayerVirtualWorld(playerid, 12);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, 27, 999999);
	GameTextForPlayer(playerid,"~w~/leavedm ~g~to exit",5000,1);

	format(textlabelspasdmstr, sizeof(textlabelspasdmstr), "players: %d", spas);
	Update3DTextLabelText(textlabelstrspasdm, COLOR_WHITE, textlabelspasdmstr);
	return 1;
}

stock LeaveDM(playerid)
{
    new str[100], textlabelddmstr[500], textlabelsdmstr[500], textlabelspasdmstr[500];
	format(str,sizeof(str),"{d6311c}%s(%d) has left the deathmatch",GetName(playerid), playerid);
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

	format(textlabelddmstr, sizeof(textlabelddmstr), "players: %d", ddm);
	Update3DTextLabelText(textlabelstrddm, COLOR_WHITE, textlabelddmstr);

	format(textlabelsdmstr, sizeof(textlabelsdmstr), "players: %d", sdm);
	Update3DTextLabelText(textlabelstrsdm, COLOR_WHITE, textlabelsdmstr);

	format(textlabelspasdmstr, sizeof(textlabelspasdmstr), "players: %d", spas);
	Update3DTextLabelText(textlabelstrspasdm, COLOR_WHITE, textlabelspasdmstr);

	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 384.3023,-2080.2852,7.8301,0.1614,0,0,0,0,0,0);
	SpawnPlayer(playerid);
	return 1;
}

function:CreateActorsForDM()
{
	{
        new textlabelddmstr[500];
        actorddm = CreateActor(94, 385.8448,-2087.5015,7.8359, 359);
        SetActorInvulnerable(actorddm, 0);
        Create3DTextLabel("Deagle DM", COLOR_BLUE, 385.8448,-2087.5015,7.8359, 20, 0, 0);
        format(textlabelddmstr, sizeof(textlabelddmstr), "players: %d", ddm);
        textlabelstrddm = Create3DTextLabel(textlabelddmstr, COLOR_WHITE, 385.8448,-2087.5015,7.6359, 20, 0, 0);
    }

    {
    	new textlabelsdmstr[500];
	    actorsdm = CreateActor(94, 383.2977,-2087.5015,7.8359, 359);
	    SetActorInvulnerable(actorsdm, 0);
	    Create3DTextLabel("Sniper DM", COLOR_RED, 383.2977,-2087.5015,7.8359, 20, 0, 0);
	    format(textlabelsdmstr, sizeof(textlabelsdmstr), "players: %d", sdm);
	    textlabelstrsdm = Create3DTextLabel(textlabelsdmstr, COLOR_WHITE, 383.2977,-2087.5015,7.6359, 20, 0, 0);
	}

	{
		new textlabelspasdmstr[500];
	    actorspasdm = CreateActor(94, 388.5406,-2087.5015,7.8359, 359);
	    SetActorInvulnerable(actorspasdm, 0);
		Create3DTextLabel("Combat Shotgun DM", COLOR_CYAN, 388.5406,-2087.5015,7.8359, 20, 0, 0);
		format(textlabelspasdmstr, sizeof(textlabelspasdmstr), "players: %d", spas);
	    textlabelstrspasdm = Create3DTextLabel(textlabelspasdmstr, COLOR_WHITE, 388.5406,-2087.5015,7.6359, 20, 0, 0);
	}
}