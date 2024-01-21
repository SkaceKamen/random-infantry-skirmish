// Sync options
{
	// Skip values that should be player specific
	if (!(_x in RSTF_PRIVATE_PROFILE_VALUES)) then {
		publicVariable _x;
	};
} foreach RSTF_PROFILE_VALUES;
