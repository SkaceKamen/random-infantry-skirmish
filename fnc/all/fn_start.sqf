// Load avaible weapons and classes
call RSTF_fnc_loadWeapons;
call RSTF_fnc_loadClasses;

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

// Checks if AI units aren't stuck somewhere
call RSTF_fnc_startMovementCheckLoop;


// Clear unhistoric items if needed
if (RSTF_CLEAR_HISTORIC_ITEMS) then {
	[RSTF_POINT, 3000] call RSTF_fnc_clearHistoricItems;
};

// Initialize selected gamemode
call RSTF_fnc_initializeMode;

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

/*
TEST OF: RSTF_fnc_getObjectiveDistance
private _line = createMarker ["LINE", RSTF_POINT];
_line setMarkerShape "RECTANGLE";
_line setMarkerSize [0.2, 200];
_line setMarkerColor "ColorRed";
_line setMarkerDir RSTF_DIRECTION + 90;

for [{_i = 0},{_i < 100},{_i = _i + 1}] do {
	private _pos = RSTF_POINT vectorAdd [-100 + random 200, -100 + random 200, 0];
	private _marker = createMarker ["TEST" + str(_i), _pos];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "mil_dot";
	_marker setMarkerSize [0.2, 0.2];
	_marker setMarkerText str([_pos] call RSTF_fnc_getObjectiveDistance);
	_marker setMarkerShadow false;
};
*/