private _parent = ([RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT] call ZUI_fnc_display) createDisplay "RscDisplayEmpty";

RSTF_STATIC_VEHICLE_SPAWN_RANDOM_LAYOUT = [missionConfigFile >> "StaticVehicleSpawnRandomDialog", _parent] call ZUI_fnc_createDisplay;

{
	([RSTF_STATIC_VEHICLE_SPAWN_RANDOM_LAYOUT, _x] call ZUI_fnc_getControlById) ctrlSetText "0";
} foreach ["wheeled", "tracked", "planes", "helicopters", "other"];

([RSTF_STATIC_VEHICLE_SPAWN_RANDOM_LAYOUT, "respawn"] call ZUI_fnc_getControlById) ctrlSetText "60";

[RSTF_STATIC_VEHICLE_SPAWN_RANDOM_LAYOUT, "cancel", "ButtonClick", {
	[RSTF_STATIC_VEHICLE_SPAWN_RANDOM_LAYOUT] call ZUI_fnc_closeDisplay;
	RSTF_STATIC_VEHICLE_SPAWN_RANDOM_LAYOUT = [];
}] call ZUI_fnc_on;

[RSTF_STATIC_VEHICLE_SPAWN_RANDOM_LAYOUT, "fill", "ButtonClick", {
	call RSTF_fnc_staticVehicleSpawnRandomFill;
}] call ZUI_fnc_on;
