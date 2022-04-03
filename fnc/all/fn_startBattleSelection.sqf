if (isServer && isMultiplayer) then {
	["Starting map tick at server"] call RSTF_fnc_Log;

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

			if (_voted == count(call BIS_fnc_listPlayers)) exitWith {
				[format["[RSTF] VOTING: All players voted (%1 / %2). Selecting battle.", _voted, count(call BIS_fnc_listPlayers)]] call RSTF_fnc_log;
			};

			[format["Timeout: %1", RSTF_VOTES_TIMEOUT]] call RSTF_fnc_Log;

			RSTF_VOTES_TIMEOUT = RSTF_VOTES_TIMEOUT - 1;
			sleep 1;
		};

		["Voting ended"] call RSTF_fnc_Log;

		if (hasInterface) then {
			closeDialog 0;
		};

		_max = [];
		_maxCount = -1;
		{
			_place = [];
			if (_foreachIndex == count(RSTF_POINTS)) then {
				_place = [["Custom", RSTF_CUSTOM_POINT], RSTF_CUSTOM_POINT_SPAWNS, RSTF_CUSTOM_DIRECTION, RSTF_CUSTOM_DISTANCE];
			} else {
				_place = RSTF_POINTS select _foreachIndex;
			};

			if (_x > _maxCount) then {
				_max = [_place];
				_maxCount = _x;
			};
			if (_x == _maxCount) then {
				_max pushBack (_place);
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
	["Showing battle selection"] call RSTF_fnc_Log;
	0 spawn RSTF_fnc_showBattleSelection;
};