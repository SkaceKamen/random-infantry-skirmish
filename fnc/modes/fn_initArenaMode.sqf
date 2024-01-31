RSTF_MODE_ARENA_init = {
	"Moving spawns..." call RSTF_fnc_dbg;

	// Move spawns to the center
	RSTF_SPAWNS set [SIDE_ENEMY, RSTF_POINT];
	RSTF_SPAWNS set [SIDE_FRIENDLY, RSTF_POINT];
	// TODO: Configurable?
	RSTF_RANDOM_SPAWN_WIDTH = 200;
	RSTF_RANDOM_SPAWN_HEIGHT = 200;
	RSTF_RANDOM_SPAWN_AVOID_ENEMIES = true;

	// Some features have to be disabled
	RSTF_DISABLE_GROUP_SPAWNS = true;
	RSTF_DISABLE_SPAWN_TRANSPORTS = true;
	
	// TODO: Neutrals?
	// RSTF_SPAWNS set [SIDE_NEUTRAL, RSTF_POINT];
};

RSTF_MODE_ARENA_startLoop = RSTF_MODE_CLASSIC_startLoop;

RSTF_MODE_ARENA_scoreChanged = RSTF_MODE_CLASSIC_scoreChanged;
RSTF_MODE_ARENA_unitKilled = RSTF_MODE_CLASSIC_unitKilled;
RSTF_MODE_ARENA_taskCompleted = RSTF_MODE_CLASSIC_taskCompleted;
RSTF_MODE_ARENA_vehicleKilled = RSTF_MODE_CLASSIC_vehicleKilled;
