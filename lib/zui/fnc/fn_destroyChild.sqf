private _layout = param [0];
private _comp = param [1];

if (typeName _comp == "STRING") then {
	_comp = [_layout, _comp] call ZUI_fnc_getComponentById;
};

private _children = _comp#ZUI_L_CHILDREN;
private _ctrl = _comp#ZUI_L_CTRL;

{
	[_x] call ZUI_fnc_destroy;
} foreach _children;

if (!isNull(_ctrl)) then {
	ctrlDelete _ctrl;
};

private _toScan = _layout#ZUI_L_CHILDREN;
for [{_i = 0},{_i < count _toScan},{_i = _i + 1}] do {
	private _item = _toScan select _i;
	private _children = _item#ZUI_L_CHILDREN;
	private _index = _children find _comp;
	if (_index > -1) then {
		_children deleteAt _index;
		break;
	} else {
		_toScan = _toScan + _children;
	};
};
