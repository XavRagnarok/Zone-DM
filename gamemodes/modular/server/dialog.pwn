// Dialogs

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		// ===================== LOGIN/REGISTER RELATED ======================
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

		// ================== HELP RELATED ============
		case DIALOG_HELP:
		{
	    	if(response)
	    	{
	    		if(listitem == 0)
	    		{
	        		return ShowPlayerDialog(playerid, DIALOG_ACCOUNT, DIALOG_STYLE_MSGBOX, "Account info", "UnderConstruction", "Close", "");
	    		}
	    		if(listitem == 1)
	    		{
	        		return ShowPlayerDialog(playerid, DIALOG_ACCOUNT, DIALOG_STYLE_MSGBOX, "Rules", "UnderConstruction", "Close", "");
	    		}
	    		if(listitem == 2)
	    		{
	        		return ShowPlayerDialog(playerid, DIALOG_ACCOUNT, DIALOG_STYLE_MSGBOX, "VIP", "UnderConstruction", "Close", "");
	    		}
	    	}
		}

		// ================ DM RELATED ==================
    	case DIALOG_DM:
		{
			if(response)
			{
            	if(listitem == 0)
            	{
            		new string[128];
					DDM(playerid);
					format(string, sizeof(string), "%s(%d) has joined the Deagle Deathmatch", GetName(playerid), playerid);
	    			SCMall(COLOR_BLUE, string);
	        	}
            	if(listitem == 1)
            	{
            		new string[128];
					SPASDM(playerid);
					format(string, sizeof(string), "%s(%d) has joined the combat Shotgun Deathmatch", GetName(playerid), playerid);
	    			SCMall(COLOR_BLUE, string);
	        	}
            	if(listitem == 2)
            	{
            		new string[128];
					SDM(playerid);
					format(string, sizeof(string), "%s(%d) has joined the Sniper Deathmatch", GetName(playerid), playerid);
	    			SCMall(COLOR_BLUE, string);
	        	}
	    	}
    	}
    	/*
    	case DIALOG_CONFIRMDDM:
    	{
        	if(response == 1)
        	{
            	new string[128];
				DDM(playerid);
				format(string, sizeof(string), "%s(%d) has joined the Deagle Deathmatch", GetName(playerid), playerid);
	    		SCMall(COLOR_BLUE, string);
        	}
        	else if(response == 0)
        	{
            	SCM(playerid, COLOR_RED, "You have Chosen Not to enter inside Deagle Deathmatch");
        	}
    	}

    	case DIALOG_CONFIRMSDM:
    	{
        	if(response == 1)
        	{
            	new string[128];
				SDM(playerid);
				format(string, sizeof(string), "%s(%d) has joined the Sniper Deathmatch", GetName(playerid), playerid);
	    		SCMall(COLOR_BLUE, string);
        	}
        	else if(response == 0)
        	{
            	SCM(playerid, COLOR_RED, "You have Chosen Not to enter inside Sniper Deathmatch");
        	}
    	}

    	case DIALOG_CONFIRMSPASDM:
    	{
        	if(response == 1)
        	{
            	new string[128];
				SPASDM(playerid);
				format(string, sizeof(string), "%s(%d) has joined the Sawn off Shotgun Deathmatch", GetName(playerid), playerid);
	    		SCMall(COLOR_BLUE, string);
        	}
        	else if(response == 0)
        	{
            	SCM(playerid, COLOR_RED, "You have Chosen Not to enter inside Combat Shotgun Deathmatch");
        	}
    	}
		*/
		
    	// RACE RELATED

    	case DIALOG_RACE:
    	{
        	if(response)
        	{
				RACE_prepareEvent(listitem);
			}
    	}
		
		#if defined RACE_OnDialogResponse
        	RACE_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
    	#endif

 	}
	return 1;
}