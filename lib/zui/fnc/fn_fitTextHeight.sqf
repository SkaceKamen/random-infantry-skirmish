private _comp = param [0];
private _ctrl = _comp#ZUI_L_CTRL;
private _height = ctrlTextHeight _ctrl;
private _old = ctrlPosition _ctrl;
_old set [3, _height];
_ctrl ctrlSetPosition _old;
_ctrl ctrlCommit 0;