private _classes = configFile >> "CfgVehicles";
private _values = [];
private _pairs = [];

for [{_i = 0},{_i < count(_classes)},{_i = _i + 1}] do {
	private _c = _classes select _i;
	if (isClass(_c)) then {
		private _scope = getNumber(_c >> "scope");
		private _man = getNumber(_c >> "isMan");
		private _name = toLower(getText(_c >> "displayName"));

		if (_scope == 2 && _man == 1 && { "crew" in _name || "pilot" in _name || "driver" in _name || "diver" in _name || "officer" in _name }) then {
			_values pushBack configName(_c);
			_pairs pushBack format['%1, // %2', str(configName(_c)), _name];
		};
	};
};

copyToClipboard str(_pairs joinString "
");
