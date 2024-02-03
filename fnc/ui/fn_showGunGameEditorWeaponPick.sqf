private _parent = ([RSTF_GUN_GAME_EDITOR_layout] call ZUI_fnc_display) createDisplay "RscDisplayEmpty";

RSTF_GUN_GAME_EDITOR_WEAPONS_layout = [missionConfigFile >> "GunGameEditorWeaponPickDialog", _parent] call ZUI_fnc_createDisplay;

private _display = [RSTF_GUN_GAME_EDITOR_WEAPONS_layout] call ZUI_fnc_display;
private _weapons = ["getNumber(_x >> 'scope') == 2 && (getNumber(_x >> 'type') == 1 || getNumber(_x >> 'type') == 2)" configClasses (configFile >> "CfgWeapons"), [], { getText(_x >> "displayName") }] call BIS_fnc_sortBy;

call RSTF_fnc_updateGunGameEditorWeaponPick;

private _ctrl = [RSTF_GUN_GAME_EDITOR_WEAPONS_layout, "weapons"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["LBSelChanged", {
	private _ctrl = param [0];
	private _index =  param [1];
	private _className = _ctrl lnbData [_index, 0];
	private _class = configFile >> "CfgWeapons" >> _className;
	
	private _detailCtrl = [RSTF_GUN_GAME_EDITOR_WEAPONS_layout, "detail"] call ZUI_fnc_getControlById;

	private _linkedItems = (("true" configClasses (_class >> "linkedItems")) apply {
		private _item = configFile >> "cfgWeapons" >> getText(_x >> "item");
		format["<img image='%1' /> %2", getText(_item >> "picture"), getText(_item >> "displayName")];
	});

	_detailCtrl ctrlSetStructuredText parseText format [
		"<t size='5' align='center'><img image='%1' /></t><br /><t align='center'>%2</t><br /><br />%3<br />%4",
		getText(_class >> "picture"),
		getText(_class >> "displayName"),
		if (count(_linkedItems) > 0) then {
			"<t align='center'>Attachments<br />" + (_linkedItems joinString "<br />") + "</t><br />"
		} else { "" },
		getText(_class >> "Library" >> "libTextDesc")
	];
}];

// TODO: This is duplicate code with PICK button
_ctrl ctrlAddEventHandler ["LBDblClick", {
	private _ctrl = [RSTF_GUN_GAME_EDITOR_WEAPONS_layout, "weapons"] call ZUI_fnc_getControlById;
	private _index = lnbCurSelRow _ctrl;
	if (_index < 0) exitWith {};

	private _className = _ctrl lnbData [_index, 0];

	RSTF_GUN_GAME_EDITOR_WEAPONS pushBack _className;
	[RSTF_GUN_GAME_EDITOR_WEAPONS_layout] call ZUI_fnc_closeDisplay;

	call RSTF_fnc_updateGunGameEditor;
}];

[RSTF_GUN_GAME_EDITOR_WEAPONS_layout, "cancel", "ButtonClick", {
	[RSTF_GUN_GAME_EDITOR_WEAPONS_layout] call ZUI_fnc_closeDisplay;
}] call ZUI_fnc_on;

[RSTF_GUN_GAME_EDITOR_WEAPONS_layout, "pick", "ButtonClick", {
	private _ctrl = [RSTF_GUN_GAME_EDITOR_WEAPONS_layout, "weapons"] call ZUI_fnc_getControlById;
	private _index = lnbCurSelRow _ctrl;
	if (_index < 0) exitWith {};

	private _className = _ctrl lnbData [_index, 0];

	RSTF_GUN_GAME_EDITOR_WEAPONS pushBack _className;
	[RSTF_GUN_GAME_EDITOR_WEAPONS_layout] call ZUI_fnc_closeDisplay;

	call RSTF_fnc_updateGunGameEditor;
}] call ZUI_fnc_on;


[RSTF_GUN_GAME_EDITOR_WEAPONS_layout, "search", "KeyUp", {
	call RSTF_fnc_updateGunGameEditorWeaponPick;
}] call ZUI_fnc_on;
