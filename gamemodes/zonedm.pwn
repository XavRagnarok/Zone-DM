//#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>
#include <sscanf2>
#include <a_mysql>






main()
{
	print("\n----------------------------------");
	print("-----Zone dm script journey---------");
	print("----------------------------------\n");
}

//Database establisher:
new ourConnection;

#define SCRIPT_VERSION "Zone"

//================MySQL Connection:=========================
 
#define SQL_HOSTNAME "127.0.0.1"
#define SQL_USERNAME "Main"
#define SQL_DATABASE "zonedm"
#define SQL_PASSWORD "12345678"
 
//==========================================================


// ========================================================[Modulars]=========================================================

// =======[server]=========

// variables
#include "./modular/server/variable.pwn"

// event.pwn
#include "./modular/server/event.pwn"

// functions
#include "./modular/server/function.pwn"

// =======[player]==========

// event.pwn
#include "./modular/player/event.pwn"

// login/register
#include "./modular/player/account.pwn"

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Zone");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);

	// sql related
	ourConnection = mysql_connect(SQL_HOSTNAME, SQL_USERNAME, SQL_DATABASE, SQL_PASSWORD);
 
    SetGameModeText(SCRIPT_VERSION);
	if(mysql_errno() != 0)
		printf ("[DATABASE]: Connection failed to '%s'...", SQL_DATABASE);
	else printf ("[DATABASE]: Connection established to '%s'...", SQL_DATABASE);
	return 1;
}

public OnGameModeExit()
{
	mysql_close(ourConnection);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if(PlayerInfo[playerid][pLoggedin] == false)
	{
     	SetSpawnInfo( playerid, 0, 0, 563.3157, 3315.2559, 0, 269.15, 0, 0, 0, 0, 0, 0 );
     	TogglePlayerSpectating(playerid, true);
     	TogglePlayerSpectating(playerid, false);
     	SetPlayerCamera(playerid);
    	return 1;
 	}
	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 2098.5088,1159.1156,11.6484, 65.2418, 0, 0, 0, 0, 0, 0 );
 	SpawnPlayer(playerid);
    return 0;
}

public OnPlayerConnect(playerid)
{
	SetPlayerCamera(playerid);
    ResetPlayer(playerid);
 
    new existCheck[248];
 
	mysql_format(ourConnection, existCheck, sizeof(existCheck), "SELECT * FROM accounts WHERE acc_name = '%e'", ReturnName(playerid));
	mysql_tquery(ourConnection, existCheck, "LogPlayerIn", "i", playerid);
	return 1;
}



public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DIALOG_REGISTER:
	    {
			if(!response)
			    return Kick(playerid);

			new insert[256];

			if(strlen(inputtext) > 128 || strlen(inputtext) < 3)
			    return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration page", "{ffffff}Your password length should be in between {ff0000}3 - 128\nPlease enter a new password in the space given below:\nthank you!", "Register", "Close");

			mysql_format(ourConnection, insert, sizeof(insert), "INSERT INTO accounts (acc_name, acc_pass, register_ip, register_date) VALUES('%e', sha1('%e'), '%e', '%e')", ReturnName(playerid), inputtext, ReturnIP(playerid), ReturnDate());
			mysql_tquery(ourConnection, insert, "OnPlayerRegister", "i", playerid);
		}
		case DIALOG_LOGIN:
		{
		    if (!response)
			{
				SendClientMessage(playerid, COLOR_RED, "You were kicked for not logging in.");
				return KickEx(playerid);
			}

			new continueCheck[211];

			mysql_format(ourConnection, continueCheck, sizeof(continueCheck), "SELECT acc_dbid FROM accounts WHERE acc_name = '%e' AND acc_pass = sha1('%e') LIMIT 1", ReturnName(playerid), inputtext);

			mysql_tquery(ourConnection, continueCheck, "LoggingIn", "i", playerid);
			return 1;
		}
	}
	return 1;
}

function:SetPlayerCamera(playerid)
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

// login/register

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
	return 1;
}
 
stock ResetPlayer(playerid)
{
    PlayerInfo[playerid][pLoggedin] = false;
    PlayerInfo[playerid][pSkin] = 0;
    return 1;
}
 
 
//Timers:
 
stock KickTimer(playerid) 
{ 
	return Kick(playerid); 
}