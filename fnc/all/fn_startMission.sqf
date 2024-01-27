RSTF_PREDEFINED_LOCATIONS = call RSTF_fnc_loadPredefined;

RSTF_PLAYER_UID = "NET:" + str(clientOwner);

if (!isDedicated) then {
	player setVariable ["ASSIGNED", false, true];
	player setVariable ["RSTF_UID", RSTF_PLAYER_UID, true];
};

waitUntil { time > 0 };
if (!isDedicated) then {
	waitUntil { !isNull(findDisplay 46) };
};

showCinemaBorder false;

if (isServer) then {
	["Starting server scripts"] call RSTF_fnc_Log;
	call RSTF_fnc_serverStart;
} else {
	["Starting client scripts"] call RSTF_fnc_Log;
	call RSTF_fnc_clientStart;
};
