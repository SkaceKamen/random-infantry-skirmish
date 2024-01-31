#include "..\..\dialogs\titles\arcadeUI.inc"

_display = uinamespace getVariable ['ARCADE_UI', displaynull];

if (isNull(_display)) exitWith {};

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

{
	_x ctrlShow true;
} foreach [
	_ctrlScoreFriendly, _ctrlScoreEnemy, _ctrlGlobalMessages,
	_ctrlUserCountIcon, _ctrlUserCountFriendly, _ctrlUserCountEnemy,_ctrlPushProgress, _ctrlPushProgressBackground
];

if (!RSTF_UI_SHOW_GAMEMODE_SCORE) then {
	{
		_x ctrlShow false;
	} foreach [
		_ctrlScoreFriendly, _ctrlScoreEnemy, _ctrlGlobalMessages,
		_ctrlUserCountIcon, _ctrlUserCountFriendly, _ctrlUserCountEnemy, _ctrlPushProgress, _ctrlPushProgressBackground
	];
} else {
	switch (call RSTF_fnc_getModeId) do {
		case "Arena": {
			{
				_x ctrlShow false;
			} foreach [_ctrlUserCountIcon, _ctrlUserCountFriendly, _ctrlUserCountEnemy, _ctrlPushProgress, _ctrlPushProgressBackground];
		};

		case "Classic": {
			{
				_x ctrlShow false;
			} foreach [_ctrlUserCountIcon, _ctrlUserCountFriendly, _ctrlUserCountEnemy, _ctrlPushProgress, _ctrlPushProgressBackground];
		};

		case "KOTH": {
			{
				_x ctrlShow false;
			} foreach [_ctrlPushProgress, _ctrlPushProgressBackground];
		};

		case "Push": {
			{
				_x ctrlShow false;
			} foreach [_ctrlScoreFriendly, _ctrlScoreEnemy];

			_ctrlUserCountFriendly ctrlSetBackgroundColor [0, 0, 0.77, 0.9];
			_ctrlUserCountEnemy ctrlSetBackgroundColor [0.9, 0.14, 0.14, 0.9];
		};

		case "PushDefense": {
			{
				_x ctrlShow false;
			} foreach [_ctrlScoreFriendly, _ctrlScoreEnemy];

			_ctrlUserCountFriendly ctrlSetBackgroundColor [0, 0, 0.77, 0.9];
			_ctrlUserCountEnemy ctrlSetBackgroundColor [0.9, 0.14, 0.14, 0.9];
		};

		case "Defense": {
			{
				_x ctrlShow false;
			} foreach [_ctrlScoreFriendly, _ctrlScoreEnemy];

			_ctrlUserCountFriendly ctrlSetBackgroundColor [0, 0, 0.77, 0.9];
			_ctrlUserCountEnemy ctrlSetBackgroundColor [0.9, 0.14, 0.14, 0.9];
		};
	};
};

// Hide/Show money if enabled
_ctrlMoney ctrlShow (RSTF_MONEY_ENABLED && RSTF_UI_SHOW_PLAYER_MONEY);

// Hide/Show player messages
_ctrlLocalMessages ctrlShow RSTF_UI_SHOW_PLAYER_FEED;
