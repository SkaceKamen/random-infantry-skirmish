#include "..\..\dialogs\titles\arcadeUI.inc"

disableSerialization;

_layer = 1586;
_layer cutRsc ["ARCADE_UI", "PLAIN"];

waitUntil {!isNull(uinamespace getVariable ['ARCADE_UI', displaynull]) };

_display = uinamespace getVariable ['ARCADE_UI', displaynull];

_ctrlGlobalMessages = _display displayCtrl RSTFUI_ARCADE_GLOBAL_MESSAGES_IDC;
_ctrlLocalMessages = _display displayCtrl RSTFUI_ARCADE_LOCAL_MESSAGES_IDC;
_ctrlOwner = _display displayCtrl RSTFUI_ARCADE_SCORE_OWNER_IDC;
_ctrlMoney = _display displayCtrl RSTFUI_ARCADE_MONEY_IDC;

_ctrlOwner ctrlShow false;
_ctrlOwner ctrlCommit 0;

_lastOwner = RSTF_MODE_KOTH_OWNER;

while { true } do {
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
		if (RSTF_MODE_KOTH_OWNER != _lastOwner) then {
			_lastOwner = RSTF_MODE_KOTH_OWNER;
			if (_lastOwner == SIDE_FRIENDLY || _lastOwner == SIDE_ENEMY) then {
				_color = RSTF_SIDES_COLORS_UI_SELECTED select _lastOwner;
				_position = [
					SafeZoneX + SafeZoneW / 2,
					SafeZoneY + 0.01 - 0.005
				];
				if (_lastOwner == SIDE_FRIENDLY) then {
					_position set [0,
						(_position select 0) - (RSTFUI_ARCADE_SCORE_W + 0.01)
					];
				};
				_ctrlOwner ctrlShow true;
				_ctrlOwner ctrlSetPosition _position;
				_ctrlOwner ctrlSetBackgroundColor _color;
				_ctrlOwner ctrlCommit 1;
			} else {
				_ctrlOwner ctrlShow false;
				_ctrlOwner ctrlCommit 0;
			};
		};

		_index = RSTF_MODE_KOTH_MONEY_INDEX find (getPlayerUID player);
		_money = 0;
		if (_index >= 0) then {
			_money = RSTF_MODE_KOTH_MONEY select _index;
		};

		_ctrlMoney ctrlSetText format["%1$", _money];
	};

	sleep RSTF_UI_STEP;
};