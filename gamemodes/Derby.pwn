// IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT
//
//                                                                   THE SERVER ONLY SUPPORTS 15 PLAYERS!                                                                              
//
// IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT
#include <a_samp>
#include <zcmd>
#include <foreach>

#include <sscanf2>


#undef MAX_PLAYERS
#define MAX_PLAYERS 				15
#define MAX_DERBY_PLAYERS 			20
#define MAX_FACTIONS                50
#define INVALID_FACTION_ID          65535


#define REMOVETYPE_QUIT_SERVER 		0
#define REMOVETYPE_EXIT_VEHICLE 	1
#define REMOVETYPE_IDLE 			2
#define REMOVETYPE_FELL 			3


#define DIALOG_NONE 				0
#define DIALOG_REGISTER 			1
#define DIALOG_LOGIN 				2


#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#if !defined isnull
    #define isnull(%1) \
                ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

//I've made some stuff on the 'derbyInfo' enum, so you can add multiple maps
//But I'm sure not how or why It'll work
//So I didn't risk doing it, but just added the vars (MinPos, Vehicle)
enum derbyInfo
{
	Vehicle[ 15 ],

	MatchStart, MatchTimer,

	TotalPlayers, ActivePlayers,
	
	MinPos,
	
	bool:DerbyStarted, bool:DerbyEnded,
	bool:VehicleOccupied[ 15 ]
};

enum playerInfo
{
	bool:InDerby,
	bool:IsConnected,
	bool:IsLoggedIn,
	
	FactionID, FactionRank,
	
	databaseID,

	AdminLevel,
	Score,
	ToBeBanned,
	
	AFKTime, StartTime,
	VehicleID,
	
	SpectateID,
	
	LoginWarns,
	
	Name[ 24 ], Password[ 24 ],
	IP[ 16 ]
};

enum factionInfo
{
	databaseID, Members,
	Name[ 24 ]
};
new
	dInfo[ derbyInfo ],
	pInfo[ MAX_PLAYERS ][ playerInfo ],
	fInfo[ MAX_FACTIONS ][ factionInfo ]
;
new
	Timer[2]
;
new
	DB:Database,
	Iterator:Factions< MAX_FACTIONS >
;
new
	Text:gSpecInfo[3] = Text:INVALID_TEXT_DRAW,
	Text:gCounterInfo = Text:INVALID_TEXT_DRAW,
	PlayerText:pSpecInfo0[ MAX_PLAYERS ]
;

main()
{
	print("\n--------------------------------------");
	print(">>> Vehicle Derby | Sumo <<<");
	print("--------------------------------------\n");
}

public OnGameModeInit()
{
	SendRconCommand("hostname >>>> Vehicle Derby | Sumo <<<");
    SetGameModeText("Derby,Sumo,Demolition,Vehicle");

    Database = db_open("derby.db");
    
    // ---- USERS
    db_query(Database,
	"CREATE TABLE IF NOT EXISTS users (userid INTEGER PRIMARY KEY AUTOINCREMENT,\
	username VARCHAR(24),\
	ip VARCHAR(16),\
	password VARCHAR(24),\
	admin INTEGER DEFAULT 0 NOT NULL,\
	score INTEGER DEFAULT 0 NOT NULL,\
	tobebanned INTEGER DEFAULT 0 NOT NULL,\
	regdate INTEGER DEFAULT 0 NOT NULL,\
	laston INTEGER DEFAULT 0 NOT NULL,\
	factionid INTEGER DEFAULT 65535 NOT NULL,\
	factionrank INTEGER DEFAULT 0 NOT NULL\
 	)");
 	
	// ---- BANNED
	db_query(Database,
	"CREATE TABLE IF NOT EXISTS banned (banid INTEGER PRIMARY KEY AUTOINCREMENT,\
	bannedname VARCHAR(24),\
	bannedip VARCHAR(16),\
	bannedby VARCHAR(24),\
	banreason VARCHAR(48),\
	date INTEGER DEFAULT 0 NOT NULL,\
	time INTEGER DEFAULT 0 NOT NULL\
	)");
	
	// ---- FACTIONS
	db_query(Database,
	"CREATE TABLE IF NOT EXISTS factions (factionid INTEGER PRIMARY KEY AUTOINCREMENT,\
	factionmembers INTEGER DEFAULT 1 NOT NULL,\
	factionname VARCHAR(24)\
	)");
	
	
	Iter_Add(Factions, 0); //Fixes /fdisband & faction log-in IDs messing up
	new
		Query[32],
		DBResult:Result
	;
 	format(Query, sizeof(Query), "SELECT * FROM factions");
    Result = db_query(Database, Query);
	if(db_num_rows(Result))
	{
		new
			field[21],
			id
		;
	    while(db_next_row(Result))
     	{
			id = Iter_Free(Factions);

            db_get_field_assoc(Result, "factionname", fInfo[ id ][ Name ], 24);
            db_get_field_assoc(Result, "factionmembers", field, 3); fInfo[ id ][ Members ] = strval( field );

	   		Iter_Add(Factions, id);
		}
 	}
 	db_free_result(Result);
	
	gSpecInfo[0] = TextDrawCreate(641.666687, 364.462951, "usebox");
	TextDrawLetterSize(gSpecInfo[0], 0.000000, 9.085805);
	TextDrawTextSize(gSpecInfo[0], -2.000000, 0.000000);
	TextDrawAlignment(gSpecInfo[0], 1);
	TextDrawColor(gSpecInfo[0], 0);
	TextDrawUseBox(gSpecInfo[0], true);
	TextDrawBoxColor(gSpecInfo[0], 102);
	TextDrawSetShadow(gSpecInfo[0], 0);
	TextDrawSetOutline(gSpecInfo[0], 0);
	TextDrawFont(gSpecInfo[0], 0);

	gSpecInfo[1] = TextDrawCreate(145.333328, 379.396301, "usebox");
	TextDrawLetterSize(gSpecInfo[1], 0.000000, -1.837655);
	TextDrawTextSize(gSpecInfo[1], 514.000000, 0.000000);
	TextDrawAlignment(gSpecInfo[1], 1);
	TextDrawColor(gSpecInfo[1], 0);
	TextDrawUseBox(gSpecInfo[1], true);
	TextDrawBoxColor(gSpecInfo[1], 102);
	TextDrawSetShadow(gSpecInfo[1], 0);
	TextDrawSetOutline(gSpecInfo[1], 0);
	TextDrawFont(gSpecInfo[1], 0);

	gSpecInfo[2] = TextDrawCreate(328.333282, 375.407348, "~w~You're currently a ~y~spectator~n~~w~Press ~y~LEFT ~w~or ~y~RIGHT~w~ to ~y~switch between players");
	TextDrawLetterSize(gSpecInfo[2], 0.449999, 1.600000);
	TextDrawAlignment(gSpecInfo[2], 2);
	TextDrawColor(gSpecInfo[2], -1);
	TextDrawSetShadow(gSpecInfo[2], 0);
	TextDrawSetOutline(gSpecInfo[2], 1);
	TextDrawBackgroundColor(gSpecInfo[2], 51);
	TextDrawFont(gSpecInfo[2], 1);
	TextDrawSetProportional(gSpecInfo[2], 1);
	
	gCounterInfo = TextDrawCreate(485.000122, 9.540781, "Players in derby: ~y~1/14");
	TextDrawLetterSize(gCounterInfo, 0.205000, 1.749332);
	TextDrawAlignment(gCounterInfo, 1);
	TextDrawColor(gCounterInfo, -1);
	TextDrawSetShadow(gCounterInfo, 0);
	TextDrawSetOutline(gCounterInfo, 1);
	TextDrawBackgroundColor(gCounterInfo, 51);
	TextDrawFont(gCounterInfo, 3);
	TextDrawSetProportional(gCounterInfo, 1);


	CreateObject(3458, 393.73184, 2982.50415, 9.80794,   0.00000, 0.00000, 0.00000);
	CreateObject(3458, 411.37982, 3005.26147, 9.80790,   0.00000, 0.00000, 90.00000);
	CreateObject(3458, 376.09714, 3005.25244, 9.80790,   0.00000, 0.00000, 90.00000);
	CreateObject(3458, 393.73221, 3028.01050, 9.80790,   0.00000, 0.00000, 0.00000);
	CreateObject(3458, 393.14392, 3025.18677, 9.80790,   0.00000, 20.00000, 90.00000);
	CreateObject(3458, 393.86258, 3004.17139, 16.63379,   0.00000, 0.00000, 0.00000);
	CreateObject(3458, 393.14389, 3004.27930, 15.23030,   0.00000, 25.00000, 90.00000);
	CreateObject(3458, 396.35382, 2984.08936, 23.63546,   0.00000, 0.00000, 0.00000);
	CreateObject(3458, 416.51660, 3003.86230, 16.64918,   0.00000, 0.00000, 90.00000);
	CreateObject(3458, 400.53189, 3032.20142, 16.65920,   0.00000, 0.00000, 149.00000);
	CreateObject(3458, 368.50534, 3032.18042, 16.64920,   0.00000, 0.00000, -149.00000);
	CreateObject(3458, 352.36578, 3003.73047, 16.65920,   0.00000, 0.00000, 90.00000);
	CreateObject(3458, 353.50168, 3004.17554, 16.64920,   0.00000, 0.00000, 0.00000);
	CreateObject(3458, 368.42981, 2975.47900, 16.64920,   0.00000, 0.00000, 149.00000);
	CreateObject(3458, 400.48346, 2975.46875, 16.65920,   0.00000, 0.00000, -149.00000);
	CreateObject(3458, 330.77386, 3021.81641, 16.65920,   0.00000, 0.00000, 90.00000);
	CreateObject(3458, 333.97806, 3039.43921, 16.80297,   0.00000, -20.00000, 0.00000);
	CreateObject(3458, 419.11404, 3001.72095, 23.63550,   0.00000, 0.00000, 90.00000);
	CreateObject(3458, 401.48746, 3024.49268, 23.63546,   0.00000, 0.00000, 0.00000);
	CreateObject(3458, 361.09671, 3024.49048, 23.63550,   0.00000, 0.00000, 0.00000);
	CreateObject(3458, 338.35687, 3006.86011, 23.63550,   0.00000, 0.00000, 90.00000);
	CreateObject(3458, 355.04340, 3047.25098, 23.63550,   0.00000, 0.00000, 90.00000);
	CreateObject(3458, 372.72256, 3069.86938, 23.63550,   0.00000, 0.00000, 0.00000);
	CreateObject(3458, 390.37036, 3047.12915, 23.63550,   0.00000, 0.00000, 90.00000);
	CreateObject(3458, 356.00348, 2984.09888, 23.63546,   0.00000, 0.00000, 0.00000);

	dInfo[ Vehicle ][ 0 ] = CreateVehicle(451, 389.4179, 3069.9277, 26.1960, 90.0000, -1, -1, 100);
	dInfo[ Vehicle ][ 1 ] = CreateVehicle(451, 354.8904, 3069.8838, 26.1960, 180.0000, -1, -1, 100);
	dInfo[ Vehicle ][ 2 ] = CreateVehicle(451, 343.8498, 3024.7666, 26.3427, -90.0000, -1, -1, 100);
	dInfo[ Vehicle ][ 3 ] = CreateVehicle(451, 418.8108, 3019.8938, 26.1409, 180.0000, -1, -1, 100);
	dInfo[ Vehicle ][ 4 ] = CreateVehicle(451, 414.1092, 2984.3071, 26.0973, 90.0000, -1, -1, 100);
	dInfo[ Vehicle ][ 5 ] = CreateVehicle(451, 338.1761, 2989.4629, 26.2080, 0.0000, -1, -1, 100);
	dInfo[ Vehicle ][ 6 ] = CreateVehicle(451, 330.7242, 3005.5422, 19.2366, 0.0000, -1, -1, 100);
	dInfo[ Vehicle ][ 7 ] = CreateVehicle(451, 405.9525, 3028.1956, 12.3337, 90.0000, -1, -1, 100);
	dInfo[ Vehicle ][ 8 ] = CreateVehicle(451, 416.7807, 3016.7617, 19.0938, 0.0000, -1, -1, 100);
	dInfo[ Vehicle ][ 9 ] = CreateVehicle(451, 376.2791, 3022.3601, 12.0909, 180.0000, -1, -1, 100);
	dInfo[ Vehicle ][ 10 ] = CreateVehicle(451, 381.7555, 2982.9788, 12.3678, -90.0000, -1, -1, 100);
	dInfo[ Vehicle ][ 11 ] = CreateVehicle(451, 411.5647, 2988.5537, 12.2679, 0.0000, -1, -1, 100);
	dInfo[ Vehicle ][ 12 ] = CreateVehicle(451, 388.2325, 2967.9790, 19.1873, -60.0000, -1, -1, 100);
	dInfo[ Vehicle ][ 13 ] = CreateVehicle(451, 379.1497, 2969.2070, 19.2052, 60.0000, -1, -1, 100);
	dInfo[ Vehicle ][ 14 ] = CreateVehicle(451, 352.2428, 2991.7075, 19.0426, 0.0000, -1, -1, 100);
	
	UsePlayerPedAnims();
	AddClasses();
	
	dInfo[ MatchStart ] = 5, dInfo[ MatchTimer ] = 360;
    dInfo[ MinPos ] = 10;
    
	Timer[ 0 ] = SetTimer("MainTimer", 1000, true);
	Timer[ 1 ] = SetTimer("BanCheck", 86400000, true);
	return 1;
}

public OnGameModeExit()
{
	db_close(Database);
	KillTimer(Timer[ 0 ]), KillTimer(Timer[ 1 ]);
	TextDrawDestroy(gCounterInfo), TextDrawDestroy(gSpecInfo[0]), TextDrawDestroy(gSpecInfo[1]), TextDrawDestroy(gSpecInfo[2]);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerInterior(playerid, 3);
	SetPlayerPos(playerid, -2673.8381, 1399.7424, 918.3516);
	SetPlayerFacingAngle(playerid, 181.0);
   	SetPlayerCameraPos(playerid, -2673.2776, 1394.3859, 918.3516);
	SetPlayerCameraLookAt(playerid, -2673.8381, 1399.7424, 918.3516);
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(pInfo[ playerid ][ IsConnected ] == true)
	{
	    KickEx(playerid, 300, ">> Exploit usage is not permitted in this server.");
	    return 1;
	}
	else
	{
	    new
	        string[ 122 ],
	        Query[ 128 ], DBResult:Result
		;
		GetPlayerName(playerid, pInfo[ playerid ][ Name ], 24);
		GetPlayerIp(playerid, pInfo[ playerid ][ IP ], 16);
		
		format(Query, sizeof(Query), "SELECT bannedname, bannedby, banreason FROM banned WHERE bannedname = '%s' OR bannedip = '%s'", DB_Escape(pInfo[ playerid ][ Name ]), pInfo[ playerid ][ IP ]);
		Result = db_query(Database, Query);
		if(db_num_rows(Result))
		{
		    new
		        bannedby[24],
		        banreason[48]
			;
			db_get_field_assoc(Result, "bannedby", bannedby, 24), db_get_field_assoc(Result, "banreason", banreason, 48);
			
		    format(string, sizeof(string), ">> This account has been banned by %s due to %s.", bannedby, banreason);
		    KickEx(playerid, 300, string);
		}
		else
		{
			format(Query, sizeof(Query), "SELECT password FROM users WHERE username = '%s' LIMIT 0, 1", DB_Escape(pInfo[ playerid ][ Name ]));
			Result = db_query(Database, Query);
			if(db_num_rows(Result))
			{
			    db_get_field_assoc(Result, "password", pInfo[ playerid ][ Password ], 24);
			    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{60ba46}Login", "{ffc663}( ! ) {ffffff}This account is {60ba46}registered{ffffff}.\nEnter your password to {60ba46}LOGIN!", "Accept", "Cancel");
			}
			else
			{
				ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "{60ba46}Register", "{ffc663}( ! ) {ffffff}This account isn't {60ba46}registered{ffffff}.\nEnter a password to {60ba46}REGISTER!", "Accept", "Cancel");
			}
			pSpecInfo0[playerid] = CreatePlayerTextDraw(playerid, 325.000152, 362.548034, "PlayerName(PlayerID)");
			PlayerTextDrawLetterSize(playerid, pSpecInfo0[playerid], 0.449999, 1.600000);
			PlayerTextDrawAlignment(playerid, pSpecInfo0[playerid], 2);
			PlayerTextDrawColor(playerid, pSpecInfo0[playerid], -1);
			PlayerTextDrawSetShadow(playerid, pSpecInfo0[playerid], 0);
			PlayerTextDrawSetOutline(playerid, pSpecInfo0[playerid], 1);
			PlayerTextDrawBackgroundColor(playerid, pSpecInfo0[playerid], 51);
			PlayerTextDrawFont(playerid, pSpecInfo0[playerid], 1);
			PlayerTextDrawSetProportional(playerid, pSpecInfo0[playerid], 1);
		}
		db_free_result(Result);
		
		format(string, sizeof(string), ">> %s(ID: %d) has connected.", pInfo[ playerid ][ Name ], playerid);
		SendClientMessageToAll(0xB9C9BFAA, string);

		pInfo[ playerid ][ InDerby ] = false;
		pInfo[ playerid ][ IsConnected ] = true;
		
		pInfo[ playerid ][ VehicleID ] = INVALID_VEHICLE_ID;
		pInfo[ playerid ][ LoginWarns ] = 0;
		
		dInfo[ TotalPlayers ]++;
		if(dInfo[ TotalPlayers ] == 1) RestartDerby();
		
		format(string, sizeof( string ), "Players in derby: ~y~%d/%d", dInfo[ ActivePlayers ], dInfo[ TotalPlayers ]);
		TextDrawSetString(gCounterInfo, string);
		TextDrawShowForAll(gCounterInfo);
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(pInfo[ playerid ][ IsLoggedIn ] == true)
	{
		UpdatePlayerData(playerid, false);
		if(pInfo[ playerid ][ FactionID ] != INVALID_FACTION_ID) UpdateFactionData(pInfo[ playerid ][ FactionID ]);
	}
	
	new reason_str[3][] =
	{
 		"Timeout/Crash",
	    "Quit",
		"Kick/Ban"
    };
    new
	    string[ 76 ]
	;
    format(string, sizeof(string), ">> %s(ID: %d) has disconnected (%s)", pInfo[ playerid ][ Name ], playerid, reason_str[reason]);
	SendClientMessageToAll(0xB9C9BFAA, string);
	
	if(pInfo[ playerid ][ InDerby ] == true) dInfo[ ActivePlayers ]--;
	dInfo[ TotalPlayers ]--;
	for(new i; i < _: playerInfo; ++i) pInfo[ playerid ][ playerInfo: i ] = 0;
	
	format(string, sizeof( string ), "Players in derby: ~y~%d/%d", dInfo[ ActivePlayers ], dInfo[ TotalPlayers ]);
	TextDrawSetString(gCounterInfo, string);
	TextDrawShowForAll(gCounterInfo);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerInterior(playerid, 0);
	if(dInfo[ MatchStart ] > 0)
	{
		for(new x; x < 15; x++)
		{
			if(dInfo[ VehicleOccupied ][ x ]) continue;
			else
			{
				dInfo[ VehicleOccupied ][ x ] = true;
	            PutPlayerInVehicle(playerid, dInfo[ Vehicle ][ x ], 0);
	            break;
			}
        }
        pInfo[ playerid ][ SpectateID ] = INVALID_PLAYER_ID;
        pInfo[ playerid ][ InDerby ] = true;
        dInfo[ ActivePlayers ]++;
        
        TogglePlayerControllable(playerid, false);
	}
	else if(dInfo[ MatchStart ] <= 0)
	{
	    if(dInfo[ DerbyEnded ] == false)
	    {
		    pInfo[ playerid ][ InDerby ] = false;
		    foreach(Player, i)
		    {
		        if(pInfo[ i ][ InDerby ] == false) continue;
		        else
				{
					TogglePlayerSpectating(playerid, true), PlayerSpectateVehicle(playerid, GetPlayerVehicleID( i ));
					pInfo[ playerid ][ SpectateID ] = i;
					break;
				}
			}
		}
		else SetPlayerPos(playerid, 0, 0, 0);
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	RemoveFromDerby(playerid, REMOVETYPE_EXIT_VEHICLE);
	return 1;
}

public OnPlayerText(playerid, text[])
{
	new
		string[ 128 ]
	;
	if(text[0] == '!' || text[0] == '=')
	{
	    if(pInfo[ playerid ][ FactionID ] != INVALID_FACTION_ID)
	    {
	        format(string, sizeof(string), "(Faction Chat) %s %s(%d): %s", Rank(pInfo[ playerid ][ FactionRank ]), pInfo[ playerid ][ Name ], playerid, text[ 1 ]);
			SendFactionMessage(playerid, string);
			return 0;
		}
	}
    format(string, sizeof(string), "(%d) %s", playerid, text);
    SendPlayerMessageToAll(playerid, string);
	return 0;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER)
	{
		if(pInfo[ playerid ][ InDerby ] == true)
		{
			RemoveFromDerby(playerid, REMOVETYPE_EXIT_VEHICLE);
		}
		pInfo[ playerid ][ VehicleID ] = INVALID_VEHICLE_ID;
	}
	else if(newstate == PLAYER_STATE_DRIVER) pInfo[ playerid ][ VehicleID ] = GetPlayerVehicleID(playerid);
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	if(GetPlayerInterior(playerid) == 0)
	{
	    SetVehicleToRespawn(vehicleid);
		pInfo[ playerid ][ ToBeBanned ] = 1;
     	KickEx(playerid, 300, ">> Cheat usage is not permitted in this server.");
	}
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_FIRE))
	{
		if(IsPlayerInAnyVehicle(playerid)) AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
	{
	    if(PRESSED(KEY_LEFT) || PRESSED(KEY_FIRE))
	    {
	        if(pInfo[ playerid ][ SpectateID ] > 0)
	        {
	            pInfo[ playerid ][ SpectateID ]--;
	            if(!IsPlayerConnected(pInfo[ playerid ][ SpectateID ]))
	            {
	                do pInfo[ playerid ][ SpectateID ]--;
				 	while(!IsPlayerConnected(pInfo[ playerid ][ SpectateID ]));
				}
				else
				{
				    PlayerSpectateVehicle(playerid, GetPlayerVehicleID( pInfo[ playerid ][ SpectateID ] ));
					UpdateSpecInfo(playerid);
				}
			}
		}
		else if(PRESSED(KEY_RIGHT) || PRESSED(KEY_HANDBRAKE))
		{
		    if(pInfo[ playerid ][ SpectateID ] < MAX_PLAYERS)
		    {
		        pInfo[ playerid ][ SpectateID ]++;
		        if(!IsPlayerConnected(pInfo[ playerid ][ SpectateID ]))
	            {
	                do pInfo[ playerid ][ SpectateID ]++;
				 	while(!IsPlayerConnected(pInfo[ playerid ][ SpectateID ]));
				}
				else
				{
				    PlayerSpectateVehicle(playerid, GetPlayerVehicleID( pInfo[ playerid ][ SpectateID ] ));
					UpdateSpecInfo(playerid);
				}
			}
		}
	}
	return 1;
}
public OnRconLoginAttempt(ip[], password[], success)
{
	if(!success)
	{
     	foreach(Player, i)
	    {
	        if(strcmp(ip, pInfo[ i ][ IP ])) continue;
			//else if(strcmp("Kyance", pInfo[ i ][ Name ])) continue;
	        else BanEx(i, "Invalid RCON Password");
		}
	}
	else
	{
	    foreach(Player, i)
	    {
	        if(strcmp(ip, pInfo[ i ][ IP ])) continue;
	        else pInfo[ i ][ AdminLevel ] = 5;
		}
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
	pInfo[ playerid ][ AFKTime ] = 0;
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DIALOG_REGISTER:
	    {
	        if(response)
	        {
	            if(!IsValidPassword(inputtext))
	            {
	                ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register", "( ! ) Password contained in-valid characters!\nEnter a different password!", "Accept", "Cancel");
	                PlayerPlaySound(playerid, 1055, 0, 0, 0);
				}
				else if(strlen(inputtext) < 3 || strlen(inputtext) > 24)
				{
				    ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register", "( ! ) Password is either too short, or too long!\nChoose a password which has 3 - 24 characters!", "Accept", "Cancel");
	                PlayerPlaySound(playerid, 1055, 0, 0, 0);
				}
				else
				{
				    new
						Query[ 168 ],
						year, month, day
					;
					getdate(year, month, day);
					
					format(Query, sizeof(Query), "INSERT INTO users (username, ip, password, regdate, laston) VALUES ('%s', '%s', '%s', '%d/%d/%d', '%d/%d/%d')",
					DB_Escape(pInfo[ playerid ][ Name ]), pInfo[ playerid ][ IP ], DB_Escape(inputtext), year, month, day, year, month, day);
					db_query(Database, Query);
					
					SendClientMessage(playerid, 0xadff00AA, ">> You've registered!");
					pInfo[ playerid ][ IsLoggedIn ] = true;
					pInfo[ playerid ][ FactionID ] = INVALID_FACTION_ID;
					PlayerPlaySound(playerid, 1056, 0, 0, 0);
				}
	        }
	        else KickEx(playerid, 300, ">> You must register to play here!");
		}
		case DIALOG_LOGIN:
		{
		    if(response)
	        {
	            if(!strcmp(inputtext, pInfo[ playerid ][ Password ], false))
	            {
	                new
		                Query[ 128 ], string[ 84 ],
		                DBResult:Result,
		                
		                year, month, day
		            ;
		            getdate(year, month, day);
		            
		            format(Query, sizeof(Query), "SELECT * FROM users WHERE username = '%s' LIMIT 0, 1", DB_Escape(pInfo[ playerid ][ Name ]));
		            Result = db_query(Database, Query);
		            if(db_num_rows(Result))
		            {
		                db_get_field_assoc(Result, "userid", Query, 8); pInfo[ playerid ][ databaseID ] = strval(Query);
		                db_get_field_assoc(Result, "admin", Query, 3); pInfo[ playerid ][ AdminLevel ] = strval(Query);
		                db_get_field_assoc(Result, "score", Query, 8); pInfo[ playerid ][ Score ] = strval(Query), SetPlayerScore(playerid, pInfo[ playerid ][ Score ]);
		                db_get_field_assoc(Result, "tobebanned", Query, 2); pInfo[ playerid ][ ToBeBanned ] = strval(Query);
		                db_get_field_assoc(Result, "factionid", Query, 8); pInfo[ playerid ][ FactionID ] = strval(Query);
		                db_get_field_assoc(Result, "factionrank", Query, 2); pInfo[ playerid ][ FactionRank ] = strval(Query);
		                
		                if(pInfo[ playerid ][ ToBeBanned ] == 1)
		                {
		                    KickEx(playerid, 300, ">> Account is untrusted.");
						}
		                else
		                {
		                	SendClientMessage(playerid, 0xadff00AA, ">> You've logged-in!");
							pInfo[ playerid ][ IsLoggedIn ] = true;
							PlayerPlaySound(playerid, 1056, 0, 0, 0);
							
							if( pInfo[ playerid ][ FactionID ] != INVALID_FACTION_ID )
							{
							    new fID = pInfo[ playerid ][ FactionID ];
							    format(string, sizeof( string ), "(FACTION) You've logged in %s as %s.", fInfo[ fID ][ Name ], Rank( pInfo[ playerid ][ FactionRank ] ));
							    SendClientMessage(playerid, 0xff7f50ff, string);
							}
						}
		            }
		            db_free_result(Result);
		            
		            format(Query, sizeof(Query), "UPDATE users SET laston = '%d/%d/%d' WHERE username = '%s'", year, month, day, DB_Escape(pInfo[ playerid ][ Name ]));
		            db_query(Database, Query);
				}
				else
				{
					pInfo[ playerid ][ LoginWarns ]++;
					if(pInfo[ playerid ][ LoginWarns ] < 3)
					{
					    new
					        string[ 104 ]
						;
						format(string, sizeof(string), "{ffc663}( ! ) {ffffff}Invalid Password {ffc663}(%d / 3)\n{ffffff}Enter your password to {60ba46}login!", pInfo[ playerid ][ LoginWarns ]);
					    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "{ffc663}Login", string, "Accept", "Cancel");
					}
					else if(pInfo[ playerid ][ LoginWarns ] >= 3) KickEx(playerid, 300, ">> Invalid Password (3 attempts)");
				}
			}
			else KickEx(playerid, 300, ">> You must login to play here!");
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

// -------- COMMANDs

CMD:fcreate(playerid, params[])
{
	if(pInfo[ playerid ][ FactionID ] == INVALID_FACTION_ID)
	{
		if(isnull(params))
		{
		    SendClientMessage(playerid, 0xff7f50ff, "(USAGE) /fcreate FactionName");
		    return 1;
		}
		else if(strlen(params) < 3 || strlen(params) > 24)
		{
		    SendClientMessage(playerid, 0xff7f50ff, "(NOTE) The Faction Name must be between 3 - 24 characters!");
		    return 1;
		}
		else
		{
		    new
		        fID = Iter_Free(Factions),
		        DBResult:Result, Query[ 128 ],
		        string[ 84 ]
			;
			format(Query, sizeof( Query ), "SELECT factionname FROM factions WHERE factionname = '%s'", DB_Escape( params ));
			Result = db_query(Database, Query);
			if(db_num_rows(Result))
			{
			    SendClientMessage(playerid, 0xff7f50ff, "(NOTE) Faction Name is in use!");
			}
			else
			{
			    format(Query, sizeof( Query ), "INSERT INTO factions (factionname) VALUES ('%s')", DB_Escape( params ));
			    db_query(Database, Query);

			    format(fInfo[ fID ][ Name ], 24, "%s", params);
			    fInfo[ fID ][ Members ] = 1, fInfo[ fID ][ databaseID ] = fID;
			    pInfo[ playerid ][ FactionID ] = fID, pInfo[ playerid ][ FactionRank ] = 6;
			    
			    format(Query, sizeof( Query ), "UPDATE users SET factionid = %d, factionrank = %d WHERE username = '%s'", pInfo[ playerid ][ FactionID ], pInfo[ playerid ][ FactionRank ], DB_Escape( pInfo[ playerid ][ Name ]));
			    db_query(Database, Query);

			    format(string, sizeof( string ), "(FACTION) %s has created faction %s", pInfo[ playerid ][ Name ], fInfo[ fID ][ Name ]);
			    SendClientMessageToAll(0xff7f50ff, string);

			    Iter_Add(Factions, fID);
			}
			db_free_result(Result);
		}
	}
	else
	{
	    SendClientMessage(playerid, 0xff7f50ff, "(NOTE) You're already in a Faction!");
	    return 1;
	}
	return 1;
}
CMD:fdisband(playerid, params[])
{
    if(pInfo[ playerid ][ FactionID ] != INVALID_FACTION_ID)
	{
	    if(pInfo[ playerid ][ FactionRank ] == 6)
	    {
	        new
	            fID = pInfo[ playerid ][ FactionID ],
	            string[ 88 ], Query[ 128 ]
			;
			format(Query, sizeof( Query ), "DELETE FROM factions WHERE factionid = %d", fID);
			db_query(Database, Query);
			
			format(string, sizeof( string ), "(FACTION) %s has disbanded faction %s", pInfo[ playerid ][ Name ], fInfo[ fID ][ Name ]);
			SendClientMessageToAll(0xff7f50ff, string);

			FixFaction(fID);

			Iter_Remove(Factions, fID);
		}
		else
		{
		    SendClientMessage(playerid, 0xff7f50ff, "(NOTE) You must be the Godfather to do this!");
	    	return 1;
		}
	}
	else
	{
	    SendClientMessage(playerid, 0xff7f50ff, "(NOTE) You must be in a Faction to do this!");
	    return 1;
	}
	return 1;
}

// -------- STOCKs

stock AddClasses()
{
	for(new i = 1; i < 299; i++) AddPlayerClass(i,0.0,0.0,0.0,0.0,0,0,0,0,0,0);
}

stock KickEx(playerid, time, const msg[])
{
	SendClientMessage(playerid, 0xc90020aa, msg), printf("(KICK) %s (MSG: %s)", pInfo[ playerid ][ Name ], msg);
	SetTimerEx("KickPlayer", time, false, "i", playerid);
}

stock RemoveFromDerby(playerid, removetype = REMOVETYPE_QUIT_SERVER)
{
	new
	    string[ 96 ],
	    timeplayed
	;
	SetVehicleVirtualWorld(pInfo[ playerid ][ VehicleID ], 1);
	
	dInfo[ VehicleOccupied ][ pInfo[ playerid ][ VehicleID ] ] = false;
	dInfo[ ActivePlayers ]--;
	pInfo[ playerid ][ InDerby ] = false;
	
	SetPlayerPos(playerid, 0, 0, 0);
	
	switch(removetype)
	{
	    case REMOVETYPE_QUIT_SERVER:
	    {
	        format(string, sizeof(string), ">> %s(ID: %d) left (%d/%d players)", pInfo[ playerid ][ Name ], playerid, dInfo[ ActivePlayers ]+1, dInfo[ TotalPlayers ]);
			SendClientMessageToAll(0xf3ec13AA, string);
			
			if(dInfo[ ActivePlayers ] == 1)
			{
			    foreach(Player, i)
			    {
			        if(pInfo[ i ][ InDerby ] == false) continue;
			        GameTextForPlayer(i, "~g~WINNER", 2500, 3);
			        format(string, sizeof(string), ">> %s(ID: %d) wins (position: %d/%d)", pInfo[ i ][ Name ], i, dInfo[ ActivePlayers ], dInfo[ TotalPlayers ]);
					GivePlayerScore(i, 5);
			        break;
				}
				dInfo[ DerbyEnded ] = true;
				SendClientMessageToAll(0xf3ec13AA, string);
				//SetTimer("ResetDerby", 3000, false);
			}
		}
		case REMOVETYPE_EXIT_VEHICLE:
		{
		    timeplayed = gettime() - pInfo[ playerid ][ StartTime ];
		    
			GameTextForPlayer(playerid, "~r~LOST", 2500, 3);
		    format(string, sizeof(string), ">> %s(ID: %d) lost (exit vehicle, position: %d/%d, time: %d seconds)", pInfo[ playerid ][ Name ], playerid, dInfo[ ActivePlayers ]+1, dInfo[ TotalPlayers ], timeplayed);
			SendClientMessageToAll(0xf3ec13AA, string);
			
			if(dInfo[ ActivePlayers ] == 1)
			{
			    foreach(Player, i)
			    {
			        if(pInfo[ i ][ InDerby ] == false) continue;
			        GameTextForPlayer(i, "~g~WINNER", 2500, 3);
			        format(string, sizeof(string), ">> %s(ID: %d) wins (position: %d/%d)", pInfo[ i ][ Name ], i, dInfo[ ActivePlayers ], dInfo[ TotalPlayers ]);
			        GivePlayerScore(i, 5);
			        break;
				}
				dInfo[ DerbyEnded ] = true;
				SendClientMessageToAll(0xf3ec13AA, string);
				//SetTimer("ResetDerby", 3000, false);
			}
		}
		case REMOVETYPE_IDLE:
		{
      		timeplayed = gettime() - pInfo[ playerid ][ StartTime ];
		
		    GameTextForPlayer(playerid, "~r~LOST", 2500, 3);
		    format(string, sizeof(string), ">> %s(ID: %d) lost (idle, position: %d/%d, time: %d seconds)", pInfo[ playerid ][ Name ], playerid, dInfo[ ActivePlayers ]+1, dInfo[ TotalPlayers ], timeplayed);
			SendClientMessageToAll(0xf3ec13AA, string);
			
			if(dInfo[ ActivePlayers ] == 1)
			{
			    foreach(Player, i)
			    {
			        if(pInfo[ i ][ InDerby ] == false) continue;
			        GameTextForPlayer(i, "~g~WINNER", 2500, 3);
			        format(string, sizeof(string), ">> %s(ID: %d) wins (position: %d/%d)", pInfo[ i ][ Name ], i, dInfo[ ActivePlayers ], dInfo[ TotalPlayers ]);
			        GivePlayerScore(i, 5);
			        break;
				}
				dInfo[ DerbyEnded ] = true;
				SendClientMessageToAll(0xf3ec13AA, string);
				//SetTimer("ResetDerby", 3000, false);
			}
		}
		case REMOVETYPE_FELL:
		{
      		timeplayed = gettime() - pInfo[ playerid ][ StartTime ];
		
		    GameTextForPlayer(playerid, "~r~LOST", 2500, 3);
		    format(string, sizeof(string), ">> %s(ID: %d) lost (fell, position: %d/%d, time: %d seconds)", pInfo[ playerid ][ Name ], playerid, dInfo[ ActivePlayers ]+1, dInfo[ TotalPlayers ], timeplayed);
			SendClientMessageToAll(0xf3ec13AA, string);
			
			if(dInfo[ ActivePlayers ] == 1)
			{
			    foreach(Player, i)
			    {
			        if(pInfo[ i ][ InDerby ] == false) continue;
			        GameTextForPlayer(i, "~g~WINNER", 2500, 3);
			        format(string, sizeof(string), ">> %s(ID: %d) wins (position: %d/%d)", pInfo[ i ][ Name ], i, dInfo[ ActivePlayers ], dInfo[ TotalPlayers ]);
			        GivePlayerScore(i, 5);
			        break;
				}
				dInfo[ DerbyEnded ] = true;
				SendClientMessageToAll(0xf3ec13AA, string);
				//SetTimer("ResetDerby", 3000, false);
			}
		}
	}
	if(dInfo[ ActivePlayers ] <= 1 || dInfo[ TotalPlayers ] <= 1)
	{
	    dInfo[ DerbyEnded ] = true;
	    foreach(Player, i)
	    {
			if(GetPlayerState( i ) == PLAYER_STATE_SPECTATING) TogglePlayerSpectating(i, false);
			else SetPlayerPos(i, 0, 0, 0);
		}
		SetTimer("ResetDerby", 5000, false);
	}
	else if(dInfo[ ActivePlayers ] > 1)
	{
	    pInfo[ playerid ][ SpectateID ] = INVALID_PLAYER_ID;
		foreach(Player, i)
	 	{
			if(pInfo[ i ][ InDerby ] == false) continue;
	  		else pInfo[ playerid ][ SpectateID ] = i;
		}
		if(pInfo[ playerid ][ SpectateID ] != INVALID_PLAYER_ID)
		{
            TogglePlayerSpectating(playerid, true), PlayerSpectateVehicle(playerid, GetPlayerVehicleID( pInfo[ playerid ][ SpectateID ] ));
			TextDrawShowForPlayer(playerid, gSpecInfo[0]), TextDrawShowForPlayer(playerid, gSpecInfo[1]), TextDrawShowForPlayer(playerid, gSpecInfo[2]);
			UpdateSpecInfo(playerid);
		}
	}
	format(string, sizeof( string ), "Players in derby: ~y~%d/%d", dInfo[ ActivePlayers ], dInfo[ TotalPlayers ]);
	TextDrawSetString(gCounterInfo, string);
	TextDrawShowForAll(gCounterInfo);
}

stock RestartDerby()
{
	dInfo[ MatchStart ] = 5;
	dInfo[ MatchTimer ] = 360;
	dInfo[ ActivePlayers ] = 0;
	dInfo[ DerbyEnded ] = false;

    for(new x; x < 15; x++)
	{
	    dInfo[ VehicleOccupied ][ x ] = false;
	    SetVehicleToRespawn(dInfo[ Vehicle ][ x ]);
		SetVehicleVirtualWorld(dInfo[ Vehicle ][ x ], 0);
	}
	foreach(Player, i)
	{
	    if(pInfo[ i ][ IsLoggedIn ] == false) continue;
	    if(pInfo[ i ][ SpectateID ] != INVALID_PLAYER_ID || GetPlayerState(i) == PLAYER_STATE_SPECTATING)
	    {
	        pInfo[ i ][ SpectateID ] = INVALID_PLAYER_ID;
	        TogglePlayerSpectating(i, false);
	        TextDrawHideForPlayer(i, gSpecInfo[0]), TextDrawHideForPlayer(i, gSpecInfo[1]), TextDrawHideForPlayer(i, gSpecInfo[2]);
			PlayerTextDrawHide(i, pSpecInfo0[ i ]);
		}
		else
		{
		    dInfo[ ActivePlayers ]++;
		    
		    pInfo[ i ][ InDerby ] = true;
			TogglePlayerControllable(i, false);

			for(new x; x < 15; x++)
			{
				if(dInfo[ VehicleOccupied ][ x ]) continue;
				else
				{
					dInfo[ VehicleOccupied ][ x ] = true;
		            PutPlayerInVehicle(i, dInfo[ Vehicle ][ x ], 0);
		            break;
				}
	        }
		}
	}
}

stock UpdateSpecInfo(playerid)
{
	new
	    string[ 36 ],
	    targetid = pInfo[ playerid ][ SpectateID ]
	;
	if(IsPlayerConnected(targetid)) format(string, sizeof( string ), "%s(~y~%d~w~)", pInfo[ targetid ][ Name ], targetid);
	else string = "unconnected";
	
	PlayerTextDrawSetString(playerid, pSpecInfo0[ playerid ], string);
	PlayerTextDrawShow(playerid, pSpecInfo0[ playerid ]);
}


// ----

stock DB_Escape(text[])
{
    new
        ret[80* 2],
        ch,
        i,
        j
	;
    while ((ch = text[i++]) && j < sizeof (ret))
    {
        if (ch == '\'')
        {
            if (j < sizeof (ret) - 2)
            {
                ret[j++] = '\'';
                ret[j++] = '\'';
            }
        }
        else if (j < sizeof (ret))
        {
            ret[j++] = ch;
        }
        else
        {
            j++;
        }
    }
    ret[sizeof (ret) - 1] = '\0';
    return ret;
}

stock IsValidPassword(const password[ ])
{
    for(new i = 0; password[ i ] != EOS; ++i)
    {
        switch(password[ i ])
        {
            case '0'..'9', 'A'..'Z', 'a'..'z': continue;
            default: return 0;
        }
    }
    return 1;
}

stock UpdatePlayerData(playerid, bool:update_everything = false)
{
	switch(update_everything)
	{
	    case true:
	    {
	        new
	            Query[ 178 ]
			;
			format(Query, sizeof(Query), "UPDATE users SET ip = '%s', admin = %d, score = %d, tobebanned = %d, factionid = %d, factionrank = %d WHERE username = '%s'",
			pInfo[ playerid ][ IP ],
			pInfo[ playerid ][ AdminLevel ], pInfo[ playerid ][ Score ],
			pInfo[ playerid ][ ToBeBanned ],
			pInfo[ playerid ][ FactionID ], pInfo[ playerid ][ FactionRank ],
			DB_Escape(pInfo[ playerid ][ Name ]));
			
			db_query(Database, Query);
		}
		case false:
		{
		    new
				Query[ 168 ]
			;
		    format(Query, sizeof(Query), "UPDATE users SET admin = %d, score = %d, tobebanned = %d, factionid = %d, factionrank = %d WHERE username = '%s'",
			pInfo[ playerid ][ AdminLevel ], pInfo[ playerid ][ Score ],
			pInfo[ playerid ][ ToBeBanned ],
			pInfo[ playerid ][ FactionID ], pInfo[ playerid ][ FactionRank ],
			DB_Escape(pInfo[ playerid ][ Name ]));
			
			db_query(Database, Query);
		}
	}
}

stock GivePlayerScore(playerid, score)
{
	SetPlayerScore(playerid, GetPlayerScore( playerid )+score);
	pInfo[ playerid ][ Score ] = GetPlayerScore( playerid );
}
stock SetPlayerScoreEx(playerid, score)
{
    SetPlayerScore(playerid, score);
    pInfo[ playerid ][ Score ] = score;
}

// ----

stock KickUsername(const name[])
{
	foreach(Player, i)
	{
	    if(strcmp(pInfo[ i ][ Name ], name)) continue;
	    else KickEx(i, 300, ">> Account is banned.");
	}
}

// ----

stock UpdateFactionData(factionid)
{
	new
	    Query[ 128 ]
	;
	format(Query, sizeof(Query), "UPDATE factions SET factionmembers = %d WHERE factionid = %d",
	fInfo[ factionid ][ Members ], factionid);
	db_query(Database, Query);
}

stock SendFactionMessage(playerid, const msg[])
{
	foreach(Player, i)
	{
	    if(pInfo[ i ][ FactionID ] != pInfo[ playerid ][ FactionID ]) continue;
	    else SendClientMessage(i, 0x00ced1FF, msg);
	}
}

stock Rank(factionrank)
{
	new rankname[14];
	switch(factionrank)
	{
	    case 0: rankname = "Player";
	    case 1: rankname = "Guest";
	    case 2: rankname = "Rookie";
	    case 3: rankname = "Member";
	    case 4: rankname = "Senior Member";
		case 5: rankname = "Assistant";
		case 6: rankname = "Godfather";
		default: rankname = "Unknown";
	}
	return rankname;
}

stock FixFaction(factionid)
{
	foreach(Player, i)
	{
	    if(pInfo[ i ][ FactionID ] != factionid) continue;
	    else pInfo[ i ][ FactionID ] = INVALID_FACTION_ID, pInfo[ i ][ FactionRank ] = 0;
	}
}

// -------- TIMERs

forward ResetDerby();
public ResetDerby()
{
	RestartDerby();
	return 1;
}

forward KickPlayer(playerid);
public KickPlayer(playerid)
{
	Kick(playerid);
	return 1;
}

forward MainTimer();
public MainTimer()
{
	if(dInfo[ TotalPlayers ] != 0 && dInfo[ ActivePlayers ] != 0)
	{
	    dInfo[ MatchStart ]--;
	    if(dInfo[ MatchStart ] == 3)
		{
			foreach(Player, i)
			{
				GameTextForPlayer(i, "~r~3", 1000, 3);
				PlayerPlaySound(i, 1056, 0, 0, 0);
			}
		}
	    else if(dInfo[ MatchStart ] == 2)
		{
		    foreach(Player, i)
			{
				GameTextForPlayer(i, "~n~~r~~h~2", 1000, 3);
				PlayerPlaySound(i, 1056, 0, 0, 0);
			}
		}
	    else if(dInfo[ MatchStart ] == 1)
		{
		    foreach(Player, i)
			{
				GameTextForPlayer(i, "~n~~n~~y~1", 1000, 3);
	            PlayerPlaySound(i, 1056, 0, 0, 0);
			}
		}
	    else if(dInfo[ MatchStart ] == 0)
		{
		    new
		        string[ 32 ]
    		;
		    format(string, sizeof( string ), "Players in derby: ~y~%d/%d", dInfo[ ActivePlayers ], dInfo[ TotalPlayers ]);
			TextDrawSetString(gCounterInfo, string);
			TextDrawShowForAll(gCounterInfo);
			
			GameTextForAll("~g~GO~n~GO~n~GO", 2000, 3);
			
			dInfo[ DerbyEnded ] = false;
			foreach(Player, i)
			{
				TogglePlayerControllable(i, true);
				SetCameraBehindPlayer(i);
				PlayerPlaySound(i, 1057, 0, 0, 0);
				pInfo[ i ][ StartTime ] = gettime();
			}
			for(new x; x < 15; x++)
			{
				if(dInfo[ VehicleOccupied ][ x ]) continue;
	            else SetVehicleVirtualWorld(dInfo[ Vehicle ][ x ], 1);
	        }
		}
	    if(dInfo[ MatchStart ] <= 0)
	    {
			dInfo[ MatchTimer ]--;
			if(dInfo[ MatchTimer ] > 0)
			{
			    new
					Float:X,
					Float:Y,
					Float:Z
				;
			    foreach(Player, i)
			    {
			        if(pInfo[ i ][ InDerby ] == false) continue;
			        else if(GetPlayerState( i ) == PLAYER_STATE_SPECTATING) continue;
			        else
			        {
				        pInfo[ i ][ AFKTime ]++;

						if(pInfo[ i ][ AFKTime ] > 3)
						{
							RemoveFromDerby(i, REMOVETYPE_IDLE);
							continue;
						}
						else
						{
							GetPlayerPos(i, X, Y, Z);
							RepairVehicle(GetPlayerVehicleID(i));

							if(Z <= dInfo[ MinPos ])
							{
								RemoveFromDerby(i, REMOVETYPE_FELL);
								continue;
							}
						}
					}
				}
			}
			else if(dInfo[ MatchTimer ] == 0)
			{
				RestartDerby();
				GameTextForAll("~r~TIMES UP", 2500, 3);
			}
		}
	}
	return 1;
}

forward BanCheck();
public BanCheck()
{
	new
 		Query[ 256 ],
       	DBResult:Result
	;
	Result = db_query(Database, "SELECT username, ip FROM users WHERE tobebanned = 1");
	if(db_num_rows( Result ))
	{
		new
	        username[24], userip[16],
	        hour, minute, second,
	        year, month, day
		;
		getdate(year, month, day);
		gettime(hour, minute, second);
		
		do
		{
			db_get_field_assoc(Result, "username", username, 24);
			db_get_field_assoc(Result, "ip", userip, 16);

			format(Query, sizeof( Query ), "INSERT INTO banned (bannedname, bannedip, bannedby, banreason, date, time) VALUES ('%s', '%s', 'Server', 'Cheating Infraction', '%d/%d/%d', '%d/%d/%d')",
			DB_Escape( username ), userip, year, month, day, hour, minute, second);
			db_query(Database, Query);

			format(Query, sizeof( Query ), "UPDATE users SET tobebanned = 0 WHERE username = '%s'", username);
			db_query(Database, Query);
				
			KickUsername(username);
				
			printf("(ANTICHEAT) Banned %s.", username);
		}
		while(db_next_row( Result ));
	}
	db_free_result(Result);
	return 1;
}
