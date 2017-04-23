_dialogName = "RSTF_RscDialogEquip";
_ok = createDialog _dialogName;
if (!_ok) exitWith {
	systemChat "Fatal error. Couldn't create equip dialog.";
};

RSTF_EQUIP_RETURN = [RSTF_EQUIP_SPAWN, RSTF_CAM_TARGET];
if (count(_this) > 0) then {
	RSTF_EQUIP_RETURN = _this;
};

RTSF_STANCE_PISTOL = "AidlPercMstpSrasWpstDnon_AI";
RSTF_STANCE_RIFLE = "AidlPercMstpSrasWrflDnon_G01_player";

RSTF_EQUIP_SPAWN = RSTF_CAM_SPAWN vectorAdd [0.5,0,0];
RSTF_EQUIP_WEAPON = (creategroup civilian) createUnit ["C_Soldier_VR_F", RSTF_EQUIP_SPAWN, [], 0, "NONE"];
RSTF_EQUIP_WEAPON setBehaviour "COMBAT";
RSTF_EQUIP_WEAPON setUnitPos "UP";
RSTF_EQUIP_WEAPON setDir 270;
RSTF_EQUIP_WEAPON switchMove RSTF_STANCE_RIFLE;
RSTF_EQUIP_WEAPON enableSimulation false;

group(RSTF_EQUIP_WEAPON) setFormDir 270;

RSTF_EQUIP_DIRECTION = 90;
RSTF_EQUIP_YAW = 0;

if (isNull(RSTF_CAM)) then {
	RSTF_CAM = "camera" camCreate RSTF_CAM_TARGET;
};

RSTF_CAM camSetTarget (RSTF_CAM_TARGET vectorAdd [0,0,0.5]);
RSTF_CAM camSetFocus [2, 1];
RSTF_CAM camSetRelPos [cos(RSTF_EQUIP_DIRECTION) * 2, sin(RSTF_EQUIP_DIRECTION) * 2, 0];
RSTF_CAM camCommit 0.1;

RSTF_MOUSE = false;

_display = _dialogName call RSTF_fnc_getDisplay;
_display displayAddEventHandler ["MouseButtonDown", {
	RSTF_MOUSE = true;
}];
_display displayAddEventHandler ["MouseButtonUp", {
	RSTF_MOUSE = false;
}];

_display displayAddEventHandler ["MouseMoving", {
	if (RSTF_MOUSE) then {
		RSTF_EQUIP_DIRECTION = RSTF_EQUIP_DIRECTION + (_this select 1);
		RSTF_EQUIP_YAW = RSTF_EQUIP_YAW + (_this select 2);

		RSTF_CAM camSetRelPos [
			cos(RSTF_EQUIP_DIRECTION) * cos(RSTF_EQUIP_YAW) * 2,
			sin(RSTF_EQUIP_DIRECTION) * cos(RSTF_EQUIP_YAW) * 2,
			sin(RSTF_EQUIP_YAW) * 2
		];
		RSTF_CAM camCommit 0;
	};
}];

_display displayAddEventHandler ["unload", {
	_group = group(RSTF_EQUIP_WEAPON);
	deleteVehicle RSTF_EQUIP_WEAPON;
	deleteGroup _group;

	RSTF_CAM camSetPos (RSTF_EQUIP_RETURN select 0);
	RSTF_CAM camSetTarget (RSTF_EQUIP_RETURN select 1);
	RSTF_CAM camCommit 0;
}];


_side = SIDE_FRIENDLY;
_weapons = RSTF_WEAPONS;
_launchers = RSTF_LAUNCHERS;
_pistols = RSTF_PISTOLS;

if (RSTF_RANDOMIZE_WEAPONS_RESTRICT) then {
	_weapons = RSTF_WEAPONS select _side;
	_launchers = RSTF_LAUNCHERS select _side;
	_pistols = RSTF_PISTOLS select _side;
};

_secondary = _pistols + _launchers;

_ctrl = [_dialogName, "primary"] call RSTF_fnc_getCtrl;

_index = 0;
_selected = 0;
_displayed = [];
{
	_data = _x call BIS_fnc_weaponComponents;
	if (!((_data select 0) in _displayed)) then {
		_weapon = _data select 0;
		_name = getText(configFile >> "cfgWeapons" >> _weapon >> "displayName");
		_icon = getText(configFile >> "cfgWeapons" >> _weapon >> "picture");

		_ctrl lnbAddRow [_name];
		_ctrl lnbSetData [[_index, 0], _weapon];
		_ctrl lnbSetPicture [[_index, 0], _icon];

		if (_weapon == RSTF_PLAYER_PRIMARY) then {
			_selected = _index;
		};

		_displayed pushBack _weapon;

		_index = _index + 1;
	};
} foreach _weapons;

_ctrl ctrlAddEventHandler ["LBSelChanged", {
	_ctrl = _this select 0;
	_index = lnbCurSelRow _ctrl;
	if (_index >= 0) then {
		_weapon = _ctrl lnbData [_index, 0];
		_attachments = _weapon call RSTF_fnc_getAttachments;

		_ctrl = ["RSTF_RscDialogEquip", "attachments"] call RSTF_fnc_getCtrl;
		lnbClear _ctrl;

		_toremove = [];
		{
			if (!(_x in _attachments)) then {
				_found = false;
				_type = _x select 1;
				_index = _foreachIndex;
				{
					if (_x select 1 == _type) exitWith {
						_found = true;
						RSTF_PLAYER_ATTACHMENTS set [_index, _x];
					};
				} foreach _attachments;

				if (!_found) then {
					_toremove pushBack _foreachIndex;
				};
			};
		} foreach RSTF_PLAYER_ATTACHMENTS;

		_tmp = RSTF_PLAYER_ATTACHMENTS;
		RSTF_PLAYER_ATTACHMENTS = [];
		{
			if (!(_foreachIndex in _toremove)) then {
				RSTF_PLAYER_ATTACHMENTS pushBack _x;
			};
		} foreach _tmp;

		{
			_name = getText(configFile >> "cfgWeapons" >> _x select 0 >> "displayName");
			_icon = getText(configFile >> "cfgWeapons" >> _x select 0 >> "picture");

			_ctrl lnbAddRow [_name];
			_ctrl lnbSetData [[_foreachIndex, 0], _x select 0];
			_ctrl lnbSetData [[_foreachIndex, 1], _x select 1];
			_ctrl lnbSetPicture [[_foreachIndex, 0], _icon];
		} foreach _attachments;

		RSTF_PLAYER_PRIMARY = _weapon;
	};

	call RSTF_refreshEquippedAttachments;
}];

_ctrl lnbSetCurSelRow _selected;

RSTF_refreshEquippedAttachments = {
	_ctrl = ["RSTF_RscDialogEquip", "equipped"] call RSTF_fnc_getCtrl;
	lnbClear _ctrl;

	{
		_name = getText(configFile >> "cfgWeapons" >> _x select 0 >> "displayName");
		_icon = getText(configFile >> "cfgWeapons" >> _x select 0 >> "picture");

		_ctrl lnbAddRow [_name];
		_ctrl lnbSetData [[_foreachIndex, 0], _x select 0];
		_ctrl lnbSetData [[_foreachIndex, 1], _x select 1];
		_ctrl lnbSetPicture [[_foreachIndex, 0], _icon];
	} foreach RSTF_PLAYER_ATTACHMENTS;

	call RSTF_refreshWeapon;
};

RSTF_refreshWeapon = {
	_weapon = RSTF_PLAYER_PRIMARY;
	_attachments = RSTF_PLAYER_ATTACHMENTS;

	removeAllWeapons RSTF_EQUIP_WEAPON;

	/*
	if (getNumber(configFile >> "cfgWeapons" >> _weapon >> "type") == 2) then {
		RSTF_EQUIP_WEAPON enableSimulation true;
		RSTF_EQUIP_WEAPON switchMove RSTF_STANCE_PISTOL;
		RSTF_EQUIP_WEAPON enableSimulation false;
		//RSTF_EQUIP_WEAPON setPos RSTF_EQUIP_SPAWN;
	} else {
		RSTF_EQUIP_WEAPON enableSimulation true;
		RSTF_EQUIP_WEAPON switchMove RSTF_STANCE_RIFLE;
		RSTF_EQUIP_WEAPON enableSimulation false;
		//RSTF_EQUIP_WEAPON setPos RSTF_EQUIP_SPAWN;
	};
	*/

	RSTF_EQUIP_WEAPON addWeapon _weapon;
	{
		RSTF_EQUIP_WEAPON addWeaponItem [_weapon, _x select 0];
	} foreach _attachments;
};

RSTF_equipAttachmentAdd = {
	_ctrl = ["RSTF_RscDialogEquip", "attachments"] call RSTF_fnc_getCtrl;
	_index = lnbCurSelRow _ctrl;
	if (_index >= 0) then {
		_attachment = _ctrl lnbData [_index, 0];
		_category = _ctrl lnbData [_index, 1];

		_exists = false;
		_replacement = -1;
		{
			if (_x select 0 == _attachment) exitWith {
				_exists = true;
			};
			if (_x select 1 == _category) exitWith {
				_replacement = _foreachIndex;
			};
		} foreach RSTF_PLAYER_ATTACHMENTS;

		if (!_exists) then {
			_item = [_attachment, _category];
			if (_replacement != -1) then {
				RSTF_PLAYER_ATTACHMENTS set [_replacement, _item];
			} else {
				RSTF_PLAYER_ATTACHMENTS pushBack _item;
			};

			call RSTF_refreshEquippedAttachments;
		};
	};
};

RSTF_equipAttachmentRemove = {
	_ctrl = ["RSTF_RscDialogEquip", "equipped"] call RSTF_fnc_getCtrl;
	_index = lnbCurSelRow _ctrl;
	if (_index >= 0) then {
		RSTF_PLAYER_ATTACHMENTS = [RSTF_PLAYER_ATTACHMENTS, [_index]] call BIS_fnc_removeIndex;
		call RSTF_refreshEquippedAttachments;
	};
};

_ctrl = [_dialogName, "secondary"] call RSTF_fnc_getCtrl;

_ctrl lnbAddRow ["Nothing"];
_ctrl lnbSetData [[0, 0], ""];

_ctrl lnbAddRow ["Grenades"];
_ctrl lnbSetData [[1, 0], "grenades"];
_ctrl lnbSetPicture [[1, 0], getText(ConfigFile >> "cfgMagazines" >> "handgrenade" >> "picture")];

if (RSTF_PLAYER_SECONDARY == "") then {
	_ctrl lnbSetCurSelRow 0;
};

if (RSTF_PLAYER_SECONDARY == "grenades") then {
	_ctrl lnbSetCurSelRow 1;
};

{
	_name = getText(configFile >> "cfgWeapons" >> _x >> "displayName");
	_icon = getText(configFile >> "cfgWeapons" >> _x >> "picture");

	_ctrl lnbAddRow [_name];
	_ctrl lnbSetData [[2 + _foreachIndex, 0], _x];
	_ctrl lnbSetPicture [[2 + _foreachIndex, 0], _icon];

	if (_x == RSTF_PLAYER_SECONDARY) then {
		_ctrl lnbSetCurSelRow (2 + _foreachIndex);
	};
} foreach _secondary;

_ctrl ctrlAddEventHandler ["LBSelChanged", {
	_ctrl = _this select 0;
	_index = lnbCurSelRow _ctrl;
	if (_index >= 0) then {
		_weapon = _ctrl lnbData [_index, 0];
		RSTF_PLAYER_SECONDARY = _weapon;
	};
}];

_ctrl = ["RSTF_RscDialogEquip", "attachments"] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["LBDblClick", RSTF_equipAttachmentAdd];
_ctrl = ["RSTF_RscDialogEquip", "buttonAttach"] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", RSTF_equipAttachmentAdd];


_ctrl = [_dialogName, "equipped"] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["LBDblClick", RSTF_equipAttachmentRemove];
_ctrl = ["RSTF_RscDialogEquip", "buttonDeattach"] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", RSTF_equipAttachmentAdd];

_ctrl = ["RSTF_RscDialogEquip", "buttonBack"] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", { closeDialog 0; }];

call RSTF_refreshEquippedAttachments;