disableSerialization;

#define DISPLAYNAME "RSTF_RscVehicleDialog"

private _ok = createDialog DISPLAYNAME;
if (!_ok) exitWith {
	systemChat "Fatal error. Couldn't create vehicle dialog.";
};

private _display = DISPLAYNAME call RSTF_fnc_getDisplay;

private _ctrlList = [DISPLAYNAME, "VehicleSelect"] call RSTF_fnc_getCtrl;
private _ctrlBuy = [DISPLAYNAME, "ButtonBuy"] call RSTF_fnc_getCtrl;

private _vehicles = (RSTF_VEHICLES select SIDE_FRIENDLY) select RSTF_VEHICLE_APC;

lnbClear _ctrlList;
{
	private _config = configFile >> "cfgVehicles" >> _x;
	private _displayName = getText(_config >> "displayName");
	private _picture = getText(_config >> "picture");
	private _cost = [_x] call RSTF_fnc_vehicleCost;

	_ctrlList lnbAddRow [_displayName, format["%1$", _cost]];
	_ctrlList lnbSetPicture [[_foreachIndex, 0], _picture];
} foreach _vehicles;

_ctrlBuy ctrlAddEventHandler ["ButtonClick", {
	private _display = DISPLAYNAME call RSTF_fnc_getDisplay;
	private _ctrlList = [DISPLAYNAME, "VehicleSelect"] call RSTF_fnc_getCtrl;
	private _selected = lnbCurSelRow _ctrlList;

	private _vehicles = (RSTF_VEHICLES select SIDE_FRIENDLY) select RSTF_VEHICLE_APC;
	private _index = [player] call RSTF_MODE_KOTH_getMoneyIndex;
	private _money = RSTF_MODE_KOTH_MONEY select _index;

	if (_selected >= 0 && _selected < count(_vehicles)) then {
		private _vehicle = _vehicles select _selected;
		private _cost = [_vehicle] call RSTF_fnc_vehicleCost;

		if (_money >= _cost) then {
			closeDialog 0;

			RSTF_MODE_KOTH_MONEY set [_index, _money - _cost];

			private _vehicle = createVehicle [_vehicle, RSTF_SPAWNS select SIDE_FRIENDLY, [], 50, "NONE"];
			createVehicleCrew _vehicle;

			[_vehicle] spawn {
				_previous = player;
				effectiveCommander(_this select 0) call RSTF_fnc_assignPlayer;
				deleteVehicle _previous;
			};
		} else {
			["You don't have money for that.", "You're poor"] spawn BIS_fnc_guiMessage;
		};
	}
}];