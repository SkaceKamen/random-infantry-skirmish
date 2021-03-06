disableSerialization;

private _display = _this select 0;
private _ctrl = _this select 1;
private _ns = ["controls"];
if (count(_this) > 2) then {
	_ns = _this select 2;
};
if (typeName(_ns) != typeName([])) then {
	_ns = [_ns];
};

private _config = missionConfigFile >> _display;
{
	_config = _config >> _x;
} foreach _ns;

private _displayCtrl = _display call RSTF_fnc_getDisplay;
private _idc = getNumber(_config >> _ctrl >> "idc");
private _result = _displayCtrl displayCtrl _idc;

if (isNull(_result)) then {
	systemChat format["Failed to find %1/%2 (%3,%4,%5)", _display, _ctrl, _displayCtrl, _result, _idc];
	diag_log text(format["getCtrl: Failed to find %1/%2 (%3,%4,%5-%6)", _display, _ctrl, _displayCtrl, _result, _idc, typeName(_idc)]);
};

_result;