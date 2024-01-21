_side = _this select 0;
_killer = _this select 1;
_body = _this select 2;

RSTF_DEATH_SHOWN = true;

if (isNull(RSTF_CAM)) then {
	RSTF_CAM = "camera" camCreate getPos(_body);
};

// Move camera above player body
RSTF_CAM camSetPos (getPos(_body) vectorAdd [0, 0, 1]);
RSTF_CAM camSetTarget _body;
RSTF_CAM cameraEffect ["internal", "back"];
RSTF_CAM camCommit 0;
RSTF_CAM camSetRelPos [3, 0, 3];
RSTF_CAM camCommit 2;

// Focus on killer too, if possible
if (!isNull(_killer)) then {
	[_killer] spawn {
		private _killer = param [0];
		
		waitUntil { camCommitted RSTF_CAM };

		if (RSTF_DEATH_SHOWN) then {
			RSTF_CAM camSetTarget _killer;
			RSTF_CAM camSetRelPos [0.5, 0, 3];
			RSTF_CAM camCommit 5;
		};
	};
};

"RSTF_DEATH_SCREEN" cutRsc ["RscTitleDisplayEmpty", "PLAIN", 0.5, false];
private _display = uiNamespace getVariable "RscTitleDisplayEmpty";

// Show title
RSTF_DEATH_DIALOG_BG_layout = [missionConfigFile >> "DeathTitle", _display] call ZUI_fnc_createDisplay;
[RSTF_DEATH_DIALOG_BG_layout, 1] call ZUI_fnc_fadeIn;

sleep 1;

RSTF_DEATH_DIALOG_layout = [missionConfigFile >> "DeathDialog"] call ZUI_fnc_createDisplay;
[RSTF_DEATH_DIALOG_layout, 0.5] call ZUI_fnc_fadeIn;

RSTF_DEATH_SIDE = _side;
RSTF_DEATH_KILLER = _killer;
RSTF_DEATH_BODY = _body;

_display = [RSTF_DEATH_DIALOG_layout] call ZUI_fnc_display;
_display displayAddEventHandler ["unload", {
	RSTF_DEATH_SHOWN = false;
	if (_this select 1 != 1) then {
		([RSTF_DEATH_DIALOG_BG_layout] call ZUI_fnc_display) closeDisplay 0;
		RSTF_DEATH_SIDE spawn RSTF_fnc_spawnPlayer
	};
}];

_ctrl = [RSTF_DEATH_DIALOG_layout, "respawn"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	RSTF_DEATH_SHOWN = false;
	RSTF_CAM camCommit 0;
	
	([RSTF_DEATH_DIALOG_layout] call ZUI_fnc_display) closeDisplay 0;
}];
ctrlSetFocus _ctrl;

_ctrl = [RSTF_DEATH_DIALOG_layout, "settings"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	[[RSTF_DEATH_DIALOG_layout] call ZUI_fnc_display, true] spawn RSTF_fnc_showAdvancedConfig;
}];

_ctrl = [RSTF_DEATH_DIALOG_layout, "equipment"] call ZUI_fnc_getControlById;
_ctrl ctrlEnable RSTF_CUSTOM_EQUIPMENT;

if (!RSTF_CUSTOM_EQUIPMENT) then {
	_ctrl ctrlSetTooltip "Custom equipment is disabled";
};

_ctrl ctrlAddEventHandler ["ButtonClick", {
	([RSTF_DEATH_DIALOG_layout] call ZUI_fnc_display) closeDisplay 1;
	[true, [RSTF_DEATH_SIDE, RSTF_DEATH_KILLER, RSTF_DEATH_BODY]] spawn RSTF_fnc_showEquip;
	true;
}];

if (isNull(_killer)) then {
	_ctrl = [RSTF_DEATH_DIALOG_layout, "killer"] call ZUI_fnc_getControlById;
	_ctrl ctrlShow false;
	_ctrl = [RSTF_DEATH_DIALOG_layout, "weapon"] call ZUI_fnc_getControlById;
	_ctrl ctrlShow false;
	_ctrl = [RSTF_DEATH_DIALOG_layout, "weaponImage"] call ZUI_fnc_getControlById;
	_ctrl ctrlShow false;
} else {
	private _cfg = configFile >> "cfgVehicles" >> typeof(_killer);
	private _cfgName = getText(_cfg >> "displayName");
	_isMan = getNumber(configFile >> "cfgVehicles" >> typeof(_killer) >> "isMan");
	_distance = _killer distance _body;
	_weapon = currentWeapon(_killer);
	_name = getText(configFile >> "cfgWeapons" >> _weapon >> "displayName");
	_image = "";

	if (vehicle(_killer) == _killer && _isMan == 1) then {
		_image = getText(configFile >> "cfgWeapons" >> _weapon >> "picture");
	} else {
		_image = getText(configFile >> "cfgVehicles" >> typeOf(vehicle(_killer)) >> "picture");
	};

	_ctrl = [RSTF_DEATH_DIALOG_layout, "killer"] call ZUI_fnc_getControlById;
	_ctrl ctrlSetText ("Killed by " + (if (isPlayer(_killer)) then { name(_killer) } else { _cfgName }));
	_ctrl = [RSTF_DEATH_DIALOG_layout, "weapon"] call ZUI_fnc_getControlById;
	_ctrl ctrlSetText ("With " + _name + " from distance of " + str(round(_distance)) + " m");
	_ctrl = [RSTF_DEATH_DIALOG_layout, "weaponImage"] call ZUI_fnc_getControlById;
	_ctrl ctrlSetText _image;
};
