// Indexes used for various arrays
SIDE_ENEMY = 0;
SIDE_FRIENDLY = 1;
SIDE_NEUTRAL = 2;

// Center point
RSTF_POINT = [];
RSTF_LOCATION = locationNull;

// Building that shouldn't be populated
RSTF_BANNED_BUILDINGS = [ "Land_Pier_F", "Land_Metal_Shed_F" ];

// Sides in this conflict
RSTF_SIDES = [ SIDE_ENEMY, SIDE_FRIENDLY, SIDE_NEUTRAL ];

// Vehicle classes [ STATIC, TRANSPORT, APC ] for each side
RSTF_VEHICLES = [ [[], [], []], [[], [], []], [[], [], []] ];
RSTF_VEHICLE_STATIC = 0;
RSTF_VEHICLE_TRANSPORT = 1;
RSTF_VEHICLE_APC = 2;
RSTF_VEHICLES_TYPES = [RSTF_VEHICLE_STATIC, RSTF_VEHICLE_TRANSPORT, RSTF_VEHICLE_APC];

// Men classes for each side (inc neutral)
RSTF_MEN = [ [], [], [] ];
// Command groups
RSTF_COMMANDO = [ [], [] ];
// Actual state of score for each side
RSTF_SCORE = [ 0, 0 ];

//Weapon classes - universal
RSTF_WEAPONS = [];
RSTF_LAUNCHERS = [];

//Was player spawned (assigned to unit)
PLAYER_SPAWNED = false;

//All groups, per side
RSTF_GROUPS = [ [], [] ];

//Neutral houses - used for random mission
RSRF_NEUTRAL_HOUSES = [];

//Vehicle groups
RSTF_VEHICLE_GROUPS = [ [], [], [] ];

//Rate of UI update
RSTF_UI_STEP = 0.5;

//List of message to show to player
RSTF_UI_MESSAGES = [];

//Custom equipment
RSTF_PLAYER_PRIMARY = "";
RSTF_PLAYER_SECONDARY = "";
RSTF_PLAYER_ATTACHMENTS = [];
RSTF_CUSTOM_EQUIPMENT = true;

//Camera used for cam effects
RSTF_CAM = objNull;
RSTF_BACKUP_PLAYER = player;

RSTF_ENDED = false;
RSTF_WATER = false;

RSTF_WEATHER_TYPES = [
	"Random",
	"Sunny",
	"Rainy",
	"Storm"
];

RSTF_WEATHER_OPTIONS = [
	nil,
	[[0,0.2], 0, [0,2]],
	[[0.2,0.7], [0.2,0.7], [0,5]],
	[[0.8,1], [0.8,1], [5,20]]
];

RSTF_TIME_TYPES = [
	"Random"
];

for[{_i = 0},{_i < 24},{_i = _i + 1}] do {
	RSTF_TIME_TYPES pushBack (format["%1:00", _i]);
};


RSTF_SPAWN_TYPES = [
	"Closest unit",
	"My group unit",
	"Random unit"
];
RSTF_SPAWN_CLOSEST = 0;
RSTF_SPAWN_GROUP = 1;
RSTF_SPAWN_RANDOM = 2;

RSTF_SPAWN_TYPE = RSTF_SPAWN_RANDOM;

//RSTF_SELECTED_WORLD = worldName;

// List of values saved to profile namespace when saving options.
RSTF_PROFILE_VALUES = [
	"FRIENDLY_FACTIONS",
	"NEUTRAL_FACTIONS",
	"ENEMY_FACTIONS",
	"RSTF_WEAPONS_BANNED",
	"RSTF_SOLDIERS_BANNED",
	"RSTF_RANDOMIZE_WEAPONS",
	"RSTF_RANDOMIZE_WEAPONS_RESTRICT",
	"RSTF_LIMIT_GROUPS",
	"RSTF_LIMIT_UNITS",
	"RSTF_LIMIT_SPAWN",
	"RSTF_NEUTRALS_GROUPS",
	"RSTF_SCORE_LIMIT",
	"RSTF_SCORE_PER_KILL",
	"RSTF_SCORE_PER_TASK",
	"RSTF_CLEAN",
	"RSTF_SPAWN_TYPE",
	"RSTF_CUSTOM_EQUIPMENT",
	"RSTF_PLAYER_PRIMARY",
	"RSTF_PLAYER_SECONDARY",
	"RSTF_PLAYER_ATTACHMENTS",
	"RSTF_WEATHER",
	"RSTF_TIME"
	//"RSTF_SELECTED_WORLD"
];

// List of spawns, indexed by side
RSTF_SPAWNS = [];
// List of vehicles that can be used for spawn, indexed by side
RSTF_SPAWN_VEHICLES = [[], []];
// List of buildings that can be used for spawn, indexed by side
RSTF_SPAWN_BUILDINGS = [[], []];

/**
 * List of available side missions.
 * Format of one side mission is [
 *   string ident,
 *   function returning if task is available,
 *   function to start new task of this type
 *   function to resume existing task
 * ]
 */
RSTF_TASKS = [];

// Identifies position of variable in task info
RSTF_TASK_IDENT = 0;
RSTF_TASK_AVAILABLE = 1;
RSTF_TASK_START = 2;
RSTF_TASK_LOAD = 3;

// This is where current task info is saved
RSTF_TASK = "";
RSTF_TASK_TYPE = "";
RSTF_TASK_PARAMS = [];

RSTF_CAM_SPAWN = [0,0,1000];
RSTF_CAM_TARGET = RSTF_CAM_SPAWN vectorAdd [0,0, 1];

if (isNil("RSTF_SKIP_CONFIG")) then {
	RSTF_SKIP_CONFIG = false;
};

// Inidicates if game has started
RSTF_STARTED = false;

// Contains units assinged to players
RSTF_ASSIGNED_UNITS = [];

// Used for multiplayer, contains kill info
RSTF_KILL_OCCURED = [];