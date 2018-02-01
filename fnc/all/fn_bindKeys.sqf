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

	if (_code in RSTF_KEYS_DISPLAY_SUPPORT) exitWith {
		// Make sure there isn't any other dialog displayed
		closeDialog 0;

		// Show vehicle selection dialog
		0 spawn RSTFUI_fnc_showVehicleDialog;

		// Notify engine that we handled this
		true;
	};

	false;
}];