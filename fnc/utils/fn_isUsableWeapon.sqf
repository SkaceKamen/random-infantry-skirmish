private ["_magazine", "_type", "_usable"];
params ["_weapon", "_vehicle"];

_magazine = getArray(_weapon >> "magazines");
_type = getNumber(_weapon >> "type");
_usable = (
	!isNil("_magazine") &&
	configName(_weapon) != "SmokeLauncher" &&
	count(_magazine) > 0 &&
	(_vehicle || (_type == 1 || _type == 2 || _type == 4)) &&
	(!isNumber(_weapon >> "laser") || getNumber(_weapon >> "laser") == 0)
);
_usable;