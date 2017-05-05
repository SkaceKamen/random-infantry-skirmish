/*
	Author: Jan Zipek

	Description:
	Called when RSTF_POINT was changed
*/

if (isNull(RSTF_CAM)) then {
	call RSTF_fnc_createCam;
};

RSTF_CAM camSetTarget RSTF_POINT;
RSTF_CAM camSetRelPos [30, 30, 50];
RSTF_CAM camCommit 0;

[
	[
		[text(RSTF_LOCATION), "%1<br />"],
		[format["%1:%2", date select 3, date select 4],"<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"]
	]
] call BIS_fnc_typeText;