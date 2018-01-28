#include "..\..\scripts.inc"

RSTF_MODE_KOTH_SCORE = [0, 0, 0];
RSTF_MODE_KOTH_SCOREINTERVAL = 10;

RSTF_MODE_KOTH_init = {
	// Reset score
	RSTF_MODE_KOTH_score = [0, 0, 0];

	// Hill parameters
	private _center = RSTF_POINT;
	private _radius = 100;

	private _currentOwner = -1;
	private _last = time;
	private _marker = createMarker ["KOTH_OBJECTIVE", _center];
	_marker setMarkerShape "ELLIPSE";
	_marker setMarkerSize [_radius, _radius];
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
			]] call RSTF_fnc_UI_addGlobalMessage;
		} else {
			// If enought time passed
			if (time - _last > RSTF_MODE_KOTH_SCOREINTERVAL) then {
				// Add point and reset timer
				_last = time;
				RSTF_MODE_KOTH_SCORE set [_currentOwner, (RSTF_MODE_KOTH_SCORE select _currentOwner) + 1];

				// Create notification
				[format[
					"<t color='%1'>%2</t> +1 for holding objective",
					RSTF_SIDES_COLORS_TEXT select _currentOwner,
					RSTF_SIDES_NAMES select _currentOwner
				]] call RSTF_fnc_UI_addGlobalMessage;
			};
		};

		sleep 1;
	};
};

RSTF_MODE_KOTH_unitKilled = {

};

RSTF_MODE_KOTH_taskCompleted = {

};

[
	RSTF_MODE_KOTH_init,
	RSTF_MODE_KOTH_unitKilled,
	RSTF_MODE_KOTH_taskCompleted
];