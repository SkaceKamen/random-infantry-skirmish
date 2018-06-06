/*
	Function:
	RSTF_fnc_destroyCam

	Description:
	Terminate camera.
*/

if (isNull(RSTF_CAM)) exitWith {
	diag_log "[RSTF] destroyCam called when camera is already destroyed.";
};

RSTF_CAM cameraEffect ["terminate","back"];
camDestroy RSTF_CAM;
RSTF_CAM = objNull;