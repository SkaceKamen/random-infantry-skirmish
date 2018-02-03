/*
	Function:
	RSTFUI_fnc_showVehicleDialog

	Description:
	Shows vehicle selection ui dialog.

	Author:
	Jan Zípek
*/
#include "..\..\dialogs\vehicleDialog.inc"

disableSerialization;

#define DISPLAYNAME "RSTF_RscVehicleDialog"

private _ok = createDialog DISPLAYNAME;
if (!_ok) exitWith {
	systemChat "Fatal error. Couldn't create vehicle dialog.";
};

private _display = DISPLAYNAME call RSTF_fnc_getDisplay;

private _ctrlList = [DISPLAYNAME, "VehicleSelect"] call RSTF_fnc_getCtrl;
private _ctrlCancel = [DISPLAYNAME, "ButtonCancel"] call RSTF_fnc_getCtrl;

private _vehicles = RSTF_BUYABLE_VEHICLES select SIDE_FRIENDLY;
private _money = [player] call RSTF_fnc_getPlayerMoney;

private _xx = 0;
private _yy = 0;

{
	private _category = _x select 0;
	private _vehicle = _x select 1;
	private _cost = _x select 2;
	private _config = configFile >> "cfgVehicles" >> _vehicle;
	private _displayName = getText(_config >> "displayName");
	private _picture = getText(_config >> "picture");

	private _weapons = [_vehicle] call RSTF_fnc_getVehicleWeapons;
	private _description = "";

	{
		_description = _description + getText(configFile >> "cfgWeapons" >> _x >> "displayName") + "<br/>";
	} foreach _weapons;

	private _ctrlBackground = _display ctrlCreate ["RSTF_VehicleDialog_VehicleContainer", -1, _ctrlList];
	private _ctrlPicture = _display ctrlCreate ["RSTF_VehicleDialog_VehicleImage", -1, _ctrlList];
	private _ctrlName = _display ctrlCreate ["RSTF_VehicleDialog_VehicleName", -1, _ctrlList];
	private _ctrlCost = _display ctrlCreate ["RSTF_VehicleDialog_VehicleCost", -1, _ctrlList];
	private _ctrlBuy = _display ctrlCreate ["RSTF_VehicleDialog_VehicleBuy", -1, _ctrlList];
	private _ctrlDesc = _display ctrlCreate ["RSTF_VehicleDialog_VehicleDesc", -1, _ctrlList];

	_ctrlBackground ctrlSetPosition [_xx, _yy];
	_ctrlPicture ctrlSetPosition [_xx + RSTF_VEHDG_VEH_PIC_X, _yy + RSTF_VEHDG_VEH_PIC_Y];
	_ctrlName ctrlSetPosition [_xx + RSTF_VEHDG_VEH_TITLE_X, _yy + RSTF_VEHDG_VEH_TITLE_Y];
	_ctrlCost ctrlSetPosition [_xx + RSTF_VEHDG_VEH_PRICE_X, _yy + RSTF_VEHDG_VEH_PRICE_Y];
	_ctrlBuy ctrlSetPosition [_xx + RSTF_VEHDG_VEH_BUY_X, _yy + RSTF_VEHDG_VEH_BUY_Y];
	_ctrlDesc ctrlSetPosition [_xx + RSTF_VEHDG_VEH_DESC_X, _yy + RSTF_VEHDG_VEH_DESC_Y];

	_ctrlPicture ctrlSetText _picture;
	_ctrlName ctrlSetText _displayName;
	_ctrlCost ctrlSetText format["$%1", _cost];
	_ctrlDesc ctrlSetStructuredText parseText(_description);

	_ctrlCost ctrlSetBackgroundColor
		(if (_money < _cost) then {
			[ 0.6, 0, 0, 0.5 ]
		} else {
			[ 0, 0.6, 0, 0.5 ]
		});

	_ctrlBuy ctrlAddEventHandler ["ButtonClick", format['
		private _vehicles = RSTF_BUYABLE_VEHICLES select SIDE_FRIENDLY;
		private _money = [player] call RSTF_fnc_getPlayerMoney;
		private _vehicle = (_vehicles select %1) select 1;
		private _cost = [_vehicle] call RSTF_fnc_getVehicleCost;

		if (_money >= _cost) then {
			closeDialog 0;

			// Ask server to spawn our vehicle
			[player, _vehicle] remoteExec ["RSTF_fnc_requestVehicle", 2];
		} else {
			["You don''t have money for that.", "You''re poor"] spawn BIS_fnc_guiMessage;
		};
	', _foreachIndex]];

	private _ctrls = [_ctrlBackground, _ctrlPicture, _ctrlName, _ctrlCost, _ctrlBuy, _ctrlDesc];

	{
		_x ctrlSetFade 1;
		_x ctrlCommit 0;
	} foreach _ctrls;

	[_foreachIndex, _ctrls] spawn {
		disableSerialization;

		private _index = param [0];
		private _ctrls = param [1];

		private _sleep = _index * 0.1;
		uisleep _sleep;

		{
			_x ctrlSetFade 0;
			_x ctrlCommit 0.2;
		} foreach _ctrls;
	};

	_xx = _xx + RSTF_VEHDG_VEH_W + RSTF_VEHDG_VEH_MARGIN;
	if (_xx > 1) then {
		_xx = 0;
		_yy = _yy + RSTF_VEHDG_VEH_H + RSTF_VEHDG_VEH_MARGIN;
	};

} foreach _vehicles;

_ctrlCancel ctrlAddEventHandler ["ButtonClick", {
	closeDialog 0;
}];

player switchMove RSTF_REMOTE_WORK_MOVE;
