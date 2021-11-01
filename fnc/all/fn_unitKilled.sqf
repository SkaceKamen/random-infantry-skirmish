private _killed = param [0];
private _killer = param [2];
private _side = (_killed getVariable ["SPAWNED_SIDE", civilian]) call RSTF_fnc_sideIndex;

(RSTF_QUEUE_NAMES select _side) pushBack name(_killed);

if (isServer) then {
	if (isPlayer(_killer)) then {
		private _uid = getPlayerUID _killer;
		private _kills = RSTF_MULTIKILL_COUNTS getOrDefault [_uid, 0];
		RSTF_MULTIKILL_TIMES set [_uid, time];
		RSTF_MULTIKILL_COUNTS set [_uid, _kills + 1];
	};
};

// Only call this callback on valid events
if (!isNull(_killer) && !isNull(_killed)) then {
	_this call RSTF_MODE_unitKilled;
};
