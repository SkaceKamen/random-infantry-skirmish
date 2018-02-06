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
		class getRandomVehicle {};

		class loadClasses {};
		class loadSoldiers {};
		class loadVehicles {};
		class loadWeapons {};

		class mapsShow {};

		class profileLoad {};
		class profileReset {};
		class profileSave {};

		class randomPoint {};
		class randomWeather2 {};
		class superRandomTime {};
		class superRandomWeather {};

		class start {};
		class loopMultikills {};
		class loop {};

		class scoreChanged {};
		class unitKilled {};
		class playerKilled {};

		class createCam {};
		class createPointMarkers {};
		class spawnComposition {};

		class getAttackWaypoint {};
		class randomSpawn {};

		class requestVehicle {};
		class bindKeys {};

		class moveCamera {};

		class aiDecideVehicle {};

	};

	class money
	{
		file = "fnc\money";

		class getUnitMoney {};
		class getUnitMoneyIndex {};
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
		class randomPosition {};
		class randomLocation {};
		class sideIndex {};
		class weaponHasAttachment {};
		class arrayShuffle {};
		class aliveCrew {};
	};

	class ui
	{
		file = "fnc\ui";

		class showAdvancedConfig {};
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
};