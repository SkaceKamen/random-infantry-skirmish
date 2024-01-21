private _sideIndex = param [0];

if (_sideIndex == SIDE_FRIENDLY) exitWith { FRIENDLY_FACTIONS };
if (_sideIndex == SIDE_ENEMY) exitWith { ENEMY_FACTIONS };
if (_sideIndex == SIDE_NEUTRAL) exitWith { NEUTRAL_FACTIONS };

[];
