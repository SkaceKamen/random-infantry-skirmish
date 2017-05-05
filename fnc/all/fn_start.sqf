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

// Helper markers for spawns
{
	_marker = createMarker ["SPAWN " + str(_foreachIndex), _x];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "mil_ambush";
	_marker setMarkerDir ((_x getDir RSTF_POINT) - 90);

	if (_foreachIndex == SIDE_ENEMY) then {
		_marker setMarkerColor "ColorRed";
	} else {
		_marker setMarkerColor "ColorBlue";
	};
} foreach RSTF_SPAWNS;

// Spawn neutral units
call RSTF_fnc_spawnNeutrals;

// Spawn spawns
{
	[_foreachIndex, _x] call RSTF_fnc_spawnSpawnDefenses;
} foreach RSTF_SPAWNS;

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

sleep 2;

// Marks unspawned players
{
	RSTF_ASSIGNED_UNITS pushBack [_x, objNull];
} foreach allPlayers;

// Start game loop
[] spawn RSTF_fnc_loop;