_unit = _this select 0;

RSTF_RESPAWN_KILLED = _unit;
RSTF_RESPAWN_KILLER = _this select 1;

RSTF_DEATH_POSITION = getPos(_unit);
RSTF_DEATH_GROUP = group(_unit);

if (!isMultiplayer) then {
	selectPlayer RSTF_BACKUP_PLAYER;

	_side = SIDE_ENEMY;
	if (PLAYER_SIDE == west) then {
		_side = SIDE_FRIENDLY;
	};

	[_side, _this select 1, _unit] call RSTF_fnc_showDeath;
};