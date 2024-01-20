private _weapon = param [0];
private _vehicle = param [1];

private _magazine = getArray(_weapon >> "magazines");
private _muzzles = getArray(_weapon >> "muzzles") select { _x != "this" };
private _type = getNumber(_weapon >> "type");
private _simulation = getText(_weapon >> "simulation");
private _name = if (isText(_weapon >> "displayName")) then { getText(_weapon >> "displayName") } else { configName(_weapon) };

// These are not weapons, just smoke/flare launchers
private _uselessWeapon = 
	   (["smoke launcher", _name] call BIS_fnc_inString)
	|| (["flare launcher", _name] call BIS_fnc_inString)
	|| (["smoke white", _name] call BIS_fnc_inString)
	|| (["smoke red", _name] call BIS_fnc_inString)
	|| (["fuel tank", _name] call BIS_fnc_inString);

if (_uselessWeapon) exitWith { false };

// Hors have "sound" simulation
if (_simulation != "Weapon") exitWith { false };

private _uselessMag = false;
if (!isNil("_magazine")) then {
	{
		{
			_magazine pushBack _x;
		} foreach getArray(_weapon >> _x >> "magazines");
	} foreach _muzzles;

	_uselessMag = false;
	{
		if (_x in _magazine) exitWith { _uselessMag = true; };
	} foreach RTSF_USELESS_MAGAZINES;
};

(
	!isNil("_magazine") && {
		configName(_weapon) != "SmokeLauncher" &&
		!(configName(_weapon) in RTSF_USELESS_WEAPONS) &&
		!_uselessMag &&
		count(_magazine) > 0 &&
		(_vehicle || (_type == 1 || _type == 2 || _type == 4)) &&
		(!isNumber(_weapon >> "laser") || getNumber(_weapon >> "laser") == 0)
	}
);