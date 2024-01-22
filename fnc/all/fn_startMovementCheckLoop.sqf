/*
	Function:
	RSTF_fnc_startMovementCheckLoop

	Description:
	Starts a loop that checks if AI units are stuck or not

	Author:
	Jan Zípek
*/

0 spawn {
	while { !RSTF_ENDED } do {
		private _toCheck = [];

		{
			// No need to check dead units
			if (!alive(_x)) then {
				continue;
			};

			// Obviously skip players
			if (isPlayer(_x)) then {
				_toCheck pushBack _x;
				continue;
			};

			// Player units can have orders and stuff
			if (units(group(_x)) findIf { isPlayer(_x) } != -1) then {
				_toCheck pushBack _x;
				continue;
			};

			private _previousPosition = _x getVariable ["RSTF_MOVEMENT_LAST", []];

			if (count(_previousPosition) > 0) then {
				private _newPos = getPos(_x);
				private _moved = (_newPos distance _previousPosition);

				if (_moved < 1 /*&& _newPos distance RSTF_POINT > 150*/) then {
					private _timeout = _x getVariable ["RSTF_MOVEMENT_TIMEOUT", 0];
					if (_timeout > 60) then {
						_x setDamage 1;
					
						if (RSTF_DEBUG) then {
							systemChat "Killed a unit because it wasn't moving!";

							private _marker = createMarkerLocal [str(getPos(_x)), getPos(_x)];
							_marker setMarkerShape "ICON";
							_marker setMarkerType "KIA";
						};

						continue;
					};
					
					_x setVariable ["RSTF_MOVEMENT_TIMEOUT", _timeout + 10];
				} else {
					_x setVariable ["RSTF_MOVEMENT_LAST", _newPos];
					_x setVariable ["RSTF_MOVEMENT_TIMEOUT", 0];
				};
			} else {
				_x setVariable ["RSTF_MOVEMENT_LAST", getPos(_x)];
			};

			_toCheck pushBack _x;
		} foreach RSTF_MOVEMENT_CHECK_UNITS;

		RSTF_MOVEMENT_CHECK_UNITS = _toCheck;

		sleep 10;
	};
};