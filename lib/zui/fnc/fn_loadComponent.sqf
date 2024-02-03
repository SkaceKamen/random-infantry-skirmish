private _config = param [0, objNull, [missionConfigFile]];
private _parent = param [1, []];

private _children = [];
private _ids = [ [], [] ];
private _overrides = [ [], [] ];

private _layout = [
	_config,
	_children,
	controlNull,
	displayNull,
	[0,0],
	[0,0],
	_ids,
	controlNull,
	_overrides,
	true
];

{
	private _component = [_x, _layout] call ZUI_fnc_loadComponent;
	private _childIds = _component select ZUI_L_IDS;

	_ids set [0, _ids#0 + _childIds#0];
	_ids set [1, _ids#1 + _childIds#1];

	_children pushBack _component;

	if (isText(_x >> "id")) then {
		_ids#0 pushBack getText(_x >> "id");
		_ids#1 pushBack _component;
	};
} foreach ("true" configClasses _config);

_layout;
