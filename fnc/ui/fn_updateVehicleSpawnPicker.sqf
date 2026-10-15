private _side = RSTF_VEHICLE_SPAWN_PICKER_SIDE;
private _category = RSTF_VEHICLE_SPAWN_PICKER_CATEGORY;

// Load vehicles of selected side (static weapons are excluded, they can't be AI crewed like vehicles)
private _factions = if (_side == SIDE_ENEMY) then { ENEMY_FACTIONS } else { FRIENDLY_FACTIONS };
private _vehicles = [_factions] call RSTF_fnc_loadVehicles;

private _classes = [];
if (_category == 0) then {
	{
		_classes append _x;
	} foreach [
		_vehicles#RSTF_VEHICLE_TRANSPORT,
		_vehicles#RSTF_VEHICLE_APC,
		_vehicles#RSTF_VEHICLE_AIR
	];
} else {
	private _index = [RSTF_VEHICLE_TRANSPORT, RSTF_VEHICLE_APC, RSTF_VEHICLE_AIR] select (_category - 1);
	_classes = _vehicles#_index;
};

private _configs = [];
{
	private _config = configFile >> "cfgVehicles" >> _x;
	if (isClass(_config)) then {
		_configs pushBack _config;
	};
} foreach _classes;

_configs = [_configs, [], { getText(_x >> "displayName") }] call BIS_fnc_sortBy;

private _search = ctrlText ([RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "search"] call ZUI_fnc_getControlById);

private _ctrl = [RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "vehicles"] call ZUI_fnc_getControlById;
lnbClear _ctrl;
_ctrl lnbSetColumnsPos [0, 0.6];
([RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "detail"] call ZUI_fnc_getControlById) ctrlSetStructuredText parseText "";

{
	private _name = getText(_x >> "displayName");

	if (_search == "" || { [_search, _name] call BIS_fnc_inString }) then {
		private _row = _ctrl lnbAddRow [_name, getText(_x >> "vehicleClass")];
		_ctrl lnbSetPicture [[_row, 0], getText(_x >> "picture")];
		_ctrl lnbSetData [[_row, 0], configName(_x)];
	};
} foreach _configs;
