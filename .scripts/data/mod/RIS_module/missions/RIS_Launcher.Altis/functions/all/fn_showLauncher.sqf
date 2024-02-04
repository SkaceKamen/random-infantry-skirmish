// Create dialog
private _layout  = [missionConfigFile >> "LauncherDialog"] call ZUI_fnc_createDisplay;
private _missions = "true" configClasses (configFile >> "cfgMissions" >> "Missions" >> "RIS_Missions");
private _list = [_layout, "list"] call ZUI_fnc_getControlById;

RIS_layout = _layout;
RIS_maps = [];
RIS_selected = configNull;

{
	private _target = getText(_x >> "risMap");
	// TODO: Check if map exists
	// TODO: Load map info
	_list lnbAddRow [_target, configName(_x)];
	RIS_maps pushBack _x;
} foreach _missions;

_list ctrlAddEventHandler ["LBSelChanged", {
	private _index = param [1];
	if (_index >= 0 && _index < count(RIS_maps)) then {
		RIS_selected = RIS_maps select _index;
	};
}];

([_layout, "start"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", {
	if (!isNull(RIS_selected)) then {
		[RIS_layout] call ZUI_fnc_closeDisplay;

		playMission ["", getText(RIS_selected >> "directory"), true];

		_zero = findDisplay 0;
		{
			if (_x != _zero) then {
				_x closeDisplay 1;
			};
		} foreach allDisplays;

		// failMission "END1";
	};
}];

([_layout, "cancel"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", {
	[RIS_layout] call ZUI_fnc_closeDisplay;

	endMission "END1";
}];
