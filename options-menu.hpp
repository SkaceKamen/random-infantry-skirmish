#define IS_PUSH "(call RSTF_fnc_getModeId) == 'Push' || (call RSTF_fnc_getModeId) == 'PushDefense'"
#define IS_KOTH "(call RSTF_fnc_getModeId) == 'KOTH'"
#define IS_ARENA "(call RSTF_fnc_getModeId) == 'Arena'"
#define SPACER class spacer2##__LINE__ { type = "spacer"; }
#define CONDITIONAL_SPACER(COND) class spacer2##__LINE__ { type = "spacer"; visible = COND; }

class RSTF_Options {
	class General {
		title = "Mode";
		ingame=1;

		class Items {
			class RSTF_MODE_SELECTED {
				title="Game mode";
				description="Game mode dictates rules of winning.";
				type="select";
				optionsVariable="RSTF_MODES_OPTIONS";
				optionType="string";
			};

			// Arena
			class RSTF_MODE_ARENA_RECTANGLE_SIZE {
				title="Rectangle size";
				description="Size of the rectangle where the fighting happens";
				type="number";
				visible=IS_ARENA;
				postfix="meters";
			};

			CONDITIONAL_SPACER(IS_ARENA);

			// KOTH
			class RSTF_MODE_KOTH_SCORE_LIMIT {
				title="Score to win";
				description="One side wins after reaching this limit.";
				type="number";
				visible=IS_KOTH;
				ingame=1;
			};
			class RSTF_MODE_KOTH_SCORE_INTERVAL {
				title="Point award interval";
				description="In seconds. Interval in which is point awarded to side that holds the objective.";
				type="number";
				visible=IS_KOTH;
				ingame=1;
			};

			CONDITIONAL_SPACER(IS_KOTH);

			class RSTF_MODE_KOTH_POINT_RADIUS {
				title="Point radius";
				description="In meters, capture point radius";
				type="number";
				visible=IS_KOTH;
				postfix="meters";
			};

			// Classic
			class RSTF_SCORE_LIMIT {
				title="Score to win";
				description="One side wins after reaching this limit.";
				type="number";
				visible = "(call RSTF_fnc_getModeId) == 'Classic' || (call RSTF_fnc_getModeId) == 'Arena'";
				ingame=1;
			};
			class RSTF_SCORE_PER_KILL {
				title="Score per kill";
				description="Score you get for killing soldier.";
				type="number";
				visible = "(call RSTF_fnc_getModeId) == 'Classic' || (call RSTF_fnc_getModeId) == 'Arena'";
				ingame=1;
			};
			class RSTF_SCORE_PER_TASK {
				title="Score per task";
				description="Score you get for completing task.";
				type="number";
				visible = "(call RSTF_fnc_getModeId) == 'Classic'";
				ingame=1;
			};
			class RSTF_ENEMY_ADVANTAGE_SCORE {
				title="Enemy score multiplier";
				description="Enemy score will be multiplied by this.";
				type="float";
				visible = "(call RSTF_fnc_getModeId) == 'Classic' || (call RSTF_fnc_getModeId) == 'Arena'";
				ingame=1;
			};

			// Push
			class RSTF_MODE_PUSH_SIDE {
				title="Side";
				description="Which side will BLUFOR be on";
				type="select";
				visible=IS_PUSH;
				optionsVariable="RSTF_MODE_PUSH_SIDE_OPTIONS";
			};
			
			CONDITIONAL_SPACER(IS_PUSH);

			class RSTF_MODE_PUSH_POINT_COUNT {
				title="Points to capture";
				description="Number of points that you have to capture to win";
				type="number";
				visible=IS_PUSH;
			};
			class RSTF_MODE_PUSH_POINT_RADIUS {
				title="Point capture radius";
				description="Capture radius of the point in meters";
				type="number";
				visible=IS_PUSH;
				postfix="meters";
			};

			CONDITIONAL_SPACER(IS_PUSH);
			
			class RSTF_MODE_PUSH_ATTACKERS_ADVANTAGE {
				title="Attackers group advantage";
				description="Attackers will have this much more groups.";
				type="number";
				visible=IS_PUSH;
				ingame=1;
			};

			CONDITIONAL_SPACER(IS_PUSH);

			class RSTF_MODE_PUSH_SCORE_LIMIT {
				title="Score to capture";
				description="Point is captured when one side reaches this number of points";
				type="number";
				visible=IS_PUSH;
				ingame=1;
			};

			class RSTF_MODE_PUSH_SCORE_INTERVAL {
				title="Point award interval";
				description="In seconds. Interval in which is point awarded to side that holds the objective.";
				type="number";
				visible=IS_PUSH;
				ingame=1;
				postfix="seconds";
			};

			CONDITIONAL_SPACER(IS_PUSH);

			class RSTF_MODE_PUSH_EMPLACEMENTS_PER_POINT {
				title="Number of defensive emplacements";
				description="Number of defensive emplacements spawned, only works when faction has suitable static emplacements.";
				type="number";
				visible=IS_PUSH;
			};

			// Defense
			class RSTF_MODE_DEFEND_DURATION {
				title="Duration";
				description="Number of seconds that the point has to be defended to win the battle.";
				type="number";
				visible = "(call RSTF_fnc_getModeId) == 'Defense'";
				ingame=1;
				postfix="seconds";
			};
			class RSTF_MODE_DEFEND_RADIUS {
				title="Defended point radius";
				description="Capture radius of the defended point";
				type="number";
				visible = "(call RSTF_fnc_getModeId) == 'Defense'";
				ingame=1;
				postfix="meters";
			};
			class RSTF_MODE_DEFEND_SCORE_LIMIT {
				title="Score to capture";
				description="Point is lost when attackers reach this score";
				type="number";
				visible = "(call RSTF_fnc_getModeId) == 'Defense'";
				ingame=1;
			};
			class RSTF_MODE_DEFEND_SCORE_INTERVAL {
				title="Point award interval";
				description="In seconds. Interval in which is point awarded to attackers when they have majority on the objective.";
				type="number";
				visible = "(call RSTF_fnc_getModeId) == 'Defense'";
				ingame=1;
				postfix="seconds";
			};
		};
	};
	
	class Spawning {
		title = "Spawning";
		ingame=1;

		class Items {
			class RSTF_LIMIT_GROUPS {
				title="Groups per side";
				description="Number of groups spawned for each side.";
				type="number";
				ingame=1;
			};
			class RSTF_LIMIT_UNITS {
				title="Units per group";
				description="Number of soldiers in single group.";
				type="number";
				ingame=1;
			};

			class RSTF_ENEMY_ADVANTAGE_GROUPS {
				title="Enemy groups advantage";
				description="Enemy will have this much more groups.";
				type="number";
				ingame=1;
			};
			class RSTF_ENEMY_ADVANTAGE_UNITS {
				title="Enemy units advantage";
				description="Enemy groups will have this much more units.";
				type="number";
				ingame=1;
			};

			SPACER;

			class RSTF_LIMIT_SPAWN {
				title="Wave spawn time";
				description="Interval in seconds in which reinforcements are spawned";
				type="number";
				ingame=1;
				postfix="seconds";
			};

			SPACER;

			class RSTF_SPAWN_AT_OWN_GROUP {
				title="Spawn new units near group";
				description="Spawn new units near group when there's no enemy near";
				type="checkbox";
				ingame=1;
			};
			class RSTF_SPAWN_REUSE_GROUPS {
				title="Reuse existing groups when spawning";
				description="Don't create new groups when spawning new units, reuse existing ones. Can cause AI issues";
				type="checkbox";
				ingame=1;
				enabled="!RSTF_SPAWN_AT_OWN_GROUP";
			};

			SPACER;

			class RSTF_SKILL_MIN {
				title="Minimum unit skill";
				description="Minimum unit skill, value from 0 to 1";
				type="float";
				validator="_this call RSTF_VALIDATOR_SKILL_MIN";
				ingame=1;
			};
			class RSTF_SKILL_MAX {
				title="Maximum unit skill";
				description="Maximum unit skill, value from 0 to 1";
				type="float";
				validator="_this call RSTF_VALIDATOR_SKILL_MAX";
				ingame=1;
			};

			SPACER;

			class RSTF_SPAWN_DISTANCE_MIN {
				title="Minimal spawn distance";
				description="Minimal spawn distance from center of battle, in meters";
				type="number";
				validator="_this call RSTF_VALIDATOR_SPAWN_DISTANCE_MIN";
				ingame=1;
				postfix="meters";
			};
			class RSTF_SPAWN_DISTANCE_MAX {
				title="Maximal spawn distance";
				description="Maximal spawn distance from center of battle, in meters";
				type="number";
				validator="_this call RSTF_VALIDATOR_SPAWN_DISTANCE_MAX";
				ingame=1;
				postfix="meters";
			};

			SPACER;

			class RSTF_GROUP_UNIT_RESTRICTION {
				title="Restrict units in group";
				description="Restricts which units are placed in same group. When set to faction, each unit in group will have same randomy selected faction. Same with category.";
				type="select";
				optionsVariable="RSTF_GROUP_UNIT_RESTRICTION_OPTIONS";
				ingame=1;
			};
			class RSTF_RANDOMIZE_WEAPONS {
				title="Randomize weapons for units";
				description="Each soldier will be given random weapon.";
				type="checkbox";
				ingame=1;
			};
			class RSTF_RANDOMIZE_WEAPONS_RESTRICT {
				title="Restrict random weapons to sides";
				description="When weapons are randomized, only use weapons that origins from unit faction. (Useful for weapon mods).";
				type="checkbox";
				disabled="!RSTF_RANDOMIZE_WEAPONS";
				ingame=1;
			};

			SPACER;

			class RSTF_SPAWN_TRANSPORTS {
				title="Spawn vehicles at spawn";
				description="Tries to spawn transport vehicles at side spawns to cover unit spawning.";
				type="checkbox";
			};
		};
	};

	class Player {
		title = "Player";
		ingame=1;
		client=1;

		class Items {
			class RSTF_SPAWN_TYPE {
				title="Respawn player to";
				description="How to select unit to spawn to. Closest - unit closest to your death, Group - unit in your group, Random - random unit";
				type="select";
				optionsVariable="RSTF_SPAWN_TYPES";
				ingame=1;
			};
			class RSTF_PLAYER_ALWAYS_LEADER {
				title="Always set player as leader";
				description="Always set player as a leader of group of selected unit";
				type="checkbox";
				optionsVariable="RSTF_SPAWN_TYPES";
				ingame=1;
			};
			class RSTF_CUSTOM_EQUIPMENT {
				title="Enable player custom equipment";
				description="Enable player to customize his equipment, which will be used when switching to soldier.";
				type="checkbox";
				ingame=1;
			};

			SPACER;

			class RSTF_BUY_MENU_ACTION {
				title="Buy shortcut";
				description="What button opens vehicle shop.";
				type="select";
				optionsVariable="RSTF_POSSIBLE_KEYS_NAMES";
				ingame=1;
				client=1;
			};
			class RSTF_BUY_MENU_SHOW_AS_ACTION {
				title="Add 'Open Shop' context menu item";
				description="Enable 'Open Shop' action";
				type="checkbox";
				ingame=1;
				client=1;
			};
		};
	};

	class Neutrals {
		title = "Neutrals";
		visible = "call RSTF_fnc_doesModeSupportNeutrals";

		class Items {
			class RSTF_NEUTRALS_EAST {
				title="Friendly with enemies";
				description="Should neutrals be same side as enemies.";
				type="checkbox";
			};

			SPACER;

			class RSTF_NEUTRALS_GROUPS {
				title="Number of buildings occupied by neutrals";
				description="Maximum number of neutral groups spawned.";
				type="number";
			};
			class RSTF_NEUTRALS_UNITS_MIN {
				title = "Minimum number of units in building";
				description = "Minimum number of units that can be spawned in single building";
				type = "number";
			};
			class RSTF_NEUTRALS_UNITS_MAX {
				title = "Maximum number of units in building";
				description = "Maximum number of units that can be spawned in single building";
				type = "number";
			};

			SPACER;

			class RSTF_NEUTRALS_EMPLACEMENTS {
				title="Allow emplacements";
				description="Spawn neutral emplacements if possible.";
				type="checkbox";
			};
			class RSTF_NEUTRALS_EMPLACEMENTS_COUNT {
				title="Neutral emplacements count";
				description="Number of neutral emplacements spawned.";
				type="number";
			};
		};
	};
	class Map {
		title = "Map";

		class Items {
			class RSTF_MAP_VOTE {
				title="Allow map selection";
				description="System will allow player(s) to select map.";
				type="checkbox";
			};
			class RSTF_MAP_VOTE_COUNT {
				title="Number of maps to pick";
				description="Number of maps that will be proposed to player(s). 0 for unlimited";
				type="number";
				disabled="!RSTF_MAP_VOTE";
			};
			class RSTF_MAP_VOTE_TIMEOUT {
				title="Vote timeout (secs)";
				description="Time in seconds to wait for votes (only in multiplayer).";
				type="number";
				visible="isMultiplayer";
			};
		};
	};
	class Money {
		title = "Money";
		ingame=1;

		class Items {
			class RSTF_MONEY_ENABLED {
				title="Allow money system";
				description="Allow money rewards as whole";
				type="checkbox";
			};

			SPACER;

			class RSTF_MONEY_VEHICLES_ENABLED {
				title="Allow buying vehicles by players";
				description="Allow players to buy vehicles for their money";
				type="checkbox";
				disabled="!RSTF_MONEY_ENABLED";
				ingame=1;
			};
			class RSTF_ENABLE_SUPPORTS {
				title="Allow buying supports";
				description="Allow players to buy supports (artillery)";
				type="checkbox";
				disabled="!RSTF_MONEY_ENABLED";
				ingame=1;
			};
			class RSTF_ENABLE_AI_SUPPORT_VEHICLES {
				title="Allow buying AI vehicles by players";
				description="Allow players to buy support AI vehicles";
				type="checkbox";
				disabled="!RSTF_MONEY_ENABLED";
				ingame=1;
			};
			class RSTF_AI_VEHICLE_SUPPORT_COST_MULTIPLIER {
				title="AI vehicle support price multiplier";
				description="Vehicle cost multiplier applied when player buys vehicle as AI support";
				type="number";
				disabled="!RSTF_MONEY_ENABLED || !RSTF_ENABLE_AI_SUPPORT_VEHICLES";
				ingame=1;
			};

			SPACER;

			class RSTF_MONEY_START {
				title="Starting money";
				description="Money each unit gets at start of the mission";
				type="number";
				disabled="!RSTF_MONEY_ENABLED";
			};
			class RSTF_MONEY_PER_KILL {
				title="Money per kill";
				description="Award for killing enemy";
				type="number";
				disabled="!RSTF_MONEY_ENABLED";
				ingame=1;
			};
			class RSTF_MULTIKILL_BONUS {
				title="Bonus for multikill";
				description="Bonus money for multikills, awarded for each kill over 1";
				type="number";
				disabled="!RSTF_MONEY_ENABLED";
				ingame=1;
			};
			class RSTF_MONEY_PER_TASK {
				title="Money per task";
				description="Award for completing task";
				type="number";
				disabled="!RSTF_MONEY_ENABLED";
				ingame=1;
			};

			SPACER;

			class RSTF_VEHICLE_COST_MULTIPLIER {
				title="Vehicle cost multiplier";
				description="Mutliplier applied to cost of every vehicle";
				type="number";
				disabled="!RSTF_MONEY_ENABLED";
				ingame=1;
			};

			SPACER;
			
			class RSTF_AI_MONEY_MULTIPLIER {
				title="AI money multiplier";
				description="AI money reward multiplier, AI usually have less kills than player, so this helps them to catch up";
				type="number";
				disabled="!RSTF_MONEY_ENABLED";
				ingame=1;
			};
			class RSTF_AI_MONEY_PER_SECOND {
				title="AI money per second";
				description="Money added per second to all AI units, allows AI to catch up with player";
				type="number";
				disabled="!RSTF_MONEY_ENABLED";
				ingame=1;
			};
		};
	};
	class Vehicles {
		title = "Vehicles";
		ingame=1;

		class Items {
			class RSTF_AI_VEHICLES_ENABLED {
				title="Allow AI Vehicles";
				description="Allow AI to buy vehicles for their money";
				type="checkbox";
				ingame=1;
			};

			class RSTF_SPAWN_VEHICLES_UNLOCKED {
				title="Allow players to access AI vehicles";
				description="Allow players to enter AI vehicles";
				type="checkbox";
				disabled="!RSTF_AI_VEHICLES_ENABLED";
				ingame=1;
			};

			SPACER;

			class RSTF_MONEY_VEHICLES_AI_LIMIT {
				title="Max AI vehicles per side";
				description="Maximum number of spawned AI vehicles per side";
				type="number";
				disabled="!RSTF_AI_VEHICLES_ENABLED";
				ingame=1;
			};

			class RSTF_MONEY_VEHICLES_AI_CLASS_LIMITS {
				title="Limit vehicles per class";
				description="Limit how many vehicles can spawn per-class. Global limit will be applied too.";
				type="checkbox";
				disabled="!RSTF_AI_VEHICLES_ENABLED";
				ingame=1;
			};

			class RSTF_MONEY_VEHICLES_AI_AIR_LIMIT {
				title="Max air AI vehicles per side";
				description="Maximum number of spawned air AI vehicles per side. Global limit will be applied too.";
				type="number";
				disabled="!RSTF_AI_VEHICLES_ENABLED || !RSTF_MONEY_VEHICLES_AI_CLASS_LIMITS";
				ingame=1;
			};

			class RSTF_MONEY_VEHICLES_AI_LAND_LIMIT {
				title="Max land AI vehicles per side";
				description="Maximum number of spawned land AI vehicles per side. Global limit will be applied too.";
				type="number";
				disabled="!RSTF_AI_VEHICLES_ENABLED || !RSTF_MONEY_VEHICLES_AI_CLASS_LIMITS";
				ingame=1;
			};

			SPACER;

			class RSTF_VEHICLES_SPAWN_DISTANCE {
				title="Vehicles spawn distance";
				description="Distance from side spawn that vehicles spawn at";
				type="number";
				ingame=1;
				postfix="meters";
			};

			class RSTF_AIR_VEHICLES_SPAWN_DISTANCE {
				title="Air vehicles spawn distance";
				description="Distance from center that air vehicles spawn at";
				type="number";
				ingame=1;
				postfix="meters";
			};

			class RSTF_PLANES_SPAWN_DISANCE {
				title="Planes spawn distance";
				description="Distance from center that planes spawn at";
				type="number";
				ingame=1;
				postfix="meters";
			};
		};
	};
	class UI {
		title = "UI";
		ingame=1;

		class Items {
			class RSTF_UI_SHOW_PLAYER_FEED {
				title="Show player feed";
				description="Show messages when player score changes.";
				type="checkbox";
				ingame=1;
			};

			class RSTF_UI_SHOW_PLAYER_MONEY {
				title="Show player money";
				description="Show current player money.";
				type="checkbox";
				ingame=1;
			};

			class RSTF_UI_SHOW_VEHICLE_MARKERS {
				title="Show vehicle markers";
				description="Show 3D markers of friendly vehicles.";
				type="checkbox";
				ingame=1;
			};

			class RSTF_UI_SHOW_GAMEMODE_SCORE {
				title="Show game mode info";
				description="Show current state of game mode, such team points in KoTH.";
				type="checkbox";
				ingame=1;
			};

			class RSTF_UI_SHOW_GAMEMODE_UNIT_COUNT {
				title="Show game mode unit count";
				description="Show exact unit count when showing capture state.";
				type="checkbox";
				ingame=1;
			};
		};
	};
	class Tasks {
		title = "Tasks";
		visible = "(call RSTF_fnc_getModeId) == 'Classic' || (call RSTF_fnc_getModeId) == 'KOTH'";

		class Items {
			/*
			class RSTF_TASKS_IFV_ENABLED {
				title="Neutralize IFV";
				description="Allows 'Neutralize IFV' task";
				type="checkbox";
			};
			*/
			class RSTF_TASKS_CLEAR_ENABLED {
				title="Clear house";
				description="Allows 'Clear house' task";
				type="checkbox";
			};

			class RSTF_TASKS_EMP_ENABLED {
				title="Neutralize emplacement";
				description="Allows tasks for neutralizing emplacements";
				type="checkbox";
			};
		};
	};
	class Other {
		title = "Other";

		class Items {
			class RSTF_WEATHER {
				title="Weather";
				description="Mission weather.";
				type="select";
				optionsVariable="RSTF_WEATHER_TYPES";
			};

			SPACER;

			class RSTF_TIME {
				title="Daytime";
				description="Mission daytime.";
				type="select";
				optionsVariable="RSTF_TIME_TYPES";
			};
			class RSTF_USE_DEFAULT_DATE {
				title="Load date from world";
				description="Use default date for the world.";
				type="checkbox";
			};
			class RSTF_DATE_YEAR {
				title="Year";
				description="";
				type="select";
				optionsVariable="RSTF_AVAILABLE_YEARS";
				disabled="RSTF_USE_DEFAULT_DATE";
			};
			class RSTF_DATE_MONTH {
				title="Month";
				description="";
				type="select";
				optionsVariable="RSTF_AVAILABLE_MONTHS";
				disabled="RSTF_USE_DEFAULT_DATE";
			};
			class RSTF_DATE_DAY {
				title="Day";
				description="";
				type="select";
				optionsVariable="RSTF_AVAILABLE_DAYS";
				disabled="RSTF_USE_DEFAULT_DATE";
			};

			SPACER;

			class RSTF_CLEAR_HISTORIC_ITEMS {
				title="Clear modern things";
				description="Simple script that will try to remove modern things from map, intended to be used with WW2 mods on modern maps.";
				type="checkbox";
			};

			SPACER;

			class RSTF_CLEAN {
				title="Clear dead bodies";
				description="Dead bodies will be destroyed after 3 minutes. This helps performance.";
				type="checkbox";
			};
			class RSTF_CLEAN_INTERVAL {
				title="Infantry clean interval";
				description="After how much time should be dead bodies removed. In seconds.";
				type="number";
				postfix="seconds";
			};
			class RSTF_CLEAN_INTERVAL_VEHICLES {
				title="Vehicles clean interval";
				description="After how much time should be empty/destroyed vehicles removed. In seconds.";
				type="number";
				postfix="seconds";
			};

			SPACER;

			class RSTF_SKIP_MODE_SELECT {
				title="Skip mode selection";
				description="Skip mode selection screen when starting mission";
				type="checkbox";
			};
		};
	};
};
