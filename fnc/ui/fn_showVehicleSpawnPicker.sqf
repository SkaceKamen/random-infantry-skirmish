private _parent = ([RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT] call ZUI_fnc_display) createDisplay "RscDisplayEmpty";

RSTF_VEHICLE_SPAWN_PICKER_LAYOUT = [missionConfigFile >> "VehicleSpawnPickerDialog", _parent] call ZUI_fnc_createDisplay;

// Side selector
private _sideCtrl = [RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "side"] call ZUI_fnc_getControlById;
{
	_sideCtrl lbAdd _x;
	_sideCtrl lbSetData [_forEachIndex, str(_forEachIndex)];
} foreach [RSTF_SIDES_NAMES select SIDE_ENEMY, RSTF_SIDES_NAMES select SIDE_FRIENDLY];

_sideCtrl lbSetCurSel RSTF_VEHICLE_SPAWN_PICKER_SIDE;
_sideCtrl ctrlAddEventHandler ["LBSelChanged", {
	params ["_ctrl", "_index"];

	RSTF_VEHICLE_SPAWN_PICKER_SIDE = parseNumber(_ctrl lbData _index);
	RSTF_VEHICLE_SPAWN_PICKER_CATEGORY = 0;

	([RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "categories"] call ZUI_fnc_getControlById) lbSetCurSel 0;

	call RSTF_fnc_updateVehicleSpawnPicker;
}];

// Category selector
private _categoryCtrl = [RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "categories"] call ZUI_fnc_getControlById;
{
	_categoryCtrl lbAdd _x;
} foreach RSTF_VEHICLE_SPAWN_PICKER_CATEGORIES;

_categoryCtrl lbSetCurSel RSTF_VEHICLE_SPAWN_PICKER_CATEGORY;
_categoryCtrl ctrlAddEventHandler ["LBSelChanged", {
	params ["_ctrl", "_index"];

	RSTF_VEHICLE_SPAWN_PICKER_CATEGORY = _index;

	call RSTF_fnc_updateVehicleSpawnPicker;
}];

// Default count and respawn delay
([RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "count"] call ZUI_fnc_getControlById) ctrlSetText "1";
([RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "respawn"] call ZUI_fnc_getControlById) ctrlSetText "60";

// Searching
[RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "search", "KeyUp", {
	call RSTF_fnc_updateVehicleSpawnPicker;
}] call ZUI_fnc_on;

// Vehicle detail
[RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "vehicles", "LBSelChanged", {
	private _ctrl = param [0];
	private _index = param [1];
	if (_index < 0) exitWith {};

	private _class = _ctrl lnbData [_index, 0];
	private _config = configFile >> "cfgVehicles" >> _class;

	private _description = format [
		"<t size='5' align='center'><img image='%1' /></t><br /><t align='center' size='1.2'>%2</t><br /><br />",
		getText(_config >> "editorPreview"),
		getText(_config >> "displayName")
	];

	private _crew = [_class] call RSTF_fnc_getVehicleClassCrew;
	if (count(_crew) > 0) then {
		_description = _description + "<t size='1.2'>CREW</t><br />" + ((_crew apply { _x#0 }) joinString "<br />") + "<br /><br />";
	};

	private _weapons = [_class] call RSTF_fnc_getVehicleWeapons;
	if (count(_weapons) > 0) then {
		_description = _description + "<t size='1.2'>WEAPONS</t><br />" + ((_weapons apply { getText(configFile >> "cfgWeapons" >> _x >> "displayName") }) joinString "<br />");
	};

	([RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "detail"] call ZUI_fnc_getControlById) ctrlSetStructuredText parseText _description;
}] call ZUI_fnc_on;

// Add on double click
[RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "vehicles", "LBDblClick", {
	call RSTF_fnc_vehicleSpawnPickerAddVehicle;
}] call ZUI_fnc_on;

[RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "cancel", "ButtonClick", {
	[RSTF_VEHICLE_SPAWN_PICKER_LAYOUT] call ZUI_fnc_closeDisplay;
	RSTF_VEHICLE_SPAWN_PICKER_LAYOUT = [];
}] call ZUI_fnc_on;

[RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "pick", "ButtonClick", {
	call RSTF_fnc_vehicleSpawnPickerAddVehicle;
}] call ZUI_fnc_on;

call RSTF_fnc_updateVehicleSpawnPicker;
