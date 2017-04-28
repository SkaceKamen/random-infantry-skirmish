/*
	Author: Jan Zipek

	Description:
	Called when RSTF_POINT was changed
*/

if (isNull(RSTF_CAM)) then {
	RSTF_CAM = "camera" camCreate [RSTF_POINT select 0, RSTF_POINT select 1, 100];
};

RSTF_CAM camSetTarget RSTF_POINT;
RSTF_CAM camSetRelPos [1,1,50];
RSTF_CAM camCommit 0;