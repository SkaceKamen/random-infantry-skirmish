private _unit = _this;

RSTF_BACKUP_PLAYER setVariable ["ASSIGNED", true, true];
_unit setVariable ["USED", true, true];

if (isNull(RSTF_CAM)) then {
	call RSTF_fnc_createCam;
};

waitUntil { camCommitted RSTF_CAM; };

RSTF_CAM camSetTarget _unit;
RSTF_CAM camSetRelPos [0, -1, 0.5];
RSTF_CAM camCommit 1;

waitUntil { camCommitted RSTF_CAM; };

if (alive(_unit)) then {
	if (RSTF_CUSTOM_EQUIPMENT && count(RSTF_PLAYER_EQUIPMENT) > 0) then {
		_data = missionNamespace getvariable ["bis_fnc_saveInventory_data",[]];
		_nameID = _data find "RSTF_PLAYER_EQUIPMENT";
		if (_nameID < 0) then {
			_nameID = count _data;
			_data set [_nameID, "RSTF_PLAYER_EQUIPMENT"];
		};
		_data set [_nameID + 1, RSTF_PLAYER_EQUIPMENT];
		bis_fnc_saveInventory_data = _data;
		[_unit, [missionNamespace, "RSTF_PLAYER_EQUIPMENT"]] call BIS_fnc_loadInventory;
	};

	selectPlayer _unit;
	[_unit] joinSilent group(_unit);
	_unit addEventHandler ["Killed", RSTF_fnc_playerKilled];

	// _unit addAction ["Vehicle menu", RSTF_fnc_UI_showVehicleSelection, nil, 0];


} else {
	[_unit, objNull] call RSTF_fnc_playerKilled;
};

RSTF_CAM cameraEffect ["terminate","back"];
camDestroy RSTF_CAM;
RSTF_CAM = objNull;

if (RSTF_TASK != "") then {
	[RSTF_TASK, "ASSIGNED", false] call BIS_fnc_taskSetState;
};

{
	[_x, ([_x] call BIS_fnc_taskState), false] call BIS_fnc_taskSetState;
} foreach RSTF_CURRENT_TASKS;
