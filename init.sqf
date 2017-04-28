diag_log text(format["STARTING: isMultiplayer: %1, isDedicated: %2, isServer: %3", isMultiplayer, isDedicated, isServer]);

SCRIPTS_ROOT = "";
call compile(preprocessFileLineNumbers(SCRIPTS_ROOT + "init-game.sqf"));
call compile(preprocessFileLineNumbers(SCRIPTS_ROOT + "variables.sqf"));
call compile(preprocessFileLineNumbers(SCRIPTS_ROOT + "options.sqf"));

RSTF_initScripts = [
	"map",
	"tasks",
	"tasks\clear",
	// "tasks\rescue-house",
	// "tasks\rescue-vehicle",
	"start"
];

{
	call compile(preprocessFileLineNumbers(format["%1init\%2.sqf", SCRIPTS_ROOT, _x]));
} foreach RSTF_initScripts;
