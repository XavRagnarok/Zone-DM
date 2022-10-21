// login/register related

function:SetPlayerCamera(playerid)
{

	new rand = random(4);

	switch(rand)
	{

	    case 0:
	    {
	        SetPlayerCameraPos(playerid, -2813.0288, -197.5183, 47.1108);
			SetPlayerCameraLookAt(playerid, -2812.4990, -198.3723, 47.0508);
	    }
		case 1:
		{
		    SetPlayerCameraPos(playerid, -2598.4858, 1435.8639, 108.1429);
			SetPlayerCameraLookAt(playerid, -2598.7920, 1436.8192, 108.1929);
		}
		case 2:
		{
		    SetPlayerCameraPos(playerid, 2055.3882, 1182.9683, 66.7956);
			SetPlayerCameraLookAt(playerid, 2056.2783, 1182.4999, 66.7205);
		}
		case 3:
		{
		    SetPlayerCameraPos(playerid, 1388.1973, -955.0184, 92.0558);
			SetPlayerCameraLookAt(playerid, 1388.3502, -954.0233, 92.0557);
		}

	}

	return 1;
}

function:ResetPlayer(playerid)
{
	PlayerLogin[playerid] = 0;
	PlayerInfo[playerid][pDBID] = 0;
    PlayerInfo[playerid][pLoggedin] = false;
    PlayerInfo[playerid][pSkin] = 0;
    PlayerInfo[playerid][pAdmin] = 0;
    PlayerInfo[playerid][pCash] = 0;
    PlayerInfo[playerid][pScore] = 0;

    return 1;
}

function:LogPlayerIn(playerid)
{

	new rows, fields;
	cache_get_data(rows, fields, ourConnection);
	if(!rows)
	{
	    SCMex(playerid, COLOR_YELLOW, "The user (%s) you're connected with isn't registered", ReturnName(playerid));
	    SCMex(playerid, COLOR_YELLOW, "Please register in order to continue");

        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Welcome to Zone's DM server", "{ffffff}It seems that you are not {ff0000}Registered {ffffff}so kindly please register yourself by entering a new password \nin the space given below:\nthank you!\n\n", "Register", "Close");
		return 1;
	}

	SCMex(playerid, COLOR_YELLOW, "Welcome to Zones DM server!");
	ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Welcome to Zone's DM server", "{ffffff}It seems that you already have an account, so kindly please {ff0000}Login {ffffff}by entering your \npassword in the given section below:\nThank you!\n\n", "Login", "Close");
	return 1;
}

function:OnPlayerRegister(playerid)
{
	PlayerInfo[playerid][pDBID] = cache_insert_id();
	format(PlayerInfo[playerid][pAccName], 32, "%s", ReturnName(playerid));

	new thread[128];

	mysql_format(ourConnection, thread, sizeof(thread), "SELECT * FROM accounts WHERE acc_name = '%e'", ReturnName(playerid));
	mysql_tquery(ourConnection, thread, "Query_LoadAccount", "i", playerid);

	PlayerInfo[playerid][pLoggedin] = true;
}

function:LoggingIn(playerid)
{
	if(!cache_num_rows())
	{
	    PlayerLogin[playerid]++;
        if(PlayerLogin[playerid] == 3)
		{
			SCM(playerid, COLOR_RED, "[SERVER]: You were kicked for bad password attempts.");
			return KickEx(playerid);
		}
		return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Welcome to Zone's DM server", "{ff0000}You entered the wrong password!\nPlease try again and enter your password in the space given below:\nthank you!", "Login", "Cancel");
	}

    new thread[128];

	mysql_format(ourConnection, thread, sizeof(thread), "SELECT * FROM accounts WHERE acc_name = '%e'", ReturnName(playerid));
	mysql_tquery(ourConnection, thread, "Query_LoadAccount", "i", playerid);

    PlayerInfo[playerid][pDBID] = cache_insert_id();
	format(PlayerInfo[playerid][pAccName], 32, "%s", ReturnName(playerid));

	PlayerInfo[playerid][pLoggedin] = true;
	return 1;
}

function:Query_LoadAccount(playerid)
{
	PlayerInfo[playerid][pAdmin] = cache_get_field_content_int(0, "Admin", ourConnection);
    PlayerInfo[playerid][pDBID] = cache_get_field_content_int(0, "acc_dbid", ourConnection);
    PlayerInfo[playerid][pCash] = cache_get_field_content_int(0, "Cash", ourConnection);
	PlayerInfo[playerid][pScore] = cache_get_field_content_int(0, "Score", ourConnection);
	PlayerInfo[playerid][pSkin] = cache_get_field_content_int(0, "Skin", ourConnection);

	GivePlayerMoney(playerid, PlayerInfo[playerid][pCash]);
	SetPlayerScore(playerid, PlayerInfo[playerid][pScore]);
	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 384.3023,-2080.2852,7.8301,0.1614,0,0,0,0,0,0);
	
	SpawnPlayer(playerid);
	return 1;
}