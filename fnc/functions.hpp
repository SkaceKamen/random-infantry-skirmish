class all
{
	file = "fnc\all";

	class startBattleSelection {};
	class assignPoint {};
	class assignPlayer {};
	class countTurrets {};
	class equipSoldier {};
	class getAttachments {};
	class getCtrl {};
	class getDisplay {};
	class getRandomSoldier {};
	class getRandomVehicle {};
	class groupVehicle {};
	class isUsableWeapon {};

	class loadClasses {};
	class loadSoldiers {};
	class loadVehicles {};
	class loadWeapons {};

	class loopMultikills {};
	class loop {};

	class mapsShow {};
	class playerKilled {};
	class profileLoad {};
	class profileReset {};
	class profileSave {};
	class randomLocation {};
	class randomPoint {};
	class randomPosition {};
	class randomWeather2 {};
	class scoreChanged {};
	class start {};
	class superRandomTime {};
	class superRandomWeather {};
	class unitKilled {};
	class pathString {};
	class createCam {};
	class pickRandomPoints {};
	class createPointMarkers {};
	class randomSpawn {};
	class spawnComposition {};
	class vehicleCost {};
	class requestVehicle {};
	class bindKeys {};

	class getUnitMoney {};
	class getUnitMoneyIndex {};
	class setUnitMoney {};
	class addUnitMoney {};
	class getPlayerMoney {};
	class setPlayerMoney {};
	class addPlayerMoney {};

	class moveCamera {};

	class aiDecideVehicle {};

	class getAttackWaypoint {};
};

class spawn
{
	file = "fnc\spawn";

	class createRandomUnit {};
	class createRandomVehicle {};
	class spawnCommando {};
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

	class weaponHasAttachment {};
	class getWeaponAttachments {};
	class sideIndex {};
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
