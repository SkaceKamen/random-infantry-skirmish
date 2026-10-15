// Build a class -> category lookup for both sides, so entries can be sorted and displayed by category
private _categories = [RSTF_VEHICLE_TRANSPORT, RSTF_VEHICLE_APC, RSTF_VEHICLE_AIR];
private _categoryBySide = [];

{
	private _factions = if (_x == SIDE_ENEMY) then { ENEMY_FACTIONS } else { FRIENDLY_FACTIONS };
	private _vehicles = [_factions] call RSTF_fnc_loadVehicles;
	private _map = createHashMap;

	{
		private _category = _x;
		{
			_map set [_x, _category];
		} foreach (_vehicles#_category);
	} foreach _categories;

	_categoryBySide set [_x, _map];
} foreach [SIDE_ENEMY, SIDE_FRIENDLY];

// Keep entries automatically sorted by side, category then name
RSTF_STATIC_VEHICLE_SPAWNS_EDITOR = [RSTF_STATIC_VEHICLE_SPAWNS_EDITOR, [], {
	format [
		"%1_%2_%3",
		_x#0,
		(_categoryBySide#(_x#0)) getOrDefault [_x#1, 0],
		toLower(getText(configFile >> "cfgVehicles" >> (_x#1) >> "displayName"))
	]
}] call BIS_fnc_sortBy;

private _ctrl = [RSTF_STATIC_VEHICLE_SPAWN_EDITOR_LAYOUT, "vehicles"] call ZUI_fnc_getControlById;

lnbClear _ctrl;

{
	_x params ["_side", "_class", "_count", "_respawn"];

	private _config = configFile >> "cfgVehicles" >> _class;
	private _name = if (isClass(_config)) then { getText(_config >> "displayName") } else { "MISSING: " + _class };
	private _sideName = RSTF_SIDES_NAMES select _side;

	private _category = (_categoryBySide#_side) getOrDefault [_class, 0];
	private _categoryName = if (_category > 0) then { RSTF_VEHICLES_NAMES#_category } else { "-" };

	private _row = _ctrl lnbAddRow [_sideName, _categoryName, _name, str(_count) + "x", str(_respawn) + "s"];

	if (isClass(_config)) then {
		_ctrl lnbSetPicture [[_row, 2], getText(_config >> "picture")];
	} else {
		_ctrl lnbSetColor [[_row, 2], [1, 0, 0, 1]];
	};
} foreach RSTF_STATIC_VEHICLE_SPAWNS_EDITOR;
