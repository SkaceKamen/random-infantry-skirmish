#include "..\..\scripts.inc"

// TODO: Modify spawn logic:
//  1. First wave should be spawned at the point (maybe even in buildings?) - this should happend everytime point is changed
//  2. Rest of the waves should spawn behind the point - same distance as attackers

// TODO: Disable Neutrals globally?

// TODO: Points location:
//  - Start at edge of the town
//  - Continue through the town
//  - Maybe even continue futher
//    - this would require us to spawn some defenses and buildings and stuff to make it fun

RSTF_MODE_PUSH_ENABLED = false;
RSTF_MODE_PUSH_COUNTS = [];
RSTF_MODE_PUSH_POINTS = [];
RSTF_MODE_PUSH_POINT_INDEX = -1;
RSTF_MODE_PUSH_TASK_ATTACKERS = "";
RSTF_MODE_PUSH_TASK_DEFENDERS = "";

RSTF_MODE_DEFENDERS_SIDE = 0;
RSTF_MODE_ATTACKERS_SIDE = 1;

RSTF_MODE_DISTANCE_KILL_TIMEOUT = 20;

RSTF_MODE_PUSH_NEXT_POINT = {
	RSTF_MODE_PUSH_POINT_INDEX = RSTF_MODE_PUSH_POINT_INDEX + 1;
	private _nextPoint = RSTF_MODE_PUSH_POINTS select RSTF_MODE_PUSH_POINT_INDEX;
	private _point = _nextPoint#0;
	private _direction = _nextPoint#1;

	"PUSH_OBJECTIVE" setMarkerPos _point;

	// private _direction = RSTF_DIRECTION;
	private _distance = RSTF_SPAWN_DISTANCE_MIN + random(RSTF_SPAWN_DISTANCE_MAX - RSTF_SPAWN_DISTANCE_MIN);
	// TODO: Multiplayer?

	// Reset score
	RSTF_SCORE = [0, 0, 0];

	// Rebuild target and spawns
	RSTF_POINT = _point;
	RSTF_DIRECTION = _direction;

	if (RSTF_MODE_DEFENDERS_SIDE == SIDE_FRIENDLY) then {
		RSTF_DIRECTION = RSTF_DIRECTION + 180;
	};

	RSTF_SPAWNS = [
		[0,0,0],
		[0,0,0],
		[0,0,0]
	];

	RSTF_SPAWNS set [RSTF_MODE_DEFENDERS_SIDE, _point];
	RSTF_SPAWNS set [RSTF_MODE_ATTACKERS_SIDE, _point vectorAdd [sin(180 + _direction) * _distance, cos(180 + _direction) * _distance, 0]];

	// Force-spawn enemy wave
	if (RSTF_MODE_DEFENDERS_SIDE == SIDE_ENEMY) then {
		RSTF_ENEMY_ADVANTAGE_GROUPS = RSTF_ENEMY_ADVANTAGE_GROUPS - 1;
	};

	[RSTF_MODE_DEFENDERS_SIDE, true] call RSTF_fnc_spawnWave;

	if (RSTF_MODE_DEFENDERS_SIDE == SIDE_ENEMY) then {
		RSTF_ENEMY_ADVANTAGE_GROUPS = RSTF_ENEMY_ADVANTAGE_GROUPS + 1;
	};

	// Update waypoints
	[RSTF_MODE_DEFENDERS_SIDE] call RSTF_fnc_refreshSideWaypoints;
	[RSTF_MODE_ATTACKERS_SIDE] call RSTF_fnc_refreshSideWaypoints;

	// Move enemy spawn point back
	RSTF_SPAWNS set [
		RSTF_MODE_DEFENDERS_SIDE,
		_point vectorAdd [sin(_direction) * _distance, cos(_direction) * _distance, 0]
	];

	// Finish previous task
	if (RSTF_MODE_PUSH_TASK_ATTACKERS != "") then {
		[RSTF_MODE_PUSH_TASK_ATTACKERS, "Succeeded", true] call BIS_fnc_taskSetState;
		[RSTF_MODE_PUSH_TASK_DEFENDERS, "FAILED", true] call BIS_fnc_taskSetState;
	};

	0 spawn {
		if (RSTF_MODE_PUSH_POINT_INDEX == 0) then {
			sleep 10;
		};

		private _pointLetter = toString [65 + (RSTF_MODE_PUSH_POINT_INDEX % 26)];

		RSTF_MODE_PUSH_TASK_ATTACKERS = [
			[RSTF_MODE_ATTACKERS_SIDE] call RSTF_fnc_indexSide,
			"CAPTURE" + str(RSTF_MODE_PUSH_POINT_INDEX),
			["We need to capture this point to advance", "Capture point " + _pointLetter,""],
			RSTF_POINT,
			"ASSIGNED",
			0,
			true,
			"attack"
		] call BIS_fnc_taskCreate;

		RSTF_MODE_PUSH_TASK_DEFENDERS = [
			[RSTF_MODE_DEFENDERS_SIDE] call RSTF_fnc_indexSide,
			"DEFEND" + str(RSTF_MODE_PUSH_POINT_INDEX),
			["Defend this point to prevent enemies advance", "Defend point " + _pointLetter,""],
			RSTF_POINT,
			"ASSIGNED",
			0,
			true,
			"defend"
		] call BIS_fnc_taskCreate;
	};
};

RSTF_MODE_PUSH_initDefense = {
	RSTF_MODE_DEFENDERS_SIDE = SIDE_FRIENDLY;
	RSTF_MODE_ATTACKERS_SIDE = SIDE_ENEMY;

	call RSTF_MODE_PUSH_init;
};

RSTF_MODE_PUSH_init = {
	RSTF_MODE_PUSH_ENABLED = true;
	publicVariable "RSTF_MODE_PUSH_ENABLED";

	RSTF_SPAWN_TRANSPORTS = false;
	RSTF_NEUTRALS_GROUPS = 0;
	RSTF_NEUTRALS_EMPLACEMENTS = false;
	RSTF_TASKS_IFV_ENABLED = false;
	RSTF_TASKS_CLEAR_ENABLED = false;
	RSTF_TASKS_EMP_ENABLED = false;
};

RSTF_MODE_PUSH_startLoop = {
	// Build points
	private _center = RSTF_POINT;
	private _radius = RSTF_DISTANCE;
	private _direction = RSTF_DIRECTION;


	if (RSTF_MODE_DEFENDERS_SIDE == SIDE_FRIENDLY) then {
		_direction = _direction + 180;
	};
	
	_center = _center vectorAdd [
		sin(_direction + 180) * _radius,
		cos(_direction + 180) * _radius,
		0
	];

	while { count(RSTF_MODE_PUSH_POINTS) < RSTF_MODE_PUSH_POINT_COUNT } do {
		_direction = _direction - 20 + random 40;
		_center = _center vectorAdd [
			sin(_direction) * _radius * 0.8,
			cos(_direction) * _radius * 0.8,
			0
		];

		if (RSTF_DEBUG) then {
			private _marker = createMarkerLocal [str(_center), _center];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "mil_flag";
		};

		RSTF_MODE_PUSH_POINTS pushBack [_center, _direction];

		if (RSTF_MODE_PUSH_FIRST_POINT_EMPLACEMENTS || count(RSTF_MODE_PUSH_POINTS) > 1) then {
			[RSTF_MODE_PUSH_EMPLACEMENTS_PER_POINT, _center, _direction, RSTF_MODE_DEFENDERS_SIDE] call RSTF_fnc_spawnDefenceEmplacements;
		};
	};

	private _marker = createMarker ["PUSH_OBJECTIVE", _center];
	_marker setMarkerShape "ELLIPSE";
	_marker setMarkerSize [100, 100];
	_marker setMarkerColor RSTF_COLOR_NEUTRAL;

	waitUntil { sleep 0.1; !RSTF_INTRO_PLAYING; };

	call RSTF_MODE_PUSH_NEXT_POINT;

	0 spawn {
		private _center = RSTF_POINT;
		private _radius = 100;
		private _currentOwner = -1;
		private _last = time;

		while { !RSTF_ENDED } do {
			// Count men for each side inside this point
			private _counts = [];
			{
				_counts set [_x, 0];
			} foreach RSTF_SIDES;

			private _nearest = nearestObjects [RSTF_POINT, ["Man"], _radius, true];
			{
				_index = -1;
				if (alive(_x)) then {
					if (side(_x) == west) then {
						_index = SIDE_FRIENDLY;
					};
					if (side(_x) == east) then {
						_index = SIDE_ENEMY;
					};
					if (side(_x) == resistance) then {
						_index = SIDE_NEUTRAL;
					};
				};

				if (_index >= 0) then {
					_counts set [_index, (_counts select _index) + 1];
				};
			} foreach _nearest;

			RSTF_MODE_PUSH_COUNTS = _counts;

			// Now find side with most men
			private _best = _currentOwner;
			private _bestCount = 0;

			{
				if (_x > _bestCount) then {
					_best = _foreachIndex;
					_bestCount = _x;
				};
			} foreach _counts;

			if (_best == RSTF_MODE_ATTACKERS_SIDE) then {
				// Add point and reset timer
				_last = time;
				RSTF_SCORE set [_best, (RSTF_SCORE select _best) + 1];

				// Notify clients
				publicVariable "RSTF_SCORE";
				0 remoteExec ["RSTF_fnc_onScore"];

				// End when limit is reached
				if (RSTF_SCORE select _best >= RSTF_MODE_PUSH_SCORE_LIMIT) then {
					if (RSTF_MODE_PUSH_POINT_INDEX >= count(RSTF_MODE_PUSH_POINTS) - 1) then {
						[SIDE_FRIENDLY] remoteExec ["RSTF_fnc_onEnd"];
					} else {
						// Create notification
						[format[
							"<t color='%1'>%2</t> captured objective, moving to next",
							RSTF_SIDES_COLORS_TEXT select SIDE_FRIENDLY,
							RSTF_SIDES_NAMES select _best
						], 5] remoteExec ["RSTFUI_fnc_addGlobalMessage"];

						call RSTF_MODE_PUSH_NEXT_POINT;
					};
				};
			};

			publicVariable "RSTF_MODE_PUSH_COUNTS";

			sleep 1;
		};
	};


	// Kill AI that are too far away from the objective (usually happens when point is pushed)
	0 spawn {
		private _killDistance = RSTF_SPAWN_DISTANCE_MAX + 50;

		while { !RSTF_ENDED } do {
			{
				{
					{
						if (!isPlayer(_x) && alive(_x) && vehicle(_x) == _x) then {
							private _distance = _x distance RSTF_POINT;
							if (_distance > _killDistance) then {
								private _killTimeout = _x getVariable ["RSTF_KILL_TIMEOUT", 0];
								if (_killTimeout < RSTF_MODE_DISTANCE_KILL_TIMEOUT) then {
									_x setVariable ["RSTF_KILL_TIMEOUT", _killTimeout + 5];
								} else {
									if (RSTF_DEBUG) then {
										systemChat format["Killing %1 because its too far (%2 m)", name _x, _distance];
									};

									_x setDamage 1;
								};
							};
						};
					} foreach units(_x);
				} foreach _x;
			} forEach RSTF_GROUPS;

			sleep 5;
		};
	}
};

RSTF_MODE_PUSH_unitKilled = {
	_this call RSTF_fnc_killHandler;
};

RSTF_MODE_PUSH_taskCompleted = {
	private _taskName = param [0];
	private _taskScore = param [1];

	[format["+$%2 <t color='#dddddd'>%1</t>", _taskName, RSTF_MONEY_PER_TASK], 5] remoteExec ["RSTFUI_fnc_addGlobalMessage"];

	{
		[_x, RSTF_MONEY_PER_TASK] call RSTF_fnc_addPlayerMoney;
	} foreach allPlayers;
};

RSTF_MODE_PUSH_vehicleKilled = {};
