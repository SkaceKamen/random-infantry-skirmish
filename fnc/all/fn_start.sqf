if (!isDedicated) then {
	call RSTF_fnc_onPointChanged;
};

// Load avaible weapons and classes
call RSTF_fnc_loadWeapons;
call RSTF_fnc_loadClasses;

if (count(RSTF_POINT) == 0) then {
	call RSTF_fnc_randomPoint;
};

// Create helper marker
/*
_marker = createMarker ["TARGET", RSTF_POINT];
_marker setMarkerShape "ICON";
_marker setMarkerType "mil_objective";
*/

// Initialize GC
call RSTFGC_fnc_init;

// Load gamemode
private _mode = RSTF_MODES select RSTF_MODE_INDEX;

RSTF_MODE_init = _mode select 1;
RSTF_MODE_unitKilled = _mode select 2;
RSTF_MODE_taskCompleted = _mode select 3;

// Initialize gamemode
0 spawn RSTF_MODE_init;

// Helper markers for spawns
[RSTF_POINT, RSTF_SPAWNS] call RSTF_fnc_createPointMarkers;

// Spawn neutral units
call RSTF_fnc_spawnNeutrals;

// Spawn spawns
if (RSTF_SPAWN_TRANSPORTS) then {
	{
		[_foreachIndex, _x] call RSTF_fnc_spawnSpawnDefenses;
	} foreach RSTF_SPAWNS;
};

// Hide camera border
waitUntil { time > 0 };
showCinemaBorder false;

// Time
call RSTF_fnc_superRandomTime;

// Weather
[] spawn RSTF_fnc_superRandomWeather;

// Tell players we started
RSTF_STARTED = true;
publicVariable "RSTF_STARTED";
if (!isDedicated) then {
	0 spawn RSTF_fnc_onStarted;
};

// Wait for intro to finish playing
sleep 2;

// Start game loop
0 spawn RSTF_fnc_loop;