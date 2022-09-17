new MySQL:Database;
 
enum {
	d_reg,
	d_log
}
 
enum PlayerInfo{
    ID,
    Name[25],
    Password[65],
    Kills,
    Deaths,
    Cash,
    Score
}
new PI[MAX_PLAYERS][PlayerInfo];