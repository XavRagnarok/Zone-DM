// functions related admin

stock StaffRank(rankid)
{
	new string[30];
	switch(rankid)
	{
		case 0: string = "";
		case 1: string = "Moderator";
		case 2: string = "Admin";
		case 3: string = "Lead Admin";
		case 4: string = "Manager";
		case 5: string = "Owner";
	}
	return string;
}