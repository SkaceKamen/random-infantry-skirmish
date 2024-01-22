class RSTF_Modes
{
	class Classic
	{
		title = "Team Deathmatch";
		description = "Score-based team deathmatch, where first one that reaches specific number of points wins.";
		enabled = 1;
		order = 4;
		hasNeutralFaction = 1;

		init = "RSTF_MODE_CLASSIC_init";
		startLoop = "RSTF_MODE_CLASSIC_startLoop";
		unitKilled = "RSTF_MODE_CLASSIC_unitKilled";
		taskCompleted = "RSTF_MODE_CLASSIC_taskCompleted";
		vehicleKilled = "RSTF_MODE_CLASSIC_vehicleKilled";
	};

	class KOTH
	{
		title = "King of the Hill";
		description = "Side with more units in the predefined capture point receives points, side which reaches specified number of points wins.";
		enabled = 1;
		order = 2;
		hasNeutralFaction = 1;

		init = "RSTF_MODE_KOTH_init";
		startLoop = "RSTF_MODE_KOTH_startLoop";
		unitKilled = "RSTF_MODE_KOTH_unitKilled";
		taskCompleted = "RSTF_MODE_KOTH_taskCompleted";
		vehicleKilled = "RSTF_MODE_KOTH_vehicleKilled";
	};

	class Push
	{
		title = "Push";
		description = "Capture or defend series of fortified points.";
		enabled = 1;
		order = 0;
		hasNeutralFaction = 0;

		init = "RSTF_MODE_PUSH_init";
		startLoop = "RSTF_MODE_PUSH_startLoop";
		unitKilled = "RSTF_MODE_PUSH_unitKilled";
		taskCompleted = "RSTF_MODE_PUSH_taskCompleted";
		vehicleKilled = "RSTF_MODE_PUSH_vehicleKilled";
	};

	class PushDefense
	{
		title = "Push";
		description = "Defend a series of fortified points.";
		enabled = 0;
		order = 1;
		hasNeutralFaction = 0;

		init = "RSTF_MODE_PUSH_init";
		startLoop = "RSTF_MODE_PUSH_startLoop";
		unitKilled = "RSTF_MODE_PUSH_unitKilled";
		taskCompleted = "RSTF_MODE_PUSH_taskCompleted";
		vehicleKilled = "RSTF_MODE_PUSH_vehicleKilled";
	};

	class Defense
	{
		title = "Defense - BETA";
		description = "Hold area for predefined amount of time agains never ending waves of enemies. This game mode is in BETA stage and could be unablanced.";
		enabled = 1;
		order = 3;
		hasNeutralFaction = 0;

		init = "RSTF_MODE_DEFEND_init";
		startLoop = "RSTF_MODE_DEFEND_startLoop";
		unitKilled = "RSTF_MODE_DEFEND_unitKilled";
		taskCompleted = "RSTF_MODE_DEFEND_taskCompleted";
		vehicleKilled = "RSTF_MODE_DEFEND_vehicleKilled";
	};
};
