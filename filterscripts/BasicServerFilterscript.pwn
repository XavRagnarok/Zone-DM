#include <a_samp>
#include <sscanf2>

#define FILTERSCRIPT

new Muted[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("  FliterScript Successfully Loaded");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	new line[124];
	format(line, sizeof(line), "%s(%d) has joined the server",GetName(playerid),playerid);
	SendClientMessageToAll(0xFFFFFFFF, line);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new line[124];
	switch(reason) {
    case 0: format(line, sizeof(line), "%s(%d) has left the server. (Lost Connection)", GetName(playerid), playerid);
    case 1: format(line, sizeof(line), "%s(%d) has left the server. (Leaving)", GetName(playerid), playerid);
    case 2: format(line, sizeof(line), "%s(%d) has left the server. (Kicked)", GetName(playerid), playerid);
	}
	SendClientMessageToAll(0xFFFFFFFF, line);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new score = GetPlayerScore(playerid);
	new level = GetPlayerWantedLevel(killerid);
	new line[124];
	SendDeathMessage(killerid, playerid, reason);
	GameTextForPlayer(playerid,"~g~Wasted",6000,2);
	SetPlayerScore(playerid, score + 1);
	if(level == 6) {
	format(line,sizeof(line),"%s(%d) has killed %s(%d) and is not most wanted with 6 stars",GetName(killerid), killerid, GetName(playerid), playerid);
	SendClientMessageToAll(0xFFFFFFFF, line);
	}
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	if(weaponid == 35 || weaponid == 36 || weaponid == 38) return Kick(playerid);
	if(bodypart == 9) { GameTextForPlayer(issuerid,"~r~Headshot",4500,3); SetPlayerHealth(playerid, 0); }
    PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if(GetPlayerVehicleID(playerid) == 520 || GetPlayerVehicleID(playerid) == 432)
		{
			new vehid = GetPlayerVehicleID(playerid);
			DestroyVehicle(vehid);
			Kick(playerid);
		}
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
	{
		Kick(playerid);
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(Muted[playerid] == 0)
	{
	    new to_others[MAX_CHATBUBBLE_LENGTH+1];
	    format(to_others,MAX_CHATBUBBLE_LENGTH,"%s",text);
	    SetPlayerChatBubble(playerid,to_others,0xFFFFFFFF,35.0,10000);
	}
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/kick", cmdtext, true, 10) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
			new id;
			if(sscanf(cmdtext, "u", id)) return GameTextForPlayer(playerid, "~g~/kick~w~~n~(id)",4500,3);
			Kick(id);
		}
		return 1;
	}
	if (strcmp("/ban", cmdtext, true, 10) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
			new id;
			if(sscanf(cmdtext, "u", id)) return GameTextForPlayer(playerid, "~g~/ban~w~~n~(id)",4500,3);
			Ban(id);
		}
		return 1;
	}
	if (strcmp("/mute", cmdtext, true, 10) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
			new id;
			if(sscanf(cmdtext, "u", id)) return GameTextForPlayer(playerid, "~g~/mute~w~~n~(id)",4500,3);
			Muted[playerid] = 1;
		}
		return 1;
	}
	if (strcmp("/unmute", cmdtext, true, 10) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
			new id;
			if(sscanf(cmdtext, "u", id)) return GameTextForPlayer(playerid, "~g~/unmute~w~~n~(id)",4500,3);
			if(Muted[id] == 0) return SendClientMessage(playerid, 0xFFFFFFFF, "Player is already unmuted");
			Muted[playerid] = 0;
		}
		return 1;
	}
	if (strcmp("/heal", cmdtext, true, 10) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
			new id,line[124];
			if(sscanf(cmdtext, "u", id)) return GameTextForPlayer(playerid, "~g~/ban~w~~n~(id)",4500,3);
			SetPlayerHealth(id, 100);
			format(line,sizeof(line),"You healed %s(%d)",GetName(id),id);
			SendClientMessage(playerid, 0xFFFFFFFF, line);
		}
		return 1;
	}
	return 0;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	if(!success) return BlockIpAddress(ip, 60 * 60 * 1000); //Ban for 1 hour
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(IsPlayerAdmin(playerid))
	{
		new Float:x, Float:y, Float:z; //Float veriables
		GetPlayerPos(clickedplayerid, x, y, z); //Get the clicked player pos using float variable
		SetPlayerPos(playerid, x, y, z+3); //Set player pos which was stored in x y z
	}
	return 1;
}

stock GetName(playerid)
{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, Name, sizeof(Name));
	return Name;
}
