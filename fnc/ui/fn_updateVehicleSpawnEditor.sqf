private _ctrl = [RSTF_VEHICLE_SPAWN_EDITOR_LAYOUT, "vehicles"] call ZUI_fnc_getControlById;

lnbClear _ctrl;
_ctrl lnbSetColumnsPos [0, 0.12, 0.25, 0.85];

{
	_x params ["_side", "_class", "_count", "_respawn"];

	private _config = configFile >> "cfgVehicles" >> _class;
	private _name = if (isClass(_config)) then { getText(_config >> "displayName") } else { "MISSING: " + _class };
	private _sideName = RSTF_SIDES_NAMES select _side;

	private _row = _ctrl lnbAddRow [_sideName, _name, str(_count), str(_respawn)];

	if (isClass(_config)) then {
		_ctrl lnbSetPicture [[_row, 1], getText(_config >> "picture")];
	} else {
		_ctrl lnbSetColor [[_row, 1], [1, 0, 0, 1]];
	};
} foreach RSTF_VEHICLE_SPAWNS_EDITOR;
