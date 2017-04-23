//Load avaible weapons and classes
call RSTF_fnc_loadWeapons;
call RSTF_fnc_loadClasses;

if (count(RSTF_POINT) == 0) then {
	call RSTF_fnc_randomPoint;
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
call RSTF_fnc_spawnNeutrals;

// Spawn spawns
{
	[_foreachIndex, _x] call RSTF_fnc_spawnSpawnDefenses;
} foreach RSTF_SPAWNS;

//Start UI features
[] spawn RSTF_fnc_UI_Start;

//Hide camera border
waitUntil { time > 0 };
showCinemaBorder false;

//Time
call RSTF_fnc_superRandomTime;

//Weather
[] spawn RSTF_fnc_superRandomWeather;

[
	[
		[text(RSTF_LOCATION), "%1<br />"],
		[format["%1:%2", date select 3, date select 4],"<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"]
	]
] call BIS_fnc_typeText;

sleep 2;

//Start game loop
[] spawn RSTF_fnc_loop;

//Update score display
[] call RSTF_fnc_scoreChanged;
