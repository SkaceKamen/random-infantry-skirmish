private _ctrl = [RSTF_DEATH_DIALOG_layout, "equipment"] call ZUI_fnc_getControlById;
_ctrl ctrlEnable RSTF_CUSTOM_EQUIPMENT;

if (!RSTF_CUSTOM_EQUIPMENT) then {
	_ctrl ctrlSetTooltip "Custom equipment is disabled";
};
