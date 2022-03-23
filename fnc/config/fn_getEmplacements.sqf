/*
	Function:
	RSTF_fnc_getEmplacements

	Description:
	Returns emplacement config classes that match provided tags query (or all if no tags provided)

	Parameter(s):
	_tags - tags that the returned emplacements should have [Array]

	Returns:
	Config classes of matching emplacements [Array]
*/

private _tags = param [0, [], [[]]];

private _emplacements = ("true" configClasses (missionConfigFile >> "RSTF_Compositions"));

_emplacements select {
	if (count(_tags) == 0) exitWith {
		true;
	};

	private _empTags = getArray(_x >> "tags");
	private _match = true;

	{
		if (!(_x in _empTags)) exitWith {
			_match = false;
		};
	} forEach _tags;

	_match;
};
