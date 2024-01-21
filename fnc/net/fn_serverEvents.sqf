["Initializing server events"] call RSTF_fnc_Log;

// Admin closed config dialog
"RSTF_CONFIG_DONE" addPublicVariableEventHandler {
	["Admin closed config, staring game"] call RSTF_fnc_Log;
	_this spawn {
		if (RSTF_MAP_VOTE) then {
			["Starting battle selection"] call RSTF_fnc_Log;
			0 spawn RSTF_fnc_startBattleSelection;
		} else {
			["Starting game without battle selection"] call RSTF_fnc_Log;
			(RSTF_POINTS select 0) call RSTF_fnc_assignPoint;
			0 spawn RSTF_fnc_start;
		}
	};
};

if (isDedicated) then {
	addMissionEventHandler [
		"PlayerConnected",
		{
			params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

			if (admin _owner > 0 && RSTF_SHOW_CONFIG == -1) then {
				// RSTF_SHOW_CONFIG = (_this select 4);
				// publicVariable "RSTF_SHOW_CONFIG";

				RSTF_SHOW_CONFIG = _owner;
				[] remoteExec ["RSTF_fnc_showConfig", _owner];
			};
		}
	];
};
