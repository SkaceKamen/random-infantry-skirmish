/*
	Function:
	RSTF_fnc_bindKeys

	Description:
	Binds keyboard keys used in mission for custom functionality.

	Author:
	Jan Zípek
*/

#include "..\..\dialogs\keys.hpp"

disableSerialization;

waitUntil { !isNull(findDisplay 46) };

private _display = findDisplay 46;
_display displayAddEventHandler ["KeyDown", {
	private _ctrl = param [0];
	private _code = param [1];

	private _keys = [];
	
	if (RSTF_BUY_MENU_ACTION == "win") then {
		_keys = [DIK_LWIN, DIK_RWIN];
	} else {
		_keys = actionKeys RSTF_BUY_MENU_ACTION;
	};

	if (!dialog && { _code in _Keys }) exitWith {
		// Make sure there isn't any other dialog displayed
		closeDialog 0;

		// Show vehicle selection dialog
		0 spawn RSTFUI_fnc_showVehicleDialog;

		// Notify engine that we handled this
		true;
	};

	false;
}];