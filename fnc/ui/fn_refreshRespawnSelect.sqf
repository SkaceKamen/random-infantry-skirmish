private _unitsList = [];

{
	private _grp = _x;
	private _aliveUnits = (units _grp) select { alive _x && !(isPlayer _x)};
	{
		_unitsList pushBack _x;
	} forEach _aliveUnits;
} forEach RSTF_GROUPS#RSTF_CURRENT_SIDE_INDEX;

_unitsList = [_unitsList, [], { _x distance2D RSTF_RESPAWN_SELECT_CENTER }, "ASCEND"] call BIS_fnc_sortBy;
RSTF_RESPAWN_SELECT_UNITS = _unitsList;

private _listCtrl = [RSTF_RESPAWN_SELECT_layout, "list"] call ZUI_fnc_getControlById;
lnbClear _listCtrl;
{
	private _unit = _x;
	private _unitType = typeOf _unit;
	private _unitClass = configFile >> "CfgVehicles" >> _unitType;
	private _factionClass = configFile >> "CfgFactionClasses" >> (getText(_unitClass >> "faction"));
	private _typeName = getText (_unitClass >> "displayName");
	private _faction = getText (_factionClass >> "displayName");
	private _factionIcon = getText (_factionClass >> "icon");
	private _distance =  _x distance2D RSTF_RESPAWN_SELECT_CENTER;

	private _row = _listCtrl lnbAddRow [_typeName, _faction, str(round(_distance)) + "m"];
	_listCtrl lnbSetPicture [[_row, 1], _factionIcon];
} forEach _unitsList;

_listCtrl lnbSetCurSelRow 0;