private _vehicle = param [0];
private _threat = getArray(_vehicle >> "threat");

private _atThreat = _threat#1;
private _aaThreat = _threat#2;

if (_aaThreat > _atThreat && _aaThreat > 0.6) exitWith {
  RSTF_CLASSIFICATION_AA_VEHICLE;
};

if (_atThreat > _aaThreat && _atThreat > 0.6) exitWith {
  RSTF_CLASSIFICATION_AT_VEHICLE;
};

RSTF_CLASSIFICATION_GENERAL_VEHICLE;
