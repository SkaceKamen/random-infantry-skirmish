// Load ZUI functions
call compile(preprocessFileLineNumbers("lib\zui\zui-functions.sqf"));
call compile(preprocessFileLineNumbers("lib\zdbg\zdbg.sqf"));
ZDBG_Prefix = '[RSTF] ';

SCRIPTS_ROOT = "";
call compile(preprocessFileLineNumbers(SCRIPTS_ROOT + "init\modes.sqf"));
call compile(preprocessFileLineNumbers(SCRIPTS_ROOT + "init-game.sqf"));
call compile(preprocessFileLineNumbers(SCRIPTS_ROOT + "variables.sqf"));
call compile(preprocessFileLineNumbers(SCRIPTS_ROOT + "options-menu.sqf"));
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

{
	_x disableAI "ALL";
	_x allowDamage false;
	_x enableSimulationGlobal false;
} foreach allUnits;

addMissionEventHandler ["Loaded", {
	// Start UI features
	[] spawn RSTFUI_fnc_startOverlay;

	// Update score display
	[] spawn RSTF_fnc_onScore;
}];
