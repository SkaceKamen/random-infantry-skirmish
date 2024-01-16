class RSTF
{
	class all
	{
		file = "fnc\all";

		class startBattleSelection {};
		class assignPoint {};
		class assignPlayer {};
		class equipSoldier {};
		class getRandomSoldier {};

		class loadClasses {};
		class loadSoldiers {};
		class loadVehicles {};
		class loadWeapons {};
		class loadFactions {};

		class profileLoad {};
		class profileReset {};
		class profileSave {};

		class superRandomTime {};
		class superRandomWeather {};

		class initializeMode {};
		class start {};
		class loopMultikills {};
		class loop {};

		class scoreChanged {};
		class unitKilled {};
		class playerKilled {};
		class vehicleKilled {};

		class createCam {};
		class destroyCam {};
		class createPointMarkers {};
		class spawnComposition {};

		class getAttackWaypoint {};
		class randomSpawn {};

		class requestVehicle {};
		class bindKeys {};

		class moveCamera {};

		class aiDecideVehicle {};

		class respawn {};
		class attachVehicleRefundCheck {};
	};

	class money
	{
		file = "fnc\money";

		class getUnitMoney {};
		class setUnitMoney {};
		class addUnitMoney {};
		class getPlayerMoney {};
		class setPlayerMoney {};
		class addPlayerMoney {};
	};

	class spawn
	{
		file = "fnc\spawn";

		class createRandomUnit {};
		class spawnNeutrals {};
		class spawnPlayer {};
		class spawnSpawnDefenses {};
		class spawnNeutralEmplacements {};
		class spawnNeutralBuildings {};
		class spawnBoughtVehicle {};
		class shouldSpawnVehicle {};
		class spawnWave {};
		class spawnAiVehicle {};
		class spawnComposition2 {};
		class spawnDefenceEmplacements {};
	};

	class utils
	{
		file = "fnc\utils";

		class countTurrets {};
		class getCtrl {};
		class getDisplay {};
		class getWeaponAttachments {};
		class getVehicleCost {};
		class getVehicleWeapons {};
		class isUsableWeapon {};
		class pathString {};
		class pickRandomPoints {};
		class sideIndex {};
		class indexSide {};
		class weaponHasAttachment {};
		class arrayShuffle {};
		class aliveCrew {};
		class log {};
		class loadPredefined {};
		class clearHistoricItems {};
		class getModeId {};
		class killHandler {};
		class doesModeSupportNeutrals {};
	};

	class ui
	{
		file = "fnc\ui";

		class showAdvancedConfig {};
		class updateAdvancedConfig {};
		class showAdvancedOptions {};
		class saveAdvancedOptions {};
		class showConfig {};
		class showDeath {};
		class showEquip {};
		class showFactions {};
		class showWaiting {};
		class showBattleSelection {};
		class factionsUpdate {};
		class configUpdateFactions {};
		class configValidate {};
		class updateEquipment {};
		class filterInput {};
		class updateBattles {};
		class updateVoteTimeout {};
		class spawnDialog {};
		class showModeSelector {};
		class customSelectorShow {};
		class customSelectorPick {};

		class createArsenalBackground {};
		class destroyArsenalBackground {};

		class updateMainConfigScreen {};
	};

	class net
	{
		file = "fnc\net";

		class clientStart {};
		class clientEvents {};
		class serverStart {};
		class serverEvents {};
		class onStarted {};
		class onPointChanged {};
		class onScore {};
		class onEnd {};
	};

	class support
	{
		file = "fnc\support";

		class initArtillerySupport {};
		class startShelling {};
	};

	class ai
	{
		file = "fnc\ai";

		class refreshSideWaypoints {};
		class refreshGroupWaypoints {};
	};

	class config
	{
		file = "fnc\config";

		class getEmplacements {};
	};
};
