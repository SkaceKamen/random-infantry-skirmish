RSTF_TASK_RESCUE_isAvailable = {
	true;
};

RSTF_TASK_RESCUE_start = {
	_position = [];
	_unit = objNull;

	/*
		OPTIONS:
			1. Spawn guy inside car
				+ spawn guys around car
				+ destroy tire or something
				! need to correctly choose location (close to enemies, not too far / close from player, on road)
				
			2. Spawn guy inside house
				+ spawn guys inside house
				! need to correctly choose house (not too far / close from player, musn't be occupied by neutrals)
	*/
	
	_type = round(random(1))
	if (_type == 0) then {
		// Find usable houses
		_houses = nearestObjects [RSTF_POINT, ["House"], RSTF_NEUTRALS_RADIUS];
		_usable = [];
		{
			_positions = []; _i = 0;
			while { (_x buildingPos _i) distance [0,0,0] > 0 } do
			{
				_positions set [count(_positions), [_i,_x buildingPos _i]];
				_i = _i + 1;
			};

			if (count(_positions) >= 4 && !(typeOf(_x) in RSTF_BANNED_BUILDINGS)) then
			{
				_found = false;
				{
					if (_x select 0 == _x) exitWith {
						_found = true;
					};
				} foreach RSRF_NEUTRAL_HOUSES;
			
				if (!_found) then {
					_usable set [count(_usable), [_x, _positions]];
				};
			};
		} foreach _houses;
		
		// Switch to different task if no houses are suitable
		if (count(_usable) == 0) then {
			_type = 1;
		} else {
			_house = _usable call BIS_fnc_selectRandom;

			_vip = RSTF_MEN select SIDE_FRIENDLY;
		};
	};

	if (_type == 1) then {

	};

	RSTF_TASK = [
		side(player), ["sideTask"],
		["Save this guy, please","Rescue VIP",""],
		_position,
		"ASSIGNED"
	] call BIS_fnc_taskCreate;
};