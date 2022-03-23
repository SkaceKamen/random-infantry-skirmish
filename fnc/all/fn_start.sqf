if (!RSTF_DEBUG) then {
	startLoadingScreen ["Preparing battle"];
};

// Load avaible weapons and classes
call RSTF_fnc_loadWeapons;
call RSTF_fnc_loadClasses;

progressLoadingScreen 0.25;

// Send list of available vehicles to other players
publicVariable "RSTF_BUYABLE_VEHICLES";

if (count(RSTF_POINT) == 0) then {
	((1 call RSTF_fnc_pickRandomPoints) select 0) call RSTF_fnc_assignPoint;
};

// Create helper marker
/*
_marker = createMarker ["TARGET", RSTF_POINT];
_marker setMarkerShape "ICON";
_marker setMarkerType "mil_objective";
*/

// Initialize GC
call RSTFGC_fnc_init;

progressLoadingScreen 0.5;

// Clear unhistoric items if needed
if (RSTF_CLEAR_HISTORIC_ITEMS) then {
	[RSTF_POINT, 3000] call RSTF_fnc_clearHistoricItems;
};

// Initialize selected gamemode
call RSTF_fnc_initializeMode;

// Helper markers for spawns
[RSTF_POINT, RSTF_SPAWNS] call RSTF_fnc_createPointMarkers;

progressLoadingScreen 0.75;

// Spawn neutral units
call RSTF_fnc_spawnNeutrals;

// Spawn spawns
if (RSTF_SPAWN_TRANSPORTS) then {
	{
		[_foreachIndex, _x] call RSTF_fnc_spawnSpawnDefenses;
	} foreach RSTF_SPAWNS;
};

endLoadingScreen;

// TODO: What to do with this
if (!isDedicated) then {
	call RSTF_fnc_onPointChanged;
};

// Start gamemode loop
call RSTF_MODE_startLoop;

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