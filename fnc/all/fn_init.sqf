// params [["_root", ""], ["_player", false]];

diag_log _this;

//Make sure we can spawn everything
EQ = createcenter east;
WQ = createcenter west;
RQ = createcenter resistance;
CQ = createcenter civilian;

WEST setFriend [EAST, 0];
WEST setFriend [RESISTANCE, 0];
EAST setFriend [WEST, 0];
EAST setFriend [RESISTANCE, 0];
RESISTANCE setFriend [WEST, 0];
RESISTANCE setFriend [EAST, 0];

// SCRIPTS_ROOT = _root;

// Create player if needed
/* if (_player) then {
	_unit = (creategroup west) createUnit [ "B_Soldier_F", [0, 0, 0], [], 0, "NONE" ];
	_unit allowDamage false;
	{
		_unit disableAI _x;
	} foreach ["TARGET", "AUTOTARGET", "MOVE", "ANIM", "FSM"];
	
	setPlayable _unit;
	selectPlayer _unit;
}; */

// This is needed for some MP sessions for some reason
player allowDamage false;

// Server makes all slots invincible and invisible
if (!isMultiplayer || isServer) then {
	{
		_x disableAI "ALL";
		_x allowDamage false;
		_x enableSimulationGlobal false;
		_x setPos [-1000, -1000, 1000];
		_x hideObjectGlobal true;
	} foreach allUnits;
};

// Start UI when loading from save
addMissionEventHandler ["Loaded", {
	// Start UI features
	[] spawn RSTFUI_fnc_startOverlay;

	// Update score display
	[] spawn RSTF_fnc_onScore;
}];
