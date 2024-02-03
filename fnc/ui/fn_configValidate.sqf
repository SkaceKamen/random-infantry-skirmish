private ["_factionsCheck", "_limitCheck", "_validation", "_errors"];

_factionsCheck = '
	_list = [%1] call RSTF_fnc_loadSoldiers;
	if (count(_list select 0) == 0) exitWith {
		"%2 does not have any soldiers. Please select faction with soldiers."
	};
	true;
';
_limitCheck = '
	_limit = %1;
	if (_limit <= 0) exitWith {
		"%2 must be bigger than 0."
	};
	true;
';

_validation = [
	compile(format[_limitCheck, "RSTF_SCORE_LIMIT", "Score limit"]),
	compile(format[_limitCheck, "RSTF_LIMIT_GROUPS", "Groups count"]),
	compile(format[_limitCheck, "RSTF_LIMIT_UNITS", "Unit count"]),
	compile(format[_factionsCheck, FRIENDLY_FACTIONS, "Friendly side"]),
	compile(format[_factionsCheck, ENEMY_FACTIONS, "Enemy side"])
];

_errors = [];
{
	_result = call _x;
	if (typeName(_result) == typeName("")) then {
		_errors pushBack _result;
	};
} foreach _validation;

if (call RSTF_fnc_getModeId == 'GunGame') then {
	if (!RSTF_MODE_GUN_GAME_RANDOMIZED && { isClass (configFile >> "CfgWeapons" >> _x) } count RSTF_MODE_GUN_GAME_CUSTOM_WEAPONS == 0) then {
		_errors pushBack "No custom weapons defined for Gun Game mode.";
	};
};

_errors;