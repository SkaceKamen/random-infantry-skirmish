private ["_attachments", "_cfg", "_i", "_slot"];
_attachments = [];
_cfg = ([(configFile >> "cfgWeapons" >> _this >> "WeaponSlotsInfo"), 0, true] call BIS_fnc_returnChildren);

{
	_slot = _x;
	if (isClass(_slot)) then {
		_items = _slot >> "compatibleItems";
		if (isArray(_items)) then {
			_a = getArray(_items);
			{
				_attachments pushBack [_x, configName(_slot)];
			} foreach _a;
		} else {
			{
				_attachments pushBack [configName(_x), configName(_slot)];
			} foreach configProperties [_items];
		}
	};
} foreach _cfg;

_attachments;