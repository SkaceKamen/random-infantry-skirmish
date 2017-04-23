private ["_factionsCheck", "_limitCheck", "_validation", "_errors"];

_factionsCheck = '
	_list = [%1] call RSTF_fnc_loadSoldiers;
	if (count(_list select 0) == 0) exitWith {
		"%2 does not have any soldiers. Please select faction with soldiers."
	};
	true;
';
_limitCheck = '
	_ctrl = ["RSTF_RscDialogConfig", "%1", ["controls", "gameConfig", "controls"]] call RSTF_fnc_getCtrl;
	_limit = parseNumber(ctrlText _ctrl);
	if (_limit <= 0) exitWith {
		"%2 must be bigger than 0."
	};
	true;
';

_validation = [
	compile(format[_limitCheck, "scoreLimit", "Score limit"]),
	compile(format[_limitCheck, "groupsLimit", "Groups count"]),
	compile(format[_limitCheck, "unitsLimit", "Unit count"]),
	compile(format[_factionsCheck, FRIENDLY_FACTIONS, "Friendly side"]),
	compile(format[_factionsCheck, NEUTRAL_FACTIONS, "Netural side"]),
	compile(format[_factionsCheck, ENEMY_FACTIONS, "Enemy side"])
];

_errors = [];
{
	_result = call _x;
	if (typeName(_result) == typeName("")) then {
		_errors set [count(_errors), _result];
	};
} foreach _validation;

_errors;