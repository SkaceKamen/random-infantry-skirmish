RSTF_MEN = [ [], [], [] ];

{
	private _side = _x select 0;
	private _factions = _x select 1;

	private _list = [_factions] call RSTF_fnc_loadSoldiers;
	private _vehicles = [_factions] call RSTF_fnc_loadVehicles;
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

// List of buyable vehicles, each item: [CATEGORY, CLASSNAME, COST]
RSTF_BUYABLE_VEHICLES = [];
{
	private _list = [];
	private _side = _x;
	{
		private _category = _x select 0;
		private _categoryIndex = _x select 1;
		private _vehicles = ((RSTF_VEHICLES select _side) select _categoryIndex);

		{
			private _vehicle = _x;
			private _cost = [_vehicle] call RSTF_fnc_getVehicleCost;
			_list pushBack [_category, _vehicle, _cost];
		} foreach _vehicles;
	} foreach [
		['AIR', RSTF_VEHICLE_AIR],
		['APC', RSTF_VEHICLE_APC]
	];

	_list = [_list, [], { _x select 2 }] call BIS_fnc_sortBy;

	RSTF_BUYABLE_VEHICLES set [_x, _list];
} foreach RSTF_SIDES;

