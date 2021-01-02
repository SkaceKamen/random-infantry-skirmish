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

RSTF_MODE_PUSH_NEXT_POINT = {
	RSTF_MODE_PUSH_POINT_INDEX = RSTF_MODE_PUSH_POINT_INDEX + 1;
	private _point = RSTF_MODE_PUSH_POINTS select RSTF_MODE_PUSH_POINT_INDEX;
	"PUSH_OBJECTIVE" setMarkerPos _point;

	private _direction = RSTF_DIRECTION;
	private _distance = RSTF_SPAWN_DISTANCE_MIN + random(RSTF_SPAWN_DISTANCE_MAX - RSTF_SPAWN_DISTANCE_MIN);

	// TODO: Multiplayer?

	// Reset score
	RSTF_SCORE = [0, 0, 0];

	RSTF_POINT = _point;

	RSTF_SPAWNS = [
		_point,
		_point vectorAdd [sin(180 + _direction) * _distance, cos(180 + _direction) * _distance, 0],
		[0,0,0] //For netural defenders
	];

	// Move enemy spawn point back a bit after few seconds
	[_point, _distance, _direction] spawn {
		private _point = param [0];
		private _distance = param [1];
		private _direction = param [2];

		sleep 10;

		RSTF_SPAWNS set [
			SIDE_ENEMY,
			_point vectorAdd [sin(_direction) * _distance, cos(_direction) * _distance, 0]
		];
	};
};

RSTF_MODE_PUSH_init = {
	RSTF_MODE_PUSH_ENABLED = true;
	publicVariable "RSTF_MODE_PUSH_ENABLED";

	// Build points
	private _center = RSTF_POINT;
	private _radius = RSTF_DISTANCE;
	private _direction = RSTF_DIRECTION;

	_center = _center vectorAdd [
		sin(_direction + 180) * _radius,
		cos(_direction + 180) * _radius,
		0
	];

	while { count(RSTF_MODE_PUSH_POINTS) < 5 } do {
		_direction = _direction - 20 + random 40;
		_center = _center vectorAdd [
			sin(_direction) * _radius * 0.8,
			cos(_direction) * _radius * 0.8,
			0
		];

		if (RSTF_DEBUG) then {
			private _marker = createMarkerLocal [str(_center), _center];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "mil_warning";
		};

		RSTF_MODE_PUSH_POINTS pushBack _center;
	};

	_radius = 100;
	private _currentOwner = -1;
	private _last = time;
	private _marker = createMarker ["PUSH_OBJECTIVE", _center];
	_marker setMarkerShape "ELLIPSE";
	_marker setMarkerSize [_radius, _radius];
	_marker setMarkerColor RSTF_COLOR_NEUTRAL;

	call RSTF_MODE_PUSH_NEXT_POINT;

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

		if (_best == SIDE_FRIENDLY) then {
			// Add point and reset timer
			_last = time;
			RSTF_SCORE set [_best, (RSTF_SCORE select _best) + 1];

			// Notify clients
			publicVariable "RSTF_SCORE";
			0 remoteExec ["RSTF_fnc_onScore"];

			// End when limit is reached
			if (RSTF_SCORE select _best >= RSTF_MODE_PUSH_SCORE_LIMIT) then {
				// [_currentOwner] remoteExec ["RSTF_fnc_onEnd"];
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

RSTF_MODE_PUSH_unitKilled = {
	private _killed = param [0];
	private _killer = param [1];
	if (count(_this) > 2) then {
		_killer = param [2];
	};

	// Side is forgotten shortly after dying for some reason
	private _side = _killed getVariable ["SPAWNED_SIDE", civilian];

	private _isLegit = _side != side(_killer) && _killer != _killed;

	if (RSTF_MONEY_ENABLED) then {
		if (isPlayer(_killer)) then {
			if (_side != side(_killer) && _killer != _killed) then {
				[_killer, RSTF_MONEY_PER_KILL] call RSTF_fnc_addPlayerMoney;
			} else {
				[_killer, RSTF_MONEY_PER_TEAMKILL] call RSTF_fnc_addPlayerMoney;
			};
		} else {
			if (_side != side(_killer) && _killer != _killed) then {
				[_killer getVariable ["ORIGINAL_NAME", name(_killer)], RSTF_MONEY_PER_KILL * RSTF_AI_MONEY_MULTIPLIER] call RSTF_fnc_addUnitMoney;
			};
		};
	};

	// Award vehicle commander assist if applicable
	if (RSTF_MONEY_ENABLED && _isLegit) then {
		if (vehicle(_killer) != _killer && effectiveCommander(vehicle(_killer)) != _killer && isPlayer(effectiveCommander(vehicle(_killer)))) then {
			private _commander = effectiveCommander(vehicle(_killer));
			[_commander, RSTF_MONEY_PER_VEHICLE_COMMANDER_ASSIST] call RSTF_fnc_addPlayerMoney;
			[format["+$%1 <t color='#dddddd'>Commander assist</t>", RSTF_MONEY_PER_VEHICLE_COMMANDER_ASSIST], 5] remoteExec ["RSTFUI_fnc_addMessage", _commander];
		};
	};

	// Dispatch message if necessary
	if (isPlayer(_killer)) then {
		private _message = "";
		private _distance = round(_killed distance _killer);

		if (_isLegit) then {
			if (RSTF_MONEY_ENABLED) then {
				_message = format["+$%1 <t color='#dddddd'>Kill</t>", RSTF_MONEY_PER_KILL];
			} else {
				_message = format["<t color='#dddddd'>Kill</t>"];
			};

			if (_distance >= RSTF_KILL_DISTANCE_BONUS) then {
				_message = _message + format[" (%1m)", _distance];
			};
		} else {
			if (RSTF_MONEY_ENABLED) then {
				_message = format["-$%1 <t color='#dddddd'>Teamkill</t>", -RSTF_MONEY_PER_TEAMKILL];
			} else {
				_message = format["<t color='#dddddd'>Teamkill</t>"];
			};
		};

		[_message, 5] remoteExec ["RSTFUI_fnc_addMessage", _killer];
	};
};

RSTF_MODE_PUSH_taskCompleted = {
	private _taskName = param [0];
	private _taskScore = param [1];

	[format["+$%2 <t color='#dddddd'>%1</t>", _taskName, RSTF_MONEY_PER_TASK], 5] remoteExec ["RSTFUI_fnc_addGlobalMessage"];

	{
		[_x, RSTF_MONEY_PER_TASK] call RSTF_fnc_addPlayerMoney;
	} foreach allPlayers;
};

RSTF_MODE_PUSH_vehicleKilled = {

};
