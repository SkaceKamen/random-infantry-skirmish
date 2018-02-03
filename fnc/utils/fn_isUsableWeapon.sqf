private _weapon = param [0];
private _vehicle = param [1];

private _magazine = getArray(_weapon >> "magazines");
private _muzzles = getArray(_weapon >> "muzzles") select { _x != "this" };
private _type = getNumber(_weapon >> "type");

if (!isNil("_magazine")) then {
	{
		{
			_magazine pushBack _x;
		} foreach getArray(_weapon >> _x >> "magazines");
	} foreach _muzzles;
};

(
	!isNil("_magazine") && {
		configName(_weapon) != "SmokeLauncher" &&
		count(_magazine) > 0 &&
		(_vehicle || (_type == 1 || _type == 2 || _type == 4)) &&
		(!isNumber(_weapon >> "laser") || getNumber(_weapon >> "laser") == 0)
	}
);