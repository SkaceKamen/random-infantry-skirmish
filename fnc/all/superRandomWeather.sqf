_speed = 300;

_weather = {
	if (RSTF_WEATHER == 0) then {
		_type = round(random(1));
		if (_type == 0) then {
			_this setOvercast random(0.3);
			_this setRain 0;
		} else {
			_this setOvercast random(1);
			_this setRain random(1);
		};
		
		if (_this == 0) then {
			setWind [random(5), random(5), true];
		} else {
			setWind [random(5), random(5)];
		};
	} else {
		_options = RSTF_WEATHER_OPTIONS select RSTF_WEATHER;
		_over = _options select 0;
		_rain = _options select 1;
		_wind = _options select 2;
		
		if (typeName(_over) == "ARRAY") then { 
			_over = (_over select 0) + random((_over select 1) - (_over select 0));
		};
		if (typeName(_rain) == "ARRAY") then { 
			_rain = (_rain select 0) + random((_rain select 1) - (_rain select 0));
		};
		
		_wind_set = [];
		if (typeName(_wind) == "ARRAY") then {
			_wind_set set [0, (_wind select 0) + random((_wind select 1) - (_wind select 0))];
			_wind_set set [1, (_wind select 0) + random((_wind select 1) - (_wind select 0))];
		} else {
			_wind_set set [0, _wind];
			_wind_set set [1, _wind];
		};
		
		if (round(random(1)) == 1) then {
			_wind_set set [0, (_wind_set select 0) * -1];
		};
		if (round(random(1)) == 1) then {
			_wind_set set [1, (_wind_set select 1) * -1];
		};
		
		if (_this == 0) then {
			_wind_set set [2, true];
		};
	
		_this setOvercast _over;
		_this setRain _rain;
		setWind _wind_set;
	};
};

skipTime -24;
0 call _weather;
skipTime 24;
sleep 1;
simulWeatherSync;

_change = _speed/2 + random(_speed/2);	
_change = _change * 0.8 + random(_change * 0.4);
sleep _change;

while { true } do {
	_change = _speed/2 + random(_speed/2);
	_change call _weather;
	
	_change = _change * 0.8 + random(_change * 0.4);
	sleep _change;
};