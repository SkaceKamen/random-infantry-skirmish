#include "..\..\dialogs\titles\arcadeUI.inc"

disableSerialization;

// Vehicle icons
if (RSTF_UI_SHOW_VEHICLE_MARKERS) then {
	addMissionEventHandler ["Draw3D", {
		{
			private _pos = (getPosATLVisual _x) vectorAdd [0, 0, 4];
			// _pos set [2, (_x modelToWorld [0,0,1.5]) select 2];
			private _air = _x isKindOf "Air";
			private _icon = "\a3\ui_f\data\Map\Markers\NATO\b_"
				+ (if (_air) then { "armor" } else { "air" })
				+ ".paa";
			drawIcon3D [_icon, [0.5, 0.5, 1, 0.8], _pos, 0.8, 0.8, 0];
		} foreach (RSTF_AI_VEHICLES select SIDE_FRIENDLY);
	}];
};

waitUntil { sleep 0.1; !RSTF_INTRO_PLAYING };

"RSTF_INGAME_UI" cutRsc ["ARCADE_UI", "PLAIN", 1, false];

waitUntil {!isNull(uinamespace getVariable ['ARCADE_UI', displaynull]) };

_display = uinamespace getVariable ['ARCADE_UI', displaynull];

_ctrlGlobalMessages = _display displayCtrl RSTFUI_ARCADE_GLOBAL_MESSAGES_IDC;
_ctrlLocalMessages = _display displayCtrl RSTFUI_ARCADE_LOCAL_MESSAGES_IDC;
_ctrlOwner = _display displayCtrl RSTFUI_ARCADE_SCORE_OWNER_IDC;
_ctrlMoney = _display displayCtrl RSTFUI_ARCADE_MONEY_IDC;

_ctrlScoreFriendly = _display displayCtrl RSTFUI_ARCADE_SCORE_F_IDC;
_ctrlScoreEnemy = _display displayCtrl RSTFUI_ARCADE_SCORE_E_IDC;

_ctrlUserCountIcon = _display displayCtrl RSTFUI_ARCADE_USER_ICON_IDC;
_ctrlUserCountFriendly = _display displayCtrl RSTFUI_ARCADE_FRIENDLY_USER_COUNT_IDC;
_ctrlUserCountEnemy = _display displayCtrl RSTFUI_ARCADE_ENEMY_USER_COUNT_IDC;

_ctrlPushProgress = _display displayCtrl RSTFUI_ARCADE_PUSH_PROGRESS_IDC;
_ctrlPushProgressBackground = _display displayCtrl RSTFUI_ARCADE_PUSH_PROGRESS_BACKGROUND_IDC;

_ctrlDefenseProgress = _display displayCtrl RSTFUI_ARCADE_DEFENSE_PROGRESS_IDC;

_modeId = call RSTF_fnc_getModeId;

if (!RSTF_UI_SHOW_GAMEMODE_SCORE) then {
	{
		_x ctrlShow false;
		_x ctrlCommit 0;
	} foreach [
		_ctrlScoreFriendly, _ctrlScoreEnemy, _ctrlGlobalMessages,
		_ctrlUserCountIcon, _ctrlUserCountFriendly, _ctrlUserCountEnemy, _ctrlPushProgress, _ctrlPushProgressBackground
	];
} else {
	switch (_modeId) do {
		case "Classic": {
			{
				_x ctrlShow false;
				_x ctrlCommit 0;
			} foreach [_ctrlUserCountIcon, _ctrlUserCountFriendly, _ctrlUserCountEnemy, _ctrlPushProgress, _ctrlPushProgressBackground];
		};

		case "KOTH": {
			{
				_x ctrlShow false;
				_x ctrlCommit 0;
			} foreach [_ctrlPushProgress, _ctrlPushProgressBackground];
		};

		case "Push": {
			{
				_x ctrlShow false;
				_x ctrlCommit 0;
			} foreach [_ctrlScoreFriendly, _ctrlScoreEnemy];

			_ctrlUserCountFriendly ctrlSetBackgroundColor [0, 0, 0.77, 0.9];
			_ctrlUserCountEnemy ctrlSetBackgroundColor [0.9, 0.14, 0.14, 0.9];
		};

		case "PushDefense": {
			{
				_x ctrlShow false;
				_x ctrlCommit 0;
			} foreach [_ctrlScoreFriendly, _ctrlScoreEnemy];

			_ctrlUserCountFriendly ctrlSetBackgroundColor [0, 0, 0.77, 0.9];
			_ctrlUserCountEnemy ctrlSetBackgroundColor [0.9, 0.14, 0.14, 0.9];
		};

		case "Defense": {
			{
				_x ctrlShow false;
				_x ctrlCommit 0;
			} foreach [_ctrlScoreFriendly, _ctrlScoreEnemy];

			_ctrlUserCountFriendly ctrlSetBackgroundColor [0, 0, 0.77, 0.9];
			_ctrlUserCountEnemy ctrlSetBackgroundColor [0.9, 0.14, 0.14, 0.9];
		};
	};

	// Hide KOTH only controls
	if (!RSTF_MODE_KOTH_ENABLED && !RSTF_MODE_PUSH_ENABLED && !RSTF_MODE_DEFEND_ENABLED) then {
		{
			_x ctrlShow false;
			_x ctrlCommit 0;
		} foreach [_ctrlUserCountIcon, _ctrlUserCountFriendly, _ctrlUserCountEnemy];
	};
};

_ctrlOwner ctrlShow false;
_ctrlOwner ctrlCommit 0;

// Hide/Show money if enabled
_ctrlMoney ctrlShow (RSTF_MONEY_ENABLED && RSTF_UI_SHOW_PLAYER_MONEY);
_ctrlMoney ctrlCommit 0;

// Hide/Show player messages
_ctrlLocalMessages ctrlShow RSTF_UI_SHOW_PLAYER_FEED;
_ctrlLocalMessages ctrlCommit 0;

// Last displayed owner of objective in KOTH
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

	// Point capture related logic
	if (_modeId == "KOTH" || _modeId == "Push" || _modeId == "PushDefense" || _modeId == "Defense") then {
		if (RSTF_MODE_KOTH_OWNER != _lastOwner) then {
			_lastOwner = RSTF_MODE_KOTH_OWNER;
			
			if (_modeId == "KOTH") then {
				if (_lastOwner == SIDE_FRIENDLY || _lastOwner == SIDE_ENEMY) then {
					_color = RSTF_SIDES_COLORS_UI_SELECTED select _lastOwner;
					_position = [
						SafeZoneX + SafeZoneW / 2,
						SafeZoneY + 0.01
					];
					if (_lastOwner == SIDE_FRIENDLY) then {
						_position set [0,
							(_position select 0) - (RSTFUI_ARCADE_SCORE_W + 0.01)
						];
					};
					_ctrlOwner ctrlShow true;
					_ctrlOwner ctrlSetPosition _position;
					_ctrlOwner ctrlSetBackgroundColor _color;
					_ctrlOwner ctrlCommit 0.3;
				} else {
					_ctrlOwner ctrlShow false;
					_ctrlOwner ctrlCommit 0;
				};
			};

			if (_modeId == "Defense") then {
				if (_lastOwner == SIDE_ENEMY) then {
					_ctrlPushProgress ctrlSetBackgroundColor [0.77, 0, 0, 0.9];
				} else {
					_ctrlPushProgress ctrlSetBackgroundColor [0.9, 0, 0, 0.9];
				};
			};

			if (_modeId == "Push") then {
				if (_lastOwner == SIDE_FRIENDLY) then {
					_ctrlPushProgress ctrlSetBackgroundColor [0, 0, 0.77, 0.9];
				} else {
					_ctrlPushProgress ctrlSetBackgroundColor [0, 0, 0.9, 0.9];
				};
			};

			if (_modeId == "PushDefense") then {
				if (_lastOwner == SIDE_ENEMY) then {
					_ctrlPushProgress ctrlSetBackgroundColor [0.77, 0, 0, 0.9];
				} else {
					_ctrlPushProgress ctrlSetBackgroundColor [0.9, 0, 0, 0.9];
				};
			};

			playSound "DefaultNotification";
		};

		if (count(RSTF_MODE_KOTH_COUNTS) > 0) then {
			_countFriendly = RSTF_MODE_KOTH_COUNTS select SIDE_FRIENDLY;
			_countEnemy = RSTF_MODE_KOTH_COUNTS select SIDE_ENEMY;
			_countFriendlyStr = str(_countFriendly);
			_countEnemyStr = str(_countEnemy);

			if (!RSTF_UI_SHOW_GAMEMODE_UNIT_COUNT) then {
				_countFriendlyStr = "";
				_countEnemyStr = "";
				
				if (_countFriendly > _countEnemy) then {
					_countFriendlyStr = "+";
				};

				if (_countFriendly < _countEnemy) then {
					_countEnemyStr = "+";
				};
			};

			_ctrlUserCountFriendly ctrlSetText _countFriendlyStr;
			_ctrlUserCountEnemy ctrlSetText _countEnemyStr;
		};

		if (count(RSTF_MODE_PUSH_COUNTS) > 0) then {
			_countFriendly = RSTF_MODE_PUSH_COUNTS select SIDE_FRIENDLY;
			_countEnemy = RSTF_MODE_PUSH_COUNTS select SIDE_ENEMY;
			_countFriendlyStr = str(_countFriendly);
			_countEnemyStr = str(_countEnemy);

			if (!RSTF_UI_SHOW_GAMEMODE_UNIT_COUNT) then {
				_countFriendlyStr = "";
				_countEnemyStr = "";
				
				if (_countFriendly > _countEnemy) then {
					_countFriendlyStr = "+";
				};

				if (_countFriendly < _countEnemy) then {
					_countEnemyStr = "+";
				};
			};

			_ctrlUserCountFriendly ctrlSetText _countFriendlyStr;
			_ctrlUserCountEnemy ctrlSetText _countEnemyStr;
		};

		if (_modeId == "Defense") then {
			_ctrlDefenseProgress ctrlSetText format["%1m left", ceil((RSTF_MODE_DEFEND_DURATION - time)/60)];
		};
	};

	if (RSTF_MONEY_ENABLED) then {
		_money = [player] call RSTF_fnc_getPlayerMoney;
		_ctrlMoney ctrlSetText format["%1$", _money];
	};

	sleep RSTF_UI_STEP;
};