if (isServer && isMultiplayer) then {
	// This receives votes from clients
	"RSTF_POINT_VOTE" addPublicVariableEventHandler {
		_this spawn {
			_index = _this select 1;
			RSTF_POINT_VOTES set [_index, (RSTF_POINT_VOTES select _index) + 1];
			publicVariable "RSTF_POINT_VOTES";
			call RSTF_fnc_updateBattles;
		};
	};

	// This manages voting on server
	0 spawn {
		_timeout = RSTF_MAP_VOTE_TIMEOUT;
		while { _timeout >= 0 } do {
			_voted = 0;
			{
				_voted = _voted + _x;
			} foreach RSTF_POINT_VOTES;

			if (_voted == count(allPlayers)) exitWith {};

			_timeout = _timeout - 1;
			sleep 1;
		};

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
};

if (!isDedicated) then {
	0 spawn RSTF_fnc_showBattleSelection;
};