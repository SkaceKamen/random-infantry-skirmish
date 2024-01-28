/*
	Function:
	RSTF_fnc_refreshGroupWaypoints

	Description:
	Refreshes waypoints for specific group

	Parameters:
		0: GROUP - group to be refreshed
		1: SIDE INDEX - side index that should be refreshed

	Author:
	Jan Zípek
*/


private _group = param [0];
private _sideIndex = param [1];

private _dis = selectRandom([-1,1]) * random(RSTF_DISTANCE * 0.3);
private _wppoint = [_sideIndex, true] call RSTF_fnc_getAttackWaypoint;

// Delete and recreate waypoint
// This sometimes helps with stuck units
deleteWaypoint [_group, 0];

private _wp = _group addWaypoint [_wppoint, 10];
private _order = "SAD";
private _speed = "NORMAL";
private _dbg = "";

if (!isNull(leader(_group))) then {
	private _groupLeaderPos = getPos(leader(_group));

	switch (call RSTF_fnc_getModeId) do {
		case "PushDefense";
		case "Push": {
			private _objectiveDistance = [_groupLeaderPos] call RSTF_fnc_getObjectiveDistance;
			_dbg = str(_objectiveDistance);

			if (_sideIndex == RSTF_MODE_ATTACKERS_SIDE) then {
				if (_objectiveDistance > 50) then {
					_order = "MOVE";
					_speed = "FULL";
				};
			} else {
				if (_objectiveDistance > 30) then {
					_order = "MOVE";
					_speed = "FULL";
				};
			}
		};

		case "KOTH": {
			private _distance = _groupLeaderPos distance2D RSTF_POINT;

			if (_distance > RSTF_DISTANCE * 0.6) then {
				_order = "MOVE";
				_speed = "FULL";
			};
		};

		case "Defense": {
			private _distance = _groupLeaderPos distance2D RSTF_POINT;

			if (_sideIndex == SIDE_ENEMY) then {
				if (_distance >RSTF_MODE_DEFEND_RADIUS) then {
					_order = "MOVE";
					_speed = "FULL";
				};
			};
		};
	};
};


if (RSTF_DEBUG) then {
	(str(_group)) setMarkerPos _wppoint;
	(str(_group)) setMarkerText (_order + "," + _speed + "," + _dbg);
};
