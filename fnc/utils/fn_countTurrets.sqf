private _c = _this;
private _turrets = 0;
private _ii = 0;

for[{_ii = 0},{_ii < count(_c >> "Turrets")},{_ii = _ii + 1}] do {
	private _turret = (_c >> "Turrets") select _ii;
	private _weapons = getArray(_turret >> "weapons");
	private _wpns = 0;
	{
		private _usable = [configFile >> "cfgWeapons" >> _x, true] call RSTF_fnc_isUsableWeapon;
		if (_usable && _x != "FakeWeapon" && _x != "Laserdesignator_mounted" && _x != "SmokeLauncher") exitWith {
			_wpns = _wpns + 1;
		};
	} foreach _weapons;

	if (_wpns != 0) exitWith {
		_turrets = _turrets + 1;
	};
};

_turrets;