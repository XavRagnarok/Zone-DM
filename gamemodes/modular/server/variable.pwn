/*
variable.pwn
contains global and player variables for the server
*/


#define SERVER_NAME "Zone DM"


#define COLOR_GREEN   		0x00FF22FF
#define COLOR_ORANGE  		0xF06B0CFF

#define COLOR_WHITE   		0xFFFFFFFF
#define COLOR_PURPLE  		0xB00EC9FF
#define COLOR_BLUE    		0x40FFFFFF
#define COLOR_RED 	  		0xFF0000FF
#define COLOR_GREY    		0xB5B5B5FF

// used in error messages
#define COLOR_ERROR   		0xFF8282FF

// dialog ids
enum
{
	DIALOG_NONE,
	DIALOG_REGISTER,
	DIALOG_LOGIN
};

enum e_playerInfo
{
    pDBID,
    pAccName[60],
    bool:pLoggedin,
  
};
new PlayerInfo[MAX_PLAYERS][e_playerInfo];

// =====================REGISTER/LOGGING STUFF===================

new joinskin = mS_INVALID_LISTID;

new PlayerLogin[MAX_PLAYERS];

