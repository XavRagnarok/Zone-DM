/*
account.pwn
contains account logging in, registering, saving.
*/

function:LogPlayerIn(playerid)
{

	new rows, fields;
	cache_get_data(rows, fields, ourConnection);
	SetPlayerCamera(playerid);
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
	SetPlayerCamera(playerid);
	if(!cache_num_rows())
	{
	    PlayerLogin[playerid]++;
        if(PlayerLogin[playerid] == 3)
		{
			SCM(playerid, COLOR_RED, "[SERVER]: You were kicked for bad password attempts.");
			return KickEx(playerid);
		}
		return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Welcome to Zone's DM server", "{ffffff}You entered the {ff0000}wrong {ffffff}password!\nPlease try again and enter your password in the space given below:\nthank you!", "Login", "Cancel");
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
    PlayerInfo[playerid][pCash] = cache_get_field_content_int(0, "Cash", ourConnection), GivePlayerMoney(playerid, PlayerInfo[playerid][pCash]);
	PlayerInfo[playerid][pScore] = cache_get_field_content_int(0, "Score", ourConnection), SetPlayerScore(playerid, PlayerInfo[playerid][pScore]);
	PlayerInfo[playerid][pSkin] = cache_get_field_content_int(0, "Skin", ourConnection), SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 223.0138,-1872.2523,4.4400,1.4446,0,0,0,0,0,0), SpawnPlayer(playerid);
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

