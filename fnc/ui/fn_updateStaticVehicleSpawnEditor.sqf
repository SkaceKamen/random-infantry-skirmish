// Keep entries automatically sorted by side, category then name
RSTF_STATIC_VEHICLE_SPAWNS_EDITOR = [RSTF_STATIC_VEHICLE_SPAWNS_EDITOR, [], {
	format [
		"%1_%2_%3",
		_x#0,
		[_x#1] call RSTF_fnc_getVehicleShopCategory,
		toLower(getText(configFile >> "cfgVehicles" >> (_x#1) >> "displayName"))
	]
}] call BIS_fnc_sortBy;

private _ctrl = [RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT, "vehicles"] call ZUI_fnc_getControlById;

lnbClear _ctrl;
_ctrl lnbSetColumnsPos [0, 0.1, 0.22, 0.6, 0.85];

{
	_x params ["_side", "_class", "_count", "_respawn"];

	private _config = configFile >> "cfgVehicles" >> _class;
	private _name = if (isClass(_config)) then { getText(_config >> "displayName") } else { "MISSING: " + _class };
	private _sideName = RSTF_SIDES_NAMES select _side;
	private _categoryName = RSTF_STATIC_VEHICLE_SPAWN_CATEGORIES#(([_class] call RSTF_fnc_getVehicleShopCategory) - 1);

	private _row = _ctrl lnbAddRow [_sideName, _categoryName, _name, str(_count), str(_respawn)];

	if (isClass(_config)) then {
		_ctrl lnbSetPicture [[_row, 2], getText(_config >> "picture")];
	} else {
		_ctrl lnbSetColor [[_row, 2], [1, 0, 0, 1]];
	};
} foreach RSTF_STATIC_VEHICLE_SPAWNS_EDITOR;
