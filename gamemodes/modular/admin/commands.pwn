// admin related commands.

CMD:setadmin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4 || IsPlayerAdmin(playerid))
	{
		new playerb, adminlvl, insert[128];

		if(sscanf(params, "ui", playerb, adminlvl))
	    {
	        return SCM(playerid, COLOR_RED, "Usage: /setadmin [id/name] [Level 1-2]");
	    }

        if(playerb == INVALID_PLAYER_ID)
		{
			return SCM(playerid, COLOR_RED, "player is not connected");
		}

		if(!IsPlayerAdmin(playerid))
		{
			if(playerb == playerid)
			{
				return SCM(playerid, COLOR_RED, "You cannot set yourself an admin level");
			}
		}

  		if(adminlvl < 1 || adminlvl > 5)
   		{
   			return SCM(playerid, COLOR_RED, "[SERVER]: Invalid Admin Level");
   		}

		SCMex(playerid, COLOR_CYAN, "You've just made %s a %s", ReturnName(playerb), StaffRank(adminlvl));
		SCMex(playerb, COLOR_CYAN, "You've just been made %s", StaffRank(adminlvl));

		PlayerInfo[playerb][pAdmin] = adminlvl;

		mysql_format(ourConnection, insert, sizeof(insert), "UPDATE accounts SET Admin = %i WHERE acc_dbid = %i", adminlvl, PlayerInfo[playerb][pDBID]);
		mysql_tquery(ourConnection, insert);
	}
	else return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");

	return 1;
}

CMD:radmin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2 || IsPlayerAdmin(playerid))
	{
		new playerb, insert[128];

		if(sscanf(params, "ui", playerb))
	        return SCM(playerid, COLOR_RED, "Usage: /radmin [id/name]");

        if(playerb == INVALID_PLAYER_ID)
			return SCM(playerid, COLOR_RED, "player is not connected");

		if(!IsPlayerAdmin(playerid))
		{
			if(playerb == playerid)
			{
				return SCM(playerid, COLOR_RED, "You cannot remove yourself from admin");
			}
		}

		SCMex(playerid, COLOR_CYAN, "You've just now removed admin permissions from %s", ReturnName(playerb));
		SCMex(playerb, COLOR_RED, "Admin permissions has been taken from you");

		mysql_format(ourConnection, insert, sizeof(insert), "UPDATE accounts SET Admin = 0 WHERE acc_dbid = %i", PlayerInfo[playerb][pDBID]);
		mysql_tquery(ourConnection, insert);
	}
	else return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");
	return 1;
}

CMD:aduty(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		if(aduty[playerid] == 1) 
		{	
			aduty[playerid] = 0;
			SetPlayerHealth(playerid,100.0);
			SetPlayerChatBubble(playerid," ",0xFF0000FF, 100.0, 1000);
			new string[128];
			format(string,sizeof(string),"{ff0000}[Administrator]%s is now off duty", ReturnName(playerid));
			SendClientMessageToAll(-1,string);
			return 1;
		}

		aduty[playerid] = 1;
		SetPlayerChatBubble(playerid,"Administrator",-1,100.0,99999999);
		new string[128];
		format(string,sizeof(string),"{ff0000}[Administrator]%s is on duty", ReturnName(playerid));
		SendClientMessageToAll(-1,string);
	}

	else return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");

	return 1;
}

CMD:setap(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1)
	    return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");

	if(aduty[playerid] == 0)
	{
		return SCM(playerid, COLOR_RED,"You are not on admin duty");
	}

	new playerb, amount;

	if(sscanf(params, "ui", playerb, amount))
	    return SCM(playerid, COLOR_RED, "Usage: /setap [name/id] [amount 0-100]");
	    
    if(playerb == INVALID_PLAYER_ID)
		return GameTextForPlayer(playerid,"~g~player is not connected",4500,4);

	if(amount < 0 || amount > 100)
	    return SCM(playerid, COLOR_RED, "[SERVER]: Invalid armour amount");

	SCMex(playerid, COLOR_CYAN, "You've just given an armour to %s with an amount of ( %i )", ReturnName(playerb), amount);
	SCMex(playerb, COLOR_CYAN, "You've just been given an armour from admin with an amount of ( %i )", amount);

	SetPlayerArmour(playerb, amount);

	return 1;
}

CMD:agcash(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
	{
	    return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");
	}

	if(aduty[playerid] == 0)
	{
		return SCM(playerid, COLOR_RED,"You are not on admin duty");
	}

	new playerb, cash;

	if(sscanf(params, "ui", playerb, cash))
	{
		return SCM(playerid, COLOR_RED, "Usage: /agcash [name/id] [amount]");
	}
	
	if(playerb == INVALID_PLAYER_ID)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}

 	SCMex(playerid, COLOR_RED, "AdminCmd: You have given $%i cash to %s using admin cmd", cash, ReturnName(playerb));
 	SCMex(playerid, COLOR_CYAN, "AdminCmd: You have received $%i cash from an Admin", cash);

 	GivePlayerMoney(playerb, cash);
	return 1;
}

CMD:arcash(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
	{
	    return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");
	}

	if(aduty[playerid] == 0)
	{
		return SCM(playerid, COLOR_RED,"You are not on admin duty");
	}

	new playerb, cash;

	if(sscanf(params, "ui", playerb, cash))
	{
		return SCM(playerid, COLOR_RED, "Usage: /arcash [name/id] [amount]");
	}
	
	if(playerb == INVALID_PLAYER_ID)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}

 	SCMex(playerid, COLOR_RED, "AdminCmd: You have taken $%i cash from %s using admin cmd", cash, ReturnName(playerb));
 	SCMex(playerid, COLOR_CYAN, "AdminCmd: Your $%i cash has been taken from you from an Admin", cash);

 	GivePlayerMoney(playerb, - cash);
	return 1;
}

CMD:agscore(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
	{
	    return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");
	}

	if(aduty[playerid] == 0)
	{
		return SCM(playerid, COLOR_RED,"You are not on admin duty");
	}

	new playerb, score;
	new oscore = GetPlayerScore(playerid);

	if(sscanf(params, "ui", playerb, score))
	{
	    return SCM(playerid, COLOR_RED, "Usage: /agscore [name/id] [score 1 - 100000]");
	}
	
	if(playerb == INVALID_PLAYER_ID)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}
	
	if(score < 1 || score > 100000)
	{
	    return SCM(playerid, COLOR_RED, "You have put an invalid score");
	}

	SCMex(playerid, COLOR_RED, "AdminCmd: You have given %i score to %s using admin cmd", score, ReturnName(playerb));
	SCMex(playerid, COLOR_CYAN, "AdminCmd: You have been given %i score by an Admin", score);

	SetPlayerScore(playerb, oscore + score);
	return 1;
}

CMD:arscore(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
	{
	    return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");
	}

	if(aduty[playerid] == 0)
	{
		return SCM(playerid, COLOR_RED,"You are not on admin duty");
	}

	new playerb, score;
	new oscore = GetPlayerScore(playerid);
	
    if(sscanf(params, "ui", playerb, score))
	{
	    return SCM(playerid, COLOR_RED, "Usage: /arscore [name/id] [score 1 - 100000]");
	}
	
	if(playerb == INVALID_PLAYER_ID)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}
	
	if(score < 0  || score > 100000)
	{
	    return SCM(playerid, COLOR_RED, "You have put an invalid score");
	}

	SCMex(playerid, COLOR_RED, "AdminCmd: You have removed %i score from %s using admin cmd", score, ReturnName(playerb));
	SCMex(playerid, COLOR_CYAN, "AdminCmd: %i score has been removed from you by an Admin", score);

	SetPlayerScore(playerb, oscore - score);
	return 1;
}

CMD:kick(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1)
	    return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");

	if(aduty[playerid] == 0)
	{
		return SCM(playerid, COLOR_RED,"You are not on admin duty");
	}

	new playerb, reason[80];
	if(sscanf(params, "us[80]", playerb, reason))
	    return SCM(playerid, COLOR_RED, "Usage: /kick [id/name] [reason]");

    if(playerb == INVALID_PLAYER_ID)
		return SCM(playerid, COLOR_RED, "Player is not connected");

	SCMex(playerid, COLOR_CYAN, "You've just kicked %s Reason: %s", ReturnName(playerb), reason);
	SCMex(playerb, COLOR_RED, "You've just got kicked by an Admin");
	SCMex(playerb, COLOR_RED, "Reason: %s", reason);
	KickEx(playerb);
	return 1;
}

CMD:goto(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1)
	{
		return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");
	}

	if(aduty[playerid] == 0)
	{
		return SCM(playerid, COLOR_RED,"You are not on admin duty");
	}

	new playerb, Float:x, Float:y, Float:z;
	if(sscanf(params, "u", playerb))
	{
	    return SCM(playerid, COLOR_RED, "Usage: /goto [id/name]");
	}

    if(playerb == INVALID_PLAYER_ID)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}

	if(playerb == playerid)
	{
		return SCM(playerid, COLOR_RED, "Nice try :)");
	}

	GetPlayerPos(playerb, Float:x, Float:y, Float:z);
	SetPlayerPos(playerid, x, y, z);

	SCMex(playerid, COLOR_CYAN, "You've just teleported to %s", ReturnName(playerb));
	SCMex(playerb, COLOR_RED, "An Admin teleported to you");

	return 1;
}

CMD:get(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1)
	{
		return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");
	}

	if(aduty[playerid] == 0)
	{
		return SCM(playerid, COLOR_RED,"You are not on admin duty");
	}

	new playerb, Float:x, Float:y, Float:z;
	if(sscanf(params, "u", playerb))
	{
	    return SCM(playerid, COLOR_RED, "Usage: /get [id/name]");
	}

    if(playerb == INVALID_PLAYER_ID)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}

	if(playerb == playerid)
	{
		return SCM(playerid, COLOR_RED, "Nice try :)");
	}

	GetPlayerPos(playerid, Float:x, Float:y, Float:z);
	SetPlayerPos(playerb, x, y, z);

	SCMex(playerid, COLOR_CYAN, "You've just teleported %s to yourself", ReturnName(playerb));
	SCMex(playerb, COLOR_RED, "An Admin teleported you to him");
	return 1;
}

CMD:slap(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1)
	{
		return SCM(playerid, COLOR_RED, "You don't have permissions to use this command");
	}

	if(aduty[playerid] == 0)
	{
		return SCM(playerid, COLOR_RED,"You are not on admin duty");
	}

	new playerb, Float:x, Float:y, Float:z;
	if(sscanf(params, "u", playerb))
	{
	    return SCM(playerid, COLOR_RED, "Usage: /slap [id/name]");
	}

    if(playerb == INVALID_PLAYER_ID)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}

	GetPlayerPos(playerb, Float:x, Float:y, Float:z);
	SetPlayerPos(playerb, x, y, z + 5);

	PlayerPlaySound(playerb, 1190, 0.0,0.0,0.0);

	SCMex(playerid, COLOR_CYAN, "You've just slapped %s", ReturnName(playerb));
	SCMex(playerb, COLOR_RED, "An Admin slapped you");
	return 1;
}