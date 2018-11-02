private _killed = param [0];
private _killer = param [2];

// Only call this callback on valid events
if (!isNull(_killer) && !isNull(_killed)) then {
	_this call RSTF_MODE_vehicleKilled;
};
