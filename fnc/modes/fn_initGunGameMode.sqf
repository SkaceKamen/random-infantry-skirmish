RSTF_MODE_GUN_GAME_WEAPONS = [];
RSTF_MODE_GUN_GAME_PROGRESS = createHashMap;
RSTF_MODE_GUN_GAME_KILLS = createHashMap;
RSTF_MODE_GUN_GAME_WEAPONS_INITIALIZED = false;

RSTF_MODE_GUN_GAME_init = {
	"Moving spawns..." call RSTF_fnc_dbg;

	// Move spawns to the center
	RSTF_SPAWNS set [SIDE_ENEMY, RSTF_POINT];
	RSTF_SPAWNS set [SIDE_FRIENDLY, RSTF_POINT];
	RSTF_RANDOM_SPAWN_WIDTH = RSTF_MODE_GUN_GAME_RECTANGLE_SIZE;
	RSTF_RANDOM_SPAWN_HEIGHT = RSTF_MODE_GUN_GAME_RECTANGLE_SIZE;
	RSTF_RANDOM_SPAWN_AVOID_ENEMIES = true;
	RSTF_RANDOM_SPAWN_AVOID_ENEMIES_RADIUS = RSTF_MODE_GUN_GAME_RESPAWN_ENEMY_CHECK_RADIUS;

	// Some features have to be disabled
	RSTF_DISABLE_GROUP_SPAWNS = true;
	RSTF_DISABLE_SPAWN_TRANSPORTS = true;
	RSTF_DISABLE_WAVE_GROUP_SPAWNS = false;
	RSTF_DISABLE_MONEY = true;
	
	"Generating weapons..." call RSTF_fnc_dbg;

	RSTF_MODE_GUN_GAME_WEAPONS_INITIALIZED = false;

	private _compatibleWeapons = RSTF_MODE_GUN_GAME_CUSTOM_WEAPONS select {
		isClass(configFile >> "cfgWeapons" >> _x);
	};

	if (RSTF_MODE_GUN_GAME_RANDOMIZED || count(_compatibleWeapons) == 0) then {
		private _availableWeapons = if (RSTF_RANDOMIZE_WEAPONS_RESTRICT || RSTF_MODE_GUN_GAME_RESTRICT_WEAPONS) then {
			RSTF_PISTOLS#SIDE_FRIENDLY
				+ RSTF_PISTOLS#SIDE_ENEMY
				+ RSTF_WEAPONS#SIDE_FRIENDLY
				+ RSTF_WEAPONS#SIDE_ENEMY
		} else {
			RSTF_PISTOLS + RSTF_WEAPONS;
		};

		for [{_i = 0},{_i < RSTF_MODE_GUN_GAME_WEAPONS_COUNT},{_i = _i + 1}] do {
			private _weapon = "";
			while { count(_availableWeapons) > 0 } do {
				_weapon = selectRandom _availableWeapons;
				_availableWeapons = _availableWeapons - [_weapon];

				// Attempt to prevent duplicate weapons (with different mods attached)
				private _exists = RSTF_MODE_GUN_GAME_WEAPONS findIf {
					private _nameA = getText(configFile >> "cfgWeapons" >> _weapon >> "displayName");
					private _nameB = getText(configFile >> "cfgWeapons" >> _x >> "displayName");

					[_nameA, _nameB] call BIS_fnc_inString || [_nameB, _nameA] call BIS_fnc_inString;
				};

				if (_exists == -1) then {
					break;
				}
			};

			if (_weapon != "") then {
				RSTF_MODE_GUN_GAME_WEAPONS pushBack _weapon;
			};
		};
	} else {
		RSTF_MODE_GUN_GAME_WEAPONS = _compatibleWeapons;
	};

	RSTF_MODE_GUN_GAME_WEAPONS_INITIALIZED = true;

	publicVariable "RSTF_MODE_GUN_GAME_WEAPONS";
	publicVariable "RSTF_MODE_GUN_GAME_WEAPONS_INITIALIZED";
	publicVariable "RSTF_MODE_GUN_GAME_PROGRESS";
};

RSTF_MODE_GUN_GAME_getUnitIdent = {
	private _unit = param [0];
	private _unitIdent = if (isPlayer (_unit)) then {
		_unit getVariable ["RSTF_UID", "unknown"];
	} else {
		_unit getVariable ["ORIGINAL_NAME", -1];
	};

	_unitIdent;
};

RSTF_MODE_GUN_GAME_getProgress = {
	private _unit = param [0];
	private _unitIdent = [_unit] call RSTF_MODE_GUN_GAME_getUnitIdent;

	if (_unitIdent in RSTF_MODE_GUN_GAME_PROGRESS) exitWith {
		RSTF_MODE_GUN_GAME_PROGRESS get _unitIdent;
	};

	RSTF_MODE_GUN_GAME_PROGRESS set [_unitIdent, 0];
	publicVariable "RSTF_MODE_GUN_GAME_PROGRESS";

	0;
};

RSTF_MODE_GUN_GAME_getKills = {
	private _unit = param [0];
	private _unitIdent = [_unit] call RSTF_MODE_GUN_GAME_getUnitIdent;

	if (_unitIdent in RSTF_MODE_GUN_GAME_KILLS) exitWith {
		RSTF_MODE_GUN_GAME_KILLS get _unitIdent;
	};

	RSTF_MODE_GUN_GAME_KILLS set [_unitIdent, 0];

	0;
};

RSTF_MODE_GUN_GAME_addKill = {
	private _unit = param [0];
	private _unitIdent = [_unit] call RSTF_MODE_GUN_GAME_getUnitIdent;
	private _kills = [_unit] call RSTF_MODE_GUN_GAME_getKills;

	_kills = _kills + 1;

	RSTF_MODE_GUN_GAME_KILLS set [_unitIdent, _kills];

	if (_kills >= RSTF_MODE_GUN_GAME_KILLS_PER_WEAPON) then {
		[_unit] call RSTF_MODE_GUN_GAME_addProgress;
	};

	// MP compatibility
	if (isPlayer(_unit)) then {
		publicVariable "RSTF_MODE_GUN_GAME_KILLS";
	};
};

RSTF_MODE_GUN_GAME_clearKills = {
	private _unit = param [0];
	private _unitIdent = [_unit] call RSTF_MODE_GUN_GAME_getUnitIdent;

	RSTF_MODE_GUN_GAME_KILLS set [_unitIdent, 0];
	publicVariable "RSTF_MODE_GUN_GAME_KILLS";
};

RSTF_MODE_GUN_GAME_addProgress = {
	private _unit = param [0];
	private _change = param [1, 1];
	private _current = [_unit] call RSTF_MODE_GUN_GAME_getProgress;

	if (_change > 0 && _current == count(RSTF_MODE_GUN_GAME_WEAPONS) - 1) exitWith {
		if (RSTF_ENDED) exitWith {};

		private _side = _unit getVariable ["SPAWNED_SIDE", civilian];
		private _sideIndex = [_side] call RSTF_fnc_sideIndex;

		[format [
			"<t size='3'><t color='%1'>%2</t> has won the game!</t>",
			RSTF_SIDES_COLORS_TEXT select _sideIndex,
			name(_unit)
		], 20] remoteExec ["RSTFUI_fnc_addGlobalMessage"];

		[_sideIndex] remoteExec ["RSTF_fnc_onEnd"];
	};

	private _unitIdent = if (isPlayer (_unit)) then {
		_unit getVariable ["RSTF_UID", "unknown"];
	} else {
		_unit getVariable ["ORIGINAL_NAME", -1];
	};

	RSTF_MODE_GUN_GAME_PROGRESS set [_unitIdent, _current + _change];
	publicVariable "RSTF_MODE_GUN_GAME_PROGRESS";

	[_unit] call RSTF_MODE_GUN_GAME_clearKills;
	[_unit] remoteExec ["RSTF_MODE_GUN_GAME_unitSpawned", owner(_unit)];
	
	if (isPlayer(_unit)) then {
		private _progress = [_unit] call RSTF_MODE_GUN_GAME_getProgress;
		private _weapon = RSTF_MODE_GUN_GAME_WEAPONS select _progress;
		private _name = getText(configFile >> "cfgWeapons" >> _weapon >> "displayName");
		private _image = getText(configFile >> "cfgWeapons" >> _weapon >> "picture");

		[format["<t color='#ddddff'><t color='#ffffff'><img image='%2' /></t> %1</t>", _name, _image], 5] remoteExec ["RSTFUI_fnc_addMessage", _unit];
		
		playSound "DefaultNotification";
	};

	// MP compatibility
	if (isPlayer(_unit)) then {
		publicVariable "RSTF_MODE_GUN_GAME_KILLS";
	};
};

RSTF_MODE_GUN_GAME_unitSpawned = {
	private _unit = param [0];

	// We need to execute this local to the target unit
	if (owner(_unit) != 0 && owner(_unit) != clientOwner) exitWith {
		_this remoteExec ["RSTF_MODE_GUN_GAME_unitSpawned", owner(_unit)];
	};

	private _progress = [_unit] call RSTF_MODE_GUN_GAME_getProgress;
	private _weapon = RSTF_MODE_GUN_GAME_WEAPONS select _progress;
	private _weaponConfig = configFile >> "cfgWeapons" >> _weapon;
	private _mgzs = getArray(_weaponConfig >> "magazines");
	private _muzzles = getArray(_weaponConfig >> "muzzles");
	private _primaryMagazine = _mgzs select 0;
	private _magazine_size = getNumber(configFile >> "cfgMagazines" >> _primaryMagazine >> "count");
	private _need = round(5 max (200/_magazine_size));

	{
		_unit removeMagazines _x;
	} forEach ((primaryWeaponMagazine _unit) + (secondaryWeaponMagazine _unit));

	removeAllWeapons _unit;

	_unit addMagazines [_primaryMagazine, _need];

	if (count(_muzzles) > 1) then {
		{
			if (_x != "this") then {
				private _magazines = getArray(_weaponConfig >> _x >> "magazines");
				if (count(_magazines) > 0) then {
					_unit addMagazines [_magazines select 0, 5];
				};
			};
		} foreach _muzzles;
	};

	_unit addWeaponGlobal _weapon;
	_unit selectWeapon _weapon;
};

RSTF_MODE_GUN_GAME_startLoop = {};
RSTF_MODE_GUN_GAME_scoreChanged = {};
RSTF_MODE_GUN_GAME_unitKilled = {
	private _killed = param [0];
	private _killer = param [1];
	if (count(_this) > 2) then {
		_killer = param [2];
	};
	
	private _side = _killed getVariable ["SPAWNED_SIDE", civilian];
	private _isLegit = _side != side(_killer) && _killer != _killed;

	if (_isLegit && side (_killer) != side (_killed)) then {
		private _kills = [_killer] call RSTF_MODE_GUN_GAME_getKills;
		[_killer] call RSTF_MODE_GUN_GAME_addKill;

		if (isPlayer(_killer) && _kills + 1 != RSTF_MODE_GUN_GAME_KILLS_PER_WEAPON) then {
			[format["Kill %1/%2", _kills + 1, RSTF_MODE_GUN_GAME_KILLS_PER_WEAPON], 5] remoteExec ["RSTFUI_fnc_addMessage", _killer];
		};
	};

	// Make sure players can't pick their weapon
	removeAllWeapons _killed;
};
RSTF_MODE_GUN_GAME_taskCompleted = {};
RSTF_MODE_GUN_GAME_vehicleKilled = {};

RSTF_MODE_GUN_GAME_overlayLoop = {
	"RSTF_GUN_GAME_INGAME_UI" cutRsc ["RscTitleDisplayEmpty", "PLAIN", 0.5, false];
	private _display = uiNamespace getVariable "RscTitleDisplayEmpty";

	RSTF_GUN_GAME_layout = [missionConfigFile >> "GunGameOverlay", _display, true] call ZUI_fnc_createDisplay;
	[RSTF_GUN_GAME_layout, 1] call ZUI_fnc_fadeIn;

	private _lastProgress = -1;

	private _weaponsCtrl = [RSTF_GUN_GAME_layout, "weapons"] call ZUI_fnc_getControlById;

	while { true } do {
		private _progress = [player] call RSTF_MODE_GUN_GAME_getProgress;

		if (_progress != _lastProgress) then {
			_lastProgress = _progress;

			private _text = "<t align='center' shadow='0'>";

			{
				private _config = configFile >> "cfgWeapons" >> _x;
				private _name = getText(_config >> "displayName");
				private _icon = getText(_config >> "picture");
				private _color = if (_foreachIndex <= _progress) then { "#ffffff" } else { "#99ffffff" };
				private _size = if (_foreachIndex == _progress) then { "3" } else { "1.5" };

				_text = _text + format["<t color='%2' size='%3'><img image='%1' /></t>", _icon, _color, _size];

				if (_foreachIndex != count(RSTF_MODE_GUN_GAME_WEAPONS) - 1) then {
					_text = _text + format["<t size='1.5' color='%1'><img image='arrow-white.paa' /></t>", if (_foreachIndex >= _progress) then { "#44333333" } else { "#ffffff" }];
				};
				
			} forEach RSTF_MODE_GUN_GAME_WEAPONS;

			_text = _text + "</t>";

			_weaponsCtrl ctrlSetStructuredText parseText _text;
		};

		uisleep 0.2;
	};
};
