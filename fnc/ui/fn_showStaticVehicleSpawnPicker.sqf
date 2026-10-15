private _index = RSTF_STATIC_VEHICLE_SPAWN_EDITOR_INDEX;

// Defaults when adding a new entry, loaded from the edited entry otherwise
private _side = SIDE_FRIENDLY;
private _select = "";
private _count = 1;
private _respawn = 60;

if (_index >= 0) then {
	private _entry = RSTF_STATIC_VEHICLE_SPAWNS_EDITOR select _index;
	_side = _entry#0;
	_select = _entry#1;
	_count = _entry#2;
	_respawn = _entry#3;
};

RSTF_STATIC_VEHICLE_SPAWN_PICKER_SIDE = _side;
RSTF_STATIC_VEHICLE_SPAWN_PICKER_SELECT = _select;

// When editing, preselect the category of the edited vehicle so it is visible in the list
if (_select != "") then {
	private _factions = if (_side == SIDE_ENEMY) then { ENEMY_FACTIONS } else { FRIENDLY_FACTIONS };
	private _vehicles = [_factions] call RSTF_fnc_loadVehicles;

	RSTF_STATIC_VEHICLE_SPAWN_PICKER_CATEGORY = 0;

	{
		if (_select in (_vehicles#_x)) exitWith {
			RSTF_STATIC_VEHICLE_SPAWN_PICKER_CATEGORY = _forEachIndex + 1;
		};
	} foreach [RSTF_VEHICLE_APC, RSTF_VEHICLE_AIR];
};

private _parent = ([RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT] call ZUI_fnc_display) createDisplay "RscDisplayEmpty";
RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT = [missionConfigFile >> "StaticVehicleSpawnPickerDialog", _parent] call ZUI_fnc_createDisplay;

([RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "title"] call ZUI_fnc_getControlById) ctrlSetText (if (_index >= 0) then { "EDIT VEHICLE" } else { "PICK A VEHICLE" });

// Side selector
private _sideCtrl = [RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "side"] call ZUI_fnc_getControlById;
{
	_sideCtrl lbAdd _x;
	_sideCtrl lbSetData [_forEachIndex, str(_forEachIndex)];
} foreach [RSTF_SIDES_NAMES select SIDE_ENEMY, RSTF_SIDES_NAMES select SIDE_FRIENDLY];

_sideCtrl lbSetCurSel _side;
_sideCtrl ctrlAddEventHandler ["LBSelChanged", {
	params ["_ctrl", "_index"];

	RSTF_STATIC_VEHICLE_SPAWN_PICKER_SIDE = parseNumber(_ctrl lbData _index);
	RSTF_STATIC_VEHICLE_SPAWN_PICKER_SELECT = "";

	call RSTF_fnc_updateStaticVehicleSpawnPicker;
}];

// Category filter
private _categoryCtrl = [RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "category"] call ZUI_fnc_getControlById;
{
	_categoryCtrl lbAdd _x;
} foreach RSTF_STATIC_VEHICLE_SPAWN_PICKER_CATEGORIES;

_categoryCtrl lbSetCurSel RSTF_STATIC_VEHICLE_SPAWN_PICKER_CATEGORY;
_categoryCtrl ctrlAddEventHandler ["LBSelChanged", {
	params ["_ctrl", "_index"];

	RSTF_STATIC_VEHICLE_SPAWN_PICKER_CATEGORY = _index;
	RSTF_STATIC_VEHICLE_SPAWN_PICKER_SELECT = "";

	call RSTF_fnc_updateStaticVehicleSpawnPicker;
}];

// Count and respawn delay
([RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "count"] call ZUI_fnc_getControlById) ctrlSetText str(_count);
([RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "respawn"] call ZUI_fnc_getControlById) ctrlSetText str(_respawn);

// Searching
[RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "search", "KeyUp", {
	RSTF_STATIC_VEHICLE_SPAWN_PICKER_SELECT = "";
	call RSTF_fnc_updateStaticVehicleSpawnPicker;
}] call ZUI_fnc_on;

// Vehicle detail
[RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "vehicles", "LBSelChanged", {
	private _ctrl = param [0];
	private _index = param [1];
	if (_index < 0) exitWith {};

	[_ctrl lnbData [_index, 0]] call RSTF_fnc_staticVehicleSpawnPickerShowDetail;
}] call ZUI_fnc_on;

// Confirm on double click
[RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "vehicles", "LBDblClick", {
	call RSTF_fnc_staticVehicleSpawnPickerAddVehicle;
}] call ZUI_fnc_on;

[RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "cancel", "ButtonClick", {
	[RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT] call ZUI_fnc_closeDisplay;
	RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT = [];
	RSTF_STATIC_VEHICLE_SPAWN_EDITOR_INDEX = -1;
}] call ZUI_fnc_on;

[RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "pick", "ButtonClick", {
	call RSTF_fnc_staticVehicleSpawnPickerAddVehicle;
}] call ZUI_fnc_on;

call RSTF_fnc_updateStaticVehicleSpawnPicker;
