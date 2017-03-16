NL = "
";
SCRIPTS_ROOT = "";

RSTF_INIT = "";
RSTF_INIT = RSTF_INIT + NL + preprocessFileLineNumbers('init-game.sqf');
RSTF_INIT = RSTF_INIT + NL + preprocessFileLineNumbers(SCRIPTS_ROOT + "variables.sqf");
RSTF_INIT = RSTF_INIT + NL + preprocessFileLineNumbers(SCRIPTS_ROOT + "options.sqf");

//Basic function that adds script to loading script
RSTF_loadScript = {
	//#include "' + SCRIPTS_ROOT + 'fw.inc"'

	RSTF_INIT = RSTF_INIT + format["RSTF_%1",_this] + ' = { ' + NL + preprocessFileLineNumbers(format["%1fnc\%2.sqf", SCRIPTS_ROOT, _this]) + NL + " };" + NL;
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
	RSTF_INIT = RSTF_INIT + NL + preprocessFileLineNumbers(format["%1init\%2.sqf", SCRIPTS_ROOT, _x]);
} foreach RSTF_initScripts;

[] call compile(RSTF_INIT);