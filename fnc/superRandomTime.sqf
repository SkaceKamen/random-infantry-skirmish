if (RSTF_TIME == 0) then {
	//Skip random time
	skipTime (random(24));

	//Wait for skipTime
	sleep 0.1;
} else {
	skipTime (-13 + RSTF_TIME);
};
