private ["_group", "_position", "_unit"];

_group = _this select 0;
_position = _this select 1;

_unit = _group createUnit [(GAME_MEN select SIDE_NEUTRAL) select round(random(count(GAME_MEN select SIDE_NEUTRAL)-1)), _position, [], 5, "NONE"];
if (isNull(_unit)) then {
	systemChat "FAILED TO SPAWN AI!";
};

_marker = createMarker [str(_unit), getPos(_unit)];
_marker setMarkerShape "ICON";
_marker setMarkerType "MIL_DOT";

[_unit] joinSilent _group;
	
_unit;