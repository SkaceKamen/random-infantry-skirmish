class RSTF_Options {
	class General {
		title = "General";

		class Items {
			class RSTF_MODE_SELECTED {
				title="Game mode";
				description="Game mode dictates rules of winning.";
				type="select";
				optionsVariable="RSTF_MODES_OPTIONS";
				optionType="string";
			}
			class RSTF_LIMIT_GROUPS {
				title="Groups per side";
				description="Number of groups spawned for each side.";
				type="number";
			}
			class RSTF_LIMIT_UNITS {
				title="Units per group";
				description="Number of soldiers in single group.";
				type="number";
			};
			class RSTF_SKILL_MIN {
				title="Minimum unit skill";
				description="Minimum unit skill, value from 0 to 1";
				type="float";
				validator="_this call RSTF_VALIDATOR_SKILL_MIN";
			};
			class RSTF_SKILL_MAX {
				title="Maximum unit skill";
				description="Maximum unit skill, value from 0 to 1";
				type="float";
				validator="_this call RSTF_VALIDATOR_SKILL_MAX";
			};
			class spacer1 { type = "spacer"; };
			class RSTF_LIMIT_SPAWN {
				title="Wave spawn time";
				description="Interval in seconds in which reinforcements are spawned";
				type="number";
			};
			class RSTF_SPAWN_REUSE_GROUPS {
				title="Reuse existing groups when spawning";
				description="Don't create new groups when spawning new units, reuse existing ones. Can cause AI issues";
				type="checkbox";
			};
			class RSTF_SPAWN_AT_OWN_GROUP {
				title="Spawn new units near group";
				description="Spawn new units near group when there's no enemy near";
				type="checkbox";
			};
			class spacer2 { type = "spacer"; };
			class RSTF_CLEAR_HISTORIC_ITEMS {
				title="Clear modern things";
				description="Simple script that will try to remove modern things from map, intended to be used with WW2 mods on modern maps.";
				type="checkbox";
			};
		};
	};
	class Classic {
		title = "Mode";
		visible = "(call RSTF_fnc_getModeId) == 'Classic'";

		class Items {
			class RSTF_SCORE_LIMIT {
				title="Score to win";
				description="One side wins after reaching this limit.";
				type="number";
			};
			class RSTF_SCORE_PER_KILL {
				title="Score per kill";
				description="Score you get for killing soldier.";
				type="number";
			};
			class RSTF_SCORE_PER_TASK {
				title="Score per task";
				description="Score you get for completing task.";
				type="number";
			};
		};
	};
	class KOTH {
		title = "Mode";
		visible = "(call RSTF_fnc_getModeId) == 'KOTH'";

		class Items {
			class RSTF_MODE_KOTH_SCORE_LIMIT {
				title="Score to win";
				description="One side wins after reaching this limit.";
				type="number";
			};
			class RSTF_MODE_KOTH_SCORE_INTERVAL {
				title="Point award interval";
				description="In seconds. Interval in which is point awarded to side that holds the objective.";
				type="number";
			};
		};
	};
	class Push {
		title = "Mode";
		visible = "(call RSTF_fnc_getModeId) == 'Push' || (call RSTF_fnc_getModeId) == 'PushDefense'";

		class Items {
			class RSTF_MODE_PUSH_POINT_COUNT {
				title="Number of points";
				description="Number of points that you have to capture to win";
				type="number";
			};
			class RSTF_MODE_PUSH_SCORE_LIMIT {
				title="Score to capture";
				description="Point is captured when one side reaches this number of points";
				type="number";
			};
			class RSTF_MODE_PUSH_SCORE_INTERVAL {
				title="Point award interval";
				description="In seconds. Interval in which is point awarded to side that holds the objective.";
				type="number";
			};
			class RSTF_MODE_PUSH_EMPLACEMENTS_PER_POINT {
				title="Number of defensive emplacements";
				description="Number of defensive emplacements spawned, only works when faction has suitable static emplacements.";
				type="number";
			};
			class RSTF_MODE_PUSH_ATTACKERS_ADVANTAGE {
				title="Attackers group advantage";
				description="Attackers will have this much more groups.";
				type="number";
			};
		};
	};
	class Defense {
		title = "Mode";
		visible = "(call RSTF_fnc_getModeId) == 'Defense'";

		class Items {
			class RSTF_MODE_DEFEND_DURATION {
				title="Duration";
				description="Number of seconds that the point has to be defended to win the battle.";
				type="number";
			};
			class RSTF_MODE_DEFEND_RADIUS {
				title="Defended point radius";
				description="Capture radius of the defended point";
				type="number";
			};
			class RSTF_MODE_DEFEND_SCORE_LIMIT {
				title="Score to capture";
				description="Point is lost when attackers reach this score";
				type="number";
			};
			class RSTF_MODE_DEFEND_SCORE_INTERVAL {
				title="Point award interval";
				description="In seconds. Interval in which is point awarded to attackers when they have majority on the objective.";
				type="number";
			};
		};
	};
	class Spawning {
		title = "Spawning";

		class Items {
			class RSTF_SPAWN_TYPE {
				title="Spawn to";
				description="How to select unit to spawn to. Closest - unit closest to your death, Group - unit in your group, Random - random unit";
				type="select";
				optionsVariable="RSTF_SPAWN_TYPES";
			};
			class RSTF_PLAYER_ALWAYS_LEADER {
				title="Always set as leader";
				description="Always set player as a leader of group of selected unit";
				type="checkbox";
				optionsVariable="RSTF_SPAWN_TYPES";
			};
			class RSTF_RANDOMIZE_WEAPONS {
				title="Randomize weapons";
				description="Each soldier will be given random weapon.";
				type="checkbox";
			};
			class RSTF_RANDOMIZE_WEAPONS_RESTRICT {
				title="Restrict weapons to sides";
				description="When weapons are randomized, only use weapons that origins from unit faction. (Useful for mods).";
				type="checkbox";
			};
			class RSTF_CUSTOM_EQUIPMENT {
				title="Enable custom equipment";
				description="Enable player to customize his equipment, which will be used when switching to soldier.";
				type="checkbox";
			};
			class spacer1 { type = "spacer"; };
			class RSTF_SPAWN_TRANSPORTS {
				title="Vehicles at spawn";
				description="Tries to spawn transport vehicles at side spawns to cover unit spawning.";
				type="checkbox";
			};
			class spacer2 { type = "spacer"; };
			class RSTF_SPAWN_DISTANCE_MIN {
				title="Minimal spawn distance";
				description="Minimal spawn distance from center of battle, in meters";
				type="number";
				validator="_this call RSTF_VALIDATOR_SPAWN_DISTANCE_MIN";
			};
			class RSTF_SPAWN_DISTANCE_MAX {
				title="Maximal spawn distance";
				description="Maximal spawn distance from center of battle, in meters";
				type="number";
				validator="_this call RSTF_VALIDATOR_SPAWN_DISTANCE_MAX";
			};
		};
	};
	class Neutrals {
		title = "Neutrals";

		class Items {
			class RSTF_NEUTRALS_GROUPS {
				title="Neutral groups";
				description="Maximum number of neutral groups spawned.";
				type="number";
			};
			class RSTF_NEUTRALS_EAST {
				title="Friendly with enemies";
				description="Should neutrals be same side as enemies.";
				type="checkbox";
			};
			class RSTF_NEUTRALS_EMPLACEMENTS {
				title="Allow emplacements";
				description="Spawn neutral emplacements if possible.";
				type="checkbox";
			};
		};
	};
	class Enemy {
		title = "Enemy";

		class Items {
			class RSTF_ENEMY_ADVANTAGE_GROUPS {
				title="Groups advantage";
				description="Enemy will have this much more groups.";
				type="number";
			};
			class RSTF_ENEMY_ADVANTAGE_UNITS {
				title="Units advantage";
				description="Enemy groups will have this much more units.";
				type="number";
			};
			class RSTF_ENEMY_ADVANTAGE_SCORE {
				title="Score multiplier";
				description="Enemy score will be multiplied by this.";
				type="float";
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
			};
			class RSTF_MAP_VOTE_TIMEOUT {
				title="Vote timeout (secs)";
				description="Time in seconds to wait for votes (only in multiplayer).";
				type="number";
			};
		};
	};
	class Money {
		title = "Money";

		class Items {
			class RSTF_MONEY_ENABLED {
				title="Allow money system";
				description="Allow money rewards as whole";
				type="checkbox";
			};
			class RSTF_MONEY_VEHICLES_ENABLED {
				title="Allow buying vehicles by players";
				description="Allow players to buy vehicles for their money";
				type="checkbox";
			};
			class RSTF_ENABLE_SUPPORTS {
				title="Allow buying supports";
				description="Allow players to buy supports (artillery)";
				type="checkbox";
			};
			class spacer1 { type = "spacer"; };
			class RSTF_MONEY_START {
				title="Starting money";
				description="Money each unit gets at start of the mission";
				type="number";
			};
			class RSTF_MONEY_PER_KILL {
				title="Money per kill";
				description="Award for killing enemy";
				type="number";
			};
			class RSTF_MONEY_PER_TASK {
				title="Money per task";
				description="Award for completing task";
				type="number";
			};
			class RSTF_AI_MONEY_MULTIPLIER {
				title="AI money multiplier";
				description="AI money reward multiplier, AI usually have less kills than player, so this helps them to catch up";
				type="number";
			};
			class RSTF_AI_MONEY_PER_SECOND {
				title="AI money per second";
				description="Money added per second to all AI units, allows AI to catch up with player";
				type="number";
			};
			class RSTF_MULTIKILL_BONUS {
				title="Bonus for multikill";
				description="Bonus money for multikills, awarded for each kill over 1";
				type="number";
			};
		};
	};
	class Vehicles {
		title = "Vehicles";

		class Items {
			class RSTF_AI_VEHICLES_ENABLED {
				title="Allow AI Vehicles";
				description="Allow AI to buy vehicles for their money";
				type="checkbox";
			};

			class RSTF_SPAWN_VEHICLES_UNLOCKED {
				title="Unlock AI vehicles";
				description="Allow players to enter AI vehicles";
				type="checkbox";
			};

			class RSTF_MONEY_VEHICLES_AI_LIMIT {
				title="Max AI vehicles per side";
				description="Maximum number of spawned AI vehicles per side";
				type="number";
			};
		};
	};
	class UI {
		title = "UI";

		class Items {
			class RSTF_UI_SHOW_PLAYER_FEED {
				title="Show player feed";
				description="Show messages when player score changes.";
				type="checkbox";
			};

			class RSTF_UI_SHOW_PLAYER_MONEY {
				title="Show player money";
				description="Show current player money.";
				type="checkbox";
			};

			class RSTF_UI_SHOW_VEHICLE_MARKERS {
				title="Show vehicle markers";
				description="Show 3D markers of friendly vehicles.";
				type="checkbox";
			};

			class RSTF_UI_SHOW_GAMEMODE_SCORE {
				title="Show game mode info";
				description="Show current state of game mode, such team points in KoTH.";
				type="checkbox";
			};

			class RSTF_UI_SHOW_GAMEMODE_UNIT_COUNT {
				title="Show game mode unit count";
				description="Show exact unit count when showing capture state.";
				type="checkbox";
			};
		};
	};
	class Tasks {
		title = "Tasks";

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
			class RSTF_BUY_MENU_ACTION {
				title="Buy button";
				description="What button opens vehicle shop.";
				type="select";
				optionsVariable="RSTF_POSSIBLE_KEYS_NAMES";
			};
			class spacer1 { type = "spacer"; };
			class RSTF_CLEAN {
				title="Clear dead bodies";
				description="Dead bodies will be destroyed after 3 minutes. This helps performance.";
				type="checkbox";
			};
			class RSTF_CLEAN_INTERVAL {
				title="Infantry clean interval";
				description="After how much time should be dead bodies removed. In seconds.";
				type="number";
			};
			class RSTF_CLEAN_INTERVAL_VEHICLES {
				title="Vehicles clean interval";
				description="After how much time should be empty/destroyed vehicles removed. In seconds.";
				type="number";
			};
			class spacer2 { type = "spacer"; };
			class RSTF_WEATHER {
				title="Weather";
				description="Mission weather.";
				type="select";
				optionsVariable="RSTF_WEATHER_TYPES";
			};
			class spacer3 { type = "spacer"; };
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
			};
			class RSTF_DATE_MONTH {
				title="Month";
				description="";
				type="select";
				optionsVariable="RSTF_AVAILABLE_MONTHS";
			};
			class RSTF_DATE_DAY {
				title="Day";
				description="";
				type="select";
				optionsVariable="RSTF_AVAILABLE_DAYS";
			};
			class spacer4 { type = "spacer"; };
			class RSTF_SKIP_MODE_SELECT {
				title="Skip mode selection";
				description="Skip mode selection screen when starting mission";
				type="checkbox";
			};
		};
	};
};