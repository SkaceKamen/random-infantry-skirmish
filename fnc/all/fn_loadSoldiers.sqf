private _factions = _this select 0;
private _ignore_bans = false;
if (count(_this) > 1) then {
	_ignore_bans = _this select 1;
};
private _soldiers = [];
private _weapons = [];

private _classes = objNull;

if (count(RSTF_SOLDIER_CLASSES_CACHE) == 0) then {
	RSTF_SOLDIER_CLASSES_CACHE = "getNumber(_x >> 'scope') == 2 && getNumber(_x >> 'isMan') == 1" configClasses (configFile >> "CfgVehicles");
};

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

	// Load men and vehicles for each faction
	{
		private _c = _x;
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
						_localWeapons pushBackUnique _x;

					};
				} foreach _wp;

				if (_weaponized) then {
					_localSoldiers pushBack configName(_c);
				};
			};
		};
	} forEach RSTF_SOLDIER_CLASSES_CACHE;
	
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
	_bannedSoldiers = RSTF_SOLDIERS_BANNED createHashMapFromArray [];
	_bannedWeapons = RSTF_WEAPONS_BANNED createHashMapFromArray [];

	_resultSoldiers = _resultSoldiers select { !(_x in _bannedSoldiers) };
	_resultWeapons = _resultWeapons select { !(_x in _bannedWeapons) };
};

[_resultSoldiers, _resultWeapons];