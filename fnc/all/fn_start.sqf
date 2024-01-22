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

// Vehicles handling
call RSTF_fnc_startVehicleCheckLoop;

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
	RSTF_INTRO_PLAYING = true;
	0 spawn RSTF_fnc_onPointChanged;
};

// Hide camera border
waitUntil { time > 0 };
showCinemaBorder false;

// Start gamemode loop
call RSTF_MODE_startLoop;

// Time
call RSTF_fnc_superRandomTime;

// Date
private _currentDate = date;
if (RSTF_USE_DEFAULT_DATE) then {
	private _worldStartDate = call RSTF_fnc_getWorldStartDate;
	_currentDate set [0, _worldStartDate#0];
	_currentDate set [1, _worldStartDate#1];
	_currentDate set [2, _worldStartDate#2];
	setDate _currentDate;
} else {
	_currentDate set [0, RSTF_DATE_YEAR];
	_currentDate set [1, RSTF_DATE_MONTH];
	_currentDate set [2, RSTF_DATE_DAY];
	setDate _currentDate;
};

// Weather
[] spawn RSTF_fnc_superRandomWeather;

waitUntil { sleep 0.1; !RSTF_INTRO_PLAYING; };

// Tell players we started
RSTF_STARTED = true;
publicVariable "RSTF_STARTED";
if (!isDedicated) then {
	0 spawn RSTF_fnc_onStarted;
};

// Start game loop
0 spawn RSTF_fnc_loop;

// Wait a second
sleep 2;

// This is initial spawn for players other than server
0 spawn {
	private _playersToAssign = call BIS_fnc_listPlayers;

	waitUntil { sleep 1; count(RSTF_GROUPS#SIDE_FRIENDLY) > 0 && count(RSTF_GROUPS#SIDE_ENEMY) > 0 };

	{
		if (_x != player) then {
			private _playerSide = [side(_x)] call RSTF_fnc_sideIndex;
			_playerSide remoteExec ["RSTF_fnc_spawnPlayer", owner(_x)];
		};
	} foreach _playersToAssign;

};

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