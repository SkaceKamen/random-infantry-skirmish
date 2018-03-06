private _killed = param [0];
private _killer = param [2];
private _used = _killed getVariable ["ORIGINAL_NAME", name(_used)];
private _side = (_killed getVariable ["SPAWNED_SIDE", civilian]) call RSTF_fnc_sideIndex;

(RSTF_QUEUE_NAMES select _side) pushBack name(_killed);

if (isServer) then {
	if (isPlayer(_killer)) then {
		private _kills = [RSTF_MULTIKILL_COUNTS, _killer, 0] call AMAP_get;
		[RSTF_MULTIKILL_TIMES, _killer, time] call AMAP_set;
		[RSTF_MULTIKILL_COUNTS, _killer, _kills + 1] call AMAP_set;
	};
};

// Only call this callback on valid events
if (!isNull(_killer) && !isNull(_killed)) then {
	_this call RSTF_MODE_unitKilled;
};
