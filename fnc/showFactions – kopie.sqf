disableSerialization;

waitUntil { time > 0 };

showCinemaBorder false;

_ok = createDialog "RSTF_RscDialogFactions";
if (!_ok) exitWith {
	systemChat "Fatal error. Couldn't create factions dialog.";
};

_list = _this select 0;
_event = _this select 1;

RSTF_FACTIONS_LIST = _list;
RSTF_FACTIONS_EVENT = _event;
RSTF_FACTIONS_SOLDIER = objNull;
RSTF_FACTIONS_GROUP = creategroup civilian;
RSTF_FACTIONS_WEAPON = objNull;
RSTF_FACTIONS_WEAPON_HOLDER = createVehicle ["Land_Can_V3_F", RSTF_CAM_SPAWN,[],0, "CAN_COLLIDE"];
RSTF_FACTIONS_WEAPON_HOLDER setPos RSTF_CAM_SPAWN;
RSTF_FACTIONS_WEAPON_HOLDER setVectorDirAndUp [[0,0,1],[0,-1,0]];
RSTF_FACTIONS_WEAPON_HOLDER hideObject true;
RSTF_FACTIONS_WEAPON_HOLDER enableSimulation false;

_display = "RSTF_RscDialogFactions" call RSTF_getDisplay;
_display displayAddEventHandler ["unload", {
	if (!isNull(RSTF_FACTIONS_SOLDIER)) then {
		deleteVehicle RSTF_FACTIONS_SOLDIER;
		RSTF_FACTIONS_SOLDIER = objNull;
	};
	
	if (!isNull(RSTF_FACTIONS_WEAPON)) then {
		deleteVehicle RSTF_FACTIONS_WEAPON;
		RSTF_FACTIONS_WEAPON = objNull;
	};
	
	if (!isNull(RSTF_FACTIONS_WEAPON_HOLDER)) then {
		deleteVehicle RSTF_FACTIONS_WEAPON_HOLDER;
		RSTF_FACTIONS_WEAPON_HOLDER = objNull;
	};

	RSTF_FACTIONS_LIST call RSTF_FACTIONS_EVENT;
}];

_ctrl = ["RSTF_RscDialogFactions", "close"] call RSTF_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	closeDialog 0;
}];

_template = '_ctrl = ["RSTF_RscDialogFactions", "%1"] call RSTF_getCtrl;
_row = lnbCurSelRow _ctrl;
if (_row >= 0) then {
	_class = _ctrl lnbData [_row, 0];
	_index = %2 find _class;
	if (_index >= 0) then {
		%2 = [%2, _index] call BIS_fnc_removeIndex;
	} else {
		%2 set [count(%2), _class];
	};
	
	call RSTF_factionsUpdate;
};';

_method = compile(format [_template, "factions", "RSTF_FACTIONS_LIST"]);
_ctrl = ["RSTF_RscDialogFactions", "toggleFaction"] call RSTF_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", _method];
_ctrl = ["RSTF_RscDialogFactions", "factions"] call RSTF_getCtrl;
_ctrl ctrlAddEventHandler ["LBDblClick", _method];

_method = compile(format [_template, "avaibleSoldiers", "RSTF_SOLDIERS_BANNED"]);
_ctrl = ["RSTF_RscDialogFactions", "banSoldier"] call RSTF_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", _method];
_ctrl = ["RSTF_RscDialogFactions", "avaibleSoldiers"] call RSTF_getCtrl;
_ctrl ctrlAddEventHandler ["LBDblClick", _method];
_ctrl ctrlAddEventHandler ["LBSelChanged", {
	if (!isNull(RSTF_FACTIONS_SOLDIER)) then {
		deleteVehicle RSTF_FACTIONS_SOLDIER;
		RSTF_FACTIONS_SOLDIER = objNull;
	};
	
	if (!isNull(RSTF_FACTIONS_WEAPON)) then {
		deleteVehicle RSTF_FACTIONS_WEAPON;
		RSTF_FACTIONS_WEAPON = objNull;
	};
	
	_ctrl = ["RSTF_RscDialogFactions", "avaibleSoldiers"] call RSTF_getCtrl;
	_row = lnbCurSelRow _ctrl;
	if (_row >= 0) then {
		_class = _ctrl lnbData [_row, 0];
		_position = RSTF_CAM_SPAWN;
		RSTF_FACTIONS_SOLDIER = RSTF_FACTIONS_GROUP createUnit [_class, _position, [], 0, "NONE"];
		RSTF_FACTIONS_SOLDIER setpos _position;
		RSTF_FACTIONS_SOLDIER enableSimulation false;
		RSTF_CAM camSetRelPos [0, 3, 1.5];
		RSTF_CAM camCommit 0.1;
	};
}];

_method = compile(format [_template, "avaibleWeapons", "RSTF_WEAPONS_BANNED"]);
_ctrl = ["RSTF_RscDialogFactions", "banWeapon"] call RSTF_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", _method];
_ctrl = ["RSTF_RscDialogFactions", "avaibleWeapons"] call RSTF_getCtrl;
_ctrl ctrlAddEventHandler ["LBDblClick", _method];
_ctrl ctrlAddEventHandler ["LBSelChanged", {
	if (!isNull(RSTF_FACTIONS_SOLDIER)) then {
		deleteVehicle RSTF_FACTIONS_SOLDIER;
		RSTF_FACTIONS_SOLDIER = objNull;
	};
	
	if (!isNull(RSTF_FACTIONS_WEAPON)) then {
		deleteVehicle RSTF_FACTIONS_WEAPON;
		RSTF_FACTIONS_WEAPON = objNull;
	};
	 
	_ctrl = ["RSTF_RscDialogFactions", "avaibleWeapons"] call RSTF_getCtrl;
	_row = lnbCurSelRow _ctrl;
	if (_row >= 0) then {
		_class = _ctrl lnbData [_row, 0];
		_position = RSTF_CAM_SPAWN;
		RSTF_FACTIONS_WEAPON = "WeaponHolderSimulated" createVehicle _position;
		RSTF_FACTIONS_WEAPON addweaponcargo  [_class, 1];
		//RSTF_FACTIONS_WEAPON setpos _position;
		RSTF_FACTIONS_WEAPON enableSimulation false;
		RSTF_FACTIONS_WEAPON attachTo [RSTF_FACTIONS_WEAPON_HOLDER, [0,0.8,1.5]];
		
		RSTF_CAM camSetRelPos [0, 1, 0.5];
		RSTF_CAM camCommit 0.1;
	};
}];

call RSTF_factionsUpdate;