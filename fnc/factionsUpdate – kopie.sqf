_ctrl = ["RSTF_RscDialogFactions", "factions"] call RSTF_getCtrl;

lnbClear _ctrl;
{
	_name = getText(ConfigFile >> "cfgFactionClasses" >> _x >> "displayName") + " (" + _x + ")";
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

_list = [RSTF_FACTIONS_LIST, true] call RSTF_loadSoldiers;
_soldiers = _list select 0;
_weapons = _list select 1;

_ctrl = ["RSTF_RscDialogFactions", "avaibleSoldiers"] call RSTF_getCtrl;
lnbClear _ctrl;
{
	_name = getText(ConfigFile >> "cfgVehicles" >> _x >> "displayName");
	_faction = getText(ConfigFile >> "cfgVehicles" >> _x >> "faction");
	_banned = "";
	if (_x in RSTF_SOLDIERS_BANNED) then {
		_banned = "BANNED";
	};
	_ctrl lnbAddRow [_name, _faction, _banned];
	_ctrl lnbSetData [[_foreachIndex, 0], _x];
	
	if (_banned != "") then {
		_ctrl lnbSetColor [[_foreachIndex, 0], [0.8,0.8,0.8,1]];
	};
} foreach _soldiers;

_ctrl = ["RSTF_RscDialogFactions", "avaibleWeapons"] call RSTF_getCtrl;
lnbClear _ctrl;
{
	_name = getText(ConfigFile >> "cfgWeapons" >> _x >> "displayName");
	_icon = getText(configFile >> "cfgWeapons" >> _x >> "picture");
	
	_banned = "";
	if (_x in RSTF_WEAPONS_BANNED) then {
		_banned = "BANNED";
	};
	_ctrl lnbAddRow [_name, _banned];
	_ctrl lnbSetData [[_foreachIndex, 0], _x];
	_ctrl lnbSetPicture [[_foreachIndex,0], _icon];
	_ctrl lnbSetPictureColor [[_foreachIndex,0], [1,1,1,1]];
	
	if (_banned != "") then {
		_ctrl lnbSetColor [[_foreachIndex, 0], [0.8,0.8,0.8,1]];
	};
} foreach _weapons;