/*
	Author:
	Jan Zípek

	Description:
	Starts shelling given position.

	Parameters:
		0: CONFIG CLASS - classname of support config
		1: STRING - class name of shell to be used
		2: NUMBER - number of shells to be used
		3: RADIUS - the shelling radius
		4: ARRAY - [min, max] delay between shots
		5: ARRAY - [min, max] initial delay
		6: POSITION - target position
		7: OBJECT - player

	Returns:
	NOTHING
*/

private _className = param [0];
private _shellType = param [1];
private _shellCount = param [2];
private _radius = param [3];
private _shotDelay = param [4];
private _initialDelay = param [5];
private _pos = param [6];
private _player = param [7];

private _cost = getNumber(missionConfigFile >> "RSTF_BUYABLE_SUPPORTS" >> _className >> "cost");
private _money = [_player] call RSTF_fnc_getPlayerMoney;

if (_money >= _cost) then {
	[player, -_cost] call RSTF_fnc_addPlayerMoney;

	private _delay = (_initialDelay#0 + random (_initialDelay#1 - _initialDelay#0));

	systemChat format["Shells on the way, ETA %1m:%2s", floor(_delay / 60), round(_delay % 60)];

	sleep _delay;

	for [{ _i = 0 }, { _i < _shellCount}, { _i = _i + 1}] do {
		private _position = [_pos select 0, _pos select 1, 800];

		while { true } do {
			_position set [0, _pos#0 - _radius + random(_radius * 2)];
			_position set [1, _pos#1 - _radius + random(_radius * 2)];

			if (_position distance2D _pos < _radius) exitWith {};
		};

		private _shell = _shellType createVehicle _position;
		_shell setShotParents [vehicle(_player), _player];
		_shell setPos _position;
		_shell setVelocity [0,0,-200];

		sleep (_shotDelay#0 + random (_shotDelay#1 - _shotDelay#0));
	};
};
