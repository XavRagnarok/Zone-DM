main()
{
	print("\n-------------------------------------");
	print("This is the sick script we are making");
	print("---------------------------------------\n");
}

public OnGameModeInit()
{
    DisableInteriorEnterExits();
    // SQL RELATED
    ourConnection = mysql_connect(SQL_HOSTNAME, SQL_USERNAME, SQL_DATABASE, SQL_PASSWORD);

    if(mysql_errno() !=0)
        printf ("[DATABASE]: Connection failed to MySQL", SQL_DATABASE);
    else printf ("[DATABASE]: Connection established to MySQL", SQL_DATABASE);
    ///////////////////////////////////////////////
    joinskin = LoadModelSelectionMenu("skins.txt");

 	SetGameModeText("friends zone");
 	// Dynamic pickups
    // DM related
    /*
 	ddmpickup = CreateDynamicPickup(1318, 2, 385.8448,-2087.5015,7.8359, -1, -1, -1, 100.0, -1, 0);
 	*/

    actorddm = CreateActor(94, 385.8448,-2087.5015,7.8359, 359);

 	Create3DTextLabel("Deagle DM", COLOR_BLUE, 385.8448,-2087.5015,7.8359, 20, 0, 0);
 	
 	sdmpickup = CreateDynamicPickup(1318, 2, 383.2977,-2087.4326,7.8359, -1, -1, -1, 100.0, -1, 0);
 	
    Create3DTextLabel("Sniper DM", COLOR_RED, 383.2977,-2087.4326,7.8359, 20, 0, 0);
    
	spasdmpickup = CreateDynamicPickup(1318, 2, 388.5406,-2087.7051,7.8359, -1, -1, -1, 100.0, -1, 0);
    
    Create3DTextLabel("Combat Shotgun DM", COLOR_CYAN, 388.5406,-2087.7051,7.8359, 20, 0, 0);
 	///////////////////////////

    SetVehiclePassengerDamage(true);
    SetDisableSyncBugs(true);

    
    //////////////////////////

    // RACE RELATED
    for(new i = 0; i < MAX_RACES; i++)
    {
        RACE_loadRaceFromFile(i);
    }
    
    printf(" ___________________________________________________________\n");
    printf("  » Raf Racing System loaded. (Loaded %d Races)", RACE_loadedRaces);
    printf(" ___________________________________________________________\n\n\n");
    
    RACE_loadTextdraws();
    
    #if defined RACE_OnGameModeInit
        RACE_OnGameModeInit();
    #endif
	return 1;
}

public OnGameModeExit()
{
    mysql_close(ourConnection);
    return 1;
}