RSTF_MEN = [ [], [], [] ];

{
	_side = _x select 0;
	_factions = _x select 1;

	_list = [_factions] call RSTF_fnc_loadSoldiers;
	_vehicles = [_factions] call RSTF_fnc_loadVehicles;
	RSTF_MEN set [_side, _list select 0];
	RSTF_VEHICLES set [_side, _vehicles];

	diag_log format[
		"Loaded %1 soldiers, %2 transport vehicles, %3 apcs and %4 static weapons for side %5 from factions %6",
		count(_list select 0),
		count(_vehicles select RSTF_VEHICLE_TRANSPORT),
		count(_vehicles select RSTF_VEHICLE_APC),
		count(_vehicles select RSTF_VEHICLE_STATIC),
		_side,
		_factions
	];

	if (RSTF_RANDOMIZE_WEAPONS_RESTRICT) then {
		_launchers = [];
		_weapons = [];
		_pistols = [];

		{
			_type = getNumber(configFile >> "cfgWeapons" >> _x >> "type");
			if (_type == 4) then {
				_launchers pushBack _x;
			};
			if (_type == 2) then {
				_pistols pushBack _x;
			};
			if (_type == 1) then {
				_weapons pushBack _x;
			};
		} foreach (_list select 1);

		RSTF_LAUNCHERS set [_side, _launchers];
		RSTF_PISTOLS set [_side, _pistols];
		RSTF_WEAPONS set [_side, _weapons];
	};
} foreach [
	[SIDE_FRIENDLY, FRIENDLY_FACTIONS],
	[SIDE_NEUTRAL, NEUTRAL_FACTIONS],
	[SIDE_ENEMY, ENEMY_FACTIONS]
];

// List of buyable vehicles, each item: [CATEGORY, CLASSNAME]
RSTF_BUYABLE_VEHICLES = [];
{
	RSTF_BUYABLE_VEHICLES pushBack ['APC', _x];
} foreach ((RSTF_VEHICLES select SIDE_FRIENDLY) select RSTF_VEHICLE_APC);

{
	RSTF_BUYABLE_VEHICLES pushBack ['AIR', _x];
} foreach ((RSTF_VEHICLES select SIDE_FRIENDLY) select RSTF_VEHICLE_AIR);

// Sort by price
RSTF_BUYABLE_VEHICLES = [RSTF_BUYABLE_VEHICLES, [], { [_x select 1] call RSTF_fnc_vehicleCost }] call BIS_fnc_sortBy;