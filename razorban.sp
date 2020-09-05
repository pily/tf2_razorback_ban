#pragma semicolon 1
#include <sourcemod>
#include <tf2_stocks>
#include <sdkhooks>
#include <sdktools>

#define PLUGIN_VERSION                  "0x03"

//Teams
#define TEAM_RED    2
#define TEAM_BLU    3

public Plugin:myinfo = {
    name = "razir back Ban",
    author = "Chdata",
    description = "Hexy.",
    version = PLUGIN_VERSION,
    url = "http://steamcommunity.com/groups/tf2data"
};

public OnPluginStart()
{
    HookEvent("post_inventory_application", evEquipped);
}

/*
On spawn, see if we need to replace a weapon for another one

*/
public Action:evEquipped(Handle:hEvent, const String:sName[], bool:bDontBroadcast)
{
    new client = GetClientOfUserId(GetEventInt(hEvent, "userid"));

    if (GetClientTeam(client) != TEAM_BLU && GetClientTeam(client) != TEAM_RED)
        return Plugin_Continue;

    new entity = -1;
    while( ( entity = FindEntityByClassname2(entity, "tf_wearable_razorback") ) != -1)
    {
        if(GetEntPropEnt(entity, Prop_Send, "m_hOwnerEntity"))
        {
            TF2_RemoveWearable(client, entity);
        }
    }

    return Plugin_Continue;
}

stock FindEntityByClassname2(startEnt, const String:classname[])
{
    /* If startEnt isn't valid shifting it back to the nearest valid one */
    while (startEnt > -1 && !IsValidEntity(startEnt)) startEnt--;
    return FindEntityByClassname(startEnt, classname);
} 