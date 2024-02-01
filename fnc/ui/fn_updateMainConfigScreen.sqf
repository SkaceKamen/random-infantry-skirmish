private _neutralsList = [RSTF_MAIN_CONFIG_layout, "neutralList"] call ZUI_fnc_getComponentById;
[_neutralsList, call RSTF_fnc_doesModeSupportNeutrals] call ZUI_fnc_setVisible;

private _neutralsButton = [RSTF_MAIN_CONFIG_layout, "neutralEdit"] call ZUI_fnc_getControlById;
_neutralsButton ctrlEnable (call RSTF_fnc_doesModeSupportNeutrals);

if (call RSTF_fnc_doesModeSupportNeutrals) then {
	_neutralsButton ctrlSetTooltip "";
} else {
	_neutralsButton ctrlSetTooltip "This game mode doesn't support neutrals";
};

private _equipmentButton = [RSTF_MAIN_CONFIG_layout, "pickEquipment"] call ZUI_fnc_getControlById;
_equipmentButton ctrlEnable RSTF_CUSTOM_EQUIPMENT;

if (RSTF_CUSTOM_EQUIPMENT) then {
	_equipmentButton ctrlSetTooltip "";
} else {
	_equipmentButton ctrlSetTooltip "You need to enable custom equipment in configuration";
};

call RSTF_fnc_updateEquipment;

private _ctrl = [RSTF_MAIN_CONFIG_layout, "basicConfigList"] call ZUI_fnc_getControlById;
lnbClear _ctrl;


private _pushItem = {
	params ["_ctrl", "_label", "_value"];

	private _row = _ctrl lnbAddRow ["", _value];
	_ctrl lnbSetTextRight [[_row, 0], _label];
	_ctrl lnbSetColorRight [[_row, 0], [1, 1, 1, 0.75]];
};


private _mode = call RSTF_fnc_getModeId;
private _modeName = getText(missionConfigFile >> "RSTF_Modes" >> _mode >> "title");

[_ctrl, "Mode", _modeName] call _pushItem;

switch (call RSTF_fnc_getModeId) do {
	case "KOTH": {
		[_ctrl, "Score to win", str(RSTF_MODE_KOTH_SCORE_LIMIT)] call _pushItem;
		[_ctrl, "Point award interval", str(RSTF_MODE_KOTH_SCORE_INTERVAL) + " seconds"] call _pushItem;
	};
	case "PushDefense": {
		[_ctrl, "Points to defend", str(RSTF_MODE_PUSH_POINT_COUNT)] call _pushItem;
	};
	case "Push": {
		[_ctrl, "Side", RSTF_MODE_PUSH_SIDE_OPTIONS#RSTF_MODE_PUSH_SIDE] call _pushItem;
		[_ctrl, "Points to push", str(RSTF_MODE_PUSH_POINT_COUNT)] call _pushItem;
		[_ctrl, "Point size", str(RSTF_MODE_PUSH_POINT_RADIUS) + " m"] call _pushItem;
	};
	case "Classic": {
		[_ctrl, "Score to win", str(RSTF_SCORE_LIMIT)] call _pushItem;
		[_ctrl, "Score per kill", str(RSTF_SCORE_PER_KILL)] call _pushItem;
		[_ctrl, "Score per task", str(RSTF_SCORE_PER_TASK)] call _pushItem;
	};
	case "Arena": {
		[_ctrl, "Score to win", str(RSTF_SCORE_LIMIT)] call _pushItem;
		[_ctrl, "Score per kill", str(RSTF_SCORE_PER_KILL)] call _pushItem;
		[_ctrl, "Rectangle size", str(RSTF_MODE_ARENA_RECTANGLE_SIZE) + " m"] call _pushItem;
	};
	case "GunGame": {
		[_ctrl, "Weapons", str(RSTF_MODE_GUN_GAME_WEAPONS_COUNT)] call _pushItem;
		[_ctrl, "Kills per level", str(RSTF_MODE_GUN_GAME_KILLS_PER_WEAPON)] call _pushItem;
		[_ctrl, "Rectangle size", str(RSTF_MODE_GUN_GAME_RECTANGLE_SIZE) + " m"] call _pushItem;
	};
};

private _dateTime = "";
private _date = [];
if (RSTF_USE_DEFAULT_DATE) then {
	private _worldStartDate = call RSTF_fnc_getWorldStartDate;
	_date set [0, _worldStartDate#0];
	_date set [1, _worldStartDate#1];
	_date set [2, _worldStartDate#2];
} else {
	_date set [0, RSTF_DATE_YEAR];
	_date set [1, RSTF_DATE_MONTH];
	_date set [2, RSTF_DATE_DAY];
};

_dateTime = format["%1-%2-%3 %4", _date#0, _date#1, _date#2, if (RSTF_TIME == 0) then { "Random"} else { RSTF_TIME_TYPES#RSTF_TIME }];

private _euipment = "From unit";
if (RSTF_CUSTOM_EQUIPMENT) then {
	_equipment = "Custom";
} else {
	if (RSTF_RANDOMIZE_WEAPONS) then {
		_equipment = "Random";
	};
};

[_ctrl, "Equipment", _euipment] call _pushItem;
[_ctrl, "Date", _dateTime] call _pushItem;
[_ctrl, "Weather", if (RSTF_WEATHER == 0) then { "Random" } else { RSTF_WEATHER_TYPES#RSTF_WEATHER }] call _pushItem;
[_ctrl, "Groups per side", str(RSTF_LIMIT_GROUPS)] call _pushItem;
[_ctrl, "Units per group", str(RSTF_LIMIT_UNITS)] call _pushItem;
[_ctrl, "Wave spawn time", str(RSTF_LIMIT_SPAWN) + " seconds"] call _pushItem;
[_ctrl, "AI Vehicles", if (RSTF_AI_VEHICLES_ENABLED) then { "Enabled" } else { "Disabled" }] call _pushItem;
[_ctrl, "Money", if (RSTF_MONEY_ENABLED) then { "Enabled" } else { "Disabled" }] call _pushItem;

if (RSTF_MONEY_ENABLED) then {
	[_ctrl, "Vehicles shop", if (RSTF_MONEY_VEHICLES_ENABLED) then { "Enabled" } else { "Disabled" }] call _pushItem;
	[_ctrl, "Supports shop", if (RSTF_ENABLE_SUPPORTS) then { "Enabled" } else { "Disabled" }] call _pushItem;
};