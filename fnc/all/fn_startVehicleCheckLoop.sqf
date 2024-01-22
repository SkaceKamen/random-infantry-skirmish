0 spawn {
	while { !RSTF_ENDED } do
	{
		{
			private _side = _foreachIndex;
			private _aliveVehicles = [];

			{
				private _group = _x#0;
				private _vehicle = _x#1;
				private _air = _x#2;
				private _gunners = _x#3;
				private _hasGunner = count(_gunners) > 0;

				// Stuck vehicle check
				private _isStuck = false;
				private _lastPos = _vehicle getVariable ["RSTF_lastPos", []];

				if (count(_lastPos) > 0) then {
					if (_lastPos distance getPos(_vehicle) < 5) then {
						private _stuckTimeout = (_vehicle getVariable ["RSTF_stuckTimeout", 0]) + 1;
						if (_stuckTimeout > 1) then {
							_isStuck = true;
						} else {
							_vehicle setVariable ["RSTF_stuckTimeout", _stuckTimeout];
						};
					} else {
						_vehicle setVariable ["RSTF_stuckTimeout", 0];
					};
				} else {
					_vehicle setVariable ["RSTF_lastPos", getPos(_vehicle)];
				};

				// Readiness vehicle check
				private _isUseless = _isStuck
					|| !canFire(_vehicle)
					|| { _hasGunner && { count(_gunners select { alive _x }) == 0 } }
					|| { count(crew(_vehicle)) == 0 }
					|| { !canMove(_vehicle) && _vehicle distance RSTF_POINT > 300 };

				if (_isUseless) then {
					// Get out of useless vehicle
					{
						[_x, _vehicle] spawn {
							sleep 1;
							unassignVehicle (_this select 0);
							(_this select 0) action ["Eject", _this select 1];
						};
					} foreach crew(_vehicle);
				} else {
					// Keep vehicle in the list
					_aliveVehicles pushBack _x;
					
					// Air vehicles have limited ammo, this makes them more fun
					if (_air) then {
						_vehicle setVehicleAmmo 1;
					};

					[_group] call RSTF_fnc_refreshVehicleWaypoints;
				};

			} forEach _x;

			RSTF_AI_VEHICLES set [_side, _aliveVehicles];

		} foreach RSTF_AI_VEHICLES;

		sleep 10;
	};
};
