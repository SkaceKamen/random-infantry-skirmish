private _layout = param [0];
private _id = param [1];
private _default = param [2, controlNull];
private _result = [_layout, _id, []] call ZUI_fnc_getComponentById;
if (count(_result) > 0) exitWith {
	_result#ZUI_L_CTRL;
};
_default;