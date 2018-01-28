disableSerialization;

if (RSTF_ENDED) exitWith {
	false;
};

_display = uinamespace getVariable ['ARCADE_UI', displaynull];

for[{_i = 0}, {_i < 2}, {_i = _i + 1}] do {
	_score = RSTF_SCORE select _i;
	(_display displayCtrl (2 + _i)) ctrlSetText str(_score);
};
