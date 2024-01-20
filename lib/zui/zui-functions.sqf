#include "zui-defines.inc"

ZUI_fnc_loadComponent = {
	private _config = param [0, objNull, [missionConfigFile]];
	private _parent = param [1, []];

	private _children = [];
	private _ids = [ [], [] ];
	private _overrides = [ [], [] ];

	private _layout = [
		_config,
		_children,
		controlNull,
		displayNull,
		[0,0],
		[0,0],
		_ids,
		controlNull,
		_overrides
	];

	{
		private _component = [_x, _layout] call ZUI_fnc_loadComponent;
		private _childIds = _component select ZUI_L_IDS;

		_ids set [0, _ids#0 + _childIds#0];
		_ids set [1, _ids#1 + _childIds#1];

		_children pushBack _component;

		if (isText(_x >> "id")) then {
			_ids#0 pushBack getText(_x >> "id");
			_ids#1 pushBack _component;
		};
	} foreach ("true" configClasses _config);

	_layout;
};

ZUI_fnc_setOverride = {
	private _comp = param [0];
	private _prop = param [1];
	private _value = param [2];

	_comp#ZUI_L_OVERRIDES#0 pushBack _prop;
	_comp#ZUI_L_OVERRIDES#1 pushBack _value;
};

ZUI_fnc_build = {
	private _comp = param [0];
	private _display = param [1];
	private _parent = param [2, controlNull];

	private _config = _comp select ZUI_L_CONFIG;
	private _children = _comp select ZUI_L_CHILDREN;
	private _type = getText(_config >> "type");
	private _ctrl = controlNull;

	_comp set [ZUI_L_DISPLAY, _display];

	if (_type == ZUI_CONTROL_ID) then {
		private _class = getText(_config >> "control");
		_ctrl = _display ctrlCreate [_class, -2, _parent];

		[_ctrl, _config] call ZUI_fnc_applyControlProps;

	};

	if (_type == ZUI_CONTAINER_ID) then {
		if (isNumber(_config >> "scrollable") && { getNumber(_config >> "scrollable") == 1 }) then {
			_ctrl = _display ctrlCreate ["RscControlsGroup", -2, _parent];
			_parent = _ctrl;
		} else {
			if (isArray(_config >> "background")) then {
				_ctrl = _display ctrlCreate ["RscBackground", -2, _parent];
				[_ctrl, _config] call ZUI_fnc_applyControlProps;
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
		[_x, _display, _parent] call ZUI_fnc_build;
	} foreach _children;
};

ZUI_fnc_applyControlProps = {
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
};

ZUI_fnc_parseNumberProp = {
	private _prop = param [0];
	if (typeName(_prop) == typeName("")) exitWith {
		call compile _prop;
	};
	_prop;
};

ZUI_fnc_getProp = {
	private _comp = param [0];
	private _prop = param [1];
	private _overridable = param [2, true];
	private _default = param [3, objNull];

	if (_overridable) then {
		private _index = _comp#ZUI_L_OVERRIDES#0 find _prop;
		if (_index >= 0) exitWith {
			_comp#ZUI_L_OVERRIDES#1#_index;
		};
	};

	private _value = _comp#ZUI_L_CONFIG >> _prop;

	if (isArray(_value)) exitWith {
		getArray(_value);
	};

	if (isText(_value)) exitWith {
		getText(_value);
	};

	if (isNumber(_value)) exitWith {
		getNumber(_value);
	};

	_default;
};

ZUI_fnc_refresh = {
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
};

ZUI_fnc_createChild = {
	private _parent = param [0];
	private _child = [param [1]] call ZUI_fnc_loadComponent;
	private _refresh = param [2, true];

	private _display = _parent#ZUI_L_DISPLAY;

	// Add child to list of parent children
	_parent#ZUI_L_CHILDREN pushBack _child;

	// Build control for the child
	[_child, _display, _parent#ZUI_L_PARENTGROUP] call ZUI_fnc_build;

	// Refresh sizing of all children in parent to fit the new child
	if (_refresh) then {
		[_parent] call ZUI_fnc_refresh;
	};

	_child;
};

ZUI_fnc_setVisible = {
	private _comp = param [0];
	private _visible = param [1, true];

	private _children = _comp#ZUI_L_CHILDREN;
	private _ctrl = _comp#ZUI_L_CTRL;

	if (!isNull(_ctrl)) then {
		_ctrl ctrlShow _visible;
	};

	{
		[_x, _visible] call ZUI_fnc_setVisible;
	} foreach _children;
};

ZUI_fnc_fadeIn = {
	private _comp = param [0];
	private _fadeTime = param [1, 1];

	private _children = _comp#ZUI_L_CHILDREN;
	private _ctrl = _comp#ZUI_L_CTRL;

	if (!isNull(_ctrl)) then {
		_ctrl ctrlSetFade 1;
		_ctrl ctrlCommit 0;
		_ctrl ctrlSetFade 0;
		_ctrl ctrlCommit _fadeTime;
	};

	{
		[_x, _fadeTime] call ZUI_fnc_fadeIn;
	} foreach _children;
};


ZUI_fnc_fadeOut = {
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
};

ZUI_fnc_parseSizing = {
	private _config = param [0];
	private _result = [];

	if (typeName(_config) == "ARRAY") then {
		_result = _config;
		if (count(_result) == 2) then {
			_result = [_result#0, _result#1, _result#0, _result#1];
		};
	} else {
		private _p = _config;
		_result = [ _p, _p, _p, _p ];
	};

	[
		[_result#0] call ZUI_fnc_parseNumberProp,
		([_result#1] call ZUI_fnc_parseNumberProp) * (pixelW / pixelH),
		[_result#2] call ZUI_fnc_parseNumberProp,
		([_result#3] call ZUI_fnc_parseNumberProp) * (pixelW / pixelH)
	];
};

ZUI_fnc_createDisplay = {
	private _layout = param [0];
	private _display = param [1, displayNull];

	if (isNull(_display)) then {
  		_display = (findDisplay 46) createDisplay "RscDisplayEmpty";
	};

	_layout = [_layout] call ZUI_fnc_loadComponent;

	[_layout, _display] call ZUI_fnc_build;
	[_layout, safeZoneW, safeZoneH, safeZoneX, safeZoneY] call ZUI_fnc_refresh;

	_layout;
};

ZUI_fnc_closeDisplay = {
	private _comp = param [0];
	private _exitCode = param [1, 0];
	(_comp#ZUI_L_DISPLAY) closeDisplay _exitCode;
};

ZUI_fnc_clearChildren = {
	private _comp = param [0];
	private _children = _comp#ZUI_L_CHILDREN;

	{
		[_x] call ZUI_fnc_destroy;
	} foreach _children;

	_comp set [ZUI_L_CHILDREN, []];
};

ZUI_fnc_destroy = {
	private _comp = param [0];
	private _children = _comp#ZUI_L_CHILDREN;
	private _ctrl = _comp#ZUI_L_CTRL;

	{
		[_x] call ZUI_fnc_destroy;
	} foreach _children;

	if (!isNull(_ctrl)) then {
		ctrlDelete _ctrl;
	};
};

ZUI_fnc_getComponentById = {
	private _layout = param [0];
	private _id = param [1];
	private _default = param [2, []];
	private _ids = _layout select ZUI_L_IDS;
	private _index = _ids#0 find _id;
	if (_index >= 0) exitWith {
		(_ids#1 select _index);
	};
	_default;
};

ZUI_fnc_getControlById = {
	private _layout = param [0];
	private _id = param [1];
	private _default = param [2, controlNull];
	private _result = [_layout, _id, []] call ZUI_fnc_getComponentById;
	if (count(_result) > 0) exitWith {
		_result#ZUI_L_CTRL;
	};
	_default;
};

ZUI_fnc_control = {
	(param [0])#ZUI_L_CTRL;
};

ZUI_fnc_display = {
	(param [0])#ZUI_L_DISPLAY;
};

ZUI_fnc_fitTextHeight = {
	private _comp = param [0];
	private _ctrl = _comp#ZUI_L_CTRL;
	private _height = ctrlTextHeight _ctrl;
	private _old = ctrlPosition _ctrl;
	_old set [3, _height];
	_ctrl ctrlSetPosition _old;
	_ctrl ctrlCommit 0;
};

ZUI_fnc_on = {
	private _layout = param [0];
	private _id = param [1];
	private _event = param [2];
	private _handler = param [3];

	([_layout, _id] call ZUI_fnc_getControlById) ctrlAddEventHandler [_event, _handler];
};

/*
ZUI_fnc_getControl = {
	private _layout = param [0];
	private _path = param [1];

	{
		private _name = _x;
		private _found = [];
		{
			if (configName(_x select 0) == _name) exitWith {
				_found = _x;
			};
		} foreach (_layout select 1);

		if (count(_found) > 0) then {
			_layout = _found;
		};

		if (count(_layout) == 0) exitWith {
			[];
		};
	} foreach _path;

	_layout select 2;
};
*/
