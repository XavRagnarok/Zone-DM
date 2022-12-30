// functions/stocks etc are all here.

stock GetPlayerFPS(playerid)
{
	SetPVarInt(playerid, "DrunkL", GetPlayerDrunkLevel(playerid));
	if(GetPVarInt(playerid, "DrunkL") < 100) SetPlayerDrunkLevel(playerid, 2000);
	else
	{
		if(GetPVarInt(playerid, "LDrunkL") != GetPVarInt(playerid, "DrunkL"))
		{
			SetPVarInt(playerid, "FPS", (GetPVarInt(playerid, "LDrunkL") - GetPVarInt(playerid, "DrunkL")));
			SetPVarInt(playerid, "LDrunkL", GetPVarInt(playerid, "DrunkL"));
			if((GetPVarInt(playerid, "FPS") > 0) && (GetPVarInt(playerid, "FPS") < 256)) return GetPVarInt(playerid, "FPS") - 1;
		}
	}
	return 0;
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

stock ReturnDate()
{
	new sendString[90], MonthStr[40], month, day, year;
	new hour, minute, second;

	gettime(hour, minute, second);
	getdate(year, month, day);
	switch(month)
	{
	    case 1:  MonthStr = "January";
	    case 2:  MonthStr = "February";
	    case 3:  MonthStr = "March";
	    case 4:  MonthStr = "April";
	    case 5:  MonthStr = "May";
	    case 6:  MonthStr = "June";
	    case 7:  MonthStr = "July";
	    case 8:  MonthStr = "August";
	    case 9:  MonthStr = "September";
	    case 10: MonthStr = "October";
	    case 11: MonthStr = "November";
	    case 12: MonthStr = "December";
	}

	format(sendString, 90, "%s %d, %d %02d:%02d:%02d", MonthStr, day, year, hour, minute, second);
	return sendString;
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

stock GetVehicleName(vehicleid)
{
	new
		modelid = GetVehicleModel(vehicleid),
		name[32];

	if(400 <= modelid <= 611)
	    strcat(name, vehicleNames[modelid - 400]);
	else
	    name = "Unknown";

	return name;
}

stock GetVehicleModelByName(const string[])
{
	new
	    modelid = strval(string);

	if(400 <= modelid <= 611)
	{
	    return modelid;
	}

	for(new i = 0; i < sizeof(vehicleNames); i ++)
	{
		if(strfind(vehicleNames[i], string, true) != -1)
  		{
			return i + 400;
		}
	}

	return 0;
}

function:KickTimer(playerid) 
{ 
	return Kick(playerid); 
}

GetWeaponID(weaponname[]) {
	for(new i = 0; i < 55; ++i) {
		if(strfind(WeaponNames[i], weaponname, true) != -1)
		return i;
	}
	return -1;
}

stock minrand(min, max) //By Alex "Y_Less" Cole for use in /veh
{
	return random(max - min) + min;
}

function:IsPlayerInLobby(playerid)
{
	if(dm[playerid] == 1 || dm[playerid] == 2 || dm[playerid] == 3 || RACE_pInfo[playerid][RACE_isPlayerInRace] == true)
	{
		return true;
	}

	else
		return false;
}

forward count5(playerid);
public count5(playerid)
{
	SetTimer("count4", 1000, false);
	PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	return SendClientMessage(playerid, COLOR_YELLOW, "5");
}

forward count4(playerid);
public count4(playerid)
{
	SetTimer("count3", 1000, false);
	PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	return SendClientMessage(playerid, COLOR_YELLOW, "4");
}

forward count3(playerid);
public count3(playerid)
{
	SetTimer("count2", 1000, false);
	PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	return SendClientMessage(playerid, COLOR_YELLOW, "3");
}

forward count2(playerid);
public count2(playerid)
{
	SetTimer("count1", 1000, false);
	PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	return SendClientMessage(playerid, COLOR_YELLOW, "2");
}

forward count1(playerid);
public count1(playerid)
{
	SetTimer("countend", 1000, false);
	PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	return SendClientMessage(playerid, COLOR_YELLOW, "1");
}

forward countend(playerid);
public countend(playerid)
{
	activecount = 0;
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	return SendClientMessage(playerid, COL_GREEN, "Start!!");
}