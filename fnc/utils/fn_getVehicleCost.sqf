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

/*
private _cost = getNumber(configFile >> "cfgVehicles" >> _className >> "cost");

round((_cost / 1E6) * 2000);
*/

private _config = configFile >> "cfgVehicles" >> _className;
private _parents = [_config, true] call BIS_fnc_returnParents;

private _air = "Air" in _parents;
private _land = "Land" in _parents;
private _car = _land && { "Car" in _parents };
private _tank = _land && { "Tank" in _parents };
private _crewVulnerable = getNumber(_config >> "crewVulnerable") == 1;
private _armor = getNumber(_config >> "armor");
private _turrets = _config call RSTF_fnc_countTurrets;

private _cost = 0;

// AIR tax
if (_air) then { _cost = _cost + 2000; };

// Crew hidden tax
if (!_crewVulnerable) then { _cost = _cost + 500; };

// Armor tax
if (_armor > 100) then { _cost = _cost + round(_armor/100) * 500; };

// Tank tax
if (_tank) then { _cost = _cost + 1000; };

// Turrets tax
_cost = _cost + _turrets * 500;

_cost;