_unit = _this select 0;
_side = _this select 1;

if (RSTF_RANDOMIZE_WEAPONS) then {
	_weapons = RSTF_WEAPONS;
	_launchers = RSTF_LAUNCHERS;
	_pistols = RSTF_PISTOLS;
	if (RSTF_RANDOMIZE_WEAPONS_RESTRICT) then {
		_weapons = RSTF_WEAPONS select _side;
		_launchers = RSTF_LAUNCHERS select _side;
		_pistols = RSTF_PISTOLS select _side;
	};

	_weapon = _weapons call RSTF_randomElement;
	_mgzs = getArray(configFile >> "cfgWeapons" >> _weapon >> "magazines");
	_magazine = _mgzs select 0;

	removeAllWeapons _unit;

	_unit addItem "FirstAidKit";
	{
		_unit addItem _x;
		_unit assignItem _x;
	} foreach ["ItemMap", "ItemGPS","ItemCompass","ItemWatch","ItemRadio"];

	if (count(_launchers) > 0 && round(random(10)) == 8) then {
		_launcher = _launchers call RSTF_randomElement;
		_mgzs = getArray(configFile >> "cfgWeapons" >> _launcher >> "magazines");
		_unit addMagazines [_mgzs select 0, 2];
		_unit addWeapon _launcher;
	} else {
		_unit addMagazines ["HandGrenade", round(random(3))];
	};

	_weaponConfig = configFile >> "cfgWeapons" >> _weapon;
	_muzzles = getArray(_weaponConfig >> "muzzles");
	if (count(_muzzles) > 1) then {
		{
			if (_x != "this") then {
				_magazines = getArray(_weaponConfig >> _x >> "magazines");
				if (count(_magazines) > 0) then {
					_unit addMagazines [_magazines select 0, 5];
				};
			};
		} foreach _muzzles;
	};

	_magazine_size = getNumber(configFile >> "cfgMagazines" >> _magazine >> "count");
	_need = round(5 max (200/_magazine_size));

	_unit addMagazines [_magazine, _need];
	_unit addWeapon _weapon;

	if (_magazine_size <= 10 && count(_pistols) > 0) then {
		_pistol = _pistols call RSTF_randomElement;
		_mag = getArray(configFile >> "cfgWeapons" >> _pistol >> "magazines") select 0;
		_mag_size = getNumber(configFile >> "cfgMagazines" >> _mag >> "count");

		_need = floor(5 max (20/_mag_size));
		_unit addMagazines [_mag, _need];
		_unit addWeapon _pistol;
	};
};