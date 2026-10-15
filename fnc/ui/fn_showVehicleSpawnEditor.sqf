private _parent = (RSTF_ADVANCED_CONFIG_DISPLAY#0) createDisplay "RscDisplayEmpty";

RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT = [missionConfigFile >> "VehicleSpawnEditorDialog", _parent] call ZUI_fnc_createDisplay;
RSTF_VEHICLE_SPAWNS_EDITOR = +RSTF_VEHICLE_SPAWNS;

[RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT, "add", "ButtonClick", {
	0 spawn RSTF_fnc_showVehicleSpawnPicker;
}] call ZUI_fnc_on;

[RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT, "remove", "ButtonClick", {
	private _ctrl = [RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT, "vehicles"] call ZUI_fnc_getControlById;
	private _index = lnbCurSelRow _ctrl;
	if (_index == -1) exitWith {};

	RSTF_VEHICLE_SPAWNS_EDITOR deleteAt _index;
	call RSTF_fnc_updateVehicleSpawnEditor;
}] call ZUI_fnc_on;

[RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT, "up", "ButtonClick", {
	private _ctrl = [RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT, "vehicles"] call ZUI_fnc_getControlById;
	private _index = lnbCurSelRow _ctrl;
	if (_index <= 0) exitWith {};

	private _entry = RSTF_VEHICLE_SPAWNS_EDITOR select _index;
	RSTF_VEHICLE_SPAWNS_EDITOR set [_index, RSTF_VEHICLE_SPAWNS_EDITOR select (_index - 1)];
	RSTF_VEHICLE_SPAWNS_EDITOR set [_index - 1, _entry];

	call RSTF_fnc_updateVehicleSpawnEditor;
	_ctrl lnbSetCurSelRow (_index - 1);
}] call ZUI_fnc_on;

[RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT, "down", "ButtonClick", {
	private _ctrl = [RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT, "vehicles"] call ZUI_fnc_getControlById;
	private _index = lnbCurSelRow _ctrl;
	if (_index == -1 || _index >= count(RSTF_VEHICLE_SPAWNS_EDITOR) - 1) exitWith {};

	private _entry = RSTF_VEHICLE_SPAWNS_EDITOR select _index;
	RSTF_VEHICLE_SPAWNS_EDITOR set [_index, RSTF_VEHICLE_SPAWNS_EDITOR select (_index + 1)];
	RSTF_VEHICLE_SPAWNS_EDITOR set [_index + 1, _entry];

	call RSTF_fnc_updateVehicleSpawnEditor;
	_ctrl lnbSetCurSelRow (_index + 1);
}] call ZUI_fnc_on;

[RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT, "clear", "ButtonClick", {
	RSTF_VEHICLE_SPAWNS_EDITOR = [];
	call RSTF_fnc_updateVehicleSpawnEditor;
}] call ZUI_fnc_on;

[RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT, "cancel", "ButtonClick", {
	RSTF_VEHICLE_SPAWNS_EDITOR = [];
	[RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT] call ZUI_fnc_closeDisplay;
	RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT = [];
}] call ZUI_fnc_on;

[RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT, "save", "ButtonClick", {
	RSTF_VEHICLE_SPAWNS = RSTF_VEHICLE_SPAWNS_EDITOR;
	RSTF_VEHICLE_SPAWNS_EDITOR = [];
	[RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT] call ZUI_fnc_closeDisplay;
	RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT = [];
}] call ZUI_fnc_on;

call RSTF_fnc_updateVehicleSpawnEditor;
