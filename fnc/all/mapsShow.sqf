disableSerialization;

_ok = createDialog "RSTF_RscDialogMaps";
if (!_ok) exitWith {
	systemChat "Fatal error. Couldn't create factions dialog.";
};

_ctrl = ["RSTF_RscDialogMaps", "select"] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	_ctrl = ["RSTF_RscDialogMaps", "mapsList"] call RSTF_fnc_getCtrl;
	_x = lnbCurSelRow _ctrl;
	if (_x >= 0) then {
		RSTF_SELECTED_WORLD = _ctrl lnbData [_x, 0];
	};
	closeDialog 0;
}];

_ctrl = ["RSTF_RscDialogMaps", "mapsList"] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["LBSelChanged", {
	_ctrl = ["RSTF_RscDialogMaps", "mapsList"] call RSTF_fnc_getCtrl;
	_x = lnbCurSelRow _ctrl;
	if (_x >= 0) then {
		_ident = _ctrl lnbData [_x, 0];
		_img = _ctrl lnbData [_x, 1];
		
		_ctrl = ["RSTF_RscDialogMaps", "mapsImage"] call RSTF_fnc_getCtrl;
		_ctrl ctrlSetText _img;
	};
}];

_cfg = configFile >> "cfgWorldList";

_index = 0;
for [{_i = 0},{_i < count(_cfg)},{_i = _i + 1}] do {
	if (isClass(_cfg select _i)) then {
		_name = configName(_cfg select _i);
		_details = configFile >> "cfgWorlds" >> _name;
		_desc = getText(_details >> "description");
		_img = getText(_details >> "pictureMap");
		
		_ctrl lnbAddRow [_desc];
		_ctrl lnbSetData [[_index, 0], _name];
		_ctrl lnbSetData [[_index, 1], _img];
		
		if (_name == RSTF_SELECTED_WORLD) then {
			_ctrl lnbSetCurSelRow _index;
		};
		
		_index = _index + 1;
	};
};