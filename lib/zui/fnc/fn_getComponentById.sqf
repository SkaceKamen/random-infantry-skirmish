private _layout = param [0];
private _id = param [1];
private _default = param [2, []];
private _ids = _layout select ZUI_L_IDS;
private _index = _ids#0 find _id;
if (_index >= 0) exitWith {
	(_ids#1 select _index);
};

if (RSTF_DEBUG) then {
	format["Failed to find %1 in %2", _id, configName(_layout#ZUI_L_CONFIG)] call RSTF_fnc_dbg;
};

_default;