if (isServer && isMultiplayer) then {
	// This manages voting on server
	0 spawn {
		RSTF_VOTES_TIMEOUT = RSTF_MAP_VOTE_TIMEOUT;
		while { RSTF_VOTES_TIMEOUT >= 0 } do {
			publicVariable "RSTF_VOTES_TIMEOUT";
			if (!isDedicated) then { 0 call RSTF_fnc_updateVoteTimeout; };
			
			_voted = 0;
			{
				_voted = _voted + _x;
			} foreach RSTF_POINT_VOTES;

			if (_voted == count(allPlayers)) exitWith {
				diag_log text("VOTING: All players voted. Selecting battle.");
			};

			RSTF_VOTES_TIMEOUT = RSTF_VOTES_TIMEOUT - 1;
			sleep 1;
		};

		closeDialog 0;

		_max = [];
		_maxCount = -1;
		{
			if (_x > _maxCount) then {
				_max = [RSTF_POINTS select _foreachIndex];
				_maxCount = _x;
			};
			if (_x == _maxCount) then {
				_max pushBack (RSTF_POINTS select _foreachIndex);
			};
		} foreach RSTF_POINT_VOTES;

		if (count(_max) == 0) then {
			_max = RSTF_POINTS;
		};

		(selectRandom(_max)) call RSTF_fnc_assignPoint;
		0 spawn RSTF_fnc_start;
	};

	publicVariable "RSTF_POINT_VOTES";
	publicVariable "RSTF_POINTS";
};

if (!isDedicated) then {
	0 spawn RSTF_fnc_showBattleSelection;
};