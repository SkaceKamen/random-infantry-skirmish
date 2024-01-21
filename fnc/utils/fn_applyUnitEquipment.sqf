/*
	Function:
	RSTF_fnc_applyUnitEquipment

	Description:
	Applies equipment of one unit to another

	Parameters:
	_source - src [Unit]
	_target - dst [Unit]
*/

private _source = param [0];
private _target = param [1];

/*
removeUniform _target;
removeVest _target;
removeHeadgear _target;
removeGoggles _target;
removeBackpack _target;
removeAllItems _target;
removeAllAssignedItems _target;
removeAllWeapons _target;
*/

[_target, configFile >> "cfgVehicles" >> typeOf(_source)] call BIS_fnc_loadInventory;
