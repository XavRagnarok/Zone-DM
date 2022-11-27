// This is very dope script we are making for Ragnarok because he wants test his coding skills at newbie level
// Server name is Zones DM :)
													/*
													$$$$$$$$\  $$$$$$\  $$\   $$\ $$$$$$$$\ 
													\____$$  |$$  __$$\ $$$\  $$ |$$  _____|
													    $$  / $$ /  $$ |$$$$\ $$ |$$ |      
													   $$  /  $$ |  $$ |$$ $$\$$ |$$$$$\    
													  $$  /   $$ |  $$ |$$ \$$$$ |$$  __|   
													 $$  /    $$ |  $$ |$$ |\$$$ |$$ |      
													$$$$$$$$\  $$$$$$  |$$ | \$$ |$$$$$$$$\ 
													\________| \______/ \__|  \__|\________|
													


													██████╗ ███╗   ███╗
													██╔══██╗████╗ ████║
													██║  ██║██╔████╔██║
													██║  ██║██║╚██╔╝██║
													██████╔╝██║ ╚═╝ ██║
													╚═════╝ ╚═╝     ╚═╝
                   




													*/                                        
                                        


#include <a_samp>
#include <a_mysql>
#include <zcmd>
#include <sscanf2>
#include <mSelection>
#include <a_players>
#include <a_vehicles>
#include <float>
#include <foreach>
#include <k_functions>
#include <string>
#include <streamer>
#include <weapon-config>
#include <SKY>


// ============================== modular scripts =============================

// =========SQL DATABASE========

#include "./modular/mysql.pwn"

///////////////////////////////

// ================Server=======================

// =========== variables ===========
#include "./modular/server/variables.pwn"

// =========== events ==============
#include "./modular/server/events.pwn"

// =========== dialogs =============
#include "./modular/server/dialog.pwn"

// =========== functions ===========
#include "./modular/server/function.pwn"

// =========== dynamic pickups =====
#include "./modular/server/dynamic-pickups.pwn"

// =========== OnPlayerGiveDamageActor ===
#include "./modular/server/actor.pwn"													


////////////////////////////////////////////////

// ================Player =====================

// =========== events ===============
#include "./modular/player/events.pwn"

// =========== LOGIN/REGISTER =======
#include "./modular/player/account.pwn"

// =========== chats related ========
#include "./modular/player/chats.pwn"

// =========== commands =============
#include "./modular/player/commands.pwn"


///////////////////////////////////////////////

// =====================Anticheat==============

// ============= CBUG ANTICHEAT ======
#include "./modular/Anticheat/cbug.pwn"





///////////////////////////////////////////////


// ===================ADMIN==================

// ============= COMMANDS ===========
#include "./modular/admin/commands.pwn"

// ============= Functions ==========
#include "./modular/admin/functions.pwn"


/////////////////////////////////////////////


// =================GAMES==============

// ============= all dm arenas ======
#include "./modular/games/all_dms.pwn"

// ============= races ==============
#include "./modular/games/race.pwn"


////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////
