NL = "
";
SCRIPTS_ROOT = "";

RSTF_INIT = "";
call compile(preprocessFileLineNumbers('init-game.sqf'));
call compile(preprocessFileLineNumbers(SCRIPTS_ROOT + "variables.sqf"));
call compile(preprocessFileLineNumbers(SCRIPTS_ROOT + "options.sqf"));

//Basic function that adds script to loading script
RSTF_loadScript = {
	//#include "' + SCRIPTS_ROOT + 'fw.inc"'
	missionNamespace setVariable [format["RSTF_%1",_this], compile(preprocessFileLineNumbers(format["%1fnc\%2.sqf", SCRIPTS_ROOT, _this]))];
};

//All RSTF functions
RSTF_functions = [
	"getCtrl",
	"getDisplay",
	"loadClasses",
	"loadWeapons",
	"randomPosition",
	"createNeutral",
	"assignPlayer",
	"createRandomVehicle",
	"createRandomUnit",
	"unitKilled",
	"getRandomSoldier",
	"getRandomVehicle",
	"equipSoldier",
	"randomLocation",
	"spawnNeutrals",
	"spawnCommando",
	"countTurrets",
	"groupVehicle",
	"playerKilled",
	"sailorKilled",
	"randomPoint",
	"start",
	"loop",
	"showConfig",
	"showFactions",
	"scoreChanged",
	"UI_addMessage",
	"UI_start",
	"factionsUpdate",
	"configUpdateFactions",
	"loadSoldiers",
	"isUsableWeapon",
	"randomElement",
	"spawnPlayer",
	"showDeath",
	"profileSave",
	"profileLoad",
	"profileReset",
	"configValidate",
	"showEquip",
	"getAttachments",
	"superRandomWeather",
	"superRandomTime",
	//"switchIsland",
	"addPlayerScore"
	//"mapsShow"
];

//Load RSTF functions
{
	_x call RSTF_loadScript;
} foreach RSTF_functions;

RSTF_initScripts = [
	"map",
	"tasks",
	// "tasks\clear",
	"tasks\rescue-house",
	"tasks\rescue-vehicle",
	"start"
];

{
	call compile(preprocessFileLineNumbers(format["%1init\%2.sqf", SCRIPTS_ROOT, _x]));
} foreach RSTF_initScripts;
