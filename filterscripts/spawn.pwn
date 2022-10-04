#include <a_samp>

//////////////////////////// DEFINES ///////////////////////////////////////////

#define FILTERSCRIPT

//////////////////////////// SETTINGS //////////////////////////////////////////

//-------------------------------- Main Settings -------------------------------

// 0 = Off
// 1 = Anti-fall damage
// 2 = Instant Spawn
// 3 = Both

#define METHOD             1


//------------ Others (These settings are related to anti-fall damage) ---------

// 1 = True
// 0 = False

#define SET_INTERIOR       1

#define SET_VIRTUALWORLD   1

#define SAVE_WEAPONS       1

#define EXTRA              1

////////////////////////////////////////////////////////////////////////////////

#if METHOD != 0

	#if SET_INTERIOR != 1 && SET_INTERIOR != 0

		#error expected value 'true' or 'false' in define "SET_INTERIOR"

	#endif

	#if SET_VIRTUALWORLD != 1 && SET_VIRTUALWORLD != 0

		#error expected value 'true' or 'false' in define "SET_VIRTUALWORLD"

	#endif

	#if SAVE_WEAPONS != 1 && SAVE_WEAPONS != 0

		#error expected value 'true' or 'false' in define "SAVE_WEAPONS"

	#endif

	#if EXTRA != 1 && EXTRA != 0

		#error expected value 'true' or 'false' in define "EXTRA"

	#endif

#endif

//////////////////////////// ENUMS /////////////////////////////////////////////

enum data
{
	Float:x,
	Float:y,
	Float:z,
	Float:angle,
	Float:health,
	interior,
	virtualworld
};

/////////////////////////// VARIABLES //////////////////////////////////////////

new SpawnInfo[MAX_PLAYERS][data];
new Weapon[MAX_PLAYERS][11];
new Ammo[MAX_PLAYERS][11];
new Text:Screen;

/////////////////////////// FORWARDS ///////////////////////////////////////////

forward Spawn(playerid);
forward Extra(playerid);
forward OnPlayerInstantSpawn(playerid);

////////////////////////////////////////////////////////////////////////////////

public OnFilterScriptInit()
{
	#if METHOD == 1
	
	print("  Anti-Fall Damage Filterscript Loaded");
	
	#elseif METHOD == 2
	
	print("  Instant Spawn Filterscript Loaded");
	
	#elseif METHOD == 3
	
	print("  Anti-Fall Damage & Instant Spawn Filterscript Loaded");
	
	#endif
	
	#if METHOD != 0
	
		#if EXTRA == 1

			Screen = TextDrawCreate(0.000000, 0.000000, "LD_SPAC:white");
			TextDrawLetterSize(Screen, 0.000000, 0.000000);
			TextDrawTextSize(Screen, 640.000000, 448.000000);
			TextDrawAlignment(Screen, 1);
			TextDrawColor(Screen, 255);
			TextDrawSetShadow(Screen, 0);
			TextDrawSetOutline(Screen, 0);
			TextDrawFont(Screen, 4);

		#endif
	
	#endif
	
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	#if METHOD == 1 || METHOD == 3
	
	if(weaponid == 54 || issuerid == INVALID_PLAYER_ID)
	{
		new Float:HP;
		GetPlayerHealth(playerid, HP);
		
		if(HP < 100.0)
		{
			HP = HP + amount;
			
			SetPlayerHealth(playerid, HP);
			
			if(HP > 100.0) SetPlayerHealth(playerid, 100.0);
		}
	}
	
	#endif
	
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid == INVALID_PLAYER_ID)
	{
        #if METHOD == 1 && METHOD != 2 || METHOD == 3 && METHOD != 2

			#if EXTRA == 1

				TextDrawShowForPlayer(playerid, Screen);

			    SetTimerEx("Extra", 100, false, "i", playerid);

			#endif

			//Saving & Applying data...
		    SaveSpawnInfo(playerid);
		    ApplySpawn(playerid);

		    //Interrupting default spawn process using a timer.
		    SetTimerEx("Spawn", 70, false, "i", playerid); //It takes 30 mili-seconds for a normal computer to complete the spawn config, im not really sure that its the real way how its made in the 'game' but still it works with this methods, ive tried with 29 mili-seconds but it gets bugged because of some issues which i can't explain here

		#endif
	}
	
	#if METHOD == 2 && METHOD != 1 || METHOD == 3 && METHOD != 1

		SetPlayerHealth(playerid, 100);
		SpawnPlayer(playerid);
		SetCameraBehindPlayer(playerid);
		CallLocalFunction("OnPlayerInstantSpawn", "i", playerid);

	#endif
	return 1;
}

/////////////////////////// STOCK & CALLBACKS //////////////////////////////////

stock Clear(playerid)
{
	SpawnInfo[playerid][x] = 0;
	SpawnInfo[playerid][y] = 0;
	SpawnInfo[playerid][z] = 0;
	SpawnInfo[playerid][angle] = 0;
	SpawnInfo[playerid][interior] = 0;
	SpawnInfo[playerid][virtualworld] = 0;
	SpawnInfo[playerid][health] = 0;
	
	for(new i = 0; i < 11; i++)
	{
		Weapon[playerid][i] = 0;
		Ammo[playerid][i] = 0;
	}
	return 1;
}

stock SaveSpawnInfo(playerid)
{
	GetPlayerPos(playerid, SpawnInfo[playerid][x], SpawnInfo[playerid][y], SpawnInfo[playerid][z]);
	GetPlayerFacingAngle(playerid, SpawnInfo[playerid][angle]);

	GetPlayerHealth(playerid, SpawnInfo[playerid][health]);

	#if SET_INTERIOR == 1

		SpawnInfo[playerid][interior] = GetPlayerInterior(playerid);

	#endif

	#if SET_VIRTUALWORLD == 1

		SpawnInfo[playerid][virtualworld] = GetPlayerVirtualWorld(playerid);

	#endif

	#if SAVE_WEAPONS == 1

		for(new i = 0; i < 11; i++)
		{
			GetPlayerWeaponData(playerid, i, Weapon[playerid][i], Ammo[playerid][i]);
		}

	#endif
	
	return 1;
}

stock ApplySpawn(playerid)
{
	SetPlayerPos(playerid, SpawnInfo[playerid][x], SpawnInfo[playerid][y], SpawnInfo[playerid][z]);
	SetPlayerFacingAngle(playerid, SpawnInfo[playerid][angle]);
	SetPlayerHealth(playerid, SpawnInfo[playerid][health]);
	SetCameraBehindPlayer(playerid);

	#if SET_INTERIOR == 1

		SetPlayerInterior(playerid, SpawnInfo[playerid][interior]);

	#endif

	#if SET_VIRTUALWORLD == 1

		SetPlayerVirtualWorld(playerid, SpawnInfo[playerid][virtualworld]);

	#endif

	#if SAVE_WEAPONS == 1

		for(new i = 0; i < 11; i++)
		{
			GivePlayerWeapon(playerid, Weapon[playerid][i], Ammo[playerid][i]);
		}

	#endif
	
	return 1;
}

public Spawn(playerid)
{

	ApplySpawn(playerid);
	Clear(playerid);
	
	return 1;
}

public Extra(playerid)
{
	TextDrawHideForPlayer(playerid, Screen);

	ApplyAnimation(playerid, "ped", "FALL_collapse", 4.1, 0, 1, 1, 0, 0, 1);
	
	PlayerPlaySound(playerid,1163,0.0,0.0,0.0);
	return 1;
}

//------------------------- EXTRAS ---------------------------------------------

public OnPlayerInstantSpawn(playerid) // OnPlayerSpawn can also be used instad of this but added just in case needed
{
	return 1;
}
