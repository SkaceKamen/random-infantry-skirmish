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

		if (_scope == 2 && _man == 1 && !(_faction in _factions)) then {
			private _weaponized = false;
			private _wp = getArray(_c >> "weapons");
			{
				private _usable = [configFile >> "cfgWeapons" >> _x, false] call RSTF_fnc_isUsableWeapon;
				if (_x != "Throw" && _x != "Put" && _usable) exitWith {
					_weaponized = true;
				};
			} foreach _wp;

			if (_weaponized) then {
				_factions pushBack _faction;
			};
		};
	};
};

_factions;
