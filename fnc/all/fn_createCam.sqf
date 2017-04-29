/*
	Author: Jan Zipek

	Description:
	Creates camera at center of battle and initializes it.
*/

RSTF_CAM = "camera" camCreate [RSTF_POINT select 0, RSTF_POINT select 1, 100];
RSTF_CAM camSetTarget RSTF_POINT;
RSTF_CAM cameraEffect ["internal", "back"];
RSTF_CAM camCommit 0;