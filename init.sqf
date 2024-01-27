waitUntil { not isNull player };

call ZUI_fnc_init;

call compile(preprocessFileLineNumbers("variables.sqf"));
call compile(preprocessFileLineNumbers("options.sqf"));
call compile(preprocessFileLineNumbers("options-menu.sqf"));

if (fileExists("local.sqf")) then {
	call compile(preprocessFileLineNumbers("local.sqf"));
};

call RSTF_fnc_initKothMode;
call RSTF_fnc_initPushMode;
call RSTF_fnc_initDefendMode;
call RSTF_fnc_initClassicMode;
call RSTF_fnc_initTasks;
call RSTF_fnc_init;

call RSTF_fnc_startMission;
