private _side = _this;
private _grps = RSTF_GROUPS select _side;
private _spawn = objNull;
private _usable = {
	alive(_this) && !(_this getVariable ["USED", false])
};

private _groupsWithoutPlayer = _grps select {
	units(_x) findIf { isPlayer(_x) && _x != player } == -1
};

if (isNil("RSTF_DEATH_POSITION")) then {
	RSTF_DEATH_POSITION = RSTF_POINT;
};
if (isNil("RSTF_DEATH_GROUP")) then {
	RSTF_DEATH_GROUP = grpNull;
};

switch(RSTF_SPAWN_TYPE) do {
	case RSTF_SPAWN_CLOSEST: {
		_closestDistance = 0;
		{
			{
				_grp = _x;
				{
					if (_x call _usable) then {
						_dis = _x distance RSTF_DEATH_POSITION;
						if (isNull(_spawn) || _dis < _closestDistance) then {
							_spawn = _x;
							_closestDistance = _dis;
						};
					};
				} foreach units(_grp);
			} foreach _x;

			if (!isNull(_spawn)) exitWith {};
		} foreach [_groupsWithoutPlayer, _grps];
	};

	case RSTF_SPAWN_GROUP: {
		private _groupsToTry = _groupsWithoutPlayer + _grps;

		_grp = RSTF_DEATH_GROUP;
		_index = 0;
		while { _index < count(_groupsToTry) } do {
			if (!isNull(_grp) && leader(_grp) call _usable) exitWith {
				_spawn = leader(_grp);
			};

			{
				if (_x call _usable) exitWith {
					_spawn = _x;
				};
			} foreach units(_grp);

			if (!isNull(_spawn)) exitWith { };

			_grp = _groupsToTry select _index;
			_index = _index + 1;
		};
	};

	case RSTF_SPAWN_RANDOM: {
		{
			_x = _x call RSTF_fnc_arrayShuffle;
			{
				_grp = _x;
				{
					if (_x call _usable) exitWith {
						_spawn = _x;
					};
				} foreach units(_grp);
				if (!isNull(_spawn)) exitWith {};
			} foreach _x;

			if (!isNull(_spawn)) exitWith {};
		} foreach [_groupsWithoutPlayer, _grps];
	};
};

if (isNull(_spawn)) exitWith {
	systemChat "Noone alive. Waiting for reinforcements.";
	sleep 1;
	_this spawn RSTF_fnc_spawnPlayer;
};

_spawn spawn RSTF_fnc_assignPlayer;