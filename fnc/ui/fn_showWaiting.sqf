_dialogName = "RSTF_RscDialogWaiting";
_ok = createDialog _dialogName;
if (!_ok) exitWith {
	systemChat "Failed to open dialog.";
	"Waiting on host to finish configuration." call BIS_fnc_titleText;
};

if (isNull(RSTF_CAM)) then {
	call RSTF_fnc_createCam;
};

RSTF_CAM camSetTarget RSTF_CAM_TARGET;
RSTF_CAM camSetRelPos [3, 3, 2];
RSTF_CAM camCommit 0;

/*
0 spawn {
	RSTF_LOADERS = [];

	_get_position = {
		params ["_index", "_progress"];
		RSTF_CAM_TARGET vectorAdd [
			sin(_index * 45 + _progress * 20),
			cos(_index * 45 + _progress * 20),
			0
		]
	};

	for [{_i = 0}, {_i < 360/45}, {_i = _i + 1}] do {
		_position = [_i, time] call _get_position;
		_unit = "C_Soldier_VR_F" createVehicleLocal _position;
		_unit setPos _position;
		_unit enableSimulation false;
		RSTF_LOADERS pushBack _unit;
	};

	_display = "RSTF_RscDialogWaiting" call RSTF_fnc_getDisplay;
	_display displayAddEventHandler ["Unload", {
		{
			deleteVehicle _x;
		} foreach RSTF_LOADERS;
		RSTF_LOADERS = [];
	}];

	while { count(RSTF_LOADERS) > 0 } do {
		{
			_x setPos ([_foreachIndex, time] call _get_position);
		} foreach RSTF_LOADERS;

		sleep 0.1;
	};
};
*/
