_unit = _this select 0;
_killer = _this select 1;
_side = _unit getVariable ["SPAWNED_SIDE", civilian];
_vehicle = _unit getVariable ["RSTF_vehicle", objNull];

//Get killer side index
_index = -1;
if (side(_killer) == east) then {
	_index = SIDE_ENEMY;
};
if (side(_killer) == west) then {
	_index = SIDE_FRIENDLY;
};


if (isNull(gunner(_vehicle)) || !alive(gunner(_vehicle))) then {
	_vehicle setDamage 1;
	
	//Attribute score
	if (_index != -1) then {
		_score = (RSTF_SCORE select _index);
		_new = _score;
		if (side(_killer) == _side) then {
			_score = _score + RSTF_SCORE_PER_TEAMKILL;
		} else {
			_score = _score + RSTF_SCORE_PER_SHIP;
		};
		RSTF_SCORE set [_index, _score];
		
		[] spawn RSTF_fnc_scoreChanged;
	};
	
	//Show player hitn
	if (_killer == player) then {
		if (_side != side(player)) then {
			if (_side == civilian) then {
				["Civilan kill -500", 5] call RSTF_fnc_UI_AddMessage;
			} else {
				[format["Kill +%1", RSTF_SCORE_PER_SHIP], 5] call RSTF_fnc_UI_AddMessage;
			};
		} else {
			[format["Team kill -%1", RSTF_SCORE_PER_TEAMKILL], 5] call RSTF_fnc_UI_AddMessage;
		};
	};
};