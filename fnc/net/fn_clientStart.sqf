/*
	Author: Jan Zipek

	Description:
	Initializes client side stuff.
*/
call RSTF_fnc_clientEvents;

if (count(RSTF_POINT) > 0) then {
	0 spawn RSTF_fnc_onPointChanged;
};

if (!RSTF_STARTED) then {
	0 spawn RSTF_fnc_showWaiting;
};
