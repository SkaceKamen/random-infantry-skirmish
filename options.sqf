//Default factions
FRIENDLY_FACTIONS = [ "BLU_F" ];
NEUTRAL_FACTIONS = [ "IND_C_F","IND_G_F","BLU_G_F","OPF_G_F" ];
ENEMY_FACTIONS = [ "OPF_F" ];

//List of banned weapons and soldiers
RSTF_WEAPONS_BANNED = [];
// TODO: Add more default banned - usually crews and pilots
RSTF_SOLDIERS_BANNED = [
	"B_diver_F",
	"B_diver_exp_F",
	"B_diver_TL_F",
	"B_Pilot_F",
	"B_helicrew_F",
	"B_helipilot_F",
	"O_diver_F",
	"O_diver_exp_F",
	"O_diver_TL_F",
	"O_Pilot_F",
	"O_helicrew_F",
	"O_helipilot_F",
	"I_diver_F",
	"I_diver_exp_F",
	"I_diver_TL_F",
	"I_Pilot_F",
	"I_helicrew_F",
	"I_helipilot_F"
];

//Where to spawn
RSTF_SPAWN_TYPE = RSTF_SPAWN_CLOSEST;

// Currently selected gamemode index in modes list
RSTF_MODE_INDEX = 1;

//Randomize weapons ? (turn off if you're using mod)
RSTF_RANDOMIZE_WEAPONS = false;

//Randomize only weapons from origin faction
RSTF_RANDOMIZE_WEAPONS_RESTRICT = false;

RSTF_PLAYER_EQUIPMENT = [];
RSTF_CUSTOM_EQUIPMENT = false;

//Groups per side
RSTF_LIMIT_GROUPS = 5;
//Units per gruop
RSTF_LIMIT_UNITS = 4;
//Time to spawn new units
RSTF_LIMIT_SPAWN = 30;

// Minimum skill
RSTF_SKILL_MIN = 0.5;
// Maximum skill
RSTF_SKILL_MAX = 1;

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

// Score needed to win
RSTF_SCORE_LIMIT = 10000;
// Score per single kill
RSTF_SCORE_PER_KILL = 100;
// Score per teamkill
RSTF_SCORE_PER_TEAMKILL = -200;
// Score awarded for completing task
RSTF_SCORE_PER_TASK = 200;
// Score awarded for killing vehicle
RSTF_SCORE_PER_VEHICLE = 500;

// Money awarded for kill
RSTF_MONEY_PER_KILL = 100;
// Money awarded for task
RSTF_MONEY_PER_TASK = 200;
// Money per teamkill
RSTF_MONEY_PER_TEAMKILL = -200;
// Bonus for each kill of multikill
RSTF_MULTIKILL_BONUS = 50;
// Money for vehicle kill as commander
RSTF_MONEY_PER_VEHICLE_COMMANDER_ASSIST = 50;
// Money for killing vehicle
RSTF_MONEY_PER_VEHICLE_KILL = 500;

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

// Enable money system
RSTF_MONEY_ENABLED = true;

// Enable vehicles for money system
RSTF_MONEY_VEHICLES_ENABLED = true;

// Maximum number of AI vehicles per side
RSTF_MONEY_VEHICLES_AI_LIMIT = 5;

// Money at start
RSTF_MONEY_START = 0;

// From wich distance is kill considered far enought to be special
RSTF_KILL_DISTANCE_BONUS = 100;

// Multiplier applied to AI money earning
RSTF_AI_MONEY_MULTIPLIER = 5;

// Money added to each AI per-side per second
RSTF_AI_MONEY_PER_SECOND = 2;

// Interval in which are points awarded to side holding objective in KOTH
RSTF_MODE_KOTH_SCORE_INTERVAL = 10;

// Score limit in KOTH
RSTF_MODE_KOTH_SCORE_LIMIT = 100;

// Display support menu hint
RSTF_HINT_SUPPORT_MENU = true;

// Show 3D vehicle markers
RSTF_UI_SHOW_VEHICLE_MARKERS = true;

// Garbage collector settings
RSTF_CLEAN = true;
RSTF_CLEAN_INTERVAL = 3*60;
RSTF_CLEAN_INTERVAL_VEHICLES = 3*60;

RSTF_BUY_MENU_ACTION = 0;

// Minimal infantry spawn distance in meters
RSTF_SPAWN_DISTANCE_MIN = 350;
// Maximal infantry spawn distance in meters
RSTF_SPAWN_DISTANCE_MAX = 400;

RSTF_MODE_PUSH_SCORE_INTERVAL = 2;
RSTF_MODE_PUSH_SCORE_LIMIT = 20;
RSTF_MODE_PUSH_POINT_COUNT = 5;
// Number of defensive emplacements spawned per point
RSTF_MODE_PUSH_EMPLACEMENTS_PER_POINT = 5;
// Spawn emplacements on the first point
RSTF_MODE_PUSH_FIRST_POINT_EMPLACEMENTS = true;

// Remove un-historical items from map
RSTF_CLEAR_HISTORIC_ITEMS = false;

// Always set player as a leader of squad
RSTF_PLAYER_ALWAYS_LEADER = true;

// Enable players to buy support artillery
RSTF_ENABLE_SUPPORTS = true;

RSTF_MODE_DEFEND_SCORE_INTERVAL = 2;
RSTF_MODE_DEFEND_SCORE_LIMIT = 20;
RSTF_MODE_DEFEND_DURATION = 30*60;
RSTF_MODE_DEFEND_RADIUS = 50;

// Allow player to access AI vehicles
RSTF_SPAWN_VEHICLES_UNLOCKED = false;

// Enable AI vehicles
RSTF_AI_VEHICLES_ENABLED = true;

// Skip initial mode select screen
RSTF_SKIP_MODE_SELECT = false;