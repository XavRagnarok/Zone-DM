/* 
dialogs
*/


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