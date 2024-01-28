private _classesToScan = "getNumber(_x >> 'scope') == 2" configClasses (configFile >> "CfgVehicles");
private _soldiersMap = RSTF_FACTIONS_SOLDIERS_CACHE;
private _vehiclesMap = RSTF_FACTIONS_VEHICLES_CACHE;

// Load men and vehicles for each faction
{
	private _c = _x;

	private _man = getNumber(_c >> "isMan");
	private _itemFaction = toLower(getText(_c >> "faction"));

	if (_man == 1) then {
		_soldiersMap set [_itemFaction, [[], []], true];
		private _factionList =_soldiersMap get _itemFaction;

		private _weaponized = false;
		private _wp = getArray(_c >> "weapons");
		{
			private _usable = [configFile >> "cfgWeapons" >> _x, false] call RSTF_fnc_isUsableWeapon;
			if (_x != "Throw" && _x != "Put" && _usable) then {
				_weaponized = true;
				(_factionList#1) pushBackUnique _x;
			};
		} foreach _wp;

		if (_weaponized) then {
			(_factionList#0) pushBack configName(_c);
		};
	} else {
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

			_vehiclesMap set [_itemFaction, [[], [], [], []], true];
			private _factionList =_vehiclesMap get _itemFaction;

			if (_land) then {
				if (_hasDriver && _transport >= 2 && !_static && count(_weapons) <= 1) then {
					(_factionList#RSTF_VEHICLE_TRANSPORT) pushBack configName(_c);
				};

				if (_weaponized) then {
					if (_static) then {
						if (!("StaticAAWeapon" in _parents)) then {
							(_factionList#RSTF_VEHICLE_STATIC) pushBack configName(_c);
						};
					} else {
						if (_hasDriver) then {
							(_factionList#RSTF_VEHICLE_APC) pushBack configName(_c);
						};
					};
				};
			};

			if (_hasDriver && _air && _weaponized) then {
				(_factionList#RSTF_VEHICLE_AIR) pushBack configName(_c);
			};
		};
	};

	progressLoadingScreen (_foreachIndex / (count(_classesToScan)));
} forEach _classesToScan;
