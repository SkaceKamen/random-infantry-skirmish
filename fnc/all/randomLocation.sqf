/*
_world_anchor = getArray(configFile >> "CfgWorlds" >> worldName >> "SafePositionAnchor");
_world_center = getArray(configFile >> "CfgWorlds" >> worldName >> "CenterPosition");

WORLD_BOUNDS = [
   (_world_center select 0) - (_world_anchor select 0)/2,(_world_center select 1) - (_world_anchor select 1)/2,
   (_world_center select 0) + (_world_anchor select 0)/2,(_world_center select 1) + (_world_anchor select 1)/2
];

_pos = [
	(WORLD_BOUNDS select 0) + random((WORLD_BOUNDS select 2) - (WORLD_BOUNDS select 0)),
	(WORLD_BOUNDS select 1) + random((WORLD_BOUNDS select 3) - (WORLD_BOUNDS select 1))  
];

_locations = nearestLocations [_pos, _this, 500];

while {count(_locations) == 0} do
{
	_pos = [
		(WORLD_BOUNDS select 0) + random((WORLD_BOUNDS select 2) - (WORLD_BOUNDS select 0)),
		(WORLD_BOUNDS select 1) + random((WORLD_BOUNDS select 3) - (WORLD_BOUNDS select 1))  
	];

	_locations = nearestLocations [_pos, _this, 500];    
};

(_locations select 0);
*/

_world_anchor = getArray(configFile >> "CfgWorlds" >> worldName >> "SafePositionAnchor");
_locations = nearestLocations [_world_anchor, ["NameCityCapital","NameCity","NameVillage"], 99999999];
_locations call BIS_fnc_selectRandom;