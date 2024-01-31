params ["_zuiDialog", ["_parent", displayNull], ["_respawn", {}], ["_faded", false]];

private _layout = [_zuiDialog, _parent, _faded] call ZUI_fnc_createDisplay;

private _display = [_layout] call ZUI_fnc_display;
_display setVariable ["displayParams", _this];
_display displayAddEventHandler ["Unload", {
	if (_this select 1 != 0) then {
		((_this select 0) getVariable "displayParams") spawn {
			params ["_className", ["_parent", displayNull], ["_respawn", {}], ["_persistent", true]];
			"Display closed. It will be reopened in 5 seconds." call BIS_fnc_titleText;
			sleep 5;
			call _respawn;
		};
	};
}];


_layout;
