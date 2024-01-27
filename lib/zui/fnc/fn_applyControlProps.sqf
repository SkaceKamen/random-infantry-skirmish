private _ctrl = param [0];
private _config = param [1];

if (isText(_config >> "text")) then {
	_ctrl ctrlSetText getText(_config >> "text");
};

if (isText(_config >> "tooltip")) then {
	_ctrl ctrlSetTooltip getText(_config >> "tooltip");
};

if (isArray(_config >> "background")) then {
	private _b = getArray(_config >> "background");
	{
		_b set [_foreachIndex, if (typeName(_x) == typeName(0)) then { _x } else { call compile _x }];
	} foreach _b;
	_ctrl ctrlSetBackgroundColor _b;
};

if (isText(_config >> "onClick")) then {
	_ctrl ctrlAddEventHandler ["ButtonClick", getText(_config >> "onClick")]
};

if (isArray(_config >> "columns")) then {
	// Remove previous columns
	private _columns = lnbGetColumnsPosition _ctrl;
	for [{_i = 0}, {_i < count(_columns)}, {_i = _i + 1}] do {
		_ctrl lnbdeletecolumn 0;
	};

	// Create new columns
	{
		_ctrl lnbAddColumn _x;
	} foreach getArray(_config >> "columns");
};

if (isNumber(_config >> "textSize")) then {
	_ctrl ctrlSetFontHeight getNumber(_config >> "textSize");
};

if (isText(_config >> "textSize")) then {
	_ctrl ctrlSetFontHeight (call compile(getText(_config >> "textSize")));
};

if (isText(_config >> "font")) then {
	_ctrl ctrlSetFont getText(_config >> "font");
};

if (isText(_config >> "fontSecondary")) then {
	_ctrl ctrlSetFontSecondary getText(_config >> "fontSecondary");
};

if (isNumber(_config >> "shadow")) then {
	_ctrl ctrlSetShadow getNumber(_config >> "shadow");
};