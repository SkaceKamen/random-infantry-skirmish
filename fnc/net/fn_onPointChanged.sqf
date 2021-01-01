/*
	Author: Jan Zipek

	Description:
	Called when RSTF_POINT was changed
*/

closeDialog 0;

if (isNull(RSTF_CAM)) then {
	call RSTF_fnc_createCam;
};

RSTF_CAM camSetTarget RSTF_POINT;
RSTF_CAM camSetRelPos [100, 100, 300];
RSTF_CAM camCommit 0;

[
	[
		["Battle for " + (RSTF_LOCATION select 0), "%1<br />"]
	]
] call BIS_fnc_typeText;