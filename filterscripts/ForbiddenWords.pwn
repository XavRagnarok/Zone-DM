#include <a_samp>
#include <zcmd>

#define FILTERSCRIPT

public OnFilterScriptInit()
{
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

enum ForbiddenEnums
{
	ForbiddenWords[500]
};

new Forbidden[8][ForbiddenEnums] =
{
	"Noob",
	"Shit",
	"Hacker",
	"Hack",
	"Noob's Server",
	"Ugly Server",
	"Ugly",
	"Password"
};

public OnPlayerText(playerid, text[])
{
    for(new i; i < sizeof(Forbidden); i++)
    {
	    if(strfind(text, Forbidden[i][ForbiddenWords], true) != -1)
	    {
	        SendClientMessage(playerid, 0xF81414FF, "Dont use forbidden words in chat");
	        return 0;
	    }
    }
	return 1;
}

CMD:forbiddenwords(playerid, params[])
{
	new str[500], count;
    for(new i; i < sizeof(Forbidden); i++)
    {
		count++;
	    format(str, sizeof(str),"{FFFFFF}%s {00FF00}%d.{FFFFFF}%s\n", str, count, Forbidden[i][ForbiddenWords]);
	}
	ShowPlayerDialog(playerid, 10000, DIALOG_STYLE_MSGBOX, "{00FF00}Forbidden Words", str, "OK", "");
	return 1;
}
