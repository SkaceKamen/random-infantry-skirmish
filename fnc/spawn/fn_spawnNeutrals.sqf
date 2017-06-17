private _neutrals_side = resistance;
if (RSTF_NEUTRALS_EAST) then {
	_neutrals_side = east;
};

_neutrals_side call RSTF_fnc_spawnNeutralBuildings;
_neutrals_side call RSTF_fnc_spawnNeutralEmplacements;