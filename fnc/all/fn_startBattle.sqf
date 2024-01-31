[RSTF_STATE_BATTLE] call RSTF_fnc_setState;

"Battle is being initialized..." call RSTF_fnc_dbg;

"Picking point..." call RSTF_fnc_dbg;

if (count(RSTF_POINT) == 0) then {
	((1 call RSTF_fnc_pickRandomPoints) select 0) call RSTF_fnc_assignPoint;
};

"Starting start overlay..." call RSTF_fnc_dbg;

// TODO: Is this good place?
if (!isDedicated) then {
	RSTF_INTRO_PLAYING = true;
	0 spawn RSTF_fnc_onPointChanged;
};

"Initializing loops..." call RSTF_fnc_dbg;

// Initialize GC
call RSTFGC_fnc_init;

// Checks if AI units aren't stuck somewhere
call RSTF_fnc_startMovementCheckLoop;

// Vehicles handling
call RSTF_fnc_startVehicleCheckLoop;

// Clear unhistoric items if needed
if (RSTF_CLEAR_HISTORIC_ITEMS) then {
	"Clearing historic items..." call RSTF_fnc_dbg;

	[RSTF_POINT, 3000] call RSTF_fnc_clearHistoricItems;
};

"Loading classes..." call RSTF_fnc_dbg;

// Load avaible weapons and classes
call RSTF_fnc_loadWeapons;
call RSTF_fnc_loadClasses;

// Send list of available vehicles to other players
publicVariable "RSTF_BUYABLE_VEHICLES";

"Initializing mode..." call RSTF_fnc_dbg;

// Initialize selected gamemode
call RSTF_fnc_initializeMode;

// Helper markers for spawns
[RSTF_POINT, RSTF_SPAWNS] call RSTF_fnc_createPointMarkers;

if (call RSTF_fnc_doesModeSupportNeutrals) then {
	"Spawning neutrals.." call RSTF_fnc_dbg;

	// Spawn neutral units
	call RSTF_fnc_spawnNeutrals;
};

// Spawn spawns
if (RSTF_SPAWN_TRANSPORTS && !RSTF_DISABLE_SPAWN_TRANSPORTS) then {
	"Spawning transports on spawns..." call RSTF_fnc_dbg;

	{
		[_foreachIndex, _x] call RSTF_fnc_spawnSpawnDefenses;
	} foreach RSTF_SPAWNS;
};

// Hide camera border
waitUntil { time > 0 };
showCinemaBorder false;

"Starting mode loop..." call RSTF_fnc_dbg;

// Start gamemode loop
call RSTF_MODE_startLoop;

"Time init..." call RSTF_fnc_dbg;

// Time
call RSTF_fnc_superRandomTime;

"Date init..." call RSTF_fnc_dbg;

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

"Weather init..." call RSTF_fnc_dbg;

// Weather
[] spawn RSTF_fnc_superRandomWeather;

// Tell players we started
RSTF_STARTED = true;
publicVariable "RSTF_STARTED";
if (!isDedicated) then {
	0 spawn RSTF_fnc_onStarted;
};

"Waiting for intro to finish..." call RSTF_fnc_dbg;

waitUntil { sleep 0.1; !RSTF_INTRO_PLAYING; };

"Starting gameplay loop..." call RSTF_fnc_dbg;

// Start game loop
0 spawn RSTF_fnc_loop;

"Starting player spawn..." call RSTF_fnc_dbg;

// Wait a second
sleep 2;

if (isMultiplayer) then {
	"Spawning remote players..." call RSTF_fnc_dbg;

	// This is initial spawn for players other than server
	0 spawn {
		private _playersToAssign = (call BIS_fnc_listPlayers) select { _x != player };

		waitUntil { sleep 1; count(RSTF_GROUPS#SIDE_FRIENDLY) > 0 && count(RSTF_GROUPS#SIDE_ENEMY) > 0 };

		{
			private _playerSide = [side(_x)] call RSTF_fnc_sideIndex;
			_playerSide remoteExec ["RSTF_fnc_spawnPlayer", owner(_x)];
		} foreach _playersToAssign;
	};
};

/*
// TEST OF: RSTF_fnc_getObjectiveDistance
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

/*
// TEST OF: RSTF_fnc_pickEmplacementPos;
for [{_i = 0}, {_i < 1000}, {_i = _i + 1}] do {
	private _pos = [RSTF_POINT, RSTF_MODE_PUSH_POINT_RADIUS, RSTF_DIRECTION, []] call RSTF_fnc_pickEmplacementPos;
	private _marker = createMarker ["TEST" + str(_i), _pos];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "mil_dot";
	_marker setMarkerShadow false;
};
*/
