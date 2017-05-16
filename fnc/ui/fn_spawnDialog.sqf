params ["_className", ["_respawn", {}], ["_persistent", true]];

_ok = createDialog _className;
if (!_ok) exitWith {
	systemChat format["Failed to open %", _className];
	false;
};

waitUntil { !isNull(_className call RSTF_fnc_getDisplay) };

_display = _className call RSTF_fnc_getDisplay;
if (_persistent) then {
	_display setVariable ["displayParams", _this];
	_display displayAddEventHandler ["Unload", {
		if (_this select 1 != 0) then {
			((_this select 0) getVariable "displayParams") spawn {
				params ["_className", ["_respawn", {}], ["_persistent", true]];
				"Display closed. It will be reopened in 5 seconds." call BIS_fnc_titleText;
				sleep 5;
				call _respawn;
			};
		};
	}];
};

_display;