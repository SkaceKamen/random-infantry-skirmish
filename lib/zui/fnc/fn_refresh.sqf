private _comp = param [0];
private _parentWidth = param [1, objNull];
private _parentHeight = param [2, objNull];
private _xPos = param [3, objNull];
private _yPos = param [4, objNull];

// Use previous values, probably called by user
if (typeName(_parentWidth) != typeName(0)) then {
	_parentWidth = _comp#ZUI_L_SIZE#0;
	_parentHeight = _comp#ZUI_L_SIZE#1;
	_xPos = _comp#ZUI_L_POS#0;
	_yPos = _comp#ZUI_L_POS#1;
};

private _children = _comp select ZUI_L_CHILDREN;
private _ctrl = _comp select ZUI_L_CTRL;

// Load component type and margin
private _type = [_comp, "type"] call ZUI_fnc_getProp;
private _layout = [_comp, "layout"] call ZUI_fnc_getProp;
private _margin = [[_comp, "margin", true, 0] call ZUI_fnc_getProp] call ZUI_fnc_parseSizing;
private _position = [_comp, "position", true, ZUI_POSITION_RELATIVE] call ZUI_fnc_getProp;

//diag_log text("[RSTF] " + str([configName(_comp#ZUI_L_CONFIG), _xPos, _yPos, _parentWidth, _parentHeight, _margin]));
//diag_log text("[RSTF] Children: " + str(_children apply { configName (_x#ZUI_L_CONFIG) }));

if (_position == ZUI_POSITION_ABSOLUTE) then {
	_xPos = [[_comp, "x", true, 0] call ZUI_fnc_getProp] call ZUI_fnc_parseNumberProp;
	_yPos = [[_comp, "y", true, 0] call ZUI_fnc_getProp] call ZUI_fnc_parseNumberProp;
};

// Save the component values (could be used later when refreshing only part of the tree)
_comp set [ZUI_L_POS, [_xPos, _yPos]];
_comp set [ZUI_L_SIZE, [_parentWidth, _parentHeight]];

// Calculate the position and size when margin is applied
_xPos = _xPos + _margin#3;
_yPos = _yPos + _margin#0;
_parentWidth = _parentWidth - _margin#1 - _margin#3;
_parentHeight = _parentHeight - _margin#0 - _margin#2;

// When we have control, apply its position and size
if (!isNull(_ctrl)) then {
	if (ctrlType _ctrl == 100) then {
		_ctrl ctrlMapSetPosition [_xPos, _yPos, _parentWidth, _parentHeight];
	} else {
		_ctrl ctrlSetPosition [_xPos, _yPos, _parentWidth, _parentHeight];
		_ctrl ctrlCommit 0;
	};
	
	// diag_log text(format["[RSTF] ZUI - %1 - %2", _comp#ZUI_L_CONFIG, [[safeZoneX, safeZoneY, safeZoneW, safeZoneH], _xPos, _yPos, _parentWidth, _parentHeight]]);
};

private _scrollable = _type == ZUI_CONTAINER_ID && { ([_comp, "scrollable", true, 0] call ZUI_fnc_getProp) == 1 };

private _index = if (_layout == ZUI_LAYOUT_ROW) then { 0 } else { 1 };
private _otherIndex = if (_layout == ZUI_LAYOUT_ROW) then { 1 } else { 0 };

private _pos = [_xPos, _yPos];
if (_scrollable) then {
	_pos = [0, 0];
};

private _parentSize = if (_index == 0) then { _parentWidth } else { _parentHeight };
private _absoluteSize = if (_index == 0) then { _parentHeight } else { _parentWidth };
private _sizeConfigName = if (_index == 0) then { "width" } else { "height" };
private _sizeTypeConfigName = _sizeConfigName + "Type";
private _otherSizeConfigName = if (_index == 1) then { "width" } else { "height" };
private _otherSizeTypeConfigName = _otherSizeConfigName + "Type";

private _p = [[_comp, "padding", true, 0] call ZUI_fnc_getProp] call ZUI_fnc_parseSizing;
private _sizeP = [ (_p#1) + (_p#3), (_p#0) + (_p#2) ];

private _total = 0;
private _percentage = 0;

{
	private _otherSizeType = [_x, _otherSizeTypeConfigName, true, ZUI_SIZE_RELATIVE] call ZUI_fnc_getProp;
	private _otherSize = [[_x, _otherSizeConfigName, true, 0] call ZUI_fnc_getProp] call ZUI_fnc_parseNumberProp;
	private _sizeType = [_x, _sizeTypeConfigName, true, ZUI_SIZE_RELATIVE] call ZUI_fnc_getProp;
	private _size = [[_x, _sizeConfigName, true, 0] call ZUI_fnc_getProp] call ZUI_fnc_parseNumberProp;
	private _positionType = [_x, "position", true, ZUI_POSITION_RELATIVE] call ZUI_fnc_getProp;

	if (_positionType != ZUI_POSITION_ABSOLUTE) then {
		switch (_sizeType) do {
			case ZUI_SIZE_ABSOLUTE: {
				_parentSize = _parentSize - _size;
			};
			case ZUI_SIZE_TEXT: {
				_size = if (_index == 1) then { ctrlTextHeight (_x#ZUI_L_CTRL) } else { ctrlTextWidth (_x#ZUI_L_CTRL) };
				_parentSize = _parentSize - _size;
				diag_log _size;
			};
			case ZUI_SIZE_PERCENTS: {
				_percentage = _percentage + _size;
			};
			default {
				_total = _total + _size;
			};
		};
	};
} foreach _children;

{
	private _otherSizeType = [_x, _otherSizeTypeConfigName, true, ZUI_SIZE_RELATIVE] call ZUI_fnc_getProp;
	private _otherSize = [[_x, _otherSizeConfigName, true, 0] call ZUI_fnc_getProp] call ZUI_fnc_parseNumberProp;
	private _sizeType = [_x, _sizeTypeConfigName, true, ZUI_SIZE_RELATIVE] call ZUI_fnc_getProp;
	private _size = [[_x, _sizeConfigName, true, 0] call ZUI_fnc_getProp] call ZUI_fnc_parseNumberProp;
	private _positionType = [_x, "position", true, ZUI_POSITION_RELATIVE] call ZUI_fnc_getProp;

	switch (_sizeType) do {
		case ZUI_SIZE_ABSOLUTE: {};
		case ZUI_SIZE_TEXT: {
			_size = if (_index == 1) then { ctrlTextHeight (_x#ZUI_L_CTRL) } else { ctrlTextWidth (_x#ZUI_L_CTRL) };
			diag_log _size;
		};
		case ZUI_SIZE_PERCENTS: {
			_size = _size * _parentSize;
		};
		default {
			_size = if (_total == 0) then { 0 } else { (_size / _total) * (_parentSize * (1 - _percentage)) };
		};
	};

	private _params = [_x];
	_params set [1 + _index, _size - (_sizeP select _index)];

	if (_otherSizeType == ZUI_SIZE_ABSOLUTE) then {
		_params set [1 + _otherIndex, _otherSize];
	} else {
		_params set [1 + _otherIndex, _absoluteSize - (_sizeP select _otherIndex)];
	};

	_params set [3, _pos#0 + _p#3];
	_params set [4, _pos#1 + _p#0];

	_params call ZUI_fnc_refresh;

	if (_positionType != ZUI_POSITION_ABSOLUTE) then {
		_pos set [_index, _pos#_index + _size];
	};
} foreach _children;