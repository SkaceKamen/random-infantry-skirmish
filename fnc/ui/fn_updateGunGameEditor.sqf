private _ctrl = [RSTF_GUN_GAME_EDITOR_layout, "weapons"] call ZUI_fnc_getControlById;

lnbClear _ctrl;

{
	private _config = configFile >> "CfgWeapons" >> _x;
	private _name = "MISSING: " + _x;
	private _icon = "";
	private _linkedItems = "";

	if (isClass(_config)) then {
		_name = getText(_config >> "displayName");
		_icon = getText(_config >> "picture");
		_linkedItems = (("true" configClasses (_config >> "linkedItems")) apply {
			private _item = configFile >> "cfgWeapons" >> getText(_x >> "item");
			getText(_item >> "displayName");
		}) joinString ",";
	};

	private _row = _ctrl lnbAddRow [_name];
	_ctrl lnbSetPicture [[_row, 0], _icon];
	_ctrl lnbSetTooltip [[_row, 0], format["Classname: %1\nAttachments: %2", _x, _linkedItems]];

	if (!isClass(_config)) then {
		_ctrl lnbSetColor [[_row, 0], [1, 0, 0, 1]];
	};
} foreach RSTF_GUN_GAME_EDITOR_WEAPONS;
