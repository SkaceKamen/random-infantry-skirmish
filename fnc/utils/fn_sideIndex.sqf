private _side = param [0];
if (_side == west) exitWith { SIDE_FRIENDLY };
if (_side == east) exitWith { SIDE_ENEMY };
if (_side == resistance) exitWith { SIDE_NEUTRAL };
SIDE_ENEMY;