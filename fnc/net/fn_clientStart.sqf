/*
	Author: Jan Zipek

	Description:
	Initializes client side stuff.
*/

waitUntil { time > 0 && alive(player) };


0 spawn {
	while { true } do {
		systemChat str(RSTF_STARTED);
		sleep 1;
	};
};

{
	_x addPublicVariableEventHandler {
		systemChat format["%1 changed to %2", _this select 0, _this select 1];
	}
} foreach allVariables missionNamespace;

// Location of battle
"RSTF_POINT" addPublicVariableEventHandler {
	RSTF_POINT = _this select 1;
	[] spawn RSTF_fnc_onPointChanged;
};

// Marks start of mission
"RSTF_STARTED" addPublicVariableEventHandler {
	if (_this select 1) then {
		[] spawn RSTF_fnc_onStarted;
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
	[] spawn RSTF_fnc_onScore;
};
