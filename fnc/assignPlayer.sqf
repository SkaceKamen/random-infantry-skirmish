_unit = _this;

if (isNull(RSTF_CAM)) then {
	RSTF_CAM = "camera" camCreate [RSTF_POINT select 0, RSTF_POINT select 1, 100];
	RSTF_CAM camSetTarget RSTF_POINT;
	RSTF_CAM cameraEffect ["internal", "back"];
	RSTF_CAM camCommit 0;
};

waitUntil { camCommitted RSTF_CAM; };

RSTF_CAM camSetTarget _unit;
RSTF_CAM camSetRelPos [0, -1, 0.5];
RSTF_CAM camCommit 1;

waitUntil { camCommitted RSTF_CAM; };

if (alive(_unit)) then {
	if (RSTF_CUSTOM_EQUIPMENT) then {
		// Use custom weapon, if selected
		_weapon = RSTF_PLAYER_PRIMARY;
		if (_weapon == "") then {
			_weapon = primaryWeapon(_unit);
		};

		// Remove primary weapon and its ammo
		if (primaryWeapon(_unit) != "") then {
			_mgzs = getArray(configFile >> "cfgWeapons" >> primaryWeapon(_unit) >> "magazines");
			{
				_unit removeMagazines _x;
			} foreach _mgzs;
			_unit removeWeapon primaryWeapon(_unit);
		};

		// Remove secondary weapon and its ammo
		if (secondaryWeapon(_unit) != "") then {
			_mgzs = getArray(configFile >> "cfgWeapons" >> secondaryWeapon(_unit) >> "magazines");
			{
				_unit removeMagazines _x;
			} foreach _mgzs;
			_unit removeWeapon secondaryWeapon(_unit);
		};

		// Add secondary if selected
		if (RSTF_PLAYER_SECONDARY != "") then {
			if (RSTF_PLAYER_SECONDARY == "grenades") then {
				_unit addMagazines ["HandGrenade", round(random(3))];
			} else {
				_launcher = RSTF_PLAYER_SECONDARY;
				_mgzs = getArray(configFile >> "cfgWeapons" >> _launcher >> "magazines");
				_type = getNumber(configFile >> "cfgWeapons" >> _launcher >> "type");

				_magazine = _mgzs select 0;
				_need = 2;
				if (_type == 2) then {
					_need = 5 max (20/getNumber(configFile >> "cfgMagazines" >> _magazine >> "count"));
				};

				_unit addMagazines [_magazine, 2];
				_unit addWeapon _launcher;
			};
		};

		// Add primary if any
		if (_weapon != "") then {
			_mgzs = getArray(configFile >> "cfgWeapons" >> _weapon >> "magazines");
			_magazine = _mgzs select 0;
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

			_need = 5 max (200/getNumber(configFile >> "cfgMagazines" >> _magazine >> "count"));
			_unit addMagazines [_magazine, _need];
			_unit addWeapon _weapon;
			_unit selectWeapon _weapon;

			{
				_unit addWeaponItem [_weapon, _x select 0];
			} foreach RSTF_PLAYER_ATTACHMENTS;
		};
	};

	selectPlayer _unit;
	_unit addEventHandler ["Killed", RSTF_playerKilled];
} else {
	[_unit, objNull] call RSTF_playerKilled;
};

RSTF_CAM cameraEffect ["terminate","back"];
camDestroy RSTF_CAM;
RSTF_CAM = objNull;

diag_log "Player spawned. Starting task.";
call RSTF_TASKS_start;