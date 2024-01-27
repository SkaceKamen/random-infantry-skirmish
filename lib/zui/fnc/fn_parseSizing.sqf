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