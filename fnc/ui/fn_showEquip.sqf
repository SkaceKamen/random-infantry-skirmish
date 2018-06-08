#include "\A3\Ui_f\hpp\defineResinclDesign.inc"

private _ingame = param [0, false, [true]];
private _params = param [1, []];

private _playerIndex = 0;
if (isMultiplayer) then {
	_playerIndex = player find allPlayers;
};

RSTF_STANCE_RIFLE = "AidlPercMstpSrasWrflDnon_G01_player";

RSTF_EQUIP_SPAWN = RSTF_CAM_SPAWN vectorAdd [0.5 + _playerIndex * 5, 0, 0];
RSTF_EQUIP_WEAPON = [RSTF_EQUIP_SPAWN] call RSTF_fnc_createArsenalBackground;

if (count(RSTF_PLAYER_EQUIPMENT) > 0) then {
	_data = missionNamespace getvariable ["bis_fnc_saveInventory_data",[]];
	_nameID = _data find "RSTF_PLAYER_EQUIPMENT";
	if (_nameID < 0) then {
		_nameID = count _data;
		_data set [_nameID, "RSTF_PLAYER_EQUIPMENT"];
	};
	_data set [_nameID + 1, RSTF_PLAYER_EQUIPMENT];
	bis_fnc_saveInventory_data = _data;

	[RSTF_EQUIP_WEAPON, [missionNamespace, "RSTF_PLAYER_EQUIPMENT"]] call BIS_fnc_loadInventory;
};

group(RSTF_EQUIP_WEAPON) setFormDir 270;

// Close our camera
_camPosition = getPos(RSTF_CAM);
call RSTF_fnc_destroyCam;

["Open", [true, objNull, RSTF_EQUIP_WEAPON]] call BIS_fnc_arsenal;
waitUntil { !isNull(uinamespace getvariable ["BIS_fnc_arsenal_cam", objnull]); };

// Hijack virtual arsenal
_displays = uinamespace getVariable ["GUI_displays", []];
_classes = uinamespace getVariable ["GUI_classes", []];
_index = _classes find "RscDisplayArsenal";

if (_index >= 0) then {
	_display = _displays select _index;
	_ctrlButtonOK = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONOK;
	_ctrlButtonOK ctrlEnable true;
	_ctrlButtonOK ctrlsettext localize "STR_DISP_OK";
	_ctrlButtonOK ctrlsettooltip "";
};

waitUntil { isNull(uinamespace getvariable ["BIS_fnc_arsenal_cam", objnull]); };

// Restore our camera
call RSTF_fnc_createCam;
RSTF_CAM camSetPos _camPosition;
RSTF_CAM camCommit 0;

// Save player equipment
RSTF_PLAYER_EQUIPMENT = [RSTF_EQUIP_WEAPON] call BIS_fnc_saveInventory;
call RSTF_fnc_profileSave;

if (!_ingame) then {
	_params spawn RSTF_fnc_showConfig;
} else {
	_params spawn RSTF_fnc_showDeath;
};

call RSTF_fnc_destroyArsenalBackground;
deleteVehicle RSTF_EQUIP_WEAPON;