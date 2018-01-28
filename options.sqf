//Default factions
FRIENDLY_FACTIONS = [ "BLU_F" ];
NEUTRAL_FACTIONS = [ "IND_C_F","IND_G_F","BLU_G_F","OPF_G_F" ];
ENEMY_FACTIONS = [ "OPF_F" ];

//List of banned weapons and soldiers
RSTF_WEAPONS_BANNED = [];
RSTF_SOLDIERS_BANNED = [
	"B_diver_F",
	"B_diver_exp_F",
	"B_diver_TL_F",
	"O_diver_F",
	"O_diver_exp_F",
	"O_diver_TL_F",
	"I_diver_F",
	"I_diver_exp_F",
	"I_diver_TL_F"
];

//Where to spawn
RSTF_SPAWN_TYPE = RSTF_SPAWN_CLOSEST;

//Randomize weapons ? (turn off if you're using mod)
RSTF_RANDOMIZE_WEAPONS = false;

//Randomize only weapons from origin faction
RSTF_RANDOMIZE_WEAPONS_RESTRICT = false;

RSTF_PLAYER_EQUIPMENT = [];
RSTF_CUSTOM_EQUIPMENT = true;

//Tanks per side
RSTF_LIMIT_TANKS = 0;
//Armed cars per side
RSTF_LIMIT_CARS = 0;
//Groups per side
RSTF_LIMIT_GROUPS = 5;
//Units per gruop
RSTF_LIMIT_UNITS = 4;
//Time to spawn new units
RSTF_LIMIT_SPAWN = 30;
//Time to spawn new vehicle
RSTF_LIMIT_SPAWN_VEHICLES = 30;

//Commando size
RSTF_LIMIT_COMMANDO_SIZE = 5;
//Max commando count
RSTF_LIMIT_COMMANDO = 5;

// Number of neutral groups in location
RSTF_NEUTRALS_GROUPS = 5;
// Radius of neutrals placement
RSTF_NEUTRALS_RADIUS = 500;
// Number of units in neutral group
RSTF_NEUTRALS_UNITS_MIN = 1;
RSTF_NEUTRALS_UNITS_MAX = 5;

// Should neutrals be friendly with east
RSTF_NEUTRALS_EAST = true;
// Should we spawn emplacements
RSTF_NEUTRALS_EMPLACEMENTS = true;

//Number of civilian units
RSTF_CIVILANS_UNITS_MIN = 10;
RSTF_CIVILANS_UNITS_MAX = 20;

//Score needed to win
RSTF_SCORE_LIMIT = 10000;
//Score per single kill
RSTF_SCORE_PER_KILL = 100;
RSTF_SCORE_PER_SHIP = 1000;
//Score per teamkill
RSTF_SCORE_PER_TEAMKILL = -200;
RSTF_SCORE_PER_TASK = 200;
//Score needed to call commando
RSTF_SCORE_COMMANDO = 3000;

// Money awarded for kill
RSTF_MONEY_PER_KILL = 100;
// Money awarded for task
RSTF_MONEY_PER_TASK = 200;
// Money per teamkill
RSTF_MONEY_PER_TEAMKILL = -200;

//Cleaning dead bodies
RSTF_CLEAN = true;
RSTF_CLEAN_INTERVAL = 3*60;

//Random weather and time
RSTF_WEATHER = 0;
RSTF_TIME = 13;

// How much more groups will enemy have
RSTF_ENEMY_ADVANTAGE_GROUPS = 0;
// How much more units prer groups will enemy have
RSTF_ENEMY_ADVANTAGE_UNITS = 0;
// Enemy score multiplier
RSTF_ENEMY_ADVANTAGE_SCORE = 1;

// Should spawn have transport vehicles
RSTF_SPAWN_TRANSPORTS = true;

// Allow voting/selecting battle position
RSTF_MAP_VOTE = true;
// Number of proposed positions, 0 for unlimited
RSTF_MAP_VOTE_COUNT = 10;
// Time in seconds to wait for votes
RSTF_MAP_VOTE_TIMEOUT = 60;

// Destroy IFV task
RSTF_TASKS_IFV_ENABLED = true;
// Clear house task
RSTF_TASKS_CLEAR_ENABLED = true;
// Destroy emplacement
RSTF_TASKS_EMP_ENABLED = true;