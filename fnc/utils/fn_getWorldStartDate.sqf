
// Example: 6/7/2035 (format is DD/MM/YYYY)
private _defaultDateCfg = configFile >> "cfgWorlds" >> worldName >> "startDate";
if (isText(_defaultDateCfg)) exitWith {
	private _defaultDate = getText(_defaultDateCfg);
	private _parts = _defaultDate splitString "/";
	private _year = parseNumber(_parts select 2);
	private _month = parseNumber(_parts select 1);
	private _day = parseNumber(_parts select 0);
	[_year, _month, _day];
};

date;