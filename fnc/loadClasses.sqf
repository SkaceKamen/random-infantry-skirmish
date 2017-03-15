RSTF_MEN = [ [], [], [] ];

{
	_side = _x select 0;
	_factions = _x select 1;

	_list = [_factions] call RSTF_loadSoldiers;
	RSTF_MEN set [_side, _list select 0];

	diag_log format["Loaded %1 soldiers for side %2 from factions %3", count(_list select 0), _side, _factions];

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
