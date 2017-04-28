if (isServer) then {
	if (RSTF_SKIP_CONFIG) then {
		//Start game
		call RSTF_fnc_start;
	} else {
		call RSTF_fnc_showConfig;
	};
} else {
	call RSTF_fnc_clientStart;
};