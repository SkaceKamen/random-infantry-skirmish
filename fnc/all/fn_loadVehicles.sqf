private _factions = param [0];
private _ignore_bans = param [1, false];

// Initialize
private _vehicles = [];

{
	_vehicles set [_x, []];
} foreach RSTF_VEHICLES_TYPES;

if (count(RSTF_VEHICLE_CLASSES_CACHE) == 0) then {
	RSTF_VEHICLE_CLASSES_CACHE = "getNumber(_x >> 'scope') == 2 && getNumber(_x >> 'isMan') == 0" configClasses (configFile >> "CfgVehicles");
};

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
	{
		private _c = _x;
		private _scope = getNumber(_c >> "scope");
		private _man = getNumber(_c >> "isMan");
		private _vehicleFaction = toLower(getText(_c >> "faction"));

		if (_scope == 2 && _man == 0 && _vehicleFaction == _factionLower) then {
			private _weaponized = false;

			// Air vehicles need to be treated differently
			private _uav = isNumber(_c >> "isUav") && { getNumber(_c >> "isUav") == 1 };
			private _arty = isNumber(_c >> "artilleryScanner") && { getNumber(_c >> "artilleryScanner") == 1 };

			if (!_uav && !_arty) then {
				// Used to identify static weapons by its base class
				private _parents = [_c, true] call BIS_fnc_returnParents;
				private _air = "Air" in _parents;
				private _land = "Land" in _parents;

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
	} foreach RSTF_VEHICLE_CLASSES_CACHE;

	{
		_vehicles set [_x, _vehicles#_x + _localVehicles#_x];
	} foreach RSTF_VEHICLES_TYPES;

	RSTF_FACTIONS_VEHICLES_CACHE set [_factionLower, _localVehicles];

} forEach _factions;

if (!_ignore_bans) then {
	_bannedVehicles = RSTF_SOLDIERS_BANNED createHashMapFromArray [];

	{
		_vehicles set [_x, _vehicles#_x select { !(_x in _bannedVehicles) } ];
	} foreach RSTF_VEHICLES_TYPES;
};

_vehicles;
