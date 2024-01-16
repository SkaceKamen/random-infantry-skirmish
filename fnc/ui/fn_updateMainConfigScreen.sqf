private _ctrl = [RSTF_MAIN_CONFIG_layout, "neutrals"] call ZUI_fnc_getControlById;
_ctrl ctrlShow (call RSTF_fnc_doesModeSupportNeutrals);
_ctrl ctrlCommit 0;

call RSTF_fnc_updateEquipment;

_ctrl = [RSTF_MAIN_CONFIG_layout, "basicConfigList"] call ZUI_fnc_getControlById;
lnbClear _ctrl;

private _mode = call RSTF_fnc_getModeId;
private _modeName = getText(missionConfigFile >> "RSTF_Modes" >> _mode >> "title");

_ctrl lnbAddRow ["Mode", _modeName];
_ctrl lnbAddRow ["Equipment", if (RSTF_CUSTOM_EQUIPMENT) then { "CUSTOM" } else { "PREDEFINED" }];
