RSTF_MODE_FRONTLINE_points = 10;
RSTF_MODE_FRONTLINE_size = 200;
RSTF_MODE_FRONTLINE_loop = {
	_center = RSTF_POINT;
	_radius = (RSTF_MODE_FRONTLINE_size/RSTF_MODE_FRONTLINE_points)/2;
	_advance = true;
	_distance = [ 0, 0 ];

	while { _advance } do {
		for [{_i = 0}, {_i <= RSTF_MODE_FRONTLINE_points}, {_i = _i + 1}] do {
			_cindex = -RSTF_MODE_FRONTLINE_points/2 + _i;
			_distance set [0, _cindex * _radius];
			_position = _center vectorAdd [
				sin(RSTF_DIRECTION) * (_distance select 0) + sin(RSTF_DIRECTION + 90) * (_distance select 1),
				cos(RSTF_DIRECTION) * (_distance select 0) + cos(RSTF_DIRECTION + 90) * (_distance select 1),
				0
			];

			_presence = [ 0, 0, 0 ];
			_entities = _position nearObjects _radius;
			{
				if (alive(_x)) then {
					_index = -1;

					if (_x isKindOf "Man") then {
						if (side(_x) == east) then {
							_index = SIDE_ENEMY;
						};
						if (side(_x) == resistance) then {
							_index = SIDE_NEUTRAL;
						};
					} else {
						{
							if (side(_x) == east) exitWith {
								_index = SIDE_ENEMY;
							};
							if (side(_x) == resistance) exitWith {
								_index = SIDE_NEUTRAL;
							};
						} foreach crew(_x);
					};

					if (_index != -1) then {
						_presence set [_index, (_presence select _index) + 1];
					};
				};
			} foreach _entities;

			if (_presence select SIDE_FRIENDLY == 0 && _presence select SIDE_ENEMY == 0) then {
				
			};

			// Advance the line forward if friendly
			if (_presence select SIDE_FRIENDLY > _presence select SIDE_ENEMY) then {
				_distance set [1, (_distance select 1) + _radius];
			};

			// Advance line backwards if enemy
			if (_presence select SIDE_FRIENDLY < _presence select SIDE_ENEMY) then {
				_distance set [1, (_distance select 1) - _radius];
			};
		};
	};
};