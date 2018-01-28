#include "..\..\scripts.inc"

RSTF_MODE_KOTH_ENABLED = false;

RSTF_MODE_KOTH_SCOREINTERVAL = 10;

RSTF_MODE_KOTH_MONEY_INDEX = [];
RSTF_MODE_KOTH_MONEY = [];

RSTF_MODE_KOTH_init = {
	RSTF_MODE_KOTH_ENABLED = true;

	// Reset score
	RSTF_SCORE = [0, 0, 0];

	// Hill parameters
	private _center = RSTF_POINT;
	private _radius = RSTF_DISTANCE * 0.6;

	private _currentOwner = -1;
	private _last = time;
	private _marker = createMarker ["KOTH_OBJECTIVE", _center];
	_marker setMarkerShape "ELLIPSE";
	_marker setMarkerSize [_radius * 2, _radius * 2];
	_marker setMarkerColor RSTF_COLOR_NEUTRAL;

	while { true } do {
		// Count men for each side inside this point
		private _counts = [];
		{
			_counts set [_x, 0];
		} foreach RSTF_SIDES;

		private _nearest = nearestObjects [_center, ["Man"], _radius, true];
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

		// Now find side with most men
		private _best = _currentOwner;
		private _bestCount = 0;

		{
			if (_x > _bestCount) then {
				_best = _foreachIndex;
				_bestCount = _x;
			};
		} foreach _counts;

		// Now compare it with current owner and change accordingly
		if (_best != _currentOwner) then {
			// Change owner
			_currentOwner = _best;

			// Reset score timer
			_last = time;

			// Change flag and marker to corresponding side
			private _color = RSTF_COLOR_NEUTRAL;

			if (_currentOwner != -1) then {
				_color = RSTF_SIDES_COLORS select _currentOwner;
			};

			_marker setMarkerColor _color;

			// Create notification
			[format[
				"<t color='%1'>%2</t> captured objective",
				RSTF_SIDES_COLORS_TEXT select _currentOwner,
				RSTF_SIDES_NAMES select _currentOwner
			], 5] remoteExec ["RSTF_fnc_UI_addGlobalMessage"];
		} else {
			// If enought time passed
			if (_currentOwner != -1 && time - _last > RSTF_MODE_KOTH_SCOREINTERVAL) then {
				// Add point and reset timer
				_last = time;
				RSTF_SCORE set [_currentOwner, (RSTF_SCORE select _currentOwner) + 1];

				// Create notification
				[format[
					"<t color='%1'>%2</t> +1 for holding objective",
					RSTF_SIDES_COLORS_TEXT select _currentOwner,
					RSTF_SIDES_NAMES select _currentOwner
				], 5] remoteExec ["RSTF_fnc_UI_addGlobalMessage"];

				// Notify clients
				remoteExec ["RSTF_fnc_onScore"];
			};
		};

		sleep 1;
	};
};

RSTF_MODE_KOTH_unitKilled = {
	private _killed = param [0];
	private _killer = param [1];
	if (count(_this) > 2) then {
		_killer = param [2];
	};

	// Side is forgotten shortly after dying for some reason
	private _side = _killed getVariable ["SPAWNED_SIDE", civilian];

	// Dispatch message if necessary
	if (isPlayer(_killer)) then {
		private _id = getPlayerUID _killer;
		private _index = RSTF_MODE_KOTH_MONEY_INDEX find _id;
		if (_index < 0) then {
			_index = count(RSTF_MODE_KOTH_MONEY_INDEX);
			RSTF_MODE_KOTH_MONEY_INDEX pushBack _id;
			RSTF_MODE_KOTH_MONEY pushBack 0;
		};

		if (_side != side(_killer)) then {
			RSTF_MODE_KOTH_MONEY set [_index, (RSTF_MODE_KOTH_MONEY select _index) + RSTF_SCORE_PER_KILL];
		} else {
			RSTF_MODE_KOTH_MONEY set [_index, 0 max ((RSTF_MODE_KOTH_MONEY select _index) - RSTF_SCORE_PER_TEAMKILL)];
		};

		private _message = "";
		private _distance = round(_killed distance _killer);

		if (_side != side(_killer)) then {
			_message = format["+%1$ <t color='#dddddd'>Kill</t> (%2 m)", RSTF_SCORE_PER_KILL, _distance];
		} else {
			_message = format["%1$ <t color='#dddddd'>Teamkill</t>", RSTF_SCORE_PER_TEAMKILL];
		};

		[_message, 5] remoteExec ["RSTF_fnc_UI_AddMessage", _killer];
	};
};

RSTF_MODE_KOTH_taskCompleted = {

};

[
	RSTF_MODE_KOTH_init,
	RSTF_MODE_KOTH_unitKilled,
	RSTF_MODE_KOTH_taskCompleted
];