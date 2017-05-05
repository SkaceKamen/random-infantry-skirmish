private ["_desc", "_score"];

_desc = _this select 0;
_score = _this select 1;

[format["+%2 <t color='#dddddd'>%1</t>", _desc, _score], 5] call RSTF_fnc_UI_AddMessage;
RSTF_SCORE set [SIDE_FRIENDLY, (RSTF_SCORE select SIDE_FRIENDLY) + _score];
[] spawn RSTF_fnc_scoreChanged;