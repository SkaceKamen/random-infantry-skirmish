/*
	Function:
	RSTF_fnc_spawnDefenceEmplacements

	Description:
	Spawns some defence positions, used for PUSH game mode now

	Parameter(s):
	_emplacementsCount - number of emplacements to spawn [Number]
	_center - point to use for spawning [Position]
	_direction - direction of advance of enemy [Number]
*/

private _emplacementsCount = param [0];
private _center = param [1];
private _direction = param [2];

// 0 - AA, 1 - AT, 2 - AI
private _staticWeaponsHigh = [ [], [], [] ];
private _staticWeaponsLow = [ [], [], [] ];
private _staticWeaponsHighAA = _staticWeaponsHigh#0;
private _staticWeaponsHighAT = _staticWeaponsHigh#1;
private _staticWeaponsHighAI = _staticWeaponsHigh#2;
private _staticWeaponsLowAA = _staticWeaponsLow#0;
private _staticWeaponsLowAT = _staticWeaponsLow#1;
private _staticWeaponsLowAI = _staticWeaponsLow#2;
// List of weapon types that have at least one item
private _staticWeaponsTypesHigh = [];
private _staticWeaponsTypesLow = [];
// Names for each weapon type index
private _staticWeaponsNames = [ "AA", "AT", "AI"];

// Contains list of possible emplacement compositions (found in compositions folder)
private _emplacements = ("true" configClasses (missionConfigFile >> "RSTF_Compositions")) apply { configName _x; };
// List of classNames and their class (AA/AT/AI) to be overriden
private _overrideEmplacementsHigh = [ [0, "RHS_ZU23_MSV"], [0, "RHS_ZU23_VDV"] ];
private _overrideEmplacementsLow = [];

private _statics = (RSTF_VEHICLES select SIDE_ENEMY) select RSTF_VEHICLE_STATIC;

// Try to load static weapons from config
{
	private _threat = getArray(configFile >> "cfgVehicles" >> _x >> "threat");
	private _veh = _x createVehicle [0, 0, 100];
	private _pos = ASLToATL(eyePos(_veh));
	private _isHigh = _pos select 2 > 1.2;

	deleteVehicle _veh;

	if (_threat select 2 >= 0.75) then {
		if (_isHigh) then {
			_staticWeaponsHighAA pushBack _x;
		} else {
			_staticWeaponsLowAA pushBack _x;
		};
	};
	if (_threat select 1 >= 0.75) then {
		if (_isHigh) then {
			_staticWeaponsHighAT pushBack _x;
		} else {
			_staticWeaponsLowAT pushBack _x;
		};
	};
	if (_threat select 0 >= 0.75) then {
		if (_isHigh) then {
			_staticWeaponsHighAI pushBack _x;
		} else {
			_staticWeaponsLowAI pushBack _x;
		};
	};
} foreach _statics;

// Add predefined static weapons if possible
{
	if ((_x select 1) in _statics) then {
		_exists = false;
		_item = _x;
		_categoryList = _staticWeaponsHigh select (_item select 0);
		
		if (_categoryList find (_item select 1) == -1) then {
			_categoryList pushBack (_item select 1);
		};
	};
} foreach _overrideEmplacementsHigh;

// Add predefined static weapons if possible
{
	if ((_x select 1) in _statics) then {
		_exists = false;
		_item = _x;
		_categoryList = _staticWeaponsLow select (_item select 0);
		
		if (_categoryList find (_item select 1) == -1) then {
			_categoryList pushBack (_item select 1);
		};
	};
} foreach _overrideEmplacementsLow;


// Load list of weapon types with at least one item
{
	if (count(_x) > 0) then {
		_staticWeaponsTypesHigh pushBack _foreachIndex;
	};
} foreach _staticWeaponsHigh;

// Load list of weapon types with at least one item
{
	if (count(_x) > 0) then {
		_staticWeaponsTypesLow pushBack _foreachIndex;
	};
} foreach _staticWeaponsLow;

// Don't try to place emplacements when there aren't any static weapons
if (count(_staticWeaponsTypesHigh) == 0 && count(_staticWeaponsTypesLow) == 0) then {
	diag_log text("[RSTF] No static weapons found for defences");
	_emplacementsCount = 0;
};


private _usedPositions = [];

// Spawn emplacements
private _i = 0;
for [{_i = 0}, {_i < _emplacementsCount}, {_i = _i + 1}] do {
	// Pick position
	// _position = [[[RSTF_POINT, 150]]] call BIS_fnc_randomPos;
	private _position = [];
	private _tries = 0;

	while { _tries < 100 } do {
		private _centerDistance = RSTF_DISTANCE * (0.1 + random(0.1));
		private _sideDistance = RSTF_DISTANCE * 0.5;

		_position = _center vectorAdd [
			sin(_direction) * _centerDistance,
			cos(_direction) * _centerDistance,
			0
		];

		_dis = selectRandom([-1,1]) * random(_sideDistance);
		_position = _position vectorAdd [
			sin(_direction + 90) * _dis,
			cos(_direction + 90) * _dis,
			0
		];

		_position = [_position, 0, 100, 10, 0, 0.1] call BIS_fnc_findSafePos;

		if (count(_position) > 0) then {
			private _closest = _usedPositions findIf { _x distance _position < 25 };
			if (_closest != -1) then {
				_position = [];
			};
		};

		if (count(_position) > 0) exitWith {};

		_tries = _tries + 1;
	};

	// Skip if no position was found
	if (count(_position) < 0) exitWith {
		diag_log text("[RSTF] Failed to find suitable defense placement location :(");
		false;
	};

	// Make position 3D
	_position set [2, 0];

	_usedPositions pushBack _position;

	if (RSTF_DEBUG) then {
		diag_log text("[RSTF] Spawning defense at " + str(_position));

		_marker = createMarker ["DEFENSE" + str(_position), _position];
		_marker setmarkerShape "ICON";
		_marker setMarkerType "loc_Ruin";
		_marker setMarkerColor "RED";
	};

	// Create emplacement
	_empType = selectRandom(_emplacements);
	_spawned = [_empType, _position, _direction + 180 - 5 + random(5)] call RSTF_fnc_spawnComposition2;

	// Replace weapon placeholder with actual weapon
	{
		private _isHighStatic = typeOf(_x) == "O_HMG_01_high_F";
		private _isLowStatic = typeOf(_x) == "I_HMG_02_F";
		private _isStatic = _isHighStatic || _isLowStatic;

		if (_isStatic) then {
			// Pick vehicle class
			private _typeIndex = if (_isLowStatic) then { selectRandom(_staticWeaponsTypesLow); } else { selectRandom(_staticWeaponsTypesHigh); };
			private _weapons = if (_isLowStatic) then { _staticWeaponsLow } else { _staticWeaponsHigh };

			_pos = getPosWorld(_x);
			_dir = vectorDir(_x);
			_up = vectorUp(_x);
			
			// Move out of the way and replace it!
			_x setPos [0,0,1000];
			deleteVehicle(_x);

			if (count(_weapons select _typeIndex) > 0) then {
				// Pick vehicle
				private _vehicle = selectRandom(_weapons select _typeIndex);
				private _vehicleType = _staticWeaponsNames select _typeIndex;

				// Create vehicle
				_group = createGroup east;

				private _spawned = createVehicle [_vehicle, [0,0,500], [], 0, "CAN_COLLIDE"];
				_spawned enableSimulationGlobal false;
				_spawned setPosWorld _pos;
				_spawned setVectorDirAndUp [_dir, _up];
				_spawned enableSimulationGlobal true;

				createvehiclecrew(_spawned);
				crew(_spawned) joinSilent _group;

				{
					_x setVariable ["SPAWNED_SIDE", side(_group), true];
					_x setVariable ["SPAWNED_SIDE_INDEX", SIDE_NEUTRAL, true];
					_x addEventHandler ["Killed", RSTF_fnc_unitKilled];
				} foreach units(_group);
			};
		};
	} foreach _spawned;
};