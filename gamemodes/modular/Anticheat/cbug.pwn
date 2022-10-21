// CBUG RELATED

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys & KEY_FIRE) && (oldkeys & KEY_CROUCH) && !((oldkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) || (oldkeys & KEY_FIRE) && (newkeys & KEY_CROUCH) && !((newkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) ) {
        switch(GetPlayerWeapon(playerid)) {
		    case 23..25, 27, 29..34, 41: {
		        if(Ammo[playerid][GetPlayerWeapon(playerid)] > GetPlayerAmmo(playerid)) {
					OnPlayerCBug(playerid);
				}
				return 1;
			}
		}
	}

	if(CheckCrouch[playerid] == 1) {
		switch(WeaponID[playerid]) {
		    case 23..25, 27, 29..34, 41: {
		    	if((newkeys & KEY_CROUCH) && !((newkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK ) {
		    		if(Ammo[playerid][GetPlayerWeapon(playerid)] > GetPlayerAmmo(playerid)) {
						OnPlayerCBug(playerid);
					}
		    	}
		    }
		}
	}

	//if(newkeys & KEY_CROUCH || (oldkeys & KEY_CROUCH)) return 1;

	else if(((newkeys & KEY_FIRE) && (newkeys & KEY_HANDBRAKE) && !((newkeys & KEY_SPRINT) || (newkeys & KEY_JUMP))) ||
	(newkeys & KEY_FIRE) && !((newkeys & KEY_SPRINT) || (newkeys & KEY_JUMP)) ||
	(NotMoving[playerid] && (newkeys & KEY_FIRE) && (newkeys & KEY_HANDBRAKE)) ||
	(NotMoving[playerid] && (newkeys & KEY_FIRE)) ||
	(newkeys & KEY_FIRE) && (oldkeys & KEY_CROUCH) && !((oldkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) ||
	(oldkeys & KEY_FIRE) && (newkeys & KEY_CROUCH) && !((newkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) ) {
		SetTimerEx("CrouchCheck", 3000, 0, "d", playerid);
		CheckCrouch[playerid] = 1;
		WeaponID[playerid] = GetPlayerWeapon(playerid);
		Ammo[playerid][GetPlayerWeapon(playerid)] = GetPlayerAmmo(playerid);
		return 1;
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
    new	string_3D[256];
	format(string_3D, sizeof(string_3D), "{FFFFFF}Ping: {FDE39D}%d\n{FFFFFF}FPS: {FDE39D}%d",GetPlayerPing(playerid), GetPlayerFPS(playerid));
	for(new i, j = GetMaxPlayers(); i != j; i++)
	{
		UpdatePlayer3DTextLabelText(i, Info[playerid], -1, string_3D);
	}

	new Keys, ud, lr;
	GetPlayerKeys(playerid, Keys, ud, lr);
	if(CheckCrouch[playerid] == 1) {
		switch(WeaponID[playerid]) {
		    case 23..25, 27, 29..34, 41: {
		    	if((Keys & KEY_CROUCH) && !((Keys & KEY_FIRE) || (Keys & KEY_HANDBRAKE)) && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK ) {
		    		if(Ammo[playerid][GetPlayerWeapon(playerid)] > GetPlayerAmmo(playerid)) {
						OnPlayerCBug(playerid);
					}
		    	}
		    	//else SendClientMessage(playerid, COLOR_RED, "Failed in onplayer update");
		    }
		}
	}

	if(!ud && !lr) { NotMoving[playerid] = 1; /*OnPlayerKeyStateChange(playerid, Keys, 0);*/ }
	else { NotMoving[playerid] = 0; /*OnPlayerKeyStateChange(playerid, Keys, 0);*/ }
	return 1;
}

forward OnPlayerCBug(playerid);
public OnPlayerCBug(playerid) {
	/*new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, sizeof(playername));
	new str2[128];
	format(str2, sizeof(str2), "Automatic system has kicked you for Crouch bugging with weapon (%s!)", aWeaponNames[WeaponID[playerid]]);
	SendClientMessage(playerid, COLOR_RED, str2);
	CheckCrouch[playerid] = 0;
	Kick(playerid);*/
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, sizeof(playername));
	new str2[128];
	format(str2, sizeof(str2), "Automatic system has slapped you for Crouch bugging with weapon (%s!)", aWeaponNames[WeaponID[playerid]]);
	SendClientMessage(playerid, COLOR_RED, str2);
	new Float:Pos[3];
	GetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]);
	SetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]+2.5);
	PlayerPlaySound(playerid,1190,0.0,0.0,0.0);
	CheckCrouch[playerid] = 0;
	return 1;
}

forward CrouchCheck(playerid);
public CrouchCheck(playerid) {
	CheckCrouch[playerid] = 0;
	return 1;
}