private _className = param [0];
private _config = configFile >> "cfgVehicles" >> _className;
private _ii = 0;

private _found = getArray(_config >> "weapons");
private _turrets = "true" configClasses (_config >> "Turrets");
{
	private _turret = _x;
	private _weapons = getArray(_turret >> "weapons");

	{
		/*
		private _usable = [configFile >> "cfgWeapons" >> _x, true] call RSTF_fnc_isUsableWeapon;
		if (_usable && _x != "FakeWeapon" && _x != "Laserdesignator_mounted" && _x != "SmokeLauncher") exitWith {
			_found pushBack _x;
		};
		*/
		_found pushBack _x;
	} foreach _weapons;

} foreach _turrets;

_found = _found select {
	([configFile >> "cfgWeapons" >> _x, true] call RSTF_fnc_isUsableWeapon)
		&& { _x != "FakeWeapon" && _x != "Laserdesignator_mounted" && _x != "SmokeLauncher" && _x != "CMFlareLauncher" }
	};
_found;