private ["_vehicle", "_group"];

_vehicle = objNull;
_group = _this;
{
	if (vehicle(_x) != _x) exitWith {
		_vehicle = vehicle(_x);
	};
} foreach units(_group);

//Destroy useless vehicles
if (!isNull(_vehicle) && !canMove(_vehicle)) then {
	_vehicle setDamage 1;
	_vehicle = objNull;
};

_vehicle;