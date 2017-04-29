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