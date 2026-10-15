private _layout = RSTF_STATIC_VEHICLE_SPAWN_RANDOM_LAYOUT;

private _counts = [
	parseNumber(ctrlText ([_layout, "apc"] call ZUI_fnc_getControlById)),
	parseNumber(ctrlText ([_layout, "air"] call ZUI_fnc_getControlById))
];

private _respawn = parseNumber(ctrlText ([_layout, "respawn"] call ZUI_fnc_getControlById));
if (_respawn < 0) then { _respawn = 0; };

private _categories = [RSTF_VEHICLE_APC, RSTF_VEHICLE_AIR];

// Vehicles indexed by side index (SIDE_ENEMY, SIDE_FRIENDLY)
private _vehiclesPerSide = [
	[ENEMY_FACTIONS] call RSTF_fnc_loadVehicles,
	[FRIENDLY_FACTIONS] call RSTF_fnc_loadVehicles
];

private _entries = [];

{
	private _count = _counts#_forEachIndex;
	private _category = _x;

	if (_count <= 0) then { continue; };

	private _friendly = (_vehiclesPerSide#SIDE_FRIENDLY)#_category;
	private _enemy = (_vehiclesPerSide#SIDE_ENEMY)#_category;

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
			private _fallback = [];

			{
				_fallback append ((_vehiclesPerSide#_otherSide)#_x);
			} foreach _categories;

			if (count(_fallback) == 0) then {
				{
					_fallback append ((_vehiclesPerSide#_seedSide)#_x);
				} foreach _categories;
			};

			if (count(_fallback) > 0) then {
				_match = selectRandom _fallback;
			};
		};

		if (_match != "") then {
			_entries pushBack [_otherSide, _match, 1, _respawn];
		};
	};
} foreach _categories;

RSTF_STATIC_VEHICLE_SPAWNS_EDITOR = _entries;

[RSTF_STATIC_VEHICLE_SPAWN_RANDOM_LAYOUT] call ZUI_fnc_closeDisplay;
RSTF_STATIC_VEHICLE_SPAWN_RANDOM_LAYOUT = [];

call RSTF_fnc_updateStaticVehicleSpawnEditor;
