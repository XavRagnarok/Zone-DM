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
 	ddmpickup = CreateDynamicPickup(1318, 2, 238.7231,-1882.8654,4.4767, -1, -1, -1, 100.0, -1, 0);
 	
 	CreateDynamic3DTextLabel("Press ~k~~VEHICLE_ENTER_EXIT~", -1, 238.7231,-1882.8654,4.4767, 5.0, -1, -1, 1, -1, -1, -1, 5.0);
 	
 	sdmpickup = CreateDynamicPickup(1318, 2, 236.1373,-1882.9423,4.4698, -1, -1, -1, 100.0, -1, 0);
 	
    CreateDynamic3DTextLabel("Press ~k~~VEHICLE_ENTER_EXIT~", -1, 236.1373,-1882.9423,4.4698, 5.0, -1, -1, 1, -1, -1, -1, 5.0);
    
	sosdmpickup = CreateDynamicPickup(1318, 2, 233.6071,-1883.0021,4.4685, -1, -1, -1, 100.0, -1, 0);
    
    CreateDynamic3DTextLabel("Press ~k~~VEHICLE_ENTER_EXIT~", -1, 233.6071,-1883.0021,4.4685, 5.0, -1, -1, 1, -1, -1, -1, 5.0);
 	///////////////////////////
    //////////////////////////
	return 1;
}

public OnGameModeExit()
{
    mysql_close(ourConnection);
    return 1;
}