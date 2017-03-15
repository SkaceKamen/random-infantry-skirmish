private ["_display", "_ctrl", "_displayCtrl", "_ns", "_result", "_idc"];

disableSerialization;

_display = _this select 0;
_ctrl = _this select 1;
_ns = ["controls"];
if (count(_this) > 2) then {
	_ns = _this select 2;
};
if (typeName(_ns) != typeName([])) then {
	_ns = [_ns];
};

_config = missionConfigFile >> _display;
{
	_config = _config >> _x;
} foreach _ns;

_displayCtrl = _display call RSTF_getDisplay;
_idc = getNumber(_config >> _ctrl >> "idc");
_result = _displayCtrl displayCtrl _idc;

if (isNull(_result)) then {
	systemChat format["Failed to find %1/%2 (%3,%4,%5)", _display, _ctrl, _displayCtrl, _result, _idc];
	diag_log format["Failed to find %1/%2 (%3,%4,%5-%6)", _display, _ctrl, _displayCtrl, _result, _idc, typeName(_idc)];
	
};

_result;