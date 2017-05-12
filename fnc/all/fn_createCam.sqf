/*
	Author: Jan Zipek

	Description:
	Creates camera at center of battle and initializes it.
*/

RSTF_CAM = "camera" camCreate RSTF_CAM_TARGET;
RSTF_CAM camSetTarget RSTF_CAM_TARGET;
RSTF_CAM camSetRelPos [3, 3, 2];
RSTF_CAM cameraEffect ["internal", "back"];
RSTF_CAM camCommit 0;