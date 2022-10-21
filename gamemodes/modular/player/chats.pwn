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
    if(pms[playerid] == 0)
    {
        pms[playerid] = 1;
        SCM(playerid, COLOR_CYAN, "Your PMS is set to ON");
    }
    else if(pms[playerid] == 1)
    {
        pms[playerid] = 0;
        SCM(playerid, COLOR_CYAN, "Your PMS is set OFF");
    }
    return 1;
}

CMD:pm(playerid, params[])
{
    new id, str[500], ip[16];
    
    if(sscanf(params, "us[500]", id, params))
 	{
		return SCM(playerid, COLOR_RED, "Usage: /pm [id] [text]");
	}
	
	if(id == INVALID_PLAYER_ID)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}
	
	if(pms[id] == 0)
	{
		return SCM(playerid, COLOR_RED, "Player has Disabled their pms");
	}
	
	if(pms[playerid] == 0)
	{
 		SCM(playerid,COLOR_RED, "You have disabled your pms");
		return SCM(playerid, COLOR_RED, "Type /pms to enable your pms");
	}
	
	GetPlayerIp(playerid, ip, sizeof(ip));
    format(str, sizeof(str), "PM to %s(%d): %s", GetName(id), id, params);
    SCM(playerid, COLOR_YELLOW, str);
    pPM[playerid] = id;
    pPM[id] = playerid;
    format(str, sizeof(str), "PM from %s(%d): %s", GetName(playerid), playerid, params);
    SCM(id, COLOR_YELLOWD, str);
    return 1;
}

CMD:r(playerid, params[])
{
    new str[128], ip[16],id = pPM[playerid];
    
    if(id == -1)
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}
	
	if(!IsPlayerConnected(id))
	{
		return SCM(playerid, COLOR_RED, "Player is not connected");
	}

	GetPlayerIp(playerid, ip, sizeof(ip));
	
    if(IsPlayerConnected(id))
    {
        if(isnull(params))
		{
			return SCM(playerid, COLOR_RED, "Usage: /r (text)");
		}
	    format(str, sizeof(str), "PM to %s(%d): %s", GetName(id), id, params);
        SCM(playerid, COLOR_YELLOW, str);
        format(str, sizeof(str), "PM from %s(%d): %s", GetName(playerid), playerid, params);
        SCM(id, COLOR_YELLOWD, str);
    }
    else return SCM(playerid, COLOR_RED, "Player is not connected");
    return 1;
}