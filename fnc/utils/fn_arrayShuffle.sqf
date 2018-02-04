private _cnt = count _this;
private _result = [];

if (_cnt > 0) then {
	private _i = 0;
	private _idxs = [];
	_idxs resize _cnt;
	for [{_i = 0}, {_i < _cnt}, {_i = _i + 1}] do {
		_idxs set [_i, _i];
	};

	_result resize _cnt;
	for [{_i = 0}, {_i < (_cnt-1)}, {_i = _i + 1}] do {
		_result set [_i, _this select (_idxs deleteAt floor random (_cnt-_i))];
	};
	_result set [_cnt-1, _this select (_idxs select 0)];
};

_result