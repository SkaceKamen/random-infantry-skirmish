disableSerialization;

if (RSTF_ENDED) exitWith {
	false;
};

_display = uinamespace getVariable ['ARCADE_UI', displaynull];

for[{_i = 0}, {_i < 2}, {_i = _i + 1}] do {
	_score = RSTF_SCORE select _i;
	_commando = RSTF_COMMANDO select _i;
	_count = RSTF_LIMIT_COMMANDO min floor(_score / RSTF_SCORE_COMMANDO);
	for[{_c = count(_commando)},{_c < _count},{_c = _c + 1}] do {
		_i call RSTF_spawnCommando;
	};
	
	(_display displayCtrl (2 + _i)) ctrlSetText str(_score);

	if (_score >= RSTF_SCORE_LIMIT) exitWith {
		RSTF_ENDED = true;
	
		if (isNull(RSTF_CAM)) then {
			RSTF_CAM = "camera" camCreate [RSTF_POINT select 0, RSTF_POINT select 1, 100];
			RSTF_CAM cameraEffect ["internal", "back"];
			RSTF_CAM camCommit 0;
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
		
		if (_i == SIDE_FRIENDLY) then {
			"END1" call BIS_fnc_endMission;
		} else {
			["LOSER", false, true] call BIS_fnc_endMission;
		};
	};
};
