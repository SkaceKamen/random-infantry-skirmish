private _status = param [0];

systemChat format ["Mission Status: %1", _status];

switch (_status) do {
	case "started": {
		// Start UI & stuff
		// 0 spawn RSTF_fnc_onPointChanged;
		// 0 spawn RSTF_fnc_onStarted;

		// Respawn player into empty unit somehow
		RSTF_DEATH_POSITION = RSTF_POINT;
		RSTF_DEATH_GROUP = grpNull;

		RSTF_CURRENT_SIDE_INDEX spawn RSTF_fnc_spawnPlayer;
	};

	case "config": {
		if (call BIS_fnc_admin > 0) then {
			0 spawn RSTF_fnc_showModeSelector;
		} else {
			0 spawn RSTF_fnc_showWaiting;
		};
	};

	case "vote": {
		// TODO: Show voting UI
	};
};

