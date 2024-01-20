private _side = _this;
private _grps = RSTF_GROUPS select _side;
private _spawn = objNull;
private _usable = {
	alive(_x) && !(_x getVariable ["USED", false])
};

switch(RSTF_SPAWN_TYPE) do {
	case RSTF_SPAWN_CLOSEST: {
		_closestDistance = 0;
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
		} foreach _grps;
	};
	case RSTF_SPAWN_GROUP: {
		_grp = RSTF_DEATH_GROUP;
		_index = 0;
		while { _index < count(_grps) } do {
			if (leader(_grp) call _usable) exitWith {
				_spawn = leader(_grp);
			};

			{
				if (_x call _usable) exitWith {
					_spawn = _x;
				};
			} foreach units(_grp);

			if (!isNull(_spawn)) exitWith { };

			_grp = _grps select _index;
			_index = _index + 1;
		};
	};
	case RSTF_SPAWN_RANDOM: {
		_grps = _grps call RSTF_fnc_arrayShuffle;
		{
			_grp = _x;
			{
				if (_x call _usable) exitWith {
					_spawn = _x;
				};
			} foreach units(_grp);
			if (!isNull(_spawn)) exitWith {};
		} foreach _grps;
	};
};

if (isNull(_spawn)) exitWith {
	systemChat "Noone alive. Waiting for reinforcements.";
	sleep 1;
	_this spawn RSTF_fnc_spawnPlayer;
};

_spawn spawn RSTF_fnc_assignPlayer;