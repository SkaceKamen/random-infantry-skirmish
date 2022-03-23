#include "..\..\scripts.inc"

// TODO: Start using own variables:
// RSTF_MODE_DEFEND_COUNTS = [];
// RSTF_MODE_DEFEND_POINTS = [];

RSTF_MODE_DEFEND_ENABLED = false;
RSTF_MODE_DEFEND_TASK = "";

RSTF_MODE_DEFEND_init = {
	RSTF_MODE_DEFEND_ENABLED = true;
	publicVariable "RSTF_MODE_DEFEND_ENABLED";

	RSTF_TASKS_IFV_ENABLED = false;
	RSTF_TASKS_CLEAR_ENABLED = false;
	RSTF_TASKS_EMP_ENABLED = false;
	RSTF_SPAWN_TRANSPORTS = false;
	RSTF_NEUTRALS_GROUPS = 0;
	RSTF_NEUTRALS_EMPLACEMENTS = false;
	RSTF_ENEMY_ADVANTAGE_GROUPS = 5;

	// Force-spawn enemy wave
	[SIDE_FRIENDLY] call RSTF_fnc_spawnWave;

	// Reset score
	RSTF_SCORE = [0, 0, 0];
};

RSTF_MODE_DEFEND_startLoop = {
	0 spawn {
		// Hill parameters
		private _center = RSTF_POINT;
		private _radius = RSTF_MODE_DEFEND_RADIUS;

		private _currentOwner = -1;
		private _last = time;
		private _marker = createMarker ["DEFEND_OBJECTIVE", _center];
		_marker setMarkerShape "ELLIPSE";
		_marker setMarkerSize [_radius, _radius];
		_marker setMarkerColor RSTF_COLOR_NEUTRAL;

		// Start new task
		RSTF_MODE_DEFEND_TASK = [
			side(player),
			"Defend this area",
			["This area is important for our efforts, defend it at all cost", "Defend this area",""],
			RSTF_POINT,
			"ASSIGNED",
			0,
			true,
			"defend"
		] call BIS_fnc_taskCreate;

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

			if (_best == SIDE_ENEMY) then {
				// Add point and reset timer
				_last = time;
				RSTF_SCORE set [_best, (RSTF_SCORE select _best) + 1];

				// Notify clients
				publicVariable "RSTF_SCORE";
				0 remoteExec ["RSTF_fnc_onScore"];

				// End when limit is reached
				if (RSTF_SCORE select _best >= RSTF_MODE_PUSH_SCORE_LIMIT) then {
					[SIDE_ENEMY] remoteExec ["RSTF_fnc_onEnd"];
				};
			};

			if (time > RSTF_MODE_DEFEND_DURATION) then {
				[SIDE_FRIENDLY] remoteExec ["RSTF_fnc_onEnd"];
			};

			publicVariable "RSTF_MODE_PUSH_COUNTS";

			sleep 1;
		};
	};
};

RSTF_MODE_DEFEND_unitKilled = {
	_this call RSTF_fnc_killHandler;
};

// No tasks in defend mode
RSTF_MODE_DEFEND_taskCompleted = {};

RSTF_MODE_DEFEND_vehicleKilled = {};
