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
		[_msg select 1] spawn RSTF_fnc_assignPlayer;
	};
};

// List of possible battles
"RSTF_POINTS" addPublicVariableEventHandler {
	0 spawn {
		closeDialog 0;
		0 spawn RSTF_fnc_showBattleSelection;
	};
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