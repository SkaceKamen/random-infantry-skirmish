private _from = param [0];
private _to = param [1];

// Camera animation
if (isNull(RSTF_CAM)) then {
	call RSTF_fnc_createCam;
};

waitUntil { camCommitted RSTF_CAM; };

// Move camera to player

RSTF_CAM camSetTarget _from;
RSTF_CAM camSetRelPos [0, -1, 0.5];
RSTF_CAM camCommit 0;

waitUntil { camCommitted RSTF_CAM; };

// Move camera to target vehicle

RSTF_CAM camSetTarget _to;
RSTF_CAM camSetRelPos [0, -1, 0.5];
RSTF_CAM camCommit 1;

waitUntil { camCommitted RSTF_CAM; };

// Destroy camera

call RSTF_fnc_destroyCam;