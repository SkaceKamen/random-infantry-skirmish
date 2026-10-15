private _side = RSTF_STATIC_VEHICLE_SPAWN_PICKER_SIDE;
private _categoryFilter = RSTF_STATIC_VEHICLE_SPAWN_PICKER_CATEGORY;

// Load vehicles of selected side (static weapons and transports are excluded)
private _factions = if (_side == SIDE_ENEMY) then { ENEMY_FACTIONS } else { FRIENDLY_FACTIONS };
private _vehicles = [_factions] call RSTF_fnc_loadVehicles;

private _search = ctrlText ([RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "search"] call ZUI_fnc_getControlById);
private _select = RSTF_STATIC_VEHICLE_SPAWN_PICKER_SELECT;
RSTF_STATIC_VEHICLE_SPAWN_PICKER_SELECT = "";

private _ctrl = [RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "vehicles"] call ZUI_fnc_getControlById;
lnbClear _ctrl;

private _selectRow = -1;
private _row = 0;

// Vehicles are grouped by category (APC, Air) and sorted by name inside each category
{
	private _category = _x;

	// Category filter: 0 = All, otherwise index in the filtered category list + 1
	if (_categoryFilter == 0 || _categoryFilter == _forEachIndex + 1) then {
		private _configs = ((_vehicles#_category) select {
			isClass(configFile >> "cfgVehicles" >> _x)
		}) apply {
			configFile >> "cfgVehicles" >> _x
		};

		_configs = [_configs, [], { getText(_x >> "displayName") }] call BIS_fnc_sortBy;

		{
			private _name = getText(_x >> "displayName");

			if (_search == "" || { [_search, _name] call BIS_fnc_inString }) then {
				private _className = configName(_x);
				_ctrl lnbAddRow [_name, RSTF_VEHICLES_NAMES#_category];
				_ctrl lnbSetPicture [[_row, 0], getText(_x >> "picture")];
				_ctrl lnbSetData [[_row, 0], _className];

				if (_select != "" && { _select == _className }) then {
					_selectRow = _row;
				};

				_row = _row + 1;
			};
		} foreach _configs;
	};
} foreach [RSTF_VEHICLE_APC, RSTF_VEHICLE_AIR];

private _detailCtrl = [RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "detail"] call ZUI_fnc_getControlById;

if (_selectRow >= 0) then {
	_ctrl lnbSetCurSelRow _selectRow;
	[_select] call RSTF_fnc_staticVehicleSpawnPickerShowDetail;
} else {
	_detailCtrl ctrlSetStructuredText parseText "";
};
