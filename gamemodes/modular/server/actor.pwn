// OnPlayerGiveDamageActor

public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float:amount, weaponid, bodypart)
{
	if(damaged_actorid == actorddm)
	{
		new string[128];
		if(dm[playerid] == 1 || dm[playerid] == 2 || dm[playerid] == 3) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500, 3);
		DDM(playerid);
		format(string, sizeof(string), "%s(%d) has joined the Deagle Deathmatch", GetName(playerid), playerid);
		SCMall(COLOR_BLUE, string);
	}

	if(damaged_actorid == actorsdm)
	{
		new string[128];
		if(dm[playerid] == 2 || dm[playerid] == 3 || dm[playerid] == 1) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500, 3);
		SDM(playerid);
		format(string, sizeof(string), "%s(%d) has joined the Sniper Deathmatch", GetName(playerid), playerid);
		SCMall(COLOR_BLUE, string);
	}

	if(damaged_actorid == actorspasdm)
	{
		new string[128];
		if(dm[playerid] == 3 || dm[playerid] == 2 || dm[playerid] == 1) return GameTextForPlayer(playerid, "~g~You are already in a deathmatch", 4500,3);
		SPASDM(playerid);
		format(string, sizeof(string), "%s(%d) has joined the Combat Shotgun Deathmatch", GetName(playerid), playerid);
		SCMall(COLOR_BLUE, string);
	}
	return 1;
}