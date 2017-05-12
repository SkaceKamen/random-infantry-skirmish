RSTF_LOCATION = _this select 0;
RSTF_POINT = getPos(_this select 0);
RSTF_POINT set [2, 0];
RSTF_SPAWNS = _this select 1;
RSTF_DIRECTION = _this select 2;
RSTF_DISTANCE = _this select 3;

publicVariable "RSTF_LOCATION";
publicVariable "RSTF_SPAWNS";
publicVariable "RSTF_DIRECTION";
publicVariable "RSTF_DISTANCE";
publicVariable "RSTF_POINT";
