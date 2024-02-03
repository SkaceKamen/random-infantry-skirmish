private _filter = "getNumber(_x >> 'scope') == 2 && (getNumber(_x >> 'type') == 1 || getNumber(_x >> 'type') == 2)";

private _ctrl = [RSTF_GUN_GAME_EDITOR_WEAPONS_layout, "search"] call ZUI_fnc_getControlById;
private _text = ctrlText _ctrl;

if (_text != "") then {
	_filter = format["%1 && (['%2', getText(_x >> 'displayName')] call BIS_fnc_inString)", _filter, _text];
};

private _weapons = [
	_filter configClasses (configFile >> "CfgWeapons"),
	[],
	{ getText(_x >> "displayName") }
] call BIS_fnc_sortBy;

_ctrl = [RSTF_GUN_GAME_EDITOR_WEAPONS_layout, "weapons"] call ZUI_fnc_getControlById;
lnbClear _ctrl;

{
	private _name = getText(_x >> "displayName");
	private _icon = getText(_x >> "picture");
	private _linkedItems = (("true" configClasses (_x >> "linkedItems")) apply {
		private _item = configFile >> "cfgWeapons" >> getText(_x >> "item");
		getText(_item >> "displayName");
	}) joinString ",";
	
	private _dlcIcon = "";
	private _dlcName = "";
	if (isText(_x >> "dlc")) then {
		_dlc = getText(_x >> "dlc");
		_dlcIcon = getText(configFile >> "cfgMods" >> _dlc >> "logoSmall");
		_dlcName = getText(configFile >> "cfgMods" >> _dlc >> "name");
	};

	private _tooltip = "Classname: " + configName(_x);
	if (_linkedItems != "") then {
		_tooltip = _tooltip + "\nAttachments: " + _linkedItems;
	};
	if (_dlcName != "") then {
		_tooltip = _tooltip + "\nDLC: " + _dlcName;
	};

	private _row = _ctrl lnbAddRow [_name, _linkedItems];
	_ctrl lnbSetPicture [[_row, 0], _icon];
	_ctrl lnbSetData [[_row, 0], configName(_x)];
	_ctrl lnbSetTooltip [[_row, 0], _tooltip];

	if (_dlcIcon != "") then {
		_ctrl lnbSetPictureRight [[_row, 1], _dlcIcon];
	};
} forEach _weapons;
