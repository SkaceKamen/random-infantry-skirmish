_speed = 300;

RSTF_WEATHER_ehOvercast = {
	(_this select 0) setOvercast (_this select 1);
};
RSTF_WEATHER_ehRain = {
	(_this select 0) setRain (_this select 1);
};
RSTF_WEATHER_ehWind = {
	setWind _this;
};

"RSTF_WEATHER_OVERCAST" addPublicVariableEventHandler { (_this select 1) spawn RSTF_WEATHER_ehOvercast };
"RSTF_WEATHER_RAIN" addPublicVariableEventHandler { (_this select 1) spawn RSTF_WEATHER_ehRain };
"RSTF_WEATHER_WIND" addPublicVariableEventHandler { (_this select 1) spawn RSTF_WEATHER_ehWind };
"RSTF_WEATHER_SYNC" addPublicVariableEventHandler {
	0 spawn {
		skipTime -24;

		RSTF_WEATHER_OVERCAST call RSTF_WEATHER_ehOvercast;
		RSTF_WEATHER_RAIN call RSTF_WEATHER_ehRain;
		RSTF_WEATHER_WIND call RSTF_WEATHER_ehWind;

		skipTime 24;
		sleep 1;
		simulWeatherSync;
	};
};

_weather = {
	if (RSTF_WEATHER == 0) then {
		_type = round(random(1));
		if (_type == 0) then {
			RSTF_WEATHER_OVERCAST = [_this, random(0.3)];
			RSTF_WEATHER_RAIN = [_this, 0];
		} else {
			RSTF_WEATHER_OVERCAST = [_this, random(1)];
			RSTF_WEATHER_RAIN = [_this, random(1)];
		};

		if (_this == 0) then {
			RSTF_WEATHER_WIND = [random(5), random(5), true];
		} else {
			RSTF_WEATHER_WIND = [random(5), random(5)];
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
	
		RSTF_WEATHER_OVERCAST = [_this, _over];
		RSTF_WEATHER_RAIN = [_this, _rain];
		RSTF_WEATHER_WIND = _wind_set;
	};

	publicVariable "RSTF_WEATHER_OVERCAST";
	publicVariable "RSTF_WEATHER_RAIN";
	publicVariable "RSTF_WEATHER_WIND";

	RSTF_WEATHER_OVERCAST call RSTF_WEATHER_ehOvercast;
	RSTF_WEATHER_RAIN call RSTF_WEATHER_ehRain;
	RSTF_WEATHER_WIND call RSTF_WEATHER_ehWind;
};

skipTime -24;
0 call _weather;
skipTime 24;

RSTF_WEATHER_SYNC = [ RSTF_WEATHER_OVERCAST, RSTF_WEATHER_RAIN, RSTF_WEATHER_WIND ];
publicVariable "RSTF_WEATHER_SYNC";

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