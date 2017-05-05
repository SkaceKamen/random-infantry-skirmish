/*
	Author: Jan Zipek

	Description:
	Called when actual game starts.
*/

closeDialog 1;

// Start UI features
[] spawn RSTF_fnc_UI_Start;

// Update score display
[] spawn RSTF_fnc_onScore;