disableSerialization;

_ctrlTimeout = ["RSTF_RscDialogBattleSelection", "timeout"] call RSTF_fnc_getCtrl;
_ctrlTimeout ctrlSetText str(0 max RSTF_VOTES_TIMEOUT);

if (RSTF_VOTES_TIMEOUT <= 0) then {
	closeDialog 0;
};