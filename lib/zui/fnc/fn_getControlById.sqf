private _layout = param [0];
private _id = param [1];
private _default = param [2, controlNull];
private _result = [_layout, _id, []] call ZUI_fnc_getComponentById;
if (count(_result) > 0) exitWith {
	_result#ZUI_L_CTRL;
};

if (RSTF_DEBUG) then {
	format["Failed to find %1 in %2", _id, configName(_layout#ZUI_L_CONFIG)] call RSTF_fnc_dbg;
};

_default;
