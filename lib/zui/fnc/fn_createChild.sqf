private _parent = param [0];
private _child = [param [1]] call ZUI_fnc_loadComponent;
private _refresh = param [2, true];

private _display = _parent#ZUI_L_DISPLAY;

// Add child to list of parent children
_parent#ZUI_L_CHILDREN pushBack _child;

// Build control for the child
[_child, _display, _parent#ZUI_L_PARENTGROUP] call ZUI_fnc_build;

// Refresh sizing of all children in parent to fit the new child
if (_refresh) then {
	[_parent] call ZUI_fnc_refresh;
};

_child;