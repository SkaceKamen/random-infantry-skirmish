/*
	Function:
	RSTF_fnc_getVehicleCost

	Description:
	Returns calculated cost of vehicle in money.

	Parameter(s):
	_className - vehicle class name [String]

	Returns:
	Cost in money [Number]

	Author:
	Jan Zípek
*/

private _className = param [0];

private _cost = getNumber(configFile >> "cfgVehicles" >> _className >> "cost");

round((_cost / 1E6) * 2000);