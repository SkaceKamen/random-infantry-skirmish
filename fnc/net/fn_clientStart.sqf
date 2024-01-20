/*
	Author: Jan Zipek

	Description:
	Initializes client side stuff.
*/
call RSTF_fnc_clientEvents;

[clientOwner] remoteExec ["RSTF_fnc_clientInitRequest", 2];
