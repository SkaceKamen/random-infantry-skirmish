/*
	Author: Jan Zipek

	Description:
	Called when RSTF_POINT was changed
*/

closeDialog 0;

if (isNull(RSTF_CAM)) then {
	call RSTF_fnc_createCam;
};

RSTF_INTRO_PLAYING = true;

RSTF_CAM camSetTarget RSTF_POINT;
RSTF_CAM camSetRelPos [100, 100, 300];
RSTF_CAM camCommit 0;

private _modeName = getText(missionConfigFile >> "RSTF_Modes" >> call RSTF_fnc_getModeId >> "title");

"RSTF_START_SCREEN" cutRsc ["RscTitleDisplayEmpty", "PLAIN", 0.5, false];
private _display = uiNamespace getVariable "RscTitleDisplayEmpty";

RSTF_START_layout = [missionConfigFile >> "BattleStartDialog", _display] call ZUI_fnc_createDisplay;
[RSTF_START_layout, 1] call ZUI_fnc_fadeIn;

private _titleCtrl = [RSTF_START_layout, "title"] call ZUI_fnc_getControlById;
_titleCtrl ctrlSetText format ["Battle for %1", (RSTF_LOCATION select 0)];

private _modeCtrl = [RSTF_START_layout, "mode"] call ZUI_fnc_getControlById;
_modeCtrl ctrlSetText _modeName;

private _bluforCtrl = [RSTF_START_layout, "bluforFactions"] call ZUI_fnc_getControlById;

{
	private _cfg = configFile >> "cfgFactionClasses" >> _x;
	if (isClass(_cfg)) then {
		private _name = getText(_cfg >> "displayName");
		private _icon = getText(_cfg >> "icon");

		private _row = _bluforCtrl lnbAddRow [""];
		_bluforCtrl lnbSetTextRight [[_row, 0], _name];
		_bluforCtrl lnbSetPictureRight [[_row, 0], _icon];
	};
} foreach FRIENDLY_FACTIONS;

private _opforCtrl = [RSTF_START_layout, "opforFactions"] call ZUI_fnc_getControlById;

{
	private _cfg = configFile >> "cfgFactionClasses" >> _x;
	if (isClass(_cfg)) then {
		private _name = getText(_cfg >> "displayName");
		private _icon = getText(_cfg >> "icon");

		private _row = _opforCtrl lnbAddRow [_name];
		_opforCtrl lnbSetPicture [[_row, 0], _icon];
	};
} foreach ENEMY_FACTIONS;

sleep 6;

[RSTF_START_layout, 1] call ZUI_fnc_fadeOut;

0 spawn {
	sleep 1;
	([RSTF_START_layout] call ZUI_fnc_display) closeDisplay 0;
};

sleep 0.5;

RSTF_INTRO_PLAYING = false;