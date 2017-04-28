/*
	Author: Jan Zipek

	Description:
	Gets called by server when score has changed.
*/

// Broadcast score and apply if on non-dedicated server
publicVariable "RSTF_SCORE";
if (!isDedicated) then {
	call RSTF_fnc_onScore;
};