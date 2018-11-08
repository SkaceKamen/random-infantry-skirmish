_ctrl = ["RSTF_RscDialogFactions", "factions"] call RSTF_fnc_getCtrl;

_expandCache = {
	params ["_ctrl", "_path"];
	private _list = [RSTF_EXPANDED, _ctrl] call AMAP_get;
	private _ex = [];
	{
		_ex pushBack _x;
		if (_list find (_ex call RSTF_fnc_pathString) != -1) then {
			_ctrl tvExpand _ex;
		};
	} foreach _path;
};

lnbClear _ctrl;
{
	_name = getText(ConfigFile >> "cfgFactionClasses" >> _x >> "displayName");
	_icon = getText(ConfigFile >> "cfgFactionClasses" >> _x >> "icon");
	_selected = "";

	if (_x in RSTF_FACTIONS_LIST) then {
		_selected = "SELECTED";
	};

	_ctrl lnbAddRow [_name, _selected];
	_ctrl lnbSetPicture [[_foreachIndex,0], _icon];
	_ctrl lnbSetPictureColor [[_foreachIndex,0], [1,1,1,1]];
	_ctrl lnbSetData [[_foreachIndex, 0], _x];

	if (_selected == "") then {
		_ctrl lnbSetColor [[_foreachIndex, 0], [0.8,0.8,0.8,1]];
	};
} foreach RSTF_FACTIONS;

_list = [RSTF_FACTIONS_LIST, true] call RSTF_fnc_loadSoldiers;
_soldiers = _list select 0;
_weapons = _list select 1;

_ctrl = ["RSTF_RscDialogFactions", "avaibleSoldiers"] call RSTF_fnc_getCtrl;
_sel = tvCurSel _ctrl;
tvClear _ctrl;

_roots = call AMAP_create;

{
	_cfg = ConfigFile >> "cfgVehicles" >> _x;
	_name = getText(_cfg >> "displayName");
	_icon = getText(_cfg >> "icon");
	_icon = getText(ConfigFile >> "cfgVehicleIcons" >> _icon);
	_faction = getText(_cfg >> "faction");
	_factionName = getText(ConfigFile >> "cfgFactionClasses" >> _faction >> "displayName");
	_dlcIcon = "";
	if (isText(_cfg >> "dlc")) then {
		_dlc = getText(_cfg >> "dlc");
		_dlcIcon = getText(configFile >> "cfgMods" >> _dlc >> "logoSmall");
	};

	_class = getText(_cfg >> "vehicleClass");
	_className = getText(ConfigFile >> "cfgVehicleClasses" >> _class >> "displayName");

	if (isText(_cfg >> "editorSubcategory")) then {
		_class = getText(_cfg >> "editorSubcategory");
		_className = getText(ConfigFile >> "cfgEditorSubcategories" >> _class >> "displayName");
	};

	_banned = "";
	if (_x in RSTF_SOLDIERS_BANNED) then {
		_banned = "[BANNED] ";
	};

	_factionBranch = [_roots, _faction, []] call AMAP_get;
	if (count(_factionBranch) == 0) then {
		_factionBranch = [
			_ctrl tvAdd [[], _factionName],
			call AMAP_create
		];
		_ctrl tvSetData [[_factionBranch select 0], _faction];
		[_roots, _faction, _factionBranch] call AMAP_set;
	};

	_classBranch = [_factionBranch select 1, _class, -1] call AMAP_get;
	if (_classBranch == -1) then {
		_classBranch = _ctrl tvAdd [[_factionBranch select 0], _className];
		_ctrl tvSetData [[_factionBranch select 0, _classBranch], _class];
		[_factionBranch select 1, _class, _classBranch] call AMAP_set;
	};

	_path = [_factionBranch select 0, _classBranch];
	_branch = _ctrl tvAdd [_path, _banned + _name];
	_path pushBack _branch;
	_ctrl tvSetData [_path, _x];
	_ctrl tvSetPicture [_path, _icon];
	if (_dlcIcon != "") then {
		_ctrl tvSetPictureRight [_path, _dlcIcon];
	};

	if (_banned != "") then {
		_ctrl tvSetPictureColor [_path, [0,0,0,1]];
	};

	[_ctrl, _path] call _expandCache;
} foreach _soldiers;

_vehicle_types = [RSTF_FACTIONS_LIST, true] call RSTF_fnc_loadVehicles;
{
	_name = RSTF_VEHICLES_NAMES select _foreachIndex;
	_vehicles = _vehicle_types select _foreachIndex;
	_path = [_ctrl tvAdd [[], _name]];

	{
		_banned = "";
		if (_x in RSTF_SOLDIERS_BANNED) then {
			_banned = "[BANNED] ";
		};

		_icon = getText(configFile >> "cfgVehicles" >> _x >> "icon");
		if (isText(ConfigFile >> "cfgVehicleIcons" >> _icon)) then {
			_icon = getText(ConfigFile >> "cfgVehicleIcons" >> _icon);
		};

		_subpath = _path + [ _ctrl tvAdd [_path, _banned + getText(configFile >> "cfgVehicles" >> _x >> "displayName")] ];
		_ctrl tvSetData [_subpath, _x];
		_ctrl tvSetPicture [_subpath, _icon];
		if (_banned != "") then {
			_ctrl tvSetPictureColor [_subpath, [0,0,0,1]];
		};
	} foreach _vehicles;
} foreach RSTF_VEHICLES_TYPES;

//_ctrl tvSetCurSel _sel;

_ctrl = ["RSTF_RscDialogFactions", "avaibleWeapons"] call RSTF_fnc_getCtrl;
_sel = tvCurSel _ctrl;
tvClear _ctrl;

_roots = call AMAP_create;
[_roots, 1, _ctrl tvAdd [[], "Primary"]] call AMAP_set;
[_roots, 2, _ctrl tvAdd [[], "Handguns"]] call AMAP_set;
[_roots, 4, _ctrl tvAdd [[], "Secondary"]] call AMAP_set;

_other = _ctrl tvAdd [[], "Other"];

{
	_cfg = configFile >> "cfgWeapons" >> _x;
	_name = getText(_cfg >> "displayName");
	_icon = getText(_cfg >> "picture");
	_type = getNumber(_cfg >> "type");
	_dlcIcon = "";
	if (isText(_cfg >> "dlc")) then {
		_dlc = getText(_cfg >> "dlc");
		_dlcIcon = getText(configFile >> "cfgMods" >> _dlc >> "logoSmall");
	};

	_banned = "";
	if (_x in RSTF_WEAPONS_BANNED) then {
		_banned = "[BANNED] ";
	};

	_branch = [_roots, _type, _other] call AMAP_get;
	_path = [_branch];
	_path pushBack (_ctrl tvAdd [_path, _banned + _name]);
	_ctrl tvSetData [_path, _x];
	_ctrl tvSetPicture [_path, _icon];
	if (_dlcIcon != "") then {
		_ctrl tvSetPictureRight [_path, _dlcIcon];
	};

	if (_banned != "") then {
		_ctrl tvSetPictureColor [_path, [0,0,0,1]];
	};

	[_ctrl, _path] call _expandCache;
} foreach _weapons;

//_ctrl tvSetCurSel _sel;