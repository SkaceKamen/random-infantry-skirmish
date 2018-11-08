#include "dialogs\keys.hpp"

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
RSTF_SIDES_SIDES = [];
RSTF_SIDES_SIDES set [SIDE_ENEMY, east];
RSTF_SIDES_SIDES set [SIDE_FRIENDLY, west];
RSTF_SIDES_SIDES set [SIDE_NEUTRAL, resistance];

RSTF_SIDES_NAMES = [
	"OPFOR",
	"BLUFOR",
	"NEUTRALS"
];

RSTF_SIDES_COLORS = [
	"ColorRed",
	"ColorBlue",
	"ColorGreen"
];

RSTF_SIDES_COLORS_UI = [
	[1, 0, 0, 0.5],
	[0, 0, 1, 0.5],
	[0, 1, 0, 0.5]
];

RSTF_SIDES_COLORS_UI_SELECTED = [
	[1, 0.5, 0.5, 0.8],
	[0.5, 0.5, 1, 0.8],
	[0.5, 1, 0.5, 0.8]
];

RSTF_SIDES_COLORS_TEXT = [
	'#FF8A8A',
	'#9B9DFF',
	'#FF8A8A'
];

RSTF_COLOR_NEUTRAL = "ColorWhite";

// Vehicle classes [ STATIC, TRANSPORT, APC ] for each side
RSTF_VEHICLES = [ [[], [], []], [[], [], []], [[], [], []] ];
RSTF_VEHICLE_STATIC = 0;
RSTF_VEHICLE_TRANSPORT = 1;
RSTF_VEHICLE_APC = 2;
RSTF_VEHICLE_AIR = 3;
RSTF_VEHICLES_TYPES = [RSTF_VEHICLE_STATIC, RSTF_VEHICLE_TRANSPORT, RSTF_VEHICLE_APC, RSTF_VEHICLE_AIR];
RSTF_VEHICLES_NAMES = ["Static", "Transport", "APC", "Air"];

RSTF_BUYABLE_VEHICLES = [];

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

// List of message to show to player
RSTF_UI_MESSAGES = [];
// List of global game messages
RSTF_UI_GLOBAL_MESSAGES = [];

//Custom equipment
RSTF_PLAYER_EQUIPMENT = [];
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
	"RSTF_SPAWN_TYPE",
	"RSTF_CUSTOM_EQUIPMENT",
	"RSTF_PLAYER_EQUIPMENT",
	"RSTF_WEATHER",
	"RSTF_TIME",
	"RSTF_NEUTRALS_EAST",
	"RSTF_ENEMY_ADVANTAGE_GROUPS",
	"RSTF_ENEMY_ADVANTAGE_UNITS",
	"RSTF_ENEMY_ADVANTAGE_SCORE",
	"RSTF_TASKS_IFV_ENABLED",
	"RSTF_TASKS_CLEAR_ENABLED",
	"RSTF_TASKS_EMP_ENABLED",
	"RSTF_MODE_INDEX",
	"RSTF_MONEY_ENABLED",
	"RSTF_MONEY_PER_KILL",
	"RSTF_MONEY_PER_TASK",
	"RSTF_MONEY_VEHICLES_ENABLED",
	"RSTF_MONEY_VEHICLES_AI_LIMIT",
	"RSTF_AI_MONEY_MULTIPLIER",
	"RSTF_MODE_KOTH_SCORE_INTERVAL",
	"RSTF_MODE_KOTH_SCORE_LIMIT",
	"RSTF_MAP_VOTE",
	"RSTF_MAP_VOTE_COUNT",
	"RSTF_MAP_VOTE_TIMEOUT",
	"RSTF_MONEY_START",
	"RSTF_MONEY_PER_TEAMKILL",
	"RSTF_MONEY_PER_VEHICLE_COMMANDER_ASSIST",
	"RSTF_MONEY_PER_VEHICLE_KILL",
	"RSTF_MULTIKILL_BONUS",
	"RSTF_NEUTRALS_EMPLACEMENTS",
	"RSTF_SCORE_PER_TEAMKILL",
	"RSTF_SPAWN_TRANSPORTS",
	"RSTF_HINT_SUPPORT_MENU",
	"RSTF_UI_SHOW_VEHICLE_MARKERS",
	"RSTF_CLEAN",
	"RSTF_CLEAN_INTERVAL",
	"RSTF_CLEAN_INTERVAL_VEHICLES",
	"RSTF_BUY_MENU_ACTION",
	"RSTF_SPAWN_DISTANCE_MIN",
	"RSTF_SPAWN_DISTANCE_MAX"
];

// Profile values that are specific to local player (don't broadcast them)
RSTF_PRIVATE_PROFILE_VALUES = [
	"RSTF_PLAYER_EQUIPMENT"
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

// This is where list of currently active tasks is stored
RSTF_CURRENT_TASKS = [];

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

// This is used when respawning
PLAYER_SIDE = side(player);

RSTF_CHARS_NUMBERS = (toArray "0123456789");
RSTF_CHARS_FLOAT = (toArray "0123456789.");

RSTF_ADVANCED_LASTOPTIONS = [];

RSTF_POINTS = [];
RSTF_POINT_VOTES = [];
RSTF_VOTES_TIMEOUT = 0;

RSTF_MONEY_INDEX = [];
RSTF_MONEY = [];
RSTF_AI_MONEY = [];

{
	RSTF_AI_MONEY set [_x, 0];
} foreach RSTF_SIDES;

RSTF_AI_VEHICLE_WISH = call AMAP_create;

RSTF_SHOW_CONFIG = -1;
RSTF_CONFIG_DONE = false;

RSTF_REMOTE_WORK_MOVE = "AmovPknlMstpSrasWrflDnon_AinvPknlMstpSrasWrflDnon";

// List of names waiting for respawn (used to index money for AI units)
RSTF_QUEUE_NAMES = [];

// List of spawned AI vehicles
RSTF_AI_VEHICLES = [];

{
	RSTF_AI_VEHICLES set [_x, []];
	RSTF_QUEUE_NAMES set [_x, []];
} foreach RSTF_SIDES;

RSTF_NAME_POOL = call(compile(preprocessFileLineNumbers("names.sqf")));

// Time of last kill for each player
RSTF_MULTIKILL_TIMES = call AMAP_create;

// Count of kills for each player
RSTF_MULTIKILL_COUNTS = call AMAP_create;

// Text for each multikill count
RSTF_MULTIKILL_TEXTS = [
	"Double kill",
	"Triple kill",
	"Multi kill",
	"ULTRA KILL",
	"MONSTER KILL",
	"UNSTOPPABLE"
];

RTSF_USELESS_WEAPONS = [
	"FakeWeapon", "Laserdesignator_mounted", "SmokeLauncher", "CMFlareLauncher", "TruckHorn2",
	"rhsusf_weap_DummyLauncher", "rhsusf_weap_M257_8", "rhsusf_weap_CMFlareLauncher",
	"rhsusf_weap_ANALQ144", "rhsusf_weap_duke", "rhsusf_weap_M259", "rhs_weap_smokegen",
	"rhsusf_weap_ANAAQ24", "rhs_weap_DummyLauncher", "rhs_weap_902a", "rhs_weap_902b"
];

RTSF_USELESS_MAGAZINES = [
	"60Rnd_CMFlareMagazine", "rhs_mag_fueltank_UH60", "rhs_mag_ANALQ131", "rhs_mag_fueltank_UH60MEV",
	"RHS_LWIRCM_Magazine_MELB", "rhsusf_DIRCM_Magazine_120", "rhs_mag_smokegen", "rhsusf_mag_L8A3_8"
];

RSTF_RESPAWN_KILLED = objNull;
RSTF_RESPAWN_KILLER = objNull;

// This will be filled with selected mode function
RSTF_MODE_init = {};

// This will be filled with selected mode function
RSTF_MODE_unitKilled = {};

// This will be filled with selected mode function
RSTF_MODE_taskCompleted = {};

// This will be filled with selected mode function
RSTF_MODE_vehicleKilled = {};

RSTF_PREDEFINED_LOCATIONS = [];

// List of possible actions, use RSTF_POSSIBLE_KEYS_NAMES to get action name
RSTF_POSSIBLE_KEYS = ["win"];
// List of possible actions names, use RSTF_POSSIBLE_KEYS to get action
RSTF_POSSIBLE_KEYS_NAMES = ["WIN key"];

for [{_i = 1},{_i <= 20},{_i = _i + 1}] do {
	RSTF_POSSIBLE_KEYS pushBack ("User" + str(_i));
	RSTF_POSSIBLE_KEYS_NAMES pushBack ("User Action " + str(_i));
};