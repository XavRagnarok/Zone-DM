// login/register

stock LogPlayerIn(playerid)
{
	new rows, fields;
	cache_get_data(rows, fields, ourConnection);
    if(!rows)
    {
		for(new i = 0; i < 3; i ++) { SendClientMessage(playerid, -1, " "); }
 
		SendClientMessageEx(playerid, COLOR_YELLOW, "The user (%s) you're connected with is not a registered.", ReturnName(playerid));
		SendClientMessage(playerid, -1, "You need to register to continue.");
 
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Welcome to Cubie's Scripting Adventure", "SERVER: You can now register!\nTIP: Please report all bugs that you\nmay have found to development.\n\n           Enter Your Password:", "Register", "Cancel");
		return 1;
	}
 
	SendClientMessageEx(playerid, COLOR_YELLOW, "Welcome to Cubie's Scripting Adventure, %s {FFFFFF}["SCRIPT_VERSION"]", ReturnName(playerid));
	return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Welcome to Cubie's Scripting Adventure", "SERVER: You van now login!\nTIP: Please report all bugs that you\nmay have found to development.\n\n           Enter Your Password:", "Login", "Cancel");
}
 
stock OnPlayerRegister(playerid)
{
	PlayerInfo[playerid][pDBID] = cache_insert_id();
	format(PlayerInfo[playerid][pAccName], 32, "%s", ReturnName(playerid));
 
	PlayerInfo[playerid][pLoggedin] = true;
	ShowModelSelectionMenu(playerid, joinskin, "Pick A Skin");
}
 
stock LoggingIn(playerid)
{
	if(!cache_num_rows())
	{
		playerLogin[playerid]++;
		if(playerLogin[playerid] == 3)
		{
			SendClientMessage(playerid, COLOR_RED, "[SERVER]: You were kicked for bad password attempts.");
			return KickEx(playerid);
		}
 
		return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Welcome to Cubie Emergency Roleplay", "You entered the wrong password!\n\nSERVER: You can now login!\nTIP: Please report all bugs that you\nmay have found to development.\n\n           Enter Your Password:", "Login", "Cancel");
	}
 
	new rows, fields;
	cache_get_data(rows, fields, ourConnection);
 
	PlayerInfo[playerid][pDBID] = cache_get_field_content_int(0, "acc_dbid", ourConnection);
 
	format(PlayerInfo[playerid][pAccName], 32, "%s", ReturnName(playerid));
	PlayerInfo[playerid][pLoggedin] = true;
    ShowModelSelectionMenu(playerid, joinskin, "Pick A Skin");
	return 1;
}
 
stock ResetPlayer(playerid)
{
    PlayerInfo[playerid][pLoggedin] = false;
    PlayerInfo[playerid][pSkin] = 0;
    return 1;
}
 
stock SetPlayerCamera(playerid)
{
	new rand = random(3);
 
	switch(rand)
	{
		case 0:
		{
		    SetPlayerCameraPos(playerid, 2019.1145, 1202.9185, 42.3246);
			SetPlayerCameraLookAt(playerid, 2019.9889, 1202.4272, 42.2945);
		}
		case 1:
		{
   			SetPlayerCameraPos(playerid, 1701.8396, -1572.9250, 26.6298);
			SetPlayerCameraLookAt(playerid, 1701.2588, -1572.1072, 27.1848);
		}
		case 2:
		{
   			SetPlayerCameraPos(playerid, -2619.1006, 2202.6091, 49.9144);
			SetPlayerCameraLookAt(playerid, -2619.2512, 2201.6155, 50.1043);
		}
	}
	return 1;
}
 
 
 
//Timers:
 
stock KickTimer(playerid) 
{ 
	return Kick(playerid); 
}

