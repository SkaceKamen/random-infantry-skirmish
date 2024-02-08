/*
	Author: Jan Zípek

	Description:
	Tries to load predefined set of possible battle locations.


	Returns:
	ARRAY - each element is [NAME, POSITION, [SIZE_X, SIZE_Y], ROTATION]
*/

private _locations = [];
{
	if (markerShape(_x) == 'ELLIPSE') then {
		_locations pushBack [
			markerText(_x),
			markerPos(_x),
			markerSize(_x),
			markerDir(_x)
		];
		deleteMarker _x;
	};
} forEach allMapMarkers;

{
	_locations pushBack [
		_x getVariable ["Name", "Unknown"],
		getPos(_x),
		[100, 100],
		getDir(_x)
	];
} forEach (entities "RIS_Location");

_locations;