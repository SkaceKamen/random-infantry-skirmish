/*
	Function:
	RSTF_fnc_attachVehicleRefundCheck

	Description:
	Check if the spawned vehicle can move and is not damaged when spawned. If it is, money is returned to the buyer.
	Checks:
	  - If the vehicle is destroyed/damaged in first 2 seconds of existence, refund the money
	  - If the vehicle has not moved in 60 seconds, the vehicle is destroyed and money is refunded

	Parameters:
	_player - set if player is buyer, objNull else [Object]
	_unit - set if an unit is buyer, objNull else [Object]
	_vehicle - vehicle to check [Object]
	_cost - vehicle cost [Number]
*/


_this spawn {
	private _player = param [0];
	private _unit = param [1];
	private _vehicle = param [2];
	private _cost = param [3];

	private _startPosition = getPos(_vehicle);

	private _doTheRefund = {
		private _player = param [0];
		private _unit = param [1];
		private _vehicle = param [2];
		private _cost = param [3];

		if (!isNull(_player)) then {
			[_player, _cost] call RSTF_fnc_addPlayerMoney;
			[format["+%1$ <t color='#dddddd'>Vehicle refund</t>", _cost], 5] remoteExec ["RSTFUI_fnc_addMessage", _player];
		};

		if (isNull(_unit)) then {
			[_unit, _cost] call RSTF_fnc_addUnitMoney;
		};
	};

	sleep 2;

	if (!canMove(_vehicle) || damage(_vehicle) > 0.2) then {
		_this call _doTheRefund;
	} else {
		sleep 60;

		if (_startPosition distance getPos(_vehicle) < 5) then {
			_vehicle setDamage 1;
			
			_this call _doTheRefund;
		};
	};
};