if (!isDedicated) then {
	player setVariable ["ASSIGNED", false, true];
};

waitUntil { time > 0 };
if (!isDedicated) then {
	waitUntil { !isNull(findDisplay 46) };
};

showCinemaBorder false;

if (isServer) then {
	call RSTF_fnc_serverStart;
} else {
	call RSTF_fnc_clientStart;
};