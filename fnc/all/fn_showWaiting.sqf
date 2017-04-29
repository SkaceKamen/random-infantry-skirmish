_dialogName = "RSTF_RscDialogWaiting";
_ok = createDialog _dialogName;
if (!_ok) exitWith {
	systemChat "Failed to open dialog.";
	"Waiting on host to finish configuration." call BIS_fnc_titleText;
};
