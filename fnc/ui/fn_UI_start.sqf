disableSerialization;

_layer = 1586;
_layer cutRsc ["ARCADE_UI", "PLAIN"];

waitUntil {!isNull(uinamespace getVariable ['ARCADE_UI', displaynull]) };

_display = uinamespace getVariable ['ARCADE_UI', displaynull];

_ctrlGlobalMessages = _display displayCtrl 4;
_ctrlLocalMessages = _display displayCtrl 1;

while {true} do {
	// Filter outdated messages
	RSTF_UI_GLOBAL_MESSAGES = RSTF_UI_GLOBAL_MESSAGES select { _x select 1 > time };
	RSTF_UI_MESSAGES = RSTF_UI_MESSAGES select { _x select 1 > time };

	// Display global and local messages
	{
		_text = "";
		{
			_text = (_x select 0) + "<br />" + _text;
		} foreach (_x select 1);
		(_x select 0) ctrlSetStructuredText parseText(_text);
	} foreach [
		[_ctrlGlobalMessages, RSTF_UI_GLOBAL_MESSAGES],
		[_ctrlLocalMessages, RSTF_UI_MESSAGES]
	];

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