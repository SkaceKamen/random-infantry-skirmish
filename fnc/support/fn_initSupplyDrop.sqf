/*
	Author:
	Jan Zípek

	Description:
	Opens dialog for dropping a suply of something

	Parameters:
		0: CONFIG CLASS - classname of support config
	Returns:
	NOTHING
*/

// Save the params for later use
RSTF_SUPPLY_DROP_params = _this;

private _className = param [0, ""];

// Params
private _cost = getNumber(missionConfigFile >> "RSTF_BUYABLE_SUPPORTS" >> _className >> "cost");
private _title = getText(missionConfigFile >> "RSTF_BUYABLE_SUPPORTS" >> _className >> "title");
private _description = getText(missionConfigFile >> "RSTF_BUYABLE_SUPPORTS" >> _className >> "description");

// Spawn the dialog
RSTF_SUPPLY_DROP_layout = [missionConfigFile >> "SupplyDropDialog"] call ZUI_fnc_createDisplay;

// Create target marker
RSTF_SUPPLY_DROP_marker = createMarkerLocal ["RSTF_SUPPLY_DROP_marker", getPos(player)];
RSTF_SUPPLY_DROP_marker setMarkerShape "ICON";
RSTF_SUPPLY_DROP_marker setMarkerType "hd_objective_noShadow";
RSTF_SUPPLY_DROP_marker setMarkerColor "ColorBlack";

// Marker should be deleted when display is closed
([RSTF_SUPPLY_DROP_layout] call ZUI_fnc_display) displayAddEventHandler ["unload", {
	deleteMarker RSTF_SUPPLY_DROP_marker;

	RSTF_SUPPLY_DROP_layout = [];
	RSTF_SUPPLY_DROP_params = [];
	RSTF_SUPPLY_DROP_marker = "";
}];

// Populate support info
([RSTF_SUPPLY_DROP_layout, "info"] call ZUI_fnc_getControlById) ctrlSetStructuredText parseText(
	"<t size='1.2'>" + _title + "</t><br />" +
	_description
);

// Move to player
private _mapCtrl = [RSTF_SUPPLY_DROP_layout, "map"] call ZUI_fnc_getControlById;
_mapCtrl ctrlMapAnimAdd [0, 0.02, getPos(player)];
ctrlMapAnimCommit _mapCtrl;

// Move marker around when user selects position
_mapCtrl ctrlAddEventHandler ["mouseButtonDown", {
	private _ctrl = _this select 0;
	private _x = _this select 2;
	private _y = _this select 3;

	private _pos = _ctrl ctrlMapScreenToWorld [_x, _y];

	RSTF_SUPPLY_DROP_marker setMarkerPos _pos;
}];

([RSTF_SUPPLY_DROP_layout, "cancel"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", {
	[RSTF_SUPPLY_DROP_layout] call ZUI_fnc_closeDisplay;
}];

([RSTF_SUPPLY_DROP_layout, "confirm"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", {
	// Copy currently selected target as last argument
	RSTF_SUPPLY_DROP_params pushBack getMarkerPos RSTF_SUPPLY_DROP_marker; 
	// Who is owner
	RSTF_SUPPLY_DROP_params pushBack player;

	// Drop the stuff!
	RSTF_SUPPLY_DROP_params remoteExec ["RSTF_fnc_performSupplyDrop", 2];

	// Close dialog
	[RSTF_SUPPLY_DROP_layout] call ZUI_fnc_closeDisplay;
}];
