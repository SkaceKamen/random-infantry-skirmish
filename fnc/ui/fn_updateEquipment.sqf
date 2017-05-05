disableSerialization;

_ctrl = ["RSTF_RscDialogConfig", "weaponText"] call RSTF_fnc_getCtrl;


if (RSTF_CUSTOM_EQUIPMENT && count(RSTF_PLAYER_EQUIPMENT) > 0) then {
	_ctrl ctrlSettext "CUSTOM";
} else {
	_ctrl ctrlSettext "RANDOM";
}
