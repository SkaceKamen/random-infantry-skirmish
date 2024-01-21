private _newUnit = param [0];
private _oldUnit = param [1];

if (isNull(_oldUnit) || isNull(_newUnit)) exitWith {};

// selectPlayer RSTF_BACKUP_PLAYER;

_newUnit setPos getPos(RSTF_BACKUP_PLAYER);
_newUnit enableSimulation false;
_newUnit allowDamage false;
_newUnit hideObject true;
_newUnit disableAI "ALL";

private _side = SIDE_ENEMY;
if (PLAYER_SIDE == west) then {
	_side = SIDE_FRIENDLY;
};

[_side, RSTF_RESPAWN_KILLER, RSTF_RESPAWN_KILLED] spawn RSTF_fnc_showDeath;