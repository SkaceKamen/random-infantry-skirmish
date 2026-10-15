/*
	Function:
	RSTF_fnc_startBattlefieldVehicleLoop

	Description:
	Starts battlefield-like automatic vehicle spawning. Every configured entry
	spawns up to its count of AI crewed vehicles at battle start and respawns a
	destroyed (or otherwise lost) vehicle after the entry's respawn delay.

	Entries have following format: [SIDE, CLASSNAME, COUNT, RESPAWN_DELAY]

	This function only takes effect on server.

	Returns:
	Nothing
*/

if (!isServer) exitWith {};

0 spawn {
	// Build a list of slots, each slot is [side, class, air, vehicle, respawnAt, delay]
	private _slots = [];

	{
		_x params ["_side", "_class", "_count", "_respawn"];

		if (_count <= 0) then { continue; };
		if (!isClass(configFile >> "cfgVehicles" >> _class)) then { continue; };

		private _parents = [configFile >> "cfgVehicles" >> _class, true] call BIS_fnc_returnParents;
		private _air = "Air" in _parents;

		for "_i" from 1 to _count do {
			_slots pushBack [_side, _class, _air, objNull, 0, _respawn];
		};
	} foreach RSTF_VEHICLE_SPAWNS;

	if (count(_slots) == 0) exitWith {};

	private _isInBattle = {
		params ["_slot"];
		_slot params ["_side", "_class", "_air", "_vehicle"];

		!isNull(_vehicle) && { alive _vehicle } && { (RSTF_AI_VEHICLES#_side) findIf { _x#1 == _vehicle } != -1 };
	};

	private _spawnVehicle = {
		params ["_slot"];
		_slot params ["_side", "_class", "_air"];

		_slot set [3, [_side, _class, _air] call RSTF_fnc_spawnAiVehicle];
	};

	// Initial spawn
	{
		[_x] call _spawnVehicle;
	} foreach _slots;

	while { !RSTF_ENDED } do {
		{
			if (!([_x] call _isInBattle)) then {
				private _vehicle = _x#3;

				if (!isNull(_vehicle)) then {
					// Vehicle was destroyed or removed from the battle, start respawn timer
					_x set [3, objNull];
					_x set [4, time + (_x#5)];
				} else {
					if (time >= (_x#4)) then {
						[_x] call _spawnVehicle;
					};
				};
			};
		} foreach _slots;

		sleep 5;
	};
};
