/*
	Function:
	RSTFGC_fnc_init

	Description:
	Initializes garbage collector and removes any leftover units if there're any.

	Author:
	Jan Zípek
*/

if (!isNil("RSTF_GC_QUEUE")) then {
	[true] call RSTFGC_fnc_tick;
};

RSTFGC_QUEUE = [];