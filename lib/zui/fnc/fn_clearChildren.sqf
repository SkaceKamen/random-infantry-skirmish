private _comp = param [0];
private _children = _comp#ZUI_L_CHILDREN;

{
	[_x] call ZUI_fnc_destroy;
} foreach _children;

_comp set [ZUI_L_CHILDREN, []];