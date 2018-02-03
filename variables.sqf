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
	"RSTF_TASKS_EMP_ENABLED"
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
RSTF_CONFIG_VALUES = [
	["Game", [
		["RSTF_SCORE_LIMIT", "Score to win", "One side wins after reaching this limit.", "number"],
		["RSTF_SCORE_PER_KILL", "Score per kill", "Score you get for killing soldier.", "number"],
		["RSTF_SCORE_PER_TASK", "Score per task", "Score you get for completing task.", "number"],
		[],
		["RSTF_LIMIT_GROUPS", "Groups per side", "Number of groups spawned for each side.", "number"],
		["RSTF_LIMIT_UNITS", "Units per group", "Number of soldiers in single group.", "number"],
		[],
		["RSTF_LIMIT_SPAWN", "Wave spawn time", "Interval in seconds in which reinforcements are spawned", "number"]
	]],
	["Spawning", [
		["RSTF_SPAWN_TYPE", "Spawn to", "How to select unit to spawn to. Closest - unit closest to your death, Group - unit in your group, Random - random unit", "select", RSTF_SPAWN_TYPES],
		["RSTF_RANDOMIZE_WEAPONS", "Randomize weapons", "Each soldier will be given random weapon.", "checkbox"],
		["RSTF_RANDOMIZE_WEAPONS_RESTRICT", "Restrict weapons to sides", "When weapons are randomized, only use weapons that origins from unit faction. (Useful for mods).", "checkbox"],
		["RSTF_CUSTOM_EQUIPMENT", "Enable custom equipment", "Enable player to customize his equipment, which will be used when switching to soldier.", "checkbox"],
		[],
		["RSTF_SPAWN_TRANSPORTS", "Vehicles at spawn", "Tries to spawn transport vehicles at side spawns to cover unit spawning.", "checkbox"]
	]],
	["Neutrals", [
		["RSTF_NEUTRALS_GROUPS", "Neutral groups", "Maximum number of neutral groups spawned.", "number"],
		["RSTF_NEUTRALS_EAST", "Friendly with enemies", "Should neutrals be same side as enemies.", "checkbox"],
		["RSTF_NEUTRALS_EMPLACEMENTS", "Allow emplacements", "Spawn neutral emplacements if possible.", "checkbox"]
	]],
	["Enemy", [
		["RSTF_ENEMY_ADVANTAGE_GROUPS", "Groups advantage", "Enemy will have this much more groups.", "number"],
		["RSTF_ENEMY_ADVANTAGE_UNITS", "Units advantage", "Enemy groups will have this much more units.", "number"],
		["RSTF_ENEMY_ADVANTAGE_SCORE", "Score multiplier", "Enemy score will be multiplied by this.", "float"]
	]],
	["Map", [
		["RSTF_MAP_VOTE", "Allow map selection", "System will allow player(s) to select map.", "checkbox"],
		["RSTF_MAP_VOTE_COUNT", "Number of maps to pick", "Number of maps that will be proposed to player(s). 0 for unlimited", "number"],
		["RSTF_MAP_VOTE_TIMEOUT", "Vote timeout (secs)", "Time in seconds to wait for votes (only in multiplayer).", "number"]
	]],
	["Tasks", [
		["RSTF_TASKS_IFV_ENABLED", "Neutralize IFV", "Allows 'Neutralize IFV' task", "checkbox"],
		["RSTF_TASKS_CLEAR_ENABLED", "Clear house", "Allows 'Clear house' task", "checkbox"],
		["RSTF_TASKS_EMP_ENABLED", "Neutralize emplacement", "Allows tasks for neutralizing emplacements", "checkbox"]
	]],
	["Other", [
		["RSTF_CLEAN", "Clear dead bodies", "Dead bodies will be destroyed after 3 minutes. This helps performance.", "checkbox"],
		["RSTF_WEATHER", "Weather", "Mission weather.", "select", RSTF_WEATHER_TYPES],
		["RSTF_TIME", "Daytime", "Mission daytime.", "select", RSTF_TIME_TYPES]
	]]
];

RSTF_POINTS = [];
RSTF_POINT_VOTES = [];
RSTF_VOTES_TIMEOUT = 0;

RSTF_MONEY_INDEX = [];
RSTF_MONEY = [];

RSTF_SHOW_CONFIG = -1;
RSTF_CONFIG_DONE = false;

RSTF_REMOTE_WORK_MOVE = "AmovPknlMstpSrasWrflDnon_AinvPknlMstpSrasWrflDnon";

// Keys that triggers support menu
RSTF_KEYS_DISPLAY_SUPPORT = [DIK_LWIN, DIK_RWIN];

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

// This will be filled with selected mode function
RSTF_MODE_init = {};

// This will be filled with selected mode function
RSTF_MODE_unitKilled = {};

// This will be filled with selected mode function
RSTF_MODE_taskCompleted = {};

