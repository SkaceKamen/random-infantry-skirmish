private _name = _this select 0;
private _list = _this select 1;

private _updated = [];
{
	if (RSTF_FACTIONS find _x != -1) then {
		_updated pushBack _x;
	}

} foreach _list;

_list = _updated;

private _ctrl = [RSTF_MAIN_CONFIG_layout, _name + "List"] call ZUI_fnc_getControlById;
lnbClear _ctrl;
{
	_name = getText(ConfigFile >> "cfgFactionClasses" >> _x >> "displayName");
	_icon = getText(ConfigFile >> "cfgFactionClasses" >> _x >> "icon");

	_ctrl lnbAddRow [_name];
	_ctrl lnbSetPicture [[_foreachIndex,0], _icon];
	_ctrl lnbSetPictureColor [[_foreachIndex,0], [1,1,1,1]];
} foreach _list;

publicVariable "RSTF_FACTIONS";
