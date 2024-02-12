call RSTF_fnc_serverEvents;

private _skipConfig = RSTF_SKIP_CONFIG || ((["skipConfig", 0] call BIS_fnc_getParamValue) == 1);

if (_skipConfig) then {
	// Start game without config
	["Skipping config, starting server"] call RSTF_fnc_Log;
	call RSTF_fnc_startBattle;
} else {
	if (hasInterface) then {
		["Showing config screen"] call RSTF_fnc_Log;
		call RSTF_fnc_showChangelog;
	} else {
		["Waiting for admin to config mission"] call RSTF_fnc_Log;
	};
};
