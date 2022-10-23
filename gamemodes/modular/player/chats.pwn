// all commands related chats are here. Also functions.

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success)
	{
		return SCM(playerid, COLOR_GREY, "The cmd does not exist, please use /help");
	}
	return 1;
}

// ============================================= COMMANDS ====================================

CMD:pms(playerid,params[])
{
    if(PlayerInfo[playerid][PMS] == 0)
    {
        PlayerInfo[playerid][PMS] = 1;
        SCM(playerid, COLOR_CYAN, "Your PMS is set to {00FF00}ON");
    }
    else if(PlayerInfo[playerid][PMS] == 1)
    {
        PlayerInfo[playerid][PMS] = 0;
        SCM(playerid, COLOR_CYAN, "Your PMS is set [FF0000}OFF");
    }
    return 1;
}

CMD:pm(playerid, params[])
{
    new playerb, str[500], ip[16];
    
    if(sscanf(params, "us[500]", playerb, params))
 	{
		return SCM(playerid, COLOR_RED, "Usage: /pm [id] [text]");
	}
	
	if(playerb == INVALID_PLAYER_ID)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}

	if(playerb == playerid)
	{
		return SCM(playerid, COLOR_RED, "You cannot PM yourself");
	}
	
	if(PlayerInfo[playerb][PMS] == 0)
	{
		return SCM(playerid, COLOR_CYAN, "Player has {FF0000}Disabled {1fe0ddFF}their pms");
	}
	
	if(PlayerInfo[playerid][PMS] == 0)
	{
 		SCM(playerid,COLOR_CYAN, "You have {FF0000}disabled {1fe0ddFF}your pms");
		return SCM(playerid, COLOR_RED, "Type /pms to enable your pms");
	}
	
	GetPlayerIp(playerid, ip, sizeof(ip));
    format(str, sizeof(str), "PM to %s(%d): %s", ReturnName(playerb), playerb, params);
    SCM(playerid, COLOR_YELLOW, str);
    pPM[playerb] = playerb;
    pPM[playerid] = playerid;
    format(str, sizeof(str), "PM from %s(%d): %s", ReturnName(playerid), playerid, params);
    SCM(playerb, COLOR_YELLOWD, str);
    return 1;
}

CMD:r(playerid, params[])
{
    new str[128], ip[16],playerb = pPM[playerb];
    
    if(playerb == -1)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}
	
	if(!IsPlayerConnected(playerb))
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}

	GetPlayerIp(playerid, ip, sizeof(ip));
	
    if(IsPlayerConnected(playerb))
    {
        if(isnull(params))
		{
			return SCM(playerid, COLOR_RED, "Usage: /r (text)");
		}
	    format(str, sizeof(str), "PM to %s(%d): %s", ReturnName(playerb), playerb, params);
        SCM(playerid, COLOR_YELLOW, str);
        format(str, sizeof(str), "PM from %s(%d): %s", GetName(playerid), playerid, params);
        SCM(playerb, COLOR_YELLOWD, str);
    }
    else return SCM(playerid, COLOR_RED, "Player is not connected");
    return 1;
}