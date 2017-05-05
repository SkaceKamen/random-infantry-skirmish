
_attempts = 0;
RSTF_WATER = true;

while {RSTF_WATER} do {
	//Load random location
	_center = ["NameCityCapital","NameCity","NameVillage"] call RSTF_fnc_randomLocation;

	//Direction and distance between two spanws
	_direction = random(360);
	_distance = 200 + random(50);

	RSTF_LOCATION = _center;

	//Save center position
	RSTF_POINT = getPos(_center);
	//RSTF_POINT = markerPos "TestCenter";
	RSTF_POINT set [2, 0];

	//Now find usable spanws
	RSTF_WATER = true;
	_tries = 0;
	while { _tries < 5 } do {
		//Load spawn locations
		//INDEX is side index
		RSTF_SPAWNS = [
			[(RSTF_POINT select 0) + sin(_direction) * _distance,(RSTF_POINT select 1) + cos(_direction) * _distance, 0],
			[(RSTF_POINT select 0) + sin(180 + _direction) * _distance,(RSTF_POINT select 1) + cos(180 + _direction) * _distance, 0],
			[0,0,0] //For netural defenders
		];
		
		if (!surfaceIsWater(RSTF_SPAWNS select 0) &&
			!surfaceIsWater(RSTF_SPAWNS select 1)) exitWith {
			RSTF_WATER = false;
			true;
		};
		
		_direction = _direction + 30;
		_tries = _tries + 1;
	};

	RSTF_DIRECTION = _direction;
	RSTF_DISTANCE = _distance;
	
	_attempts = _attempts + 1;
	
	if (RSTF_WATER && _attempts > 100) exitWith {
		systemChat "Failed to find suitable location!";
	};
};
