RSTF_MODE_GUN_GAME_WEAPONS = [];
RSTF_MODE_GUN_GAME_PROGRESS = createHashMap;

RSTF_MODE_GUN_GAME_init = {
	"Moving spawns..." call RSTF_fnc_dbg;

	// Move spawns to the center
	RSTF_SPAWNS set [SIDE_ENEMY, RSTF_POINT];
	RSTF_SPAWNS set [SIDE_FRIENDLY, RSTF_POINT];
	// TODO: Configurable?
	RSTF_RANDOM_SPAWN_WIDTH = RSTF_MODE_ARENA_RECTANGLE_SIZE;
	RSTF_RANDOM_SPAWN_HEIGHT = RSTF_MODE_ARENA_RECTANGLE_SIZE;
	RSTF_RANDOM_SPAWN_AVOID_ENEMIES = true;

	// Some features have to be disabled
	RSTF_DISABLE_GROUP_SPAWNS = true;
	RSTF_DISABLE_SPAWN_TRANSPORTS = true;
	RSTF_DISABLE_WAVE_GROUP_SPAWNS = true;
	
	// TODO: Neutrals?
	// RSTF_SPAWNS set [SIDE_NEUTRAL, RSTF_POINT];

	"Generating weapons..." call RSTF_fnc_dbg;

	private _availableWeapons = +RSTF_WEAPONS;
	for [{_i = 0},{_i < 20},{_i = _i + 1}] do {
		private _weapon = _availableWeapons call BIS_fnc_selectRandom;
		_availableWeapons = _availableWeapons - [_weapon];
		RSTF_MODE_GUN_GAME_WEAPONS pushBack _weapon;
	};
};

RSTF_MODE_GUN_GAME_getProgress = {
	private _unit = param [0];
	private _unitIdent = if (isPlayer (_unit)) then {
		_unit getVariable ["RSTF_UID", "unknown"];
	} else {
		_unit getVariable ["ORIGINAL_NAME", -1];
	};

	if (_unitIdent in RSTF_MODE_GUN_GAME_PROGRESS) exitWith {
		RSTF_MODE_GUN_GAME_PROGRESS get _unitIdent;
	};

	0;
};

RSTF_MODE_GUN_GAME_addProgress = {
	private _unit = param [0];
	private _change = param [1, 1];
	private _current = [_unit] call RSTF_MODE_GUN_GAME_getProgress;

	if (_change > 0 && _current == count(RSTF_MODE_GUN_GAME_WEAPONS) - 2) exitWith {
		if (RSTF_ENDED) exitWith {};

		private _side = _unit getVariable ["SPAWNED_SIDE", civilian];
		private _sideIndex = [_side] call RSTF_fnc_sideIndex;

		[_sideIndex] remoteExec ["RSTF_fnc_onEnd"];
	};

	private _unitIdent = if (isPlayer (_unit)) then {
		_unit getVariable ["RSTF_UID", "unknown"];
	} else {
		_unit getVariable ["ORIGINAL_NAME", -1];
	};

	RSTF_MODE_GUN_GAME_PROGRESS set [_unitIdent, _current + _change];
};

RSTF_MODE_GUN_GAME_unitSpawned = {
	private _unit = param [0];
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

	_unit addWeapon _weapon;
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
		[_killer] call RSTF_MODE_GUN_GAME_addProgress;
		[_killer] call RSTF_MODE_GUN_GAME_unitSpawned;

		if (isPlayer(_killer)) then {
			["Kill", 5] remoteExec ["RSTFUI_fnc_addMessage", _killer];
		};
	};
};
RSTF_MODE_GUN_GAME_taskCompleted = {};
RSTF_MODE_GUN_GAME_vehicleKilled = {};
