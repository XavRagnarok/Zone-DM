
/*

functions.pwn
contains functions and stocks

*/



GetPlayerNameEx(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

function:KickTimer(playerid) 
{ 
	return Kick(playerid); 
}

stock KickEx(playerid)
{
	return SetTimerEx("KickTimer", 100, false, "i", playerid);
}

stock SendClientMessageEx(playerid, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[156]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 156
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		SendClientMessage(playerid, color, string);

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}
	return SendClientMessage(playerid, color, str);
}

stock ReturnName(playerid, underScore = 1)
{
	new playersName[MAX_PLAYER_NAME + 2];
	GetPlayerName(playerid, playersName, sizeof(playersName));

	if(!underScore)
	{
		{
			for(new i = 0, j = strlen(playersName); i < j; i ++)
			{
				if(playersName[i] == '_')
				{
					playersName[i] = ' ';
				}
			}
		}
	}

	return playersName;
}

stock ReturnIP(playerid)
{
	new
		ipAddress[20];

	GetPlayerIp(playerid, ipAddress, sizeof(ipAddress));
	return ipAddress;
}