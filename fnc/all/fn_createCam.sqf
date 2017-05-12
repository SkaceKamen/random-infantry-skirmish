/*
	Author: Jan Zipek

	Description:
	Creates camera at center of battle and initializes it.
*/

RSTF_CAM = "camera" camCreate [0, 0, 100];
RSTF_CAM camSetTarget [0, 0, 0];
RSTF_CAM cameraEffect ["internal", "back"];
RSTF_CAM camCommit 0;