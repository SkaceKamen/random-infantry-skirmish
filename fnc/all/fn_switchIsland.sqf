disableSerialization;
private ["_zero", "_script"];

MISSION_ROOT = str missionConfigFile select [0, count str missionConfigFile - 15];

_script = format["
[] spawn {
	RSTF_compile = compile(preprocessFileLineNumbers('%1compile.sqf'));
	['%1', true] call RSTF_compile;
}
", MISSION_ROOT];

// _script = "['" + MISSION_ROOT + "', true] spawn { " + RSTF_INIT + "; };";

/*
_i = 0;
while { _i < count _script } do {
	diag_log text(_script select [_i, 800]);
	_i = _i + 800;
};

diag_log (str(count _script) + "/" + str(count RSTF_INIT));
*/

playScriptedMission [_this, compile(_script), missionConfigFile, true];

/*(findDisplay 2) closeDisplay 1;
(findDisplay 26) closeDisplay 1;*/

_zero = findDisplay(0);
{
	if (_x != _zero) then {
		_x closeDisplay 1;
	};
} foreach allDisplays;

failMission "END1";