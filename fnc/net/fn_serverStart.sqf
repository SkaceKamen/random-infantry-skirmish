call RSTF_fnc_serverEvents;

if (RSTF_SKIP_CONFIG) then {
	// Start game without config
	["Skipping config, starting server"] call RSTF_fnc_Log;
	call RSTF_fnc_start;
} else {
	if (hasInterface) then {
		["Showing config screen"] call RSTF_fnc_Log;
		// call RSTF_fnc_showConfig;
		call RSTF_fnc_showModeSelector;
	} else {
		["Waiting for admin to config mission"] call RSTF_fnc_Log;
	};
};