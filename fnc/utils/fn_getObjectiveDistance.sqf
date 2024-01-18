private _pos = param [0];

private _center = RSTF_POINT;
private _direction = RSTF_DIRECTION + 90;
private _distance = _pos distance _center;

private _result = abs(cos(_direction) * (_center#1 - _pos#1) - sin(_direction) * (_center#0 - _pos#0));

_result;
