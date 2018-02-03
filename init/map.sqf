/**
 * AMAP is mapped array simulated by two arrays, one with keys and one with values.
 * TODO: Use hashing!
 */

AMAP_create = {
	[ [], [] ];
};

// Sets value at given index. Args: [_map, _key, _value]
AMAP_set = {
	private ["_amap", "_key", "_keys", "_values", "_index"];

	_amap = _this select 0;
	_key = _this select 1;
	_value = _this select 2;

	_keys = (_amap select 0);
	_values = (_amap select 1);

	_index = _keys find _key;

	if (_index == -1) then {
		_index = count(_keys);
		_keys pushBack _key;
	};

	_values set [_index, _value];
};

AMAP_get = {
	private ["_amap", "_key", "_default", "_keys", "_values", "_index"];

	_amap = _this select 0;
	_key = _this select 1;
	_default = objNull;

	if (count(_this) > 2) then {
		_default = _this select 2;
	};

	_keys = (_amap select 0);
	_values = (_amap select 1);

	_index = _keys find _key;

	if (_index == -1) exitWith {
		_default;
	};

	(_values select _index);
};

AMAP_has = {
	private ["_amap", "_key", "_keys"];

	_amap = _this select 0;
	_key = _this select 1;

	_keys = (_amap select 0);

	((_keys find _key) != -1);
};

AMAP_keys = {
	(_this select 0);
};

AMAP_values = {
	(_this select 1);
};