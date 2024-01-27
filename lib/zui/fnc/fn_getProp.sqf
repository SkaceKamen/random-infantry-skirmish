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