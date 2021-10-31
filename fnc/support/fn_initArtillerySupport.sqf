/*
	Author:
	Jan Zípek

	Description:
	Opens artillery support dialog.

	Parameters:
		0: CONFIG CLASS - classname of support config
		1: STRING - class name of shell to be used
		2: NUMBER - number of shells to be used
		3: RADIUS - the shelling radius
		4: ARRAY - [min, max] delay between shots
		5: ARRAY - [min, max] initial delay

	Returns:
	NOTHING
*/


private _className = param [0];
private _radius = param [3];

private _cost = getNumber(missionConfigFile >> "RSTF_BUYABLE_SUPPORTS" >> _className >> "cost");
private _title = getText(missionConfigFile >> "RSTF_BUYABLE_SUPPORTS" >> _className >> "title");
private _description = getText(missionConfigFile >> "RSTF_BUYABLE_SUPPORTS" >> _className >> "description");

// Save the params for later use
RSTF_ARTILLERY_params = _this;

// Spawn the dialog
RSTF_ARTILLERY_layout = [missionConfigFile >> "ArtilleryDialog"] call ZUI_fnc_createDisplay;

// Create target marker
RSTF_ARTILLERY_marker = createMarkerLocal ["RSTF_ARTILLERY_MARKER", RSTF_POINT];
RSTF_ARTILLERY_marker setMarkerShape "ELLIPSE";
RSTF_ARTILLERY_marker setMarkerSize [_radius, _radius];
RSTF_ARTILLERY_marker setMarkerBrush "SolidBorder";
RSTF_ARTILLERY_marker setMarkerColor "ColorRed";

// Marker should be deleted when display is closed
([RSTF_ARTILLERY_layout] call ZUI_fnc_display) displayAddEventHandler ["unload", {
	deleteMarker RSTF_ARTILLERY_marker;

	RSTF_ARTILLERY_layout = [];
	RSTF_ARTILLERY_params = [];
	RSTF_ARTILLERY_marker = "";
}];


// Populate support info
([RSTF_ARTILLERY_layout, "info"] call ZUI_fnc_getControlById) ctrlSetStructuredText parseText(
	"<t size='1.2'>" + _title + "</t><br />" +
	_description
);

// Move to center of the game
private _mapCtrl = [RSTF_ARTILLERY_layout, "map"] call ZUI_fnc_getControlById;
_mapCtrl ctrlMapAnimAdd [0, 0.02, RSTF_POINT];
ctrlMapAnimCommit _mapCtrl;

// Move marker around when user selects position
_mapCtrl ctrlAddEventHandler ["mouseButtonDown", {
	private _ctrl = _this select 0;
	private _x = _this select 2;
	private _y = _this select 3;

	private _pos = _ctrl ctrlMapScreenToWorld [_x, _y];

	RSTF_ARTILLERY_marker setMarkerPos _pos;
}];

([RSTF_ARTILLERY_layout, "cancel"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", {
	[RSTF_ARTILLERY_layout] call ZUI_fnc_closeDisplay;
}];

([RSTF_ARTILLERY_layout, "confirm"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", {
	// Copy currently selected target as last argument
	RSTF_ARTILLERY_params set [6, getMarkerPos RSTF_ARTILLERY_marker]; 
	// Who is firing
	RSTF_ARTILLERY_params set [7, player];

	// Start shelling the position
	RSTF_ARTILLERY_params remoteExec ["RSTF_fnc_startShelling", 2];

	// Close dialog
	[RSTF_ARTILLERY_layout] call ZUI_fnc_closeDisplay;
}];