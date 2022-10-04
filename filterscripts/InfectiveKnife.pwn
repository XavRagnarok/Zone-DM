#include <a_samp>
#include <zcmd>

#define FILTERSCRIPT

//Here you can change the cost of the infective knife
#define KNIFE_COST 1000

forward Damage(playerid);
new infect[MAX_PLAYERS];
new damage[MAX_PLAYERS];
new timer;

stock RemovePlayerWeapon(playerid, weaponid)
{
	new plyWeapons[12];
	new plyAmmo[12];

	for(new slot = 0; slot != 12; slot++)
	{
		new wep, ammo;
		GetPlayerWeaponData(playerid, slot, wep, ammo);

		if(wep != weaponid)
		{
			GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
		}
	}

	ResetPlayerWeapons(playerid);
	for(new slot = 0; slot != 12; slot++)
	{
		GivePlayerWeapon(playerid, plyWeapons[slot], plyAmmo[slot]);
	}
}

public OnFilterScriptInit()
{
	print("Infective Knife FilterScript Loaded");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	infect[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    infect[playerid] = 0;
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
	if(weaponid == 4 && infect[playerid] == 1)
	{
		timer = SetTimerEx("Damage",1000,true,"i",damagedid);
		infect[playerid] = 0;
	}
	return 1;
}

public Damage(playerid)
{
	if(damage[playerid] == 5)
	{
		KillTimer(timer);
		damage[playerid] = 0;
		RemovePlayerWeapon(playerid, 4);
		return 0;
	}
	new Float:hp;
	GetPlayerHealth(playerid, hp);
	SetPlayerHealth(playerid, hp-10);
	damage[playerid]++;
	return 1;
}

CMD:iknife(playerid,params[])
{
	if(GetPlayerMoney(playerid) < KNIFE_COST) return GameTextForPlayer(playerid,"~g~You dont have enough money to buy the ~w~infective knife",4500,3);
	new str[50];
	GivePlayerMoney(playerid, -KNIFE_COST);
    GivePlayerWeapon(playerid, 4, 1);
    format(str,sizeof(str),"~g~You bougth an~n~~w~infective knife~n~COST: $%d", KNIFE_COST);
    GameTextForPlayer(playerid,str,4500,3);
    infect[playerid] = 1;
	return 1;
}
