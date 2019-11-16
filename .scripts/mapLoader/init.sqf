private _start = 9;
private _world_anchor = getArray(configFile >> "CfgWorlds" >> worldName >> "SafePositionAnchor");
if (count(_world_anchor) == 0) then {
	_world_anchor = [0, 0, 0];
};

private _locations = nearestLocations [_world_anchor, ["NameCityCapital","NameCity","NameVillage"], 99999999];

private _text = "";
private _map = getText(configFile >> "CfgWorlds" >> worldName >> "description");
private _template = loadFile('template.sqf');
{
	_position = getPos(_x);
	_text = _text + format["
		class Item%1
		{
			dataType=""Marker"";
			position[]={%2,%3,%4};
			name=""RSTF_POSITION_%6"";
			markerType=""ELLIPSE"";
			type=""ellipse"";
			text=""%5"";
			a=100;
			b=100;
			id=%1;
		};", _start + _foreachIndex, _position select 0, 0, _position select 1, text(_x), _foreachIndex];
} foreach _locations;

_args = [
	str(count(_locations) + 9),
	_text,
	_map
];

_result = _template;
{
	/*
	_split = _result splitString ("%" + str(_foreachIndex + 1));
	_result = _split select 0;
	for [{_i = 1}, {_i < count(_split)}, {_i = _i + 1}] do {
		_result = _result + str(_x) + (_split select _i);
	};
	*/
	_find = ("%" + str(_foreachIndex + 1));
	_findLength = count(toArray(_find));
	while { true } do {
		_index = _result find _find;
		if (_index < 0) exitWith {};
		_result = (_result select [0, _index])
			+ _x
			+ (_result select [_index + _findLength]);
	};
} foreach _args;

copyToClipboard _result;