private _comp = param [0];
private _visible = param [1, true];

private _children = _comp#ZUI_L_CHILDREN;
private _ctrl = _comp#ZUI_L_CTRL;

_comp set [ZUI_L_VISIBLE, _visible];

if (!isNull(_ctrl)) then {
	_ctrl ctrlShow _visible;
};

{
	[_x, _visible] call ZUI_fnc_setVisible;
} foreach _children;