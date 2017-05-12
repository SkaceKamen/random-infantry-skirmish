params ["_className", ["_persistent", true]];

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
		((_this select 0) getVariable "displayParams") spawn {
			"Display closed. It will be reopened in 5 seconds." call BIS_fnc_titleText;
			sleep 5;
			_this call RSTF_fnc_spawnDialog;
		};
	}];
};

_display;