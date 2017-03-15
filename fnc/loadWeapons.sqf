RSTF_WEAPONS = [];
RSTF_LAUNCHERS = [];
RSTF_PISTOLS = [];

_classes = configFile >> "CfgWeapons";
for[{_i = 0},{_i < count(_classes)},{_i = _i + 1}] do {
	_c = _classes select _i;
	if (isClass(_c)) then {
		if (getNumber(_c >> "scope") == 2) then {
			_magazine = getArray(_c >> "magazines");
			_type = getNumber(_c >> "type");
			if (!isNil("_magazine") && count(_magazine) > 0) then {
				if (_type == 1) then {
					RSTF_WEAPONS pushBack configName(_c);
				};
				if (_type == 2) then {
					RSTF_PISTOLS pushBack configName(_c);
				};
				if (_type == 4) then {
					RSTF_LAUNCHERS pushBack configName(_c);
				};
			};
		};
	};
};