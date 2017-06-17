/*
	Author: Jan Zipek

	Description:
	Assigns client specific event handlers.
*/

if (RSTF_SHOW_CONFIG != -1) then {
	if (RSTF_SHOW_CONFIG == clientOwner) then {
		0 spawn RSTF_fnc_showConfig;
	};
};

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
	closeDialog 0;
	0 spawn RSTF_fnc_showBattleSelection;
};

// Current vote count
"RSTF_POINT_VOTES" addPublicVariableEventHandler {
	0 spawn RSTF_fnc_updateBattles;
};

"RSTF_VOTES_TIMEOUT" addPublicVariableEventHandler {
	0 spawn RSTF_fnc_updateVoteTimeout;
};

"RSTF_SHOW_CONFIG" addPublicVariableEventHandler {
	if (_this select 1 == clientOwner) then {
		0 spawn RSTF_fnc_showConfig;
	};
};