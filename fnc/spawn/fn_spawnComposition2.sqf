/*
	Function:
	RSTF_fnc_spawnComposition2

	Description:
	Extremely simplified script for spawning EDEN compositions

	Parameter(s):
	_compositionName - name of composition, found in RSTF_Compositions [String]
	_position - composition position [Position]
	_direction - composition direction [Number]

	Returns:
	Spawned objects [Array]
*/

private _compositionName = param [0];
private _position = param [1];
private _direction = param [2];

private _builtObjects = [];
private _data = missionConfigFile >> "RSTF_Compositions" >> _compositionName;
private _center = getArray(_data >> "center");

_spawnLayer = {
	private _config = param [0];
	private _context = param [1];

	private _itemsCount = getNumber(_config >> "items");
	private _i = 0;

	for [{_i = 0}, {_i < _itemsCount}, { _i = _i + 1}] do {
		private _itemData = _config >> format["Item%1", _i];
		[_itemData, _context] call _spawnItem;
	};
};

_spawnItem = {
	private _config = param [0];
	private _context = param [1];

	private _type = getText(_config >> "dataType");

	switch (_type) do {
		case "Object": {
			[_config, _context] call _spawnObject;
		};
		case "Layer": {
			[_config >> "Entities", _context] call _spawnLayer;
		};
		default {
			diag_log text(["ERROR: Unsupported data type %1 in composition!", _type]);
		};
	};
};

_spawnObject = {
	private _config = param [0];
	private _context = param [1];
	private _contextPosition = _context#0;
	private _contextRotation = _context#1;

	private _type = getText(_config >> "type");
	private _position = getArray(_config >> "PositionInfo" >> "position");
	private _angles = if (isArray (_config >> "PositionInfo" >> "angles")) then { getArray(_config >> "PositionInfo" >> "angles"); } else { [0,0,0] };
	private _isSimpleObject = getNumber(_config >> "Attributes" >> "createAsSimpleObject") == 1;
	private _disableSimulation = getNumber(_config >> "Attributes" >> "disableSimulation") == 1;
	private _atlOffset = 0; //getNumber(_config >> "atlOffset");

	private _veh = objNull;

	if (_isSimpleObject) then {
		_veh = createSimpleObject [_type, [0,0,500]];
	} else {
		_veh = createVehicle [_type, [0,0,500], [], 0, "CAN_COLLIDE"];
		_veh enableSimulationGlobal false;
	};

	private _newPosition = [_position#0, _position#2, 0];
	_newPosition = [_newPosition, 360 - _contextRotation] call BIS_fnc_rotateVector2D;
	_newPosition = _newPosition vectorAdd _contextPosition;

	private _atlPosition = getTerrainHeightASL [_newPosition#0, _newPosition#1];
	_newPosition set [2, _atlPosition + _position#1 + _atlOffset];

	private _rotation = [
		deg (_angles#0),
		(deg (_angles#1)) + _contextRotation,
		360 - deg (_angles#2)
	];

	{
		private _deg = _x mod 360;
		if (_deg < 0) then {
			_deg = linearConversion[ -0, -360, _deg, 360, 0 ];
		};
		_rotation set [_foreachIndex, _deg];
	} forEach _rotation;

	private _P = _rotation#0;
	private _Y = _rotation#1;
	private _R = _rotation#2;

	private _dir = [ sin _Y * cos _P, cos _Y * cos _P, sin _P];
	private _up = [ [ sin _R, -sin _P, cos _R * cos _P ], -_Y ] call BIS_fnc_rotateVector2D;

	_veh setPosWorld _newPosition;
	_veh setVectorDirAndUp [ _dir, _up ];
	_veh enableSimulation !_disableSimulation;

	// diag_log text("[RSTF] Spawned " + _type + " at " + str(_newPosition));

	(_context#2) pushBack _veh;
};

[_data >> "items", [_position, _direction, _builtObjects]] call _spawnLayer;

_builtObjects;
