disableSerialization;

#define DISPLAYNAME "RSTF_RscSupportDialog"

private _ok = createDialog DISPLAYNAME;
if (!_ok) exitWith {
	systemChat "Fatal error. Couldn't create support dialog.";
};

private _display = DISPLAYNAME call RSTF_fnc_getDisplay;

private _ctrlVehicle = [DISPLAYNAME, "ButtonVehicle"] call RSTF_fnc_getCtrl;
private _ctrlEquipment = [DISPLAYNAME, "ButtonEquipment"] call RSTF_fnc_getCtrl;
private _ctrlSupport = [DISPLAYNAME, "ButtonSupport"] call RSTF_fnc_getCtrl;

_ctrlVehicle ctrlAddEventHandler ["ButtonClick", {
	closeDialog 0;
	0 spawn RSTF_fnc_UI_showVehicleSelection;
}];

player switchMove "AmovPknlMstpSrasWrflDnon_AinvPknlMstpSrasWrflDnon";

/*
_ctrlVehicle ctrlAddEventHandler ["ButtonClick", {
	closeDialog 0;
	0 spawn RSTF_fnc_UI_showVehicleSelection;
}];

_ctrlVehicle ctrlAddEventHandler ["ButtonClick", {
	closeDialog 0;
	0 spawn RSTF_fnc_UI_showVehicleSelection;
}];
*/