// This receives map votes from clients
"RSTF_POINT_VOTE" addPublicVariableEventHandler {
	_this spawn {
		_index = _this select 1;
		RSTF_POINT_VOTES set [_index, (RSTF_POINT_VOTES select _index) + 1];
		publicVariable "RSTF_POINT_VOTES";
		call RSTF_fnc_updateBattles;
	};
};

// Admin closed config dialog
"RSTF_CONFIG_DONE" addPublicVariableEventHandler {
	_this spawn {
		if (RSTF_MAP_VOTE) then {
			0 spawn RSTF_fnc_startBattleSelection;
		} else {
			(RSTF_POINTS select 0) call RSTF_fnc_assignPoint;
			0 spawn RSTF_fnc_start;
		}
	};
};

addMissionEventHandler ["PlayerConnected", {
	if (admin (_this select 4) > 0 && RSTF_SHOW_CONFIG == -1) then {
		RSTF_SHOW_CONFIG = (_this select 4);
		publicVariable "RSTF_SHOW_CONFIG";
	};
}];