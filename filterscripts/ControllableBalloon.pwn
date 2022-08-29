#include <a_samp>
 
#define FILTERSCRIPT
 
public OnFilterScriptInit()
{
        return 1;
}
 
public OnFilterScriptExit()
{
        return 1;
}
///////////////////////////////(DEFINES)////////////////////////////////////////
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define COLOR_GREENZ 0x30F114FF
#define MAX_OBJECT_DESTROY_DISTANCE 100
////////////////////////////////(FORWARDS)//////////////////////////////////////
forward MoveObjectUp(playerid); MoveObjectDown(playerid); MoveObjectForward(playerid); MoveObjectBack(playerid); MoveObjectRight(playerid); MoveObjectLeft(playerid);
/////////////////////////////////(ENUMS)////////////////////////////////////////
enum Player
{
        PBalloon
}
//////////////////////////////////(GLOBAL VARIABLES)////////////////////////////
new PlayerInfo[MAX_PLAYERS][Player],Balloon[MAX_PLAYERS], Fire[MAX_PLAYERS], Fire1[MAX_PLAYERS], TimerUP, TimerDown, TimerForward, TimerBack, TimerRight, TimerLeft;
//////////////////////////////////(PUBLIC FUNCTIONS)////////////////////////////
public OnPlayerUpdate(playerid)
{
        if(PlayerInfo[playerid][PBalloon] == 1)
        {
                new Float:x,Float:y,Float:z;
                GetObjectPos(Balloon[playerid], x, y, z);
                if(!IsPlayerInRangeOfPoint(playerid, MAX_OBJECT_DESTROY_DISTANCE, x, y, z))
                {
                    DestroyObject(Balloon[playerid]);
                    DestroyObject(Fire[playerid]);
                    DestroyObject(Fire1[playerid]);
                    PlayerInfo[playerid][PBalloon] = 0;
                    GameTextForPlayer(playerid,"~g~Destroyed controllable object",4500,3);
                }
        }
        return 1;
}
 
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
 
        for(new i = 0; i < MAX_PLAYERS; i++)
        {
                if(PlayerInfo[i][PBalloon] == 1)
                {
                        new Float:X,Float:Y,Float:Z;
                        GetObjectPos(Balloon[playerid],X,Y,Z);
                       
                        if(PRESSED(KEY_SPRINT | KEY_YES))
                        {
                                TimerUP = SetTimer("MoveObjectUp",30,1);
                                GameTextForPlayer(playerid,"~g~moving up",2000,3);
                        }
                       
                        if(RELEASED(KEY_SPRINT | KEY_YES))
                        {
                        KillTimer(TimerUP);
            }
 
                        if(PRESSED(KEY_SPRINT | KEY_NO))
                        {
                                TimerDown = SetTimer("MoveObjectDown",30,1);
                                GameTextForPlayer(playerid,"~g~moving down",2000,3);
                        }
                       
                        if(RELEASED(KEY_SPRINT | KEY_NO))
                        {
                            KillTimer(TimerDown);
                        }
 
                        if(PRESSED(KEY_SECONDARY_ATTACK | KEY_YES))
                        {
                            TimerForward = SetTimer("MoveObjectForward",30,1);
                            GameTextForPlayer(playerid,"~g~moving forward",2000,3);
                    }
                   
                        if(RELEASED(KEY_SECONDARY_ATTACK | KEY_YES))
                        {
                            KillTimer(TimerForward);
                        }
 
                        if(PRESSED(KEY_SECONDARY_ATTACK | KEY_NO))
                        {
                            TimerBack = SetTimer("MoveObjectBack",30,1);
                            GameTextForPlayer(playerid,"~g~moving backward",2000,3);
                        }
                       
                        if(RELEASED(KEY_SECONDARY_ATTACK | KEY_NO))
                        {
                            KillTimer(TimerBack);
                        }
 
                        if(PRESSED(KEY_WALK | KEY_YES))
                        {
                            TimerRight = SetTimer("MoveObjectRight",30,1);
                            GameTextForPlayer(playerid,"~g~moving right",2000,3);
                        }
                       
                        if(RELEASED(KEY_WALK | KEY_YES))
                        {
                            KillTimer(TimerRight);
                        }
 
                        if(PRESSED(KEY_WALK | KEY_NO))
                        {
                            TimerLeft = SetTimer("MoveObjectLeft",30,1);
                            GameTextForPlayer(playerid,"~g~moving left",2000,3);
                        }
                       
                        if(RELEASED(KEY_WALK | KEY_NO))
                        {
                            KillTimer(TimerLeft);
                        }
                }
        }
    return 1;
}
 
public OnPlayerCommandText(playerid, cmdtext[])
{
        if(strcmp("/balloon", cmdtext, true, 10) == 0)
        {
        new Float:x,Float:y,Float:z;
        GetPlayerPos(playerid,x,y,z);
        SetPlayerPos(playerid,x,y,z+3.5);
        Balloon[playerid] = CreateObject(19335,x,y,z + 3,0.0,0.0,0.0);
        Fire[playerid] = CreateObject(18692,x,y,z + 3,0.0,0.0,0.0);
        Fire1[playerid] = CreateObject(18692,x,y,z + 3,0.0,0.0,0.0);
        AttachObjectToObject(Fire[playerid],Balloon[playerid],0.0,0.0,2.0,0.0,0.0,0.0,1);
        AttachObjectToObject(Fire1[playerid],Balloon[playerid],0.0,0.0,4.0,0.0,0.0,0.0,1);
            SendClientMessage(playerid,COLOR_GREENZ,"Use the following keys to control the controllable object");
            SendClientMessage(playerid,COLOR_GREENZ,"~k~~PED_SPRINT~+~k~~CONVERSATION_YES~ (Move Balloon Up)");
            SendClientMessage(playerid,COLOR_GREENZ,"~k~~PED_SPRINT~+~k~~CONVERSATION_NO~ (Move Balloon Down)");
            SendClientMessage(playerid,COLOR_GREENZ,"~k~~VEHICLE_ENTER_EXIT~+~k~~CONVERSATION_YES~ (Move Balloon Forward)");
            SendClientMessage(playerid,COLOR_GREENZ,"~k~~VEHICLE_ENTER_EXIT~+~k~~CONVERSATION_NO~ (Move Balloon Back)");
            SendClientMessage(playerid,COLOR_GREENZ,"~k~~SNEAK_ABOUT~+~k~~CONVERSATION_NO~ (Move Balloon Left)");
            SendClientMessage(playerid,COLOR_GREENZ,"~k~~SNEAK_ABOUT~+~k~~CONVERSATION_YES~ (Move Balloon Right)");
            PlayerInfo[playerid][PBalloon] = 1;
                return 1;
        }
       
        else if(strcmp("/destroyballoon", cmdtext, true, 10) == 0)
        {
            if(PlayerInfo[playerid][PBalloon] == 0) return GameTextForPlayer(playerid,"~g~you dident spawned any balloon",4500,3);
                DestroyObject(Balloon[playerid]);
            DestroyObject(Fire[playerid]);
            DestroyObject(Fire1[playerid]);
            PlayerInfo[playerid][PBalloon] = 0;
            GameTextForPlayer(playerid,"~g~Destroyed controllable object",4500,3);
        }
        return 0;
}
