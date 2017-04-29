private ["_c", "_turrets", "_ii", "_turret", "_weapons", "_wpns"];

_c = _this;
_turrets = 0;
for[{_ii = 0},{_ii < count(_c >> "Turrets")},{_ii = _ii + 1}] do {
	_turret = (_c >> "Turrets") select _ii;
	_weapons = getArray(_turret >> "weapons");
	_wpns = 0;
	{
		_usable = [configFile >> "cfgWeapons" >> _x, true] call RSTF_fnc_isUsableWeapon;
		if (_usable && _x != "FakeWeapon" && _x != "Laserdesignator_mounted" && _x != "SmokeLauncher") exitWith {
			_wpns = _wpns + 1;
		};
	} foreach _weapons;

	if (_wpns != 0) exitWith {
		_turrets = _turrets + 1;
	};
};

_turrets;