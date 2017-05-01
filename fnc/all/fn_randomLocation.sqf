_world_anchor = getArray(configFile >> "CfgWorlds" >> worldName >> "SafePositionAnchor");
_locations = nearestLocations [_world_anchor, ["NameCityCapital","NameCity","NameVillage"], 99999999];
_locations call BIS_fnc_selectRandom;