#include <a_samp>
#include <sscanf>

#define FILTERSCRIPT
#define MAX_TEXT_LENGTH 50

public OnFilterScriptInit()
{
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/announce", cmdtext, true, 10) == 0)
	{
		new str[100],text[MAX_TEXT_LENGTH],time,style;
		if(sscanf(cmdtext, "s[50]ii", text, time, style)) return GameTextForPlayer(playerid,"~g~/announce~w~~n~(text)~n~(time)~n~(style)",4500,3);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(!IsPlayerAdmin(i))
			{
			    GameTextForAll(str, time * 1000, style);
			}
		}
		return 1;
	}
	return 0;
}

public OnPlayerText(playerid, text[])
{
			if(IsPlayerAdmin(playerid))
			{
				new str[500];
				format(str, sizeof(str),"[ADMIN] %s(%d): %s",GetName(playerid),playerid,text);
				SendClientMessageToAll(0xFFFFFFFF, str);
			}
	        return 0;
}

stock GetName(playerid)
{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, Name, sizeof(Name));
	return Name;
}
