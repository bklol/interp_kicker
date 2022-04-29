#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <sdkhooks>

public Plugin myinfo = 
{
	name = "kick not def interp player",
	author = "bklol",
	description = "kick not def interp player",
	version = "1.0",
};

public void OnMapStart()
{
	CreateTimer(4.0, Timer_UpdateYaw, _, TIMER_REPEAT | TIMER_FLAG_NO_MAPCHANGE);
}

public Action Timer_UpdateYaw(Handle timer, any data)
{
	for(int client = 1; client <= MaxClients; client++)
	{
		if(IsClientInGame(client) && !IsFakeClient(client))
		{
			QueryForCvars(client);
		}
	}
}


void QueryForCvars(int client)
{
	QueryClientConVar(client, "cl_interp_ratio", OnCvarRetrieved);
	QueryClientConVar(client, "cl_interp", OnCvarRetrieved);
}

public void OnCvarRetrieved(QueryCookie cookie, int client, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue)
{
	if(StrEqual(cvarName, "cl_interp_ratio"))
	{
		int cl_interp_ratio = StringToInt(cvarValue);
	
		if(cl_interp_ratio != 2)
		{
			KickClient(client, "请将 cl_interp_ratio值设置为默认值 2");
		}
	}
	/*
	if(StrEqual(cvarName, "cl_interp"))
	{
		float cl_interp = StringToFloat(cvarValue);
	
		if(cl_interp != 0.03125)
		{
			KickClient(client, "请将 cl_interp 值设置为默认值 0.03125");
		}
	}
	*/
}