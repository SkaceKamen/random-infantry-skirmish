private _neutralsList = [RSTF_MAIN_CONFIG_layout, "neutralList"] call ZUI_fnc_getComponentById;
[_neutralsList, call RSTF_fnc_doesModeSupportNeutrals] call ZUI_fnc_setVisible;

private _neutralsButton = [RSTF_MAIN_CONFIG_layout, "neutralEdit"] call ZUI_fnc_getControlById;
_neutralsButton ctrlEnable (call RSTF_fnc_doesModeSupportNeutrals);

call RSTF_fnc_updateEquipment;

private _ctrl = [RSTF_MAIN_CONFIG_layout, "basicConfigList"] call ZUI_fnc_getControlById;
lnbClear _ctrl;

private _mode = call RSTF_fnc_getModeId;
private _modeName = getText(missionConfigFile >> "RSTF_Modes" >> _mode >> "title");

_ctrl lnbAddRow ["Mode", _modeName];

switch (call RSTF_fnc_getModeId) do {
	case "KOTH": {
		_ctrl lnbAddRow ["Score to win", str(RSTF_MODE_KOTH_SCORE_LIMIT)];
		_ctrl lnbAddRow ["Point award interval", str(RSTF_MODE_KOTH_SCORE_INTERVAL) + " seconds"];
	};
	case "PushDefense": {
		_ctrl lnbAddRow ["Points to defend", str(RSTF_MODE_PUSH_POINT_COUNT)];
	};
	case "Push": {
		_ctrl lnbAddRow ["Points to push", str(RSTF_MODE_PUSH_POINT_COUNT)];
	};
	case "Classic": {
		_ctrl lnbAddRow ["Score to win", str(RSTF_SCORE_LIMIT)];
		_ctrl lnbAddRow ["Score per kill", str(RSTF_SCORE_PER_KILL)];
		_ctrl lnbAddRow ["Score per task", str(RSTF_SCORE_PER_TASK)];
	};
};


_ctrl lnbAddRow ["Equipment", if (RSTF_CUSTOM_EQUIPMENT) then { "Custom" } else { "Predefined" }];
_ctrl lnbAddRow ["Time", if (RSTF_TIME == 0) then { "Random"} else { RSTF_TIME_TYPES#RSTF_TIME }];
_ctrl lnbAddRow ["Weather", if (RSTF_WEATHER == 0) then { "Random" } else { RSTF_WEATHER_TYPES#RSTF_WEATHER }];
_ctrl lnbAddRow ["Groups per side", str(RSTF_LIMIT_GROUPS)];
_ctrl lnbAddRow ["Units per group", str(RSTF_LIMIT_UNITS)];
_ctrl lnbAddRow ["Wave spawn time", str(RSTF_LIMIT_SPAWN) + " seconds"];
_ctrl lnbAddRow ["AI Vehicles", if (RSTF_AI_VEHICLES_ENABLED) then { "Enabled" } else { "Disabled" }];
_ctrl lnbAddRow ["Money", if (RSTF_MONEY_ENABLED) then { "Enabled" } else { "Disabled" }];

if (RSTF_MONEY_ENABLED) then {
	_ctrl lnbAddRow ["Vehicles shop", if (RSTF_MONEY_VEHICLES_ENABLED) then { "Enabled" } else { "Disabled" }];
	_ctrl lnbAddRow ["Supports shop", if (RSTF_ENABLE_SUPPORTS) then { "Enabled" } else { "Disabled" }];
};