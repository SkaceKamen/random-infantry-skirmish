/*
	Author: Jan Zipek

	Description:
	Called when actual game starts.
*/

closeDialog 1;

[
	[
		[text(RSTF_LOCATION), "%1<br />"],
		[format["%1:%2", date select 3, date select 4],"<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"]
	]
] call BIS_fnc_typeText;

sleep 2;

// Start UI features
[] spawn RSTF_fnc_UI_Start;

// Update score display
[] spawn RSTF_fnc_onScore;