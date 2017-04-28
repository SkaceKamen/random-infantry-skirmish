private ["_display"];
disableSerialization;

_display = findDisplay getNumber(missionConfigFile >> _this >> "idd");
if (isNull(_display)) then {
	systemChat format["Failed to find %1", _this];
	diag_log text(format["getDisplay: Failed to find %1", _this]);
};

_display;