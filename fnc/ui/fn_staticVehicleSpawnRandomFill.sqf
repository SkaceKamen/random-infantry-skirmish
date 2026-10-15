private _layout = RSTF_STATIC_VEHICLE_SPAWN_RANDOM_LAYOUT;

private _counts = [
	parseNumber(ctrlText ([_layout, "wheeled"] call ZUI_fnc_getControlById)),
	parseNumber(ctrlText ([_layout, "tracked"] call ZUI_fnc_getControlById)),
	parseNumber(ctrlText ([_layout, "planes"] call ZUI_fnc_getControlById)),
	parseNumber(ctrlText ([_layout, "helicopters"] call ZUI_fnc_getControlById)),
	parseNumber(ctrlText ([_layout, "other"] call ZUI_fnc_getControlById))
];

private _respawn = parseNumber(ctrlText ([_layout, "respawn"] call ZUI_fnc_getControlById));
if (_respawn < 0) then { _respawn = 0; };

// Vehicle pool per side, indexed by side index (SIDE_ENEMY, SIDE_FRIENDLY)
private _poolPerSide = [];
{
	private _factions = if (_x == SIDE_ENEMY) then { ENEMY_FACTIONS } else { FRIENDLY_FACTIONS };
	private _vehicles = [_factions] call RSTF_fnc_loadVehicles;
	private _pool = [];

	{
		_pool append (_vehicles#_x);
	} foreach [RSTF_VEHICLE_APC, RSTF_VEHICLE_AIR];

	_poolPerSide set [_x, _pool];
} foreach [SIDE_ENEMY, SIDE_FRIENDLY];

private _entries = [];

{
	private _count = _counts#_forEachIndex;
	private _category = _forEachIndex + 1;

	if (_count <= 0) then { continue; };

	private _friendly = (_poolPerSide#SIDE_FRIENDLY) select { ([_x] call RSTF_fnc_getVehicleShopCategory) == _category };
	private _enemy = (_poolPerSide#SIDE_ENEMY) select { ([_x] call RSTF_fnc_getVehicleShopCategory) == _category };

	for "_i" from 1 to _count do {
		// Pick a random seed vehicle, preferring the friendly side
		private _seedSide = SIDE_FRIENDLY;
		private _seedList = _friendly;

		if (count(_seedList) == 0) then {
			_seedSide = SIDE_ENEMY;
			_seedList = _enemy;
		};

		if (count(_seedList) == 0) then { continue; };

		private _seed = selectRandom _seedList;
		private _seedPrice = [_seed] call RSTF_fnc_getVehicleCost;

		_entries pushBack [_seedSide, _seed, 1, _respawn];

		// Find the price-closest vehicle of the same category on the other side
		private _otherSide = if (_seedSide == SIDE_FRIENDLY) then { SIDE_ENEMY } else { SIDE_FRIENDLY };
		private _otherList = if (_otherSide == SIDE_FRIENDLY) then { _friendly } else { _enemy };

		private _match = "";

		if (count(_otherList) > 0) then {
			private _bestDiff = -1;

			{
				private _diff = abs(([_x] call RSTF_fnc_getVehicleCost) - _seedPrice);

				if (_bestDiff == -1 || _diff < _bestDiff) then {
					_bestDiff = _diff;
					_match = _x;
				};
			} foreach _otherList;
		};

		// Fall back to absolute random when there is nothing similar to match with
		if (_match == "") then {
			private _fallback = _poolPerSide#_otherSide;

			if (count(_fallback) == 0) then {
				_fallback = _poolPerSide#_seedSide;
			};

			if (count(_fallback) > 0) then {
				_match = selectRandom _fallback;
			};
		};

		if (_match != "") then {
			_entries pushBack [_otherSide, _match, 1, _respawn];
		};
	};
} foreach RSTF_STATIC_VEHICLE_SPAWN_CATEGORIES;

RSTF_STATIC_VEHICLE_SPAWNS_EDITOR = _entries;

[RSTF_STATIC_VEHICLE_SPAWN_RANDOM_LAYOUT] call ZUI_fnc_closeDisplay;
RSTF_STATIC_VEHICLE_SPAWN_RANDOM_LAYOUT = [];

call RSTF_fnc_updateStaticVehicleSpawnEditor;
