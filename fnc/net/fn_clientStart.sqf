/*
	Author: Jan Zipek

	Description:
	Initializes client side stuff.
*/

{
	_x addPublicVariableEventHandler {
		systemChat format["%1 changed to %2", _this select 0, _this select 1];
	};
} foreach allVariables missionNamespace;

// Location of battle
"RSTF_POINT" addPublicVariableEventHandler {
	RSTF_POINT = _this select 1;
	0 spawn RSTF_fnc_onPointChanged;
};

// Marks start of mission
"RSTF_STARTED" addPublicVariableEventHandler {
	if (_this select 1) then {
		0 spawn RSTF_fnc_onStarted;
	};
};

// Updated when unit is assigned
"RSTF_ASSIGNED_UNITS" addPublicVariableEventHandler {
	_msg = _this select 1;

	if (_msg select 0 == player) then {
		(_msg select 1) spawn RSTF_fnc_assignPlayer;
	};
};

// UI Message about unit getting killed
"RSTF_KILL_OCCURED" addPublicVariableEventHandler {
	(_this select 1) spawn RSTF_fnc_onKill;
};

// Global score
"RSTF_SCORE" addPublicVariableEventHandler {
	RSTF_SCORE = _this select 1;
	0 spawn RSTF_fnc_onScore;
};

// List of possible battles
"RSTF_POINTS" addPublicVariableEventHandler {
	0 spawn RSTF_fnc_showBattleSelection;
};

// Current vote count
"RSTF_POINT_VOTES" addPublicVariableEventHandler {
	0 spawn RSTF_fnc_updateBattles;
};

if (count(RSTF_POINT) > 0) then {
	0 spawn RSTF_fnc_onPointChanged;
};

if (!RSTF_STARTED) then {
	0 spawn RSTF_fnc_showWaiting;
};
