SCRIPTS_ROOT = "";
call compile(preprocessFileLineNumbers(SCRIPTS_ROOT + "init\map.sqf"));
call compile(preprocessFileLineNumbers(SCRIPTS_ROOT + "init\modes.sqf"));
call compile(preprocessFileLineNumbers(SCRIPTS_ROOT + "init-game.sqf"));
call compile(preprocessFileLineNumbers(SCRIPTS_ROOT + "variables.sqf"));
call compile(preprocessFileLineNumbers(SCRIPTS_ROOT + "options.sqf"));

RSTF_initScripts = [
	"tasks",
	"tasks\clear",
	// "tasks\rescue-house",
	// "tasks\rescue-vehicle",
	// "tasks\kill-vehicle",
	// "tasks\emplacement",
	"start"
];

{
	call compile(preprocessFileLineNumbers(format["%1init\%2.sqf", SCRIPTS_ROOT, _x]));
} foreach RSTF_initScripts;