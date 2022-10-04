#include <a_samp>

new Text:Blood[MAX_PLAYERS];
new Text:Blood2[MAX_PLAYERS];
new Text:Blood3[MAX_PLAYERS];
new Text:Blood4[MAX_PLAYERS];

new ShowingOne[MAX_PLAYERS];
new Showing1[MAX_PLAYERS];
new Showing2[MAX_PLAYERS];
new Showing3[MAX_PLAYERS];
new Showing4[MAX_PLAYERS];


public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("   Health & Blood Filterscript Loaded   ");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

stock HideOtherTextDraws(playerid)
{
	TextDrawHideForPlayer(playerid, Blood[playerid]);
	TextDrawHideForPlayer(playerid, Blood2[playerid]);
	TextDrawHideForPlayer(playerid, Blood3[playerid]);
	TextDrawHideForPlayer(playerid, Blood4[playerid]);
	TextDrawHideForPlayer(playerid, Blood5[playerid]);
	
	Showing1[playerid] = 0;
	Showing2[playerid] = 0;
	Showing3[playerid] = 0;
	Showing4[playerid] = 0;
	return 1;
}

public OnPlayerConnect(playerid)
{
	Blood[playerid] = TextDrawCreate(641.555541, 1.500000, "usebox");
	TextDrawLetterSize(Blood[playerid], 0.000000, 49.405799);
	TextDrawTextSize(Blood[playerid], -2.000000, 0.000000);
	TextDrawAlignment(Blood[playerid], 1);
	TextDrawColor(Blood[playerid], 0);
	TextDrawUseBox(Blood[playerid], true);
	TextDrawBoxColor(Blood[playerid], -872415215);
	TextDrawSetShadow(Blood[playerid], 0);
	TextDrawSetOutline(Blood[playerid], 0);
	TextDrawFont(Blood[playerid], 0);

	Blood2[playerid] = TextDrawCreate(641.555541, 1.500000, "usebox");
	TextDrawLetterSize(Blood2[playerid], 0.000000, 49.405799);
	TextDrawTextSize(Blood2[playerid], -2.000000, 0.000000);
	TextDrawAlignment(Blood2[playerid], 1);
	TextDrawColor(Blood2[playerid], 0);
	TextDrawUseBox(Blood2[playerid], true);
	TextDrawBoxColor(Blood2[playerid], -872415198);
	TextDrawSetShadow(Blood2[playerid], 0);
	TextDrawSetOutline(Blood2[playerid], 0);
	TextDrawFont(Blood2[playerid], 0);

	Blood3[playerid] = TextDrawCreate(641.555541, 1.500000, "usebox");
	TextDrawLetterSize(Blood3[playerid], 0.000000, 49.405799);
	TextDrawTextSize(Blood3[playerid], -2.000000, 0.000000);
	TextDrawAlignment(Blood3[playerid], 1);
	TextDrawColor(Blood3[playerid], 0);
	TextDrawUseBox(Blood3[playerid], true);
	TextDrawBoxColor(Blood3[playerid], -872415181);
	TextDrawSetShadow(Blood3[playerid], 0);
	TextDrawSetOutline(Blood3[playerid], 0);
	TextDrawFont(Blood3[playerid], 0);

	Blood4[playerid] = TextDrawCreate(641.555541, 1.500000, "usebox");
	TextDrawLetterSize(Blood4[playerid], 0.000000, 49.405799);
	TextDrawTextSize(Blood4[playerid], -2.000000, 0.000000);
	TextDrawAlignment(Blood4[playerid], 1);
	TextDrawColor(Blood4[playerid], 0);
	TextDrawUseBox(Blood4[playerid], true);
	TextDrawBoxColor(Blood4[playerid], -872415164);
	TextDrawSetShadow(Blood4[playerid], 0);
	TextDrawSetOutline(Blood4[playerid], 0);
	TextDrawFont(Blood4[playerid], 0);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	TextDrawDestroy(Blood[playerid]);
	TextDrawDestroy(Blood2[playerid]);
	TextDrawDestroy(Blood3[playerid]);
	TextDrawDestroy(Blood4[playerid]);
	
	Showing1[playerid] = 0;
	Showing2[playerid] = 0;
	Showing3[playerid] = 0;
	Showing4[playerid] = 0;
	return 1;
}

public OnPlayerUpdate(playerid)
{

	new Float:HP;
	GetPlayerHealth(playerid, HP);
	if(HP <= 50.0)
	{
		if(HP <= 40 && HP > 30)
		{
			HideOtherTextDraws(playerid);
			TextDrawShowForPlayer(playerid, Blood[playerid]);
			Showing1[playerid] = 1;
		}
		if(HP <= 30 && HP > 20)
		{
			HideOtherTextDraws(playerid);
			TextDrawShowForPlayer(playerid, Blood2[playerid]);
			Showing2[playerid] = 1;
		}
		if(HP <= 20 && HP > 10)
		{
			HideOtherTextDraws(playerid);
			TextDrawShowForPlayer(playerid, Blood3[playerid]);
			Showing3[playerid] = 1;
		}
		if(HP <= 10 && HP > 0)
		{
			HideOtherTextDraws(playerid);
			TextDrawShowForPlayer(playerid, Blood4[playerid]);
			Showing4[playerid] = 1;
		}
		ShowingOne[playerid] = 1;
	}
	if(HP > 50 && ShowingOne[playerid] == 1)
	{
		ShowingOne[playerid] = 0;
		HideOtherTextDraws(playerid);
	}
	return 1;
}

public OnPlayerDeath(playerid)
{
	if(ShowingOne[playerid] == 1)
	{
		HideOtherTextDraws(playerid);
		ShowingOne[playerid] = 0;
	}
	return 1;
}
