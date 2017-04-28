/*
	Author: Jan Zipek

	Description:
	Called when kill occured

	Parameter(s):
	0: OBJECT - killed unit
	1: OBJECT - killer
	2: SIDE - side of killed unit (this info can get lost when unit is killed, so better send it separatedly)
*/

private _killed = _this select 0;
private _killer = _this select 1;
private _side = _this select 2;

//Show player hitn
if (_killer == player) then {
	if (_side != side(player)) then {
		if (_side == civilian) then {
			["Civilan kill -500", 5] call RSTF_fnc_UI_AddMessage;
		} else {
			[format["Kill +%1", RSTF_SCORE_PER_KILL], 5] call RSTF_fnc_UI_AddMessage;
		};
	} else {
		[format["Team kill -%1", RSTF_SCORE_PER_TEAMKILL], 5] call RSTF_fnc_UI_AddMessage;
	};
};