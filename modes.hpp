class RSTF_Modes
{
	class Classic
	{
		title = "Classic";
		enabled = 1;

		init = "RSTF_MODE_CLASSIC_init";
		unitKilled = "RSTF_MODE_CLASSIC_unitKilled";
		taskCompleted = "RSTF_MODE_CLASSIC_taskCompleted";
		vehicleKilled = "RSTF_MODE_CLASSIC_vehicleKilled";
	};

	class KOTH
	{
		title = "KOTH";
		enabled = 1;

		init = "RSTF_MODE_KOTH_init";
		unitKilled = "RSTF_MODE_KOTH_unitKilled";
		taskCompleted = "RSTF_MODE_KOTH_taskCompleted";
		vehicleKilled = "RSTF_MODE_KOTH_vehicleKilled";
	};

	class Push
	{
		title = "PUSH";
		enabled = 0;

		init = "RSTF_MODE_PUSH_init";
		unitKilled = "RSTF_MODE_PUSH_unitKilled";
		taskCompleted = "RSTF_MODE_PUSH_taskCompleted";
		vehicleKilled = "RSTF_MODE_PUSH_vehicleKilled";
	};
};
