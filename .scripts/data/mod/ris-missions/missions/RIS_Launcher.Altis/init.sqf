// Load ZUI functions
call compile(preprocessFileLineNumbers("lib\zui\zui-functions.sqf"));

// Load until mission is initialized
waitUntil { time > 0 };

0 spawn RSTF_fnc_showLauncher;