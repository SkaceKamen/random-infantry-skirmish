_ctrl = _this select 0;
_list = _this select 1;

_updated = [];
{
	if (RSTF_FACTIONS find _x != -1) then {
		_updated pushBack _x;
	}

} foreach _list;

_list = _updated;

_ctrl = ["RSTF_RscDialogConfig", "factions", ["controls", _ctrl, "controls"]] call RSTF_fnc_getCtrl;
lnbClear _ctrl;
{
	_name = getText(ConfigFile >> "cfgFactionClasses" >> _x >> "displayName") + " (" + _x + ")";
	_icon = getText(ConfigFile >> "cfgFactionClasses" >> _x >> "icon");

	_ctrl lnbAddRow [_name];
	_ctrl lnbSetPicture [[_foreachIndex,0], _icon];
	_ctrl lnbSetPictureColor [[_foreachIndex,0], [1,1,1,1]];
} foreach _list;

publicVariable "RSTF_FACTIONS";