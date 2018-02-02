private _killed = param [0];
private _used = _killed getVariable ["ORIGINAL_NAME", name(_used)];
private _side = (_killed getVariable ["SPAWNED_SIDE", civilian]) call RSTF_fnc_sideIndex;

(RSTF_QUEUE_NAMES select _side) pushBack name(_killed);

_this call RSTF_MODE_unitKilled;
