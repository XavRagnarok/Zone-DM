#define COLOR_WHITE (0xffffffFF)
#define COLOR_RED (0xdb1a1aFF)
#define COLOR_BLUE (0x2265d8FF)
#define COLOR_YELLOW (0xf6ff00FF)

#define SCM SendClientMessage
#define SCMex SendClientMessageEx

enum // dialogs
{
    DIALOG_REGISTER,
    DIALOG_LOGIN   
};

enum P_ACCOUNT_DATA
{
    pDBID,
    pAccName[60],
    pSkin,
    bool:pLoggedin
}

new PlayerInfo[MAX_PLAYERS][P_ACCOUNT_DATA];
new playerLogin[MAX_PLAYERS];
