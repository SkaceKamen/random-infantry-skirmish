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

RSTF_EXPANDED = call AMAP_create;

_display = "RSTF_RscDialogFactions" call RSTF_fnc_getDisplay;
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

_ctrl = ["RSTF_RscDialogFactions", "close"] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	closeDialog 0;
}];

_template_list = '_ctrl = ["RSTF_RscDialogFactions", "%1"] call RSTF_fnc_getCtrl;
_row = lnbCurSelRow _ctrl;
if (_row >= 0) then {
	_class = _ctrl lnbData [_row, 0];
	_index = %2 find _class;
	if (_index >= 0) then {
		%2 = [%2, _index] call BIS_fnc_removeIndex;
	} else {
		%2 set [count(%2), _class];
	};
	
	call RSTF_fnc_factionsUpdate;
};';

_template_tree = '_ctrl = ["RSTF_RscDialogFactions", "%1"] call RSTF_fnc_getCtrl;
_path = tvCurSel _ctrl;
if (count(_path) == %3) then {
	_class = _ctrl tvData _path;
	_index = %2 find _class;
	_text = ((_ctrl tvText _path) splitString "\[BANNED\] ") joinString "";
	
	if (_index >= 0) then {
		%2 = [%2, _index] call BIS_fnc_removeIndex;
		_ctrl tvSetText [_path, _text];
		_ctrl tvSetPictureColor [_path, [1,1,1,1]];
	} else {
		%2 set [count(%2), _class];
		_ctrl tvSetText [_path, "[BANNED] " + _text];
		_ctrl tvSetPictureColor [_path, [0,0,0,1]];
	};
	
	//call RSTF_fnc_factionsUpdate;
};';

_method = compile(format [_template_list, "factions", "RSTF_FACTIONS_LIST"]);
_ctrl = ["RSTF_RscDialogFactions", "toggleFaction"] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", _method];
_ctrl = ["RSTF_RscDialogFactions", "factions"] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["LBDblClick", _method];

_expand = {
	_ctrl = _this select 0;
	_path = (_this select 1) call RSTF_fnc_pathString;
	
	_list = [RSTF_EXPANDED, _ctrl] call AMAP_get;
	_list pushBackUnique _path;
};

_collapse = {
	_ctrl = _this select 0;
	_path = (_this select 1) call RSTF_fnc_pathString;
	
	_list = [RSTF_EXPANDED, _ctrl] call AMAP_get;
	_index = _list find _path;
	if (_index != -1) then {
		[RSTF_EXPANDED, _ctrl, [_list, _index] call BIS_fnc_removeIndex] call AMAP_set;
	};
};

_method = compile(format [_template_tree, "avaibleSoldiers", "RSTF_SOLDIERS_BANNED", 3]);
_ctrl = ["RSTF_RscDialogFactions", "banSoldier"] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", _method];
_ctrl = ["RSTF_RscDialogFactions", "avaibleSoldiers"] call RSTF_fnc_getCtrl;

[RSTF_EXPANDED, _ctrl, []] call AMAP_set;
_ctrl ctrlAddEventHandler ["TreeExpanded", _expand];
_ctrl ctrlAddEventHandler ["TreeCollapsed", _collapse];

_ctrl ctrlAddEventHandler ["TreeDblClick", _method];
_ctrl ctrlAddEventHandler ["TreeSelChanged", {
	if (!isNull(RSTF_FACTIONS_SOLDIER)) then {
		deleteVehicle RSTF_FACTIONS_SOLDIER;
		RSTF_FACTIONS_SOLDIER = objNull;
	};
	
	if (!isNull(RSTF_FACTIONS_WEAPON)) then {
		deleteVehicle RSTF_FACTIONS_WEAPON;
		RSTF_FACTIONS_WEAPON = objNull;
	};
	
	_ctrl = ["RSTF_RscDialogFactions", "avaibleSoldiers"] call RSTF_fnc_getCtrl;
	_path = tvCurSel _ctrl;
	if (count(_path) == 3) then {
		_class = _ctrl tvData _path;
		_position = RSTF_CAM_SPAWN;
		RSTF_FACTIONS_SOLDIER = RSTF_FACTIONS_GROUP createUnit [_class, _position, [], 0, "NONE"];
		RSTF_FACTIONS_SOLDIER setpos _position;
		RSTF_FACTIONS_SOLDIER enableSimulation false;
		RSTF_CAM camSetRelPos [0, 3, 1.5];
		RSTF_CAM camCommit 0.1;
	};
}];

_method = compile(format [_template_tree, "avaibleWeapons", "RSTF_WEAPONS_BANNED", 2]);
_ctrl = ["RSTF_RscDialogFactions", "banWeapon"] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", _method];
_ctrl = ["RSTF_RscDialogFactions", "avaibleWeapons"] call RSTF_fnc_getCtrl;

[RSTF_EXPANDED, _ctrl, []] call AMAP_set;
_ctrl ctrlAddEventHandler ["TreeExpanded", _expand];
_ctrl ctrlAddEventHandler ["TreeCollapsed", _collapse];

_ctrl ctrlAddEventHandler ["TreeDblClick", _method];
_ctrl ctrlAddEventHandler ["TreeSelChanged", {
	if (!isNull(RSTF_FACTIONS_SOLDIER)) then {
		deleteVehicle RSTF_FACTIONS_SOLDIER;
		RSTF_FACTIONS_SOLDIER = objNull;
	};
	
	if (!isNull(RSTF_FACTIONS_WEAPON)) then {
		deleteVehicle RSTF_FACTIONS_WEAPON;
		RSTF_FACTIONS_WEAPON = objNull;
	};
	 
	_ctrl = ["RSTF_RscDialogFactions", "avaibleWeapons"] call RSTF_fnc_getCtrl;
	_path = tvCurSel _ctrl;
	if (count(_path) == 2) then {
		_class = _ctrl tvData _path;
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

call RSTF_fnc_factionsUpdate;