// all commands are here

CMD:jetpack(playerid, params[])
{
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USEJETPACK);
	return 1;
}

CMD:kill(playerid, params[])
{
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

	SetPlayerSkin(playerid, skinid);

	return 1;
}

CMD:w(playerid, params[])
{
	new weaponid, ammo;

	if(sscanf(params, "ii", weaponid, ammo))
	    return SCM(playerid, COLOR_RED, "Usage: /w [ID], [AMMO]");

	if(weaponid < 1 || weaponid > 46 || weaponid == 18)
	    return SCM(playerid, COLOR_RED, "[SERVER]: You have specified a invalid weapon");

	if(ammo < 1)
	    return SCM(playerid, COLOR_RED, "[SERVER]: You have specified invalid ammo amount");

	GivePlayerWeapon(playerid, weaponid, ammo);

	SCM(playerid, COLOR_CYAN, "Enjoy your Weapon, prick");

	return 1;
}

CMD:arm(playerid, params[])
{
    new amount;

    if(sscanf(params, "i", amount))
        return SCM(playerid, COLOR_RED, "Usage: /arm [0-100]");

    if(amount < 0 || amount > 100)
        return SCM(playerid, COLOR_RED, "You have specified invalid amount");

    SetPlayerArmour(playerid, amount);

    SCM(playerid, COLOR_CYAN, "You have been given an armour");

    return 1;
}

CMD:v(playerid, params[])
{
	new model[20], modelid, Float:x, Float:y, Float:z, vehicleid;

	GetPlayerPos(playerid, Float:x, Float:y, Float:z);

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

 	vehicleid = AddStaticVehicleEx(modelid, x, y, z, 2.0, 0, 0, 0, 0);

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
	SetPlayerPos(playerid, 1519.6636, -1679.0535, 12.8015);
	return 1;
}

CMD:lobby(playerid, params[])
{
	SetPlayerPos(playerid, 223.0138,-1872.2523,4.4400);
	return 1;
}

CMD:lvpd(playerid, params[])
{
	SetPlayerInterior(playerid, 3);
	SetPlayerPos(playerid, 288.745971,169.350997,1007.171875);
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