disableSerialization;

_ctrl = ["RSTF_RscDialogConfig", "weaponText"] call RSTF_fnc_getCtrl;

if (RSTF_CUSTOM_EQUIPMENT) then {
	_entry = configFile >> "cfgWeapons" >> RSTF_PLAYER_PRIMARY >> "displayName";
	if (isText(_entry)) then {
		_ctrl ctrlSetText getText(_entry);
	};
} else {
	_ctrl ctrlSettext "RANDOM";
}