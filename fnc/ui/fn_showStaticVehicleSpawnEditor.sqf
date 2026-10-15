private _parent = (RSTF_ADVANCED_CONFIG_DISPLAY#0) createDisplay "RscDisplayEmpty";

RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT = [missionConfigFile >> "StaticVehicleSpawnEditorDialog", _parent] call ZUI_fnc_createDisplay;

// Transports are not used - drop them when loading the list
private _transportClasses = [];
{
	private _factions = if (_x == SIDE_ENEMY) then { ENEMY_FACTIONS } else { FRIENDLY_FACTIONS };
	_transportClasses append (([_factions] call RSTF_fnc_loadVehicles)#RSTF_VEHICLE_TRANSPORT);
} foreach [SIDE_ENEMY, SIDE_FRIENDLY];

RSTF_STATIC_VEHICLE_SPAWNS_EDITOR = RSTF_STATIC_VEHICLE_SPAWNS select { !((_x#1) in _transportClasses) };
RSTF_STATIC_VEHICLE_SPAWN_EDITOR_INDEX = -1;

[RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT, "add", "ButtonClick", {
	RSTF_STATIC_VEHICLE_SPAWN_EDITOR_INDEX = -1;
	0 spawn RSTF_fnc_showStaticVehicleSpawnPicker;
}] call ZUI_fnc_on;

[RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT, "edit", "ButtonClick", {
	private _ctrl = [RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT, "vehicles"] call ZUI_fnc_getControlById;
	private _index = lnbCurSelRow _ctrl;
	if (_index < 0) exitWith {};

	RSTF_STATIC_VEHICLE_SPAWN_EDITOR_INDEX = _index;
	0 spawn RSTF_fnc_showStaticVehicleSpawnPicker;
}] call ZUI_fnc_on;

[RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT, "vehicles", "LBDblClick", {
	private _ctrl = [RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT, "vehicles"] call ZUI_fnc_getControlById;
	private _index = lnbCurSelRow _ctrl;
	if (_index < 0) exitWith {};

	RSTF_STATIC_VEHICLE_SPAWN_EDITOR_INDEX = _index;
	0 spawn RSTF_fnc_showStaticVehicleSpawnPicker;
}] call ZUI_fnc_on;

[RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT, "remove", "ButtonClick", {
	private _ctrl = [RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT, "vehicles"] call ZUI_fnc_getControlById;
	private _index = lnbCurSelRow _ctrl;
	if (_index < 0) exitWith {};

	RSTF_STATIC_VEHICLE_SPAWNS_EDITOR deleteAt _index;
	call RSTF_fnc_updateStaticVehicleSpawnEditor;
}] call ZUI_fnc_on;

[RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT, "clear", "ButtonClick", {
	RSTF_STATIC_VEHICLE_SPAWNS_EDITOR = [];
	call RSTF_fnc_updateStaticVehicleSpawnEditor;
}] call ZUI_fnc_on;

[RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT, "random", "ButtonClick", {
	0 spawn RSTF_fnc_showStaticVehicleSpawnRandom;
}] call ZUI_fnc_on;

[RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT, "cancel", "ButtonClick", {
	RSTF_STATIC_VEHICLE_SPAWNS_EDITOR = [];
	RSTF_STATIC_VEHICLE_SPAWN_EDITOR_INDEX = -1;
	[RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT] call ZUI_fnc_closeDisplay;
	RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT = [];
}] call ZUI_fnc_on;

[RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT, "save", "ButtonClick", {
	RSTF_STATIC_VEHICLE_SPAWNS = RSTF_STATIC_VEHICLE_SPAWNS_EDITOR;
	RSTF_STATIC_VEHICLE_SPAWNS_EDITOR = [];
	RSTF_STATIC_VEHICLE_SPAWN_EDITOR_INDEX = -1;
	[RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT] call ZUI_fnc_closeDisplay;
	RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT = [];
}] call ZUI_fnc_on;

call RSTF_fnc_updateStaticVehicleSpawnEditor;
