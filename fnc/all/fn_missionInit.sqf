// Clear module args if there're any
_this = [];

if (!isDedicated) then {
	waitUntil { not isNull player };
};

call ZUI_fnc_init;

call RSTF_fnc_initVariables;
call RSTF_fnc_initOptions;

if (fileExists("local.sqf")) then {
	call compile(preprocessFileLineNumbers("local.sqf"));
};

call RSTF_fnc_initKothMode;
call RSTF_fnc_initPushMode;
call RSTF_fnc_initDefendMode;
call RSTF_fnc_initClassicMode;
call RSTF_fnc_initArenaMode;
call RSTF_fnc_initGunGameMode;
call RSTF_fnc_initTasks;
call RSTF_fnc_init;

call RSTF_fnc_startMission;
