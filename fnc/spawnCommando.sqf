private ["_i", "_index", "_side", "_vehicle", "_list", "_size", "_group", "_unit", "_wp", "_commando"];

_index = _this;
_side = west;

if (_index == SIDE_ENEMY) then {
	_side = east;
};

_vehicle = "";
_list = RSTF_VEHICLES select _index;
_size = RSTF_LIMIT_COMMANDO_SIZE;
_group = creategroup _side;

/*
for[{_i = 4},{_i >= 0 && _vehicle == ""},{_i = _i - 1}] do {
	if (_i != 3) then {
		{
			if (getNumber(configFile >> "cfgVehicles" >> _x >> "transportSoldier") >= _size) exitWith {
				_vehicle = _x;
			};
		} foreach (_list select _i);
	};
};
*/

if (_vehicle != "") then {
	_vehicle = createVehicle [_vehicle, RSTF_SPAWNS select _index, [], 100, "FLY"];
	createVehicleCrew _vehicle;
	(crew _vehicle) joinSilent _group;
} else {
	_vehicle = objNull;
	//diag_log format["No suitable vehicle found for commando unit of size %1.", _size];
};

for[{_i = 0},{_i < _size},{_i = _i + 1}] do {
	_unit = [_group, _index] call RSTF_createRandomUnit;
	_unit setSkill 1;
	
	if (!isNull(_vehicle)) then {
		_unit moveInCargo _vehicle;
		_unit assignAsCargo _vehicle;
	};
};

_wp = _group addWaypoint [RSTF_POINT,100];
_wp setWaypointType "UNLOAD";
_wp setWaypointSpeed "LIMITED";
_wp = _group addWaypoint [RSTF_POINT,100];
_wp setWaypointType "SAD";

_commando = RSTF_COMMANDO select _index;
_commando set [count(_commando), _group];

_group;