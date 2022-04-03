params ["_position", "_direction"];

private _distance = RSTF_SPAWN_DISTANCE_MIN + (RSTF_SPAWN_DISTANCE_MAX - RSTF_SPAWN_DISTANCE_MIN) / 2;

if (isNull(RSTF_CAM)) then {
	call RSTF_fnc_createCam;
};

RSTF_CAM camSetTarget _position;
RSTF_CAM camSetRelPos [100, 100, 300];
RSTF_CAM camCommit 0;

RSTF_CUSTOM_POINT = _position;
RSTF_CUSTOM_DIRECTION = _direction;
RSTF_CUSTOM_DISTANCE = _distance;

{
	deleteMarker _x;
} foreach RSTF_BS_MARKERS;

RSTF_CUSTOM_POINT_SPAWNS = [
	RSTF_CUSTOM_POINT vectorAdd [sin(RSTF_CUSTOM_DIRECTION) * _distance, cos(RSTF_CUSTOM_DIRECTION) * _distance, 0],
	RSTF_CUSTOM_POINT vectorAdd [sin(180 + RSTF_CUSTOM_DIRECTION) * _distance, cos(180 + RSTF_CUSTOM_DIRECTION) * _distance, 0],
	[0,0,0] //For netural defenders
];

RSTF_BS_MARKERS = [_position, RSTF_CUSTOM_POINT_SPAWNS, true] call RSTF_fnc_createPointMarkers;
