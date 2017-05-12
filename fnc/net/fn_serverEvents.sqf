// This receives map votes from clients
"RSTF_POINT_VOTE" addPublicVariableEventHandler {
	_this spawn {
		_index = _this select 1;
		RSTF_POINT_VOTES set [_index, (RSTF_POINT_VOTES select _index) + 1];
		publicVariable "RSTF_POINT_VOTES";
		call RSTF_fnc_updateBattles;
	};
};