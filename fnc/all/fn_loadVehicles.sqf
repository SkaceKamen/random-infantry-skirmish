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
private _airs = _vehicles select RSTF_VEHICLE_AIR;

private _classes = configFile >> "CfgVehicles";

//Load vehicles for each faction
for [{_i = 0},{_i < count(_classes)},{_i = _i + 1}] do {
	_c = _classes select _i;
	if (isClass(_c) && { _ignore_bans || !(configName(_c) in RSTF_SOLDIERS_BANNED) }) then {
		_scope = getNumber(_c >> "scope");
		_man = getNumber(_c >> "isMan");
		_faction = getText(_c >> "faction");

		if (_scope == 2 && _man == 0 && _faction in _factions) then {
			_weaponized = false;

			// Used to identify static weapons by its base class
			_parents = [_c, true] call BIS_fnc_returnParents;

			// Air vehicles need to be treated differently
			_air = "Air" in _parents;
			_land = "Land" in _parents;

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

			// Scan weapons
			_wp = getArray(_c >> "weapons");
			{
				_usable = [configFile >> "cfgWeapons" >> _x, true] call RSTF_fnc_isUsableWeapon;
				if (_x != "FakeWeapon" && _usable) then {
					_weaponized = true;
				};
			} foreach _wp;

			if (_land) then {
				if (_transport >= 2 && !_static) then {
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

			if (_air && _weaponized) then {
				_airs pushBack configName(_c);
			};
		};
	};
};

_vehicles;