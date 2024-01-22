private _group = param [0];
private _side = [side(_group)] call RSTF_fnc_sideIndex;
private _vehicle = vehicle(leader(_group));
private _air = _vehicle isKindOf "Air";

// Reset waypoints
[_group] call RSTF_fnc_clearWaypoints;

private _wp = _group addWaypoint [[_side, true] call RSTF_fnc_getAttackWaypoint, 10];

if (RSTF_DEBUG) then {
	str(_vehicle) setmarkerPos (waypointPosition _wp);
};

if (!_air) then {
	_wp setWaypointType "SAD";
	_wp setWaypointSpeed "LIMITED";
	_wp setwaypointbehaviour "COMBAT";
} else {
	_wp setWaypointType "SAD";
};
