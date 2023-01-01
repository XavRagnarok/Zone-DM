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
            		if(dm[playerid] == 3 || dm[playerid] == 2 || dm[playerid] == 1) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500,3);
					DDM(playerid);
					format(string, sizeof(string), "%s(%d) has joined the Deagle Deathmatch", GetName(playerid), playerid);
	    			SCMall(COLOR_BLUE, string);
	        	}
            	if(listitem == 1)
            	{
            		new string[128];
            		if(dm[playerid] == 3 || dm[playerid] == 2 || dm[playerid] == 1) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500,3);
					SPASDM(playerid);
					format(string, sizeof(string), "%s(%d) has joined the combat Shotgun Deathmatch", GetName(playerid), playerid);
	    			SCMall(COLOR_BLUE, string);
	        	}
            	if(listitem == 2)
            	{
            		new string[128];
            		if(dm[playerid] == 3 || dm[playerid] == 2 || dm[playerid] == 1) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500,3);
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

 		// Vehicle save related

        case DIALOG_VEHICLE_SAVE_SLOTS:
        {
        	if(response)
        	{
        		if(listitem == 0)
        		{
        			ShowPlayerDialog(playerid, DIALOG_VEHICLE_SAVE_SLOT_INPUT1, DIALOG_STYLE_INPUT, "Slot 1", "{ffffff}Please enter the name of your Slot in the space\ngiven down below.", "Enter", "Close");
        		}
        		if(listitem == 1)
        		{
        			ShowPlayerDialog(playerid, DIALOG_VEHICLE_SAVE_SLOT_INPUT2, DIALOG_STYLE_INPUT, "Slot 2", "{ffffff}Please enter the name of your Slot in the space\ngiven down below.", "Enter", "Close");
        		}
        		if(listitem == 2)
        		{
        			ShowPlayerDialog(playerid, DIALOG_VEHICLE_SAVE_SLOT_INPUT3, DIALOG_STYLE_INPUT, "Slot 3", "{ffffff}Please enter the name of your Slot in the space\ngiven down below.", "Enter", "Close");
        		}
        		if(listitem == 3)
        		{
        			ShowPlayerDialog(playerid, DIALOG_VEHICLE_SAVE_SLOT_INPUT4, DIALOG_STYLE_INPUT, "Slot 4", "{ffffff}Please enter the name of your Slot in the space\ngiven down below.", "Enter", "Close");
        		}
        		if(listitem == 4)
        		{
        			ShowPlayerDialog(playerid, DIALOG_VEHICLE_SAVE_SLOT_INPUT5, DIALOG_STYLE_INPUT, "Slot 5", "{ffffff}Please enter the name of your Slot in the space\ngiven down below.", "Enter", "Close");
        		}
        	}
        }

        case DIALOG_VEHICLE_SAVE_SLOT_INPUT1:
        {	
        	if(strlen(inputtext) <=3 || strlen(inputtext) > 32)
        	{
        		return SendClientMessage(playerid, COLOR_RED, "Your text must be greater than 3 and less than 32");
        	}
        }
        case DIALOG_VEHICLE_SAVE_SLOT_INPUT2:
        {
        	if(strlen(inputtext) <=3 || strlen(inputtext) > 32)
        	{
        		return SendClientMessage(playerid, COLOR_RED, "Your text must be greater than 3 and less than 32");
        	}
        }
        case DIALOG_VEHICLE_SAVE_SLOT_INPUT3:
        {
        	if(strlen(inputtext) <=3 || strlen(inputtext) > 32)
        	{
        		return SendClientMessage(playerid, COLOR_RED, "Your text must be greater than 3 and less than 32");
        	}
        }
        case DIALOG_VEHICLE_SAVE_SLOT_INPUT4:
        {
        	if(strlen(inputtext) <=3 || strlen(inputtext) > 32)
        	{
        		return SendClientMessage(playerid, COLOR_RED, "Your text must be greater than 3 and less than 32");
        	}if(response)
        	{

        	}
        }
        case DIALOG_VEHICLE_SAVE_SLOT_INPUT5:
        {
        	if(strlen(inputtext) <=3 || strlen(inputtext) > 32)
        	{
        		return SendClientMessage(playerid, COLOR_RED, "Your text must be greater than 3 and less than 32");
        	}
        }
 	}
	return 1;
}