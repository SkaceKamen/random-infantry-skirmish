private _factions = [];
private _classes = configFile >> "CfgVehicles";
private _i = 0;

//Load men and vehicles for each faction
for [{_i = 0},{_i < count(_classes)},{_i = _i + 1}] do {
	private _c = _classes select _i;
	if (isClass(_c)) then {
		private _scope = getNumber(_c >> "scope");
		private _man = getNumber(_c >> "isMan");
		private _faction = getText(_c >> "faction");

		if (_scope == 2 && !(_faction in _factions)) then {
			private _weaponized = false;

			if (_man == 1) then {
				private _wp = getArray(_c >> "weapons");
				{
					private _usable = [configFile >> "cfgWeapons" >> _x, false] call RSTF_fnc_isUsableWeapon;
					if (_x != "Throw" && _x != "Put" && _usable) exitWith {
						_weaponized = true;
					};
				} foreach _wp;
			} else {
				private _weapons = [configName(_c)] call RSTF_fnc_getVehicleWeapons;
				if (count(_weapons) > 0) then {
					_weaponized = true;
				};
			};

			if (_weaponized) then {
				_factions pushBack _faction;
			};
		};
	};
};

// Sort factions by name
_factions = [_factions, [], { getText(configFile >> "cfgFactionClasses" >> _x >> "displayName") }, "ASCEND"] call BIS_fnc_sortBy;

_factions;
