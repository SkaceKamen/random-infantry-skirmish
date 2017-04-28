_killed = _this select 0;
_killer = _this select 1;

//Side is forgotten shortly after dying for some reason
_side = _killed getVariable ["SPAWNED_SIDE", civilian];

//Get killer side index
_index = -1;
if (side(_killer) == east) then {
	_index = SIDE_ENEMY;
};
if (side(_killer) == west) then {
	_index = SIDE_FRIENDLY;
};

//Attribute score
if (_index != -1) then {
	_score = (RSTF_SCORE select _index);
	_new = _score;
	if (side(_killer) == _side) then {
		_score = _score + RSTF_SCORE_PER_TEAMKILL;
	} else {
		_score = _score + RSTF_SCORE_PER_KILL;
	};
	RSTF_SCORE set [_index, _score];
	
	[] spawn RSTF_fnc_scoreChanged;
};

// Broadcast kill info, making it appear on UI for all players
RSTF_KILL_OCCURED = [_killed, _killer, _side];
publicVariable "RSTF_KILL_OCCURED";

if (!isDedicated) then {
	RSTF_KILL_OCCURED call RSTF_fnc_onKill;
};


if (RSTF_CLEAN) then {
	_killed spawn {
		sleep RSTF_CLEAN_INTERVAL;
		deleteVehicle _this;
	};
};