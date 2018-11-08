private _modesNames = [];
{
	_modesNames pushBack (_x select 0);
} foreach RSTF_MODES;

RSTF_CONFIG_VALUES = [
	["Game", [
		["RSTF_MODE_INDEX", "Game mode", "Game mode dictates rules of winning.", "select", _modesNames],
		["RSTF_LIMIT_GROUPS", "Groups per side", "Number of groups spawned for each side.", "number"],
		["RSTF_LIMIT_UNITS", "Units per group", "Number of soldiers in single group.", "number"],
		[],
		["RSTF_LIMIT_SPAWN", "Wave spawn time", "Interval in seconds in which reinforcements are spawned", "number"]
	]],
	["KOTH", [
		["RSTF_MODE_KOTH_SCORE_LIMIT", "Score to win", "One side wins after reaching this limit.", "number"],
		["RSTF_MODE_KOTH_SCORE_INTERVAL", "Point award interval", "In seconds. Interval in which is point awarded to side that holds the objective.", "number"]
	]],
	["Classic", [
		["RSTF_SCORE_LIMIT", "Score to win", "One side wins after reaching this limit.", "number"],
		["RSTF_SCORE_PER_KILL", "Score per kill", "Score you get for killing soldier.", "number"],
		["RSTF_SCORE_PER_TASK", "Score per task", "Score you get for completing task.", "number"]
	]],
	["Spawning", [
		["RSTF_SPAWN_TYPE", "Spawn to", "How to select unit to spawn to. Closest - unit closest to your death, Group - unit in your group, Random - random unit", "select", RSTF_SPAWN_TYPES],
		["RSTF_RANDOMIZE_WEAPONS", "Randomize weapons", "Each soldier will be given random weapon.", "checkbox"],
		["RSTF_RANDOMIZE_WEAPONS_RESTRICT", "Restrict weapons to sides", "When weapons are randomized, only use weapons that origins from unit faction. (Useful for mods).", "checkbox"],
		["RSTF_CUSTOM_EQUIPMENT", "Enable custom equipment", "Enable player to customize his equipment, which will be used when switching to soldier.", "checkbox"],
		[],
		["RSTF_SPAWN_TRANSPORTS", "Vehicles at spawn", "Tries to spawn transport vehicles at side spawns to cover unit spawning.", "checkbox"],
		[],
		[
			"RSTF_SPAWN_DISTANCE_MIN",
			"Minimal spawn distance",
			"Minimal spawn distance from center of battle, in meters",
			"number",
			nil,
			{
				params ["_value", "_item"];
				if (_value > RSTF_SPAWN_DISTANCE_MAX) exitWith {
					"Minimal spawn distance has to be less than maximal spawn distance."
				};
				true
			}
		],
		[
			"RSTF_SPAWN_DISTANCE_MAX",
			"Maximal spawn distance",
			"Maximal spawn distance from center of battle, in meters",
			"number",
			nil,
			{
				params ["_value", "_item"];
				if (_value < RSTF_SPAWN_DISTANCE_MIN) exitWith {
					"Maximal spawn distance has to be less than minimal spawn distance."
				};
				true
			}
		]
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
	["Money", [
		["RSTF_MONEY_ENABLED", "Allow money system", "Allow money rewards as whole", "checkbox"],
		["RSTF_MONEY_VEHICLES_ENABLED", "Allow buying vehicles", "Allow players and AI to buy vehicles for their money", "checkbox"],
		["RSTF_MONEY_VEHICLES_AI_LIMIT", "Max AI vehicles per side", "Maximum number of spawned AI vehicles per side", "number"],
		[],
		["RSTF_MONEY_START", "Starting money", "Money each unit gets at start of the mission", "number"],
		["RSTF_MONEY_PER_KILL", "Money per kill", "Award for killing enemy", "number"],
		["RSTF_MONEY_PER_TASK", "Money per task", "Award for completing task", "number"],
		["RSTF_AI_MONEY_MULTIPLIER", "AI money multiplier", "AI money reward multiplier, AI usually have less kills than player, so this helps them to catch up", "number"],
		["RSTF_MULTIKILL_BONUS", "Bonus for multikill", "Bonus money for multikills, awarded for each kill over 1", "number"]
	]],
	["UI", [
		["RSTF_UI_SHOW_VEHICLE_MARKERS", "Show vehicle markers", "Show 3D markers of friendly vehicles.", "checkbox"]
	]],
	["Tasks", [
		// ["RSTF_TASKS_IFV_ENABLED", "Neutralize IFV", "Allows 'Neutralize IFV' task", "checkbox"],
		["RSTF_TASKS_CLEAR_ENABLED", "Clear house", "Allows 'Clear house' task", "checkbox"],
		["RSTF_TASKS_EMP_ENABLED", "Neutralize emplacement", "Allows tasks for neutralizing emplacements", "checkbox"]
	]],
	["Other", [
		["RSTF_BUY_MENU_ACTION", "Buy button", "What button opens vehicle shop.", "select", RSTF_POSSIBLE_KEYS_NAMES],
		[],
		["RSTF_CLEAN", "Clear dead bodies", "Dead bodies will be destroyed after 3 minutes. This helps performance.", "checkbox"],
		["RSTF_CLEAN_INTERVAL", "Infantry clean interval", "After how much time should be dead bodies removed. In seconds.", "number"],
		["RSTF_CLEAN_INTERVAL_VEHICLES", "Vehicles clean interval", "After how much time should be empty/destroyed vehicles removed. In seconds.", "number"],
		[],
		["RSTF_WEATHER", "Weather", "Mission weather.", "select", RSTF_WEATHER_TYPES],
		["RSTF_TIME", "Daytime", "Mission daytime.", "select", RSTF_TIME_TYPES]
	]]
];