/*
	Author: Jan Zipek

	Description:
	Called when actual game starts.
*/

closeDialog 0;

[] spawn RSTF_fnc_bindKeys;

// Start UI features
[] spawn RSTFUI_fnc_startOverlay;

// Update score display
[] spawn RSTF_fnc_onScore;