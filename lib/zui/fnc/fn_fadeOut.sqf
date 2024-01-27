private _comp = param [0];
private _fadeTime = param [1, 1];

private _children = _comp#ZUI_L_CHILDREN;
private _ctrl = _comp#ZUI_L_CTRL;

if (!isNull(_ctrl)) then {
	_ctrl ctrlSetFade 1;
	_ctrl ctrlCommit _fadeTime;
};

{
	[_x, _fadeTime] call ZUI_fnc_fadeOut;
} foreach _children;