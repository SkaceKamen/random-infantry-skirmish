class RSTF
{
	class all
	{
		file = "fnc\all";

		class init {};
		class startMission {};

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
		class startBattle {};
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
		class requestAiVehicle {};
		class bindKeys {};

		class moveCamera {};

		class aiDecideVehicle {};

		class respawn {};
		class attachVehicleRefundCheck {};

		class getLastChangelog {};

		class startMovementCheckLoop {};
		class startVehicleCheckLoop {};

		class dbg {};

		class setState {};

		class loadAllClasses {};
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
		class getGroupSpawnPosition {};
		class pickEmplacementPos {};
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
		class getObjectiveDistance {};
		class getWorldStartDate {};
		class getVehicleClassCrew {};
		class getVehicleClassSkins {};
		class getVehicleClassComponents {};
		class applyUnitEquipment{};
		class getFactionsForSide {};
		class clearWaypoints {};
		class countCaptureUnits {};
	};

	class ui
	{
		file = "fnc\ui";

		class showAdvancedConfig {};
		class updateAdvancedConfig {};
		class showAdvancedOptions {};
		class updateAdvancedOptions {};

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
		class spawnZUIDialog {};
		class showModeSelector {};
		class customSelectorShow {};
		class customSelectorPick {};

		class createArsenalBackground {};
		class destroyArsenalBackground {};

		class showChangelog {};
		class updateMainConfigScreen {};

		class showVehicleConfiguration {};
		class deathUpdate {};
		class updateOverlay {};

		class showRespawnSelect {};
		class refreshRespawnSelect {};

		class showGunGameEditor {};
		class updateGunGameEditor {};
		class showGunGameEditorWeaponPick {};
		class updateGunGameEditorWeaponPick {};

		class gunGamePresetDialog {};
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
		class clientInitRequest {};
		class clientInit {};
		class assignPlayerAsLeader {};
		class syncServerOptions {};
	};

	class support
	{
		file = "fnc\support";

		class initArtillerySupport {};
		class startShelling {};
		class initSupplyDrop {};
		class performSupplyDrop {};
		class rearmInfantry {};
	};

	class ai
	{
		file = "fnc\ai";

		class refreshSideWaypoints {};
		class refreshGroupWaypoints {};
		class refreshVehicleWaypoints {};
	};

	class config
	{
		file = "fnc\config";

		class getEmplacements {};
	};

	class modes
	{
		file = "fnc\modes";

		class initClassicMode {};
		class initKothMode {};
		class initDefendMode {};
		class initPushMode {};
		class initArenaMode {};
		class initGunGameMode {};
	};

	class tasks
	{
		file = "fnc\tasks";

		class initTasks {};
		class initClearHouseTask {};
	};
};
