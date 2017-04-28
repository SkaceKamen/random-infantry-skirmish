/*
	Author: Jan Zipek

	Description:
	Initializes client side stuff.
*/

// Location of battle
"RSTF_POINT" addPublicVariableEventHandler {
	RSTF_POINT = _this select 1;
	call RSTF_fnc_onPointChanged;
};

// Marks start of mission
"RSTF_STARTED" addPublicVariableEventHandler {
	if (_this select 1) then {
		call RSTF_fnc_onStarted;
	};
};

// Updated when unit is assigned
"RSTF_ASSIGNED_UNITS" addPublicVariableEventHandler {
	{
		if (_x select 0 == player) then {
			(_x select 1) call RSTF_fnc_assignPlayer;
		};
	} foreach (_this select 1);
};

// UI Message about unit getting killed
"RSTF_KILL_OCCURED" addPublicVariableEventHandler {
	(_x select 1) call RSTF_fnc_onKill;
};