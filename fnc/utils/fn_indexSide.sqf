private _side = param [0];
if (_side == SIDE_FRIENDLY) exitWith { west };
if (_side == SIDE_ENEMY) exitWith { east };
if (_side == SIDE_NEUTRAL) exitWith { resistance };
east;
