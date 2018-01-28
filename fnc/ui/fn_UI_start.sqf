disableSerialization;

_layer = 1586;
_layer cutRsc ["ARCADE_UI", "PLAIN"];

waitUntil {!isNull(uinamespace getVariable ['ARCADE_UI', displaynull]) };

_display = uinamespace getVariable ['ARCADE_UI', displaynull];

while {true} do {
	_text = "";

	for[{_i = 0},{_i < count(RSTF_UI_MESSAGES)},{_i = _i + 1}] do {
		_x = RSTF_UI_MESSAGES select _i;
		_text = (_x select 0) + "<br/>" + _text;
		_x set [1, (_x select 1) - RSTF_UI_STEP];
		if (_x select 1 <= 0) then {
			for[{_y = _i},{_y < count(RSTF_UI_MESSAGES) - 1},{_y = _y + 1}] do {
				RSTF_UI_MESSAGES set [_y, RSTF_UI_MESSAGES select (_y + 1)];
			};
			RSTF_UI_MESSAGES resize (count(RSTF_UI_MESSAGES) - 1);
			_i = _i - 1;
		};
	};

	_text = _text;

	(_display displayCtrl 1) ctrlSetStructuredText parseText(_text);

	if (RSTF_MODE_KOTH_ENABLED) then {
		_index = RSTF_MODE_KOTH_MONEY_INDEX find (getPlayerUID player);
		_money = 0;
		if (_index >= 0) then {
			_money = RSTF_MODE_KOTH_MONEY select _index;
		};

		(_display displayCtrl 5) ctrlSetText format["%1$", _money];
	};

	sleep RSTF_UI_STEP;
};