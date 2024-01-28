#include "..\..\scripts.inc"

RSTF_MODE_KOTH_ENABLED = false;
RSTF_MODE_KOTH_OWNER = -1;
RSTF_MODE_KOTH_COUNTS = [];

RSTF_MODE_KOTH_init = {
	RSTF_MODE_KOTH_ENABLED = true;
	publicVariable "RSTF_MODE_KOTH_ENABLED";

	// Reset score
	RSTF_SCORE = [0, 0, 0];
};

RSTF_MODE_KOTH_startLoop = {
	0 spawn {
		// Hill parameters
		private _center = RSTF_POINT;
		private _radius = RSTF_DISTANCE * 0.6;

		private _currentOwner = -1;
		private _last = time;
		private _marker = createMarker ["KOTH_OBJECTIVE", _center];
		_marker setMarkerShape "ELLIPSE";
		_marker setMarkerSize [_radius, _radius];
		_marker setMarkerColor RSTF_COLOR_NEUTRAL;

		while { !RSTF_ENDED } do {
			// Count men for each side inside this point
			private _counts = [_center, _radius/2] call RSTF_fnc_countCaptureUnits;
			RSTF_MODE_KOTH_COUNTS = _counts;

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
				], 5] remoteExec ["RSTFUI_fnc_addGlobalMessage"];
			} else {
				// If enought time passed
				if (_currentOwner != -1 && _currentOwner != SIDE_NEUTRAL && time - _last > RSTF_MODE_KOTH_SCORE_INTERVAL) then {
					// Add point and reset timer
					_last = time;
					RSTF_SCORE set [_currentOwner, (RSTF_SCORE select _currentOwner) + 1];

					// Create notification
					[format[
						"<t color='%1'>%2</t> +1 for holding objective",
						RSTF_SIDES_COLORS_TEXT select _currentOwner,
						RSTF_SIDES_NAMES select _currentOwner
					], 5] remoteExec ["RSTFUI_fnc_addGlobalMessage"];

					// Notify clients
					publicVariable "RSTF_SCORE";
					0 remoteExec ["RSTF_fnc_onScore"];

					// End when limit is reached
					if (RSTF_SCORE select _currentOwner >= RSTF_MODE_KOTH_SCORE_LIMIT) then {
						[_currentOwner] remoteExec ["RSTF_fnc_onEnd"];
					};
				};
			};

			RSTF_MODE_KOTH_OWNER = _currentOwner;

			publicVariable "RSTF_MODE_KOTH_OWNER";
			publicVariable "RSTF_MODE_KOTH_COUNTS";

			sleep 1;
		};
	};
};

RSTF_MODE_KOTH_unitKilled = {
	_this call RSTF_fnc_killHandler;
};

RSTF_MODE_KOTH_taskCompleted = {
	private _taskName = param [0];
	private _taskScore = param [1];

	[format["+$%2 <t color='#dddddd'>%1</t>", _taskName, RSTF_MONEY_PER_TASK], 5] remoteExec ["RSTFUI_fnc_addGlobalMessage"];

	{
		[_x, RSTF_MONEY_PER_TASK] call RSTF_fnc_addPlayerMoney;
	} foreach allPlayers;
};

RSTF_MODE_KOTH_vehicleKilled = {};
