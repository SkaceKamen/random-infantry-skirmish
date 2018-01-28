private _killed = param [0];

_this call RSTF_MODE_unitKilled;

if (RSTF_CLEAN) then {
	_killed spawn {
		sleep RSTF_CLEAN_INTERVAL;
		deleteVehicle _this;
	};
};