#include "..\..\dialogs\keys.hpp"
/*
	Function:
	RSTF_fnc_bindKeys

	Description:
	Binds keyboard keys used in mission for custom functionality.

	Author:
	Jan Zípek
*/

disableSerialization;

waitUntil { !isNull(findDisplay 46) };

private _display = findDisplay 46;
_display displayAddEventHandler ["KeyDown", {
	private _ctrl = param [0];
	private _code = param [1];

	private _keys = [];
	private _action = RSTF_POSSIBLE_KEYS select RSTF_BUY_MENU_ACTION;

	if (_action == "win") then {
		_keys = [DIK_LWIN, DIK_RWIN];
	} else {
		_keys = actionKeys _action;
	};

	if (RSTF_MONEY_ENABLED && !RSTF_DISABLE_MONEY && !dialog && { _code in _Keys }) exitWith {
		// Make sure there isn't any other dialog displayed
		closeDialog 0;

		// Show vehicle selection dialog
		0 spawn RSTFUI_fnc_showShopDialog;

		// Notify engine that we handled this
		true;
	};

	false;
}];
