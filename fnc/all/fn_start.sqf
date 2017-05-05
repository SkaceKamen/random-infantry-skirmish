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
	_direction = _x getDir RSTF_POINT;
	for [{_xx = -160},{_xx <= 160},{_xx = _xx + 64}] do {
		_noise = random(20);
		_marker = createMarker [
			"SPAWN " + str(_foreachIndex) + str(_xx),
			_x vectorAdd [sin(_direction - 90) * _xx + sin(_direction) * _noise, cos(_direction - 90) * _xx + cos(_direction) * _noise, 0]
		];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "mil_ambush";
		_marker setMarkerDir (_direction - 90);

		if (_foreachIndex == SIDE_ENEMY) then {
			_marker setMarkerColor "ColorRed";
		} else {
			_marker setMarkerColor "ColorBlue";
		};
	};
} foreach RSTF_SPAWNS;

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
[] spawn RSTF_fnc_loop;