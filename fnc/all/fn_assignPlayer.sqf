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

	private _previous = player;
	selectPlayer _unit;

	// Remove respawned unit in multiplayer
	if (isMultiplayer && _previous != RSTF_BACKUP_PLAYER) then {
		deleteVehicle _previous;
	};

	[_unit] joinSilent group(_unit);
	_unit addEventHandler ["Killed", RSTF_fnc_playerKilled];
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

// Display support menu hint if needed
if (RSTF_HINT_SUPPORT_MENU && RSTF_MONEY_VEHICLES_ENABLED) then {
	// Only display this hint once, so disable it and save
	RSTF_HINT_SUPPORT_MENU = false;
	call RSTF_fnc_profileSave;

	_keyName = RSTF_POSSIBLE_KEYS_NAMES select RSTF_BUY_MENU_ACTION;

	// Display the hint
	hint(parseText(format["Press <t color='#999999'>%1</t> key to open <t color='#999999'>vehicle shop</t>.", _keyName]));
};
