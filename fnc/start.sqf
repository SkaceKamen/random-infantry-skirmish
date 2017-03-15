//Load avaible weapons and classes
call RSTF_loadWeapons;
call RSTF_loadClasses;

//Debug output
{
	diag_log format["Loaded %1 men, %2 tanks, %3 cars for %4",
		count(RSTF_MEN select _x),
		count((RSTF_VEHICLES select _x) select 1),
		count((RSTF_VEHICLES select _x) select 0),
		_x
	];
} foreach RSTF_SIDES;

if (count(RSTF_POINT) == 0) then {
	call RSTF_randomPoint;
};

//Create helper marker
_marker = createMarker ["TARGET", RSTF_POINT];
_marker setMarkerShape "ICON";
_marker setMarkerType "MIL_DOT";
_marker setMarkerText "Attack this position";

//Helper markers for spawns
/*_i = 0;
{
	_marker = createMarker ["SPAWN " + str(_i), _x];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "MIL_DOT";
	_marker setMarkerText "Spawn";
	_i = _i + 1;
} foreach RSTF_SPAWNS;*/

//Spawn neutral units
call RSTF_spawnNeutrals;

//Start UI features
[] spawn RSTF_UI_Start;

//Hide camera border
waitUntil { time > 0 };
showCinemaBorder false;

//Time
call RSTF_superRandomTime;

//Weather
[] spawn RSTF_superRandomWeather;

//Start game loop
[] spawn RSTF_loop;

//Update score display
[] call RSTF_scoreChanged;
