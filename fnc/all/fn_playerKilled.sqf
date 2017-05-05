_unit = _this select 0;

RSTF_DEATH_POSITION = getPos(_unit);
RSTF_DEATH_GROUP = group(_unit);

selectPlayer RSTF_BACKUP_PLAYER;

_side = SIDE_ENEMY;
if (PLAYER_SIDE == west) then {
	_side = SIDE_FRIENDLY;
};

[_side, _this select 1, _unit] call RSTF_fnc_showDeath;