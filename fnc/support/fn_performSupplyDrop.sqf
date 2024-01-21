/*
	Author:
	Jan Zípek

	Description:
	Drops supply at specified position.

	Parameters:
		0: CONFIG CLASS - classname of support config
		1: POSITION - target position
		2: OBJECT - player

	Returns:
	NOTHING
*/

private _className = param [0];
private _pos = param [1];
private _player = param [2];

private _cost = getNumber(missionConfigFile >> "RSTF_BUYABLE_SUPPORTS" >> _className >> "cost");
private _money = [_player] call RSTF_fnc_getPlayerMoney;

if (_money >= _cost) then {
	[_player, -_cost] call RSTF_fnc_addPlayerMoney;

	private _para = "B_Parachute_02_F";
	private _smokeShell = "SmokeShellRed";

	private _vehicle = objNull;

	switch (_className) do {
		case "VehicleAmmo": {
			_vehicle = "Box_NATO_AmmoVeh_F" createVehicle (getPos player);
		};
		case "InfantryAmmo": {
			_vehicle = "B_supplyCrate_F" createVehicle (getPos player);
			clearWeaponCargoglobal _vehicle;
			clearmagazinecargoglobal _vehicle;
			clearitemcargoglobal _vehicle;
			clearbackpackcargoglobal _vehicle;
			private _action = _vehicle addAction [
				"Rearm",
				RSTF_fnc_rearmInfantry,
				[],
				0,
				true,
				true,
				"",
				"true",
				2
			];
			_vehicle setUserActionText [
				_action,
				"Rearm",
				"<img size='1.5' image='\a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa'/>"
			];
		};
		case "ArsenalBox": {
			_vehicle = "VirtualReammoBox_camonet_F" createVehicle (getPos player);
			["AmmoboxInit",[_vehicle,true,{true}]] call BIS_fnc_arsenal;
		};
	};

	_vehicle setPosATL (_vehicle modelToWorld [5,5,100]);

	private _posAtHeight = _pos vectorAdd [0, 0, 100];

	private _chute = createVehicle [_para, _posAtHeight, [], 0, "NONE"];
	_vehicle attachTo [_chute, [0, 0, 1]];

	private _smoke = _smokeShell createVehicle position _vehicle;
	_smoke attachTo [_vehicle,[0,0,0]];
};
