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

private _wp = _group addWaypoint [_wppoint, 50];

if ((RSTF_MODE_DEFEND_ENABLED || (RSTF_MODE_PUSH_ENABLED && RSTF_MODE_DEFENDERS_SIDE == SIDE_FRIENDLY)) && _sideIndex == SIDE_FRIENDLY) then {
	_wp setWaypointType "HOLD";
} else {
	_wp setWaypointType "SAD";
};

if (RSTF_DEBUG) then {
	(str(_group)) setMarkerPos _wppoint;
};
