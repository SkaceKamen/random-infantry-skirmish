private ["_x", "_i", "_c", "_scope", "_man", "_faction"];

private _factions = param [0];
private _ignore_bans = param [1, false];

// Initialize 
private _vehicles = [];

{
	_vehicles set [_x, []];
} foreach RSTF_VEHICLES_TYPES;

private _transports = _vehicles select RSTF_VEHICLE_TRANSPORT;
private _statics = _vehicles select RSTF_VEHICLE_STATIC;
private _apcs = _vehicles select RSTF_VEHICLE_APC;

private _classes = configFile >> "CfgVehicles";

//Load men and vehicles for each faction
for [{_i = 0},{_i < count(_classes)},{_i = _i + 1}] do {
	_c = _classes select _i;
	if (isClass(_c)) then {
		_scope = getNumber(_c >> "scope");
		_man = getNumber(_c >> "isMan");
		_faction = getText(_c >> "faction");

		if (_scope == 2 && _man == 0 && _faction in _factions) then {
			_weaponized = false;
			
			// Used to identify static weapons by its base class
			_parents = [_c, true] call BIS_fnc_returnParents;
	
			// Load only non-AA static weapons
			_static = "StaticWeapon" in _parents && !("StaticAAWeapon" in _parents);
			
			// Load number of soliders that can be transported by this
			_transport = if (isNumber(_c >> "transportSoldier")) then {
				getNumber(_c >> "transportSoldier");
			} else { 0 };

			// Scan vehicle turrets to determine if there is any attack weapon
			if (isClass(_c >> "Turrets")) then {
				if (_c call RSTF_fnc_countTurrets > 0) then {
					_weaponized = true;
				};
			};

			// Scan weapons, mainly for soliders
			_wp = getArray(_c >> "weapons");
			{
				_usable = (configFile >> "cfgWeapons" >> _x) call RSTF_fnc_isUsableWeapon;
				if (_x != "FakeWeapon" && _x != "Throw" && _x != "Put" && _usable) then {
					_weaponized = true;
				};
			} foreach _wp;
			
			if (_transport > 3 && !_weaponized) then {
				_transports pushBack configName(_c);
			};

			if (_weaponized) then {
				if (_static) then {
					_statics pushBack configName(_c);
				} else {
					_apcs pushBack configName(_c);
				};
			};
		};
	};
};

_vehicles;