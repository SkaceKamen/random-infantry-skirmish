/*
	Function:
	RSTF_fnc_aiDecideVehicle

	Description:
	Logic for ai vehicle buying.

	Parameters:
	_unit - unit that's going to buy vehicle [Object]
	_side - units side index [Scalar]

	Returns:
	If vehicle was spawned [Boolean]
*/

private _unit = param [0];
private _side = param [1];
private _name = _unit getvariable ["ORIGINAL_NAME", name(_unit)];
private _money = (RSTF_AI_MONEY select _side) + ([_name] call RSTF_fnc_getUnitMoney);
private _vehicles = RSTF_BUYABLE_VEHICLES select _side;

// Don't bother if there're no vehicles
if (count _vehicles == 0) exitWith {};

// Select our wish vehicle
private _wish = RSTF_AI_VEHICLE_WISH getOrDefault [_name, objNull];
if (typeName(_wish) == typeName(objNull)) then {
	_wish = objNull;

	// 10 % chance of choosing random vehicle
	// 90 % chance of choosing random more expensive vehicle
	//if (random 10 > 9) then {
		_wish = selectRandom _vehicles;
	/*} else {
		_upper = floor(count(_vehicles) / 2);
		_wish = selectRandom (_vehicles select [_upper, _upper max 1]);
	};*/

	RSTF_AI_VEHICLE_WISH set [_name, _wish];
};

// Load info about our wish vehicle
private _class = _wish select 1;
private _cost = _wish select 2;

if (RSTF_DEBUG) then {
	diag_log text(format["[RSTF] %1: My wish is %2, costing %3 and I have %4", _name, _class, _cost, _money]);
};

// Stop if we don't have money
if (_money < _cost) exitWith { false };

if (RSTF_DEBUG) then {
	diag_log text(format["[RSTF] %1: Spawning with %2", _name, _class]);
};

// Reset the wish
RSTF_AI_VEHICLE_WISH set [_name, objNull];

private _parents = [configFile >> "cfgVehicles" >> _class, true] call BIS_fnc_returnParents;
private _air = "Air" in _parents;

// Remove money from unit
[_name, -_cost] call RSTF_fnc_addUnitMoney;

private _vehicle = [_side, _class, _air] call RSTF_fnc_spawnAiVehicle;
[objNull, _unit, _vehicle, _cost] call RSTF_fnc_attachVehicleRefundCheck;

true;