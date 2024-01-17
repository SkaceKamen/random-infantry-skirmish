private _i = 0;

private _factions = param [0];
private _ignore_bans = param [1, false];

// Initialize
private _vehicles = [];

{
	_vehicles set [_x, []];
} foreach RSTF_VEHICLES_TYPES;

private _classes = configFile >> "CfgVehicles";

{
	private _faction = _x;
	private _factionLower = toLower(_faction);

	if (!isClass(configFile >> "CfgFactionClasses" >> _faction)) then {
		diag_log text("[RSTF] " + _faction + " is not a valid faction");
		continue;
	};

	if (_factionLower in RSTF_FACTIONS_VEHICLES_CACHE) then {
		private _cached = RSTF_FACTIONS_VEHICLES_CACHE get _factionLower;
		{
			_vehicles set [_x, _vehicles#_x + _cached#_x];
		} foreach RSTF_VEHICLES_TYPES;
		continue;
	};

	private _localVehicles = [];
	{
		_localVehicles set [_x, []];
	} foreach RSTF_VEHICLES_TYPES;

	private _transports = _localVehicles select RSTF_VEHICLE_TRANSPORT;
	private _statics = _localVehicles select RSTF_VEHICLE_STATIC;
	private _apcs = _localVehicles select RSTF_VEHICLE_APC;
	private _airs = _localVehicles select RSTF_VEHICLE_AIR;

	//Load vehicles for each faction
	for [{_i = 0},{_i < count(_classes)},{_i = _i + 1}] do {
		private _c = _classes select _i;
		if (isClass(_c) && { _ignore_bans || !(configName(_c) in RSTF_SOLDIERS_BANNED) }) then {
			private _scope = getNumber(_c >> "scope");
			private _man = getNumber(_c >> "isMan");
			private _vehicleFaction = toLower(getText(_c >> "faction"));

			if (_scope == 2 && _man == 0 && _vehicleFaction == _factionLower) then {
				_weaponized = false;

				// Used to identify static weapons by its base class
				_parents = [_c, true] call BIS_fnc_returnParents;

				// Air vehicles need to be treated differently
				_air = "Air" in _parents;
				_land = "Land" in _parents;
				_uav = isNumber(_c >> "isUav") && { getNumber(_c >> "isUav") == 1 };
				_arty = isNumber(_c >> "artilleryScanner") && { getNumber(_c >> "artilleryScanner") == 1 };

				// Ignore driverless vehicles
				private _hasDriver = getNumber(_c >> "hasDriver") == 1;

				// Load only non-AA static weapons
				_static = "StaticWeapon" in _parents;

				// Load number of soliders that can be transported by this
				_transport = if (isNumber(_c >> "transportSoldier")) then {
					getNumber(_c >> "transportSoldier");
				} else { 0 };

				// List of vehicle weapons
				private _weapons = [configName(_c)] call RSTF_fnc_getVehicleWeapons;

				// Scan vehicle turrets to determine if there is any attack weapon
				if (count(_weapons) > 0) then {
					_weaponized = true;
				};

				if (!_uav && !_arty) then {
					if (_land) then {
						if (_hasDriver && _transport >= 2 && !_static && count(_weapons) <= 1) then {
							_transports pushBack configName(_c);
						};

						if (_weaponized) then {
							if (_static) then {
								if (!("StaticAAWeapon" in _parents)) then {
									_statics pushBack configName(_c);
								};
							} else {
								if (_hasDriver) then {
									_apcs pushBack configName(_c);
								};
							};
						};
					};

					if (_hasDriver && _air && _weaponized) then {
						_airs pushBack configName(_c);
					};
				};
			};
		};
	};

	{
		_vehicles set [_x, _vehicles#_x + _localVehicles#_x];
	} foreach RSTF_VEHICLES_TYPES;

	RSTF_FACTIONS_VEHICLES_CACHE set [_factionLower, _localVehicles];

} forEach _factions;

_vehicles;