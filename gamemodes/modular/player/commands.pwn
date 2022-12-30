// all commands are here

CMD:savecar(playerid, params[])
{

	return 1;
}

CMD:playsound(playerid, params[])
{
	new soundid;
	if(sscanf(params, "i", soundid))
	{
		return SendClientMessage(playerid, COLOR_RED, "Error");
	}
	PlayerPlaySound(playerid, soundid, 0.0, 0.0, 0.0);
	return 1;
}

CMD:countdown(playerid, params[])
{
	if(activecount == 1)
	{
		return SendClientMessage(playerid, COLOR_RED, "You already have active countdown");
	}
	else
	SetTimer("count5", 1000, false);
	SendClientMessage(playerid, COLOR_CYAN, "Countdown Starting!!");
	activecount = 1;
	return 1;
}

CMD:mark(playerid, params[])
{
	new string[500];

	GetPlayerPos(playerid, Float:markx, Float:marky, Float:markz);
	GetPlayerFacingAngle(playerid, Float:marka);

	format(string, sizeof(string), "You have Marked this location {FFFFFF}({00FF00}%f{FFFFFF}, {00FF00}%f{FFFFFF}, {00FF00}%f{FFFFFF}) (x, y, z)", Float:markx, Float:marky, Float:markz);
	SendClientMessage(playerid, COLOR_CYAN, string);

	SetPlayerMapIcon(playerid, mark, markx, marky, markz, 56, 0, MAPICON_LOCAL);
	markplaced = true;
	return 1;
}

CMD:gotomark(playerid, params[])
{
	if(!markplaced)
	{
		return SendClientMessage(playerid, COLOR_RED, "You have placed no mark. Place a mark using {00FF00}/mark {FF0000}cmd");
	}

	SetPlayerPos(playerid, markx, marky, markz);
	SetPlayerFacingAngle(playerid, marka);

	SendClientMessage(playerid, COLOR_CYAN, "Teleported to your last marked location");
	return 1;
}

CMD:removemark(playerid, params[])
{
	if(!markplaced)
	{
		return SendClientMessage(playerid, COLOR_RED, "There's no mark placed to remove.");
	}

	markplaced = false;

	RemovePlayerMapIcon(playerid, mark);
	SendClientMessage(playerid, COLOR_CYAN, "You have removed your last placed mark");
	return 1;
}

CMD:admins(playerid, params[])
{
	new count = 0, string[256];
	SCM(playerid, COLOR_CYAN,"Current online admins:");
	foreach(new i : Player)
	{
		format(string, sizeof(string),"{00FF00}%s(%d)   %s",ReturnName(i), i, StaffRank(PlayerInfo[playerid][pAdmin]));
		SendClientMessage(playerid, COLOR_CYAN, string);
		count++;
	}
	if(!count) SendClientMessage(playerid, COLOR_RED,"No admins are online right now!");
	return 1;
}

CMD:dice(playerid, params[])
{
	new string[128];

	if(IsPlayerInLobby(playerid))
	{
		return SendClientMessage(playerid, COLOR_RED, "Please return to lobby in order to use this command");
	}

	format(string, sizeof(string), "* %s rolls a dice and it lands on {FFC500}%d.", ReturnName(playerid), minrand(1, 7));
	SendClientMessageToAll(COLOR_CYAN, string);
	return 1;
}

CMD:jetpack(playerid, params[])
{
	if(IsPlayerInLobby(playerid))
	{
		return SendClientMessage(playerid, COLOR_RED, "Please return to lobby in order to use this command");
	}

    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USEJETPACK);
	return 1;
}

CMD:kill(playerid, params[])
{
	if(IsPlayerInLobby(playerid))
	{
		return SendClientMessage(playerid, COLOR_RED, "Please return to lobby in order to use this command");
	}

	SetPlayerHealth(playerid, 0);
	return 1;
}

CMD:skin(playerid, params[])
{
	new skinid;

	if(sscanf(params, "i", skinid))
	    return SCM(playerid, COLOR_RED, "Usage: /skin [ID]");

	if(skinid < 1 || skinid > 300)
	{
		return SCM(playerid, COLOR_RED, "Please choose a skin from 1 - 300");
	}

	if(IsPlayerInLobby(playerid))
	{
		return SendClientMessage(playerid, COLOR_RED, "Please return to lobby in order to use this command");
	}

	SetPlayerSkin(playerid, skinid);

	PlayerInfo[playerid][pSkin] = skinid;



	return 1;
}

CMD:w(playerid, params[])
{
	new weapon[30], ammo, gunname[32];

	if(sscanf(params, "s[30]i", weapon, ammo))
	{
	    return SCM(playerid, COLOR_RED, "Usage: /w [weaponname], [AMMO]");
	}

	new gun = GetWeaponID(weapon);

	if(gun < 1 || gun > 46)
	{
		return SCM(playerid, COLOR_RED, "Invalid Weapon!");
	}

	if(ammo < 1 || ammo > 999)
	{
		return SCM(playerid, COLOR_RED, "[SERVER]: You have specified invalid ammo amount");
	}

	if(IsPlayerInLobby(playerid))
	{
		return SendClientMessage(playerid, COLOR_RED, "Please return to lobby in order to use this command");
	}

	GivePlayerWeapon(playerid, gun, ammo);

	GetWeaponName(gun, gunname, sizeof(gunname));

	SCMex(playerid, COLOR_CYAN, "Enjoy your %s, prick", gunname);

	return 1;
}

CMD:arm(playerid, params[])
{
    new amount;

    if(sscanf(params, "i", amount))
    {
        return SCM(playerid, COLOR_RED, "Usage: /arm [0-100]");
    }

    if(amount < 0 || amount > 100)
    {
        return SCM(playerid, COLOR_RED, "You have specified invalid amount");
    }

    if(IsPlayerInLobby(playerid))
	{
		return SendClientMessage(playerid, COLOR_RED, "Please return to lobby in order to use this command");
	}

    SetPlayerArmour(playerid, amount);

    SCM(playerid, COLOR_CYAN, "You have been given an armour");

    return 1;
}

CMD:v(playerid, params[])
{
	new model[20], modelid, Float:x, Float:y, Float:z, Float:a, vehicleid;

	GetPlayerPos(playerid, Float:x, Float:y, Float:z);
	GetPlayerFacingAngle(playerid, Float:a);

	if(sscanf(params, "s[20]", model))
	    return SCM(playerid, COLOR_RED, "Usage: /v [vehicle id 400-611]");

	if((modelid = GetVehicleModelByName(model)) == 0)
	{
	    return SendClientMessage(playerid, COLOR_RED, "Invalid vehicle model.");
	}

	if(IsPlayerInAnyVehicle(playerid) == 1)
	{
		DestroyVehicle(GetPlayerVehicleID(playerid));
	}

	if(IsPlayerInLobby(playerid))
	{
		return SendClientMessage(playerid, COLOR_RED, "Please return to lobby in order to use this command");
	}

 	vehicleid = AddStaticVehicleEx(modelid, x, y, z, a, 0, 0, 0, 0);

 	PutPlayerInVehicle(playerid, vehicleid, 0);

	SCMex(playerid, COLOR_CYAN, "You have Successfully spawned a vehicle (%s)", GetVehicleName(vehicleid));

	return 1;
}

CMD:help(playerid, params[])
{
    ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_LIST, "Click any following section to get help", "1) Account\n2) Rules\n3) VIP", "Select", "Close");

	return 1;
}

//==============================teleports=========================

CMD:ls(playerid, params[])
{
	if(IsPlayerInLobby(playerid))
	{
		return SendClientMessage(playerid, COLOR_RED, "Please return to lobby in order to use this command");
	}

	SetPlayerPos(playerid, 1519.6636, -1679.0535, 12.8015);
	return 1;
}

CMD:spawn(playerid, params[])
{
	if(IsPlayerInLobby(playerid))
	{
		return SendClientMessage(playerid, COLOR_RED, "Please return to lobby in order to use this command");
	}

	SetPlayerPos(playerid, 384.3023,-2080.2852,7.8301);
	return 1;
}

CMD:lvpd(playerid, params[])
{

	if(IsPlayerInLobby(playerid))
	{
		return SendClientMessage(playerid, COLOR_RED, "Please return to lobby in order to use this command");
	}

	SetPlayerInterior(playerid, 3);
	SetPlayerPos(playerid, 288.745971,169.350997,1007.171875);
	return 1;
}

CMD:lsap(playerid, params[])
{
	if(IsPlayerInLobby(playerid))
	{
		return SendClientMessage(playerid, COLOR_RED, "Please return to lobby in order to use this command");
	}

	SetPlayerPos(playerid, 1986.7233,-2324.0649,13.5469);
	return 1;
}

//=============================Animations======================

CMD:handsup(playerid, params[])
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
	SCM(playerid, COLOR_GREY, "[SERVER]: To stop animation please use cmd (/sa) or press (F)");
	return 1;
}

CMD:dance(playerid, params[])
{
	new danceid;

	if(sscanf(params, "i", danceid))
	    return SCM(playerid, COLOR_RED, "Usage: /dance [1-4]");

	if(danceid == 1)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
		SCM(playerid, COLOR_GREY, "[SERVER]: To stop animation please use cmd (/sa) or press (F)");
		return 1;
	}
 	if(danceid == 2)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
		SCM(playerid, COLOR_GREY, "[SERVER]: To stop animation please use cmd (/sa) or press (F)");
		return 1;
	}

	if(danceid == 3)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
		SCM(playerid, COLOR_GREY, "[SERVER]: To stop animation please use cmd (/sa) or press (F)");
		return 1;
	}

	if(danceid == 4)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
		SCM(playerid, COLOR_GREY, "[SERVER]: To stop animation please use cmd (/sa) or press (F)");
		return 1;
	}

	if(danceid < 1 || danceid > 4)
	    return SCM(playerid, COLOR_RED, "Usage: /dance [1-4]");

	return 1;
}

CMD:sa(playerid, params[])
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	return 1;
}