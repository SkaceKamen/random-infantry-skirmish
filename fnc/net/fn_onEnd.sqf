private  _winner = param [0];

if (RSTF_ENDED) exitWith { false };

RSTF_ENDED = true;

if (isNull(RSTF_CAM)) then {
	call RSTF_fnc_createCam;
};

waitUntil { camCommitted RSTF_CAM; };

_target = player;
if (!alive(_target)) then {
	_target = RSTF_POINT;
} else {
	_target = getPos(_target);
};

RSTF_CAM camSetPos RSTF_POINT;
RSTF_CAM camSetTarget RSTF_POINT;
RSTF_CAM camCommit 0;
RSTF_CAM camSetPos [RSTF_POINT select 0, RSTF_POINT select 1, 300];
RSTF_CAM camCommit 5;

waitUntil { camCommitted RSTF_CAM; };

if (_winner == SIDE_FRIENDLY) then {
	"END1" call BIS_fnc_endMission;
} else {
	["LOSER", false, true] call BIS_fnc_endMission;
};