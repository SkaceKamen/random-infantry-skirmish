/*
	Function:
	RSTF_fnc_getVehicleShopCategory

	Description:
	Returns 1-based index of the shop category the vehicle belongs to.
	Uses the same categorization as the vehicle shop:
	1 - Wheeled (Car)
	2 - Tracked (Tank)
	3 - Planes (Plane)
	4 - Helicopters (Helicopter)
	5 - Other

	Parameter(s):
	_className - vehicle class name [String]

	Returns:
	Category index [Number]
*/

private _class = param [0];

// Unknown/missing classes fall into "Other"
if (!isClass(configFile >> "cfgVehicles" >> _class)) exitWith { 5; };

private _index = 0;

{
	if (_class isKindOf _x) exitWith {
		_index = _forEachIndex + 1;
	};
} foreach ["Car", "Tank", "Plane", "Helicopter"];

if (_index == 0) then {
	_index = 5;
};

_index;
