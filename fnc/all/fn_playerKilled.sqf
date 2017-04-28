_unit = _this select 0;

RSTF_DEATH_POSITION = getPos(_unit);
RSTF_DEATH_GROUP = group(_unit);

selectPlayer RSTF_BACKUP_PLAYER;

RSTF_BACKUP_PLAYER setVariable ["ASSIGNED", false, true];

_side = SIDE_ENEMY;
if (PLAYER_SIDE == west) then {
	_side = SIDE_FRIENDLY;
};

RSTF_CAM = "camera" camCreate getPos(_unit);
RSTF_CAM camSetTarget _unit;
RSTF_CAM cameraEffect ["internal", "back"];
RSTF_CAM camCommit 0;
RSTF_CAM camSetRelPos [10, 0, 50];
RSTF_CAM camCommit 2;

[_side, _this select 1, _unit] call RSTF_fnc_showDeath;