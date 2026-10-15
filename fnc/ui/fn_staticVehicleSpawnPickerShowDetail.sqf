private _class = param [0];
private _config = configFile >> "cfgVehicles" >> _class;

private _description = format [
	"<t size='5' align='center'><img image='%1' /></t><br /><t align='center' size='1.2'>%2</t><br /><br />",
	getText(_config >> "editorPreview"),
	getText(_config >> "displayName")
];

private _crew = [_class] call RSTF_fnc_getVehicleClassCrew;
if (count(_crew) > 0) then {
	_description = _description + "<t size='1.2'>CREW</t><br />" + ((_crew apply { _x#0 }) joinString "<br />") + "<br /><br />";
};

private _weapons = [_class] call RSTF_fnc_getVehicleWeapons;
if (count(_weapons) > 0) then {
	_description = _description + "<t size='1.2'>WEAPONS</t><br />" + ((_weapons apply { getText(configFile >> "cfgWeapons" >> _x >> "displayName") }) joinString "<br />");
};

([RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "detail"] call ZUI_fnc_getControlById) ctrlSetStructuredText parseText _description;
