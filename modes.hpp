class RSTF_Modes
{
	class Classic
	{
		title = "Classic";
		enabled = 1;

		init = "RSTF_MODE_CLASSIC_init";
		startLoop = "RSTF_MODE_CLASSIC_startLoop";
		unitKilled = "RSTF_MODE_CLASSIC_unitKilled";
		taskCompleted = "RSTF_MODE_CLASSIC_taskCompleted";
		vehicleKilled = "RSTF_MODE_CLASSIC_vehicleKilled";
	};

	class KOTH
	{
		title = "King of the Hill";
		enabled = 1;

		init = "RSTF_MODE_KOTH_init";
		startLoop = "RSTF_MODE_KOTH_startLoop";
		unitKilled = "RSTF_MODE_KOTH_unitKilled";
		taskCompleted = "RSTF_MODE_KOTH_taskCompleted";
		vehicleKilled = "RSTF_MODE_KOTH_vehicleKilled";
	};

	class Push
	{
		title = "Push";
		enabled = 1;

		init = "RSTF_MODE_PUSH_init";
		startLoop = "RSTF_MODE_PUSH_startLoop";
		unitKilled = "RSTF_MODE_PUSH_unitKilled";
		taskCompleted = "RSTF_MODE_PUSH_taskCompleted";
		vehicleKilled = "RSTF_MODE_PUSH_vehicleKilled";
	};

	class Defense
	{
		title = "Defense";
		enabled = 0;

		init = "RSTF_MODE_DEFEND_init";
		startLoop = "RSTF_MODE_DEFEND_startLoop";
		unitKilled = "RSTF_MODE_DEFEND_unitKilled";
		taskCompleted = "RSTF_MODE_DEFEND_taskCompleted";
		vehicleKilled = "RSTF_MODE_DEFEND_vehicleKilled";
	};
};
