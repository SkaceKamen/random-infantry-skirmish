private _comp = param [0];
private _display = param [1];
private _parent = param [2, controlNull];
private _faded = param [3, false];

private _config = _comp select ZUI_L_CONFIG;
private _children = _comp select ZUI_L_CHILDREN;
private _type = getText(_config >> "type");
private _ctrl = controlNull;

_comp set [ZUI_L_DISPLAY, _display];

if (_type == ZUI_CONTROL_ID) then {
	private _class = getText(_config >> "control");
	_ctrl = _display ctrlCreate [_class, -2, _parent];
	if (_faded) then {
		_ctrl ctrlSetFade 1;
		_ctrl ctrlCommit 0;
	};

	[_ctrl, _config] call ZUI_fnc_applyControlProps;

};

if (_type == ZUI_CONTAINER_ID) then {
	if (isNumber(_config >> "scrollable") && { getNumber(_config >> "scrollable") == 1 }) then {
		_ctrl = _display ctrlCreate ["RscControlsGroup", -2, _parent];
		if (_faded) then {
			_ctrl ctrlSetFade 1;
			_ctrl ctrlCommit 0;
		};
		_parent = _ctrl;
	} else {
		if (isArray(_config >> "background")) then {
			_ctrl = _display ctrlCreate ["RscBackground", -2, _parent];
			[_ctrl, _config] call ZUI_fnc_applyControlProps;
			if (_faded) then {
				_ctrl ctrlSetFade 1;
				_ctrl ctrlCommit 0;
			};
		};
	};
};

/*
if (!isNull(_ctrl) && ctrlType _ctrl != CT_STRUCTURED_TEXT) then {
	_ctrl ctrlSetPosition [0, 0, 0, 0];
	_ctrl ctrlCommit 0;
};
*/

_comp set [ZUI_L_PARENTGROUP, _parent];
_comp set [ZUI_L_CTRL, _ctrl];

{
	[_x, _display, _parent, _faded] call ZUI_fnc_build;
} foreach _children;