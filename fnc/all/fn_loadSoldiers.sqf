private _factions = _this select 0;
private _ignore_bans = false;
if (count(_this) > 1) then {
	_ignore_bans = _this select 1;
};
private _soldiers = [];
private _weapons = [];

private _classes = configFile >> "CfgVehicles";

{
	private _faction = _x;
	private _factionLower = toLower(_faction);

	if (!isClass(configFile >> "CfgFactionClasses" >> _faction)) then {
		diag_log text("[RSTF] " + _faction + " is not a valid faction");
		continue;
	};

	if (_factionLower in RSTF_FACTIONS_SOLDIERS_CACHE) then {
		private _cached = RSTF_FACTIONS_SOLDIERS_CACHE get _factionLower;
		_soldiers = _soldiers + _cached#0;
		_weapons = _weapons + _cached#1;
		continue;
	};

	private _localSoldiers = [];
	private _localWeapons = [];

	private _i = 0;
	// Load men and vehicles for each faction
	for [{_i = 0},{_i < count(_classes)},{_i = _i + 1}] do {
		private _c = _classes select _i;
		if (isClass(_c)) then {
			private _scope = getNumber(_c >> "scope");
			private _man = getNumber(_c >> "isMan");
			private _itemFaction = toLower(getText(_c >> "faction"));

			if (_scope == 2 && _man == 1 && _itemFaction == _factionLower) then {
				private _weaponized = false;
				private _wp = getArray(_c >> "weapons");
				{
					private _usable = [configFile >> "cfgWeapons" >> _x, false] call RSTF_fnc_isUsableWeapon;
					if (_x != "Throw" && _x != "Put" && _usable) then {
						_weaponized = true;
						if ((_ignore_bans || !(_x in RSTF_WEAPONS_BANNED))) then {
							_localWeapons pushBackUnique _x;
						};
					};
				} foreach _wp;

				if (_weaponized) then {
					if (_ignore_bans || !(configName(_c) in RSTF_SOLDIERS_BANNED)) then {
						_localSoldiers pushBack configName(_c);
					};
				};
			};
		};
	};
	
	RSTF_FACTIONS_SOLDIERS_CACHE set [_factionLower, [_localSoldiers, _localWeapons]];

	_soldiers = _soldiers + _localSoldiers;
	_weapons = _weapons + _localWeapons;

} foreach _factions;

// Deduplicate array
private _resultWeapons = [];
{
	_resultWeapons pushBackUnique _x;
} foreach _weapons;

private _resultSoldiers = _soldiers;

if (!_ignore_bans) then {
	_resultSoldiers = _resultSoldiers select { !(_x in RSTF_SOLDIERS_BANNED) };
	_resultWeapons = _resultWeapons select { !(_x in RSTF_WEAPONS_BANNED) };
};

[_soldiers, _resultWeapons];