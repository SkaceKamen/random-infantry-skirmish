/*
	Function:
	RSTF_fnc_refreshSideWaypoints

	Description:
	Refreshes waypoints for all side groups

	Parameters:
		0: SIDE INDEX - side index that should be refreshed

	Author:
	Jan Zípek
*/

private _sideIndex = param [0];
private _groups = RSTF_GROUPS select _sideIndex;

{
	[_x, _sideIndex] call RSTF_fnc_refreshGroupWaypoints;
} foreach _groups;
