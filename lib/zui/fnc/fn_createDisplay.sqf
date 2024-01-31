private _layout = param [0];
private _display = param [1, displayNull];
private _faded = param [2, false];

if (isNull(_display)) then {
	_display = (findDisplay 46) createDisplay "RscDisplayEmpty";
};

_layout = [_layout] call ZUI_fnc_loadComponent;


[_layout, _display, controlNull, _faded] call ZUI_fnc_build;
[_layout, safeZoneW, safeZoneH, safeZoneX, safeZoneY] call ZUI_fnc_refresh;

_layout;