private _comp = param [0];
private _children = _comp#ZUI_L_CHILDREN;
private _ctrl = _comp#ZUI_L_CTRL;

{
	[_x] call ZUI_fnc_destroy;
} foreach _children;

if (!isNull(_ctrl)) then {
	ctrlDelete _ctrl;
};