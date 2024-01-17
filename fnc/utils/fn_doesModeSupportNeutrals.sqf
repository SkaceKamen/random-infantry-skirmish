private _modeId = call RSTF_fnc_getModeId;
private _config = missionConfigFile >> "RSTF_Modes" >> _modeId;

getNumber (_config >> "hasNeutralFaction") == 1;
