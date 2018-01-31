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

	if (_code == DIK_LWIN || _code == DIK_RWIN) exitWith {
		closeDialog 0;

		0 spawn RSTF_fnc_UI_showVehicleSelection;

		true;
	};

	false;
}];