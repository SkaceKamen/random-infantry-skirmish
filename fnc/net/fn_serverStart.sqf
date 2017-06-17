call RSTF_fnc_serverEvents;

if (RSTF_SKIP_CONFIG) then {
	//Start game
	call RSTF_fnc_start;
} else {
	if (hasInterface) then {
		call RSTF_fnc_showConfig;
	};
};