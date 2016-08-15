#include <a_samp> 

#include <sscanf2> 

#include <zcmd> 

#include <ascii_art> 

new Player[MAX_PLAYERS] = {-1, ...}; 

CMD:render(playerid, params[]) 
{ 
    if(isnull(params)) 
        return SendClientMessage(playerid, -1, "/render [text]"); 

    if(Player[playerid] != -1) 
    { 
        DeleteASCIIArt(Player[playerid]); 
    } 

    new 
        Float:pos[3]; 

    GetPlayerPos(playerid, pos[0], pos[1], pos[2]); 
    GetPosInFrontOfPlayer(playerid, pos[0], pos[1], 45.0); 

    Player[playerid] = RenderASCIIArt(1685, params, pos[0], pos[1], pos[2], 180.0, 1.75, 1.50); 
    return 1; 
} 

forward Float:GetPosInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance); 
public Float:GetPosInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance) 
{ 
    new Float:a; 
    GetPlayerPos(playerid, x, y, a); 
    switch(IsPlayerInAnyVehicle(playerid)) 
    { 
        case 0: GetPlayerFacingAngle(playerid, a); 
        case 1: GetVehicleZAngle(GetPlayerVehicleID(playerid), a); 
    } 
    x += (distance * floatsin(-a, degrees)); 
    y += (distance * floatcos(-a, degrees)); 
    return a; 
}  