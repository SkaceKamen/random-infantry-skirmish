private _clientId = param [0];

call RSTF_fnc_syncServerOptions;

// Re-sync all variables
publicVariable "RSTF_LOCATION";
publicVariable "RSTF_SPAWNS";
publicVariable "RSTF_DIRECTION";
publicVariable "RSTF_DISTANCE";
publicVariable "RSTF_POINT";
publicVariable "RSTF_SCORE";
publicVariable "RSTF_GROUPS";
publicVariable "RSTF_BUYABLE_VEHICLES";
publicVariable "RSTF_MODE_KOTH_ENABLED";
publicVariable "RSTF_MODE_PUSH_ENABLED";
publicVariable "RSTF_MODE_DEFEND_ENABLED";

/*
TODO: 
publicVariable "RSTF_VOTES_TIMEOUT";
publicVariable "RSTF_POINT_VOTES";
publicVariable "RSTF_POINTS";
*/

publicVariable "RSTF_MONEY";
publicVariable "RSTF_STARTED";

// Resync weather
//publicVariable "RSTF_WEATHER_OVERCAST";
//publicVariable "RSTF_WEATHER_RAIN";
//publicVariable "RSTF_WEATHER_WIND";
//RSTF_WEATHER_SYNC = [ RSTF_WEATHER_OVERCAST, RSTF_WEATHER_RAIN, RSTF_WEATHER_WIND ];
//publicVariable "RSTF_WEATHER_SYNC";

private _status = "config";
if (RSTF_STARTED) then {
	_status = "started";
};

[_status] remoteExec ["RSTF_fnc_clientInit", _clientId];

