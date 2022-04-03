RSTF_BATTLE_SELECTION_layout = [missionConfigFile >> "CustomSelectorDialog"] call ZUI_fnc_createDisplay;

private _display = [RSTF_BATTLE_SELECTION_layout] call ZUI_fnc_display;
_display displayAddEventHandler ["Unload", {
	{
		deleteMarker _x;
	} foreach RSTF_BS_MARKERS;

	0 spawn RSTF_fnc_showBattleSelection;
}];

private _rotInput = ([RSTF_BATTLE_SELECTION_layout, "rotation"] call ZUI_fnc_getControlById);
_rotInput ctrlSetText str(RSTF_CUSTOM_DIRECTION);
_rotInput ctrlAddEventHandler ["KeyUp", {
	private _rotInput = ([RSTF_BATTLE_SELECTION_layout, "rotation"] call ZUI_fnc_getControlById);
	private _rotation = parseNumber(ctrlText _rotInput);
	RSTF_CUSTOM_DIRECTION = _rotation % 360;
	_rotInput ctrlSetText str(RSTF_CUSTOM_DIRECTION);
	[RSTF_CUSTOM_POINT, RSTF_CUSTOM_DIRECTION] call RSTF_fnc_customSelectorPick;
}];

([RSTF_BATTLE_SELECTION_layout, "viewSwitch"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", {
	private _mapCtrl = [RSTF_BATTLE_SELECTION_layout, "map"] call ZUI_fnc_getControlById;
	_mapCtrl ctrlShow !(ctrlShown _mapCtrl);
	_mapCtrl ctrlCommit 0;
}];

([RSTF_BATTLE_SELECTION_layout, "rotatePrev"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", {
	[RSTF_CUSTOM_POINT, (RSTF_CUSTOM_DIRECTION - 10) % 360] call RSTF_fnc_customSelectorPick;
	private _rotInput = ([RSTF_BATTLE_SELECTION_layout, "rotation"] call ZUI_fnc_getControlById);
	_rotInput ctrlSetText str(RSTF_CUSTOM_DIRECTION);
}];

([RSTF_BATTLE_SELECTION_layout, "rotateNext"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", {
	[RSTF_CUSTOM_POINT, (RSTF_CUSTOM_DIRECTION + 10) % 360] call RSTF_fnc_customSelectorPick;
	private _rotInput = ([RSTF_BATTLE_SELECTION_layout, "rotation"] call ZUI_fnc_getControlById);
	_rotInput ctrlSetText str(RSTF_CUSTOM_DIRECTION);
}];

([RSTF_BATTLE_SELECTION_layout, "confirm"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", {
	publicVariable "RSTF_CUSTOM_POINT";
	publicVariable "RSTF_CUSTOM_POINT_SPAWNS";
	publicVariable "RSTF_CUSTOM_DIRECTION";
	publicVariable "RSTF_CUSTOM_DISTANCE";

	[RSTF_BATTLE_SELECTION_layout] call ZUI_fnc_closeDisplay;
}];

private _mapCtrl = [RSTF_BATTLE_SELECTION_layout, "map"] call ZUI_fnc_getControlById;
_mapCtrl ctrlAddEventHandler ["MouseButtonDown", {
	private _ctrl = _this select 0;
	private _button = _this select 1;
	private _x = _this select 2;
	private _y = _this select 3;

	if (_button == 0) then {
		private _position = _ctrl ctrlMapScreenToWorld [_x, _y];
		[_position, RSTF_CUSTOM_DIRECTION] call RSTF_fnc_customSelectorPick;
	};
}];

[RSTF_CUSTOM_POINT, RSTF_CUSTOM_DIRECTION] call RSTF_fnc_customSelectorPick;
