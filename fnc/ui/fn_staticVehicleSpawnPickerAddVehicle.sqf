private _ctrl = [RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "vehicles"] call ZUI_fnc_getControlById;
private _index = lnbCurSelRow _ctrl;
if (_index < 0) exitWith {};

private _class = _ctrl lnbData [_index, 0];

private _count = parseNumber(ctrlText ([RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "count"] call ZUI_fnc_getControlById));
if (_count < 1) then { _count = 1; };

private _respawn = parseNumber(ctrlText ([RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT, "respawn"] call ZUI_fnc_getControlById));
if (_respawn < 0) then { _respawn = 0; };

private _entry = [RSTF_STATIC_VEHICLE_SPAWN_PICKER_SIDE, _class, _count, _respawn];

// Replace the edited entry, or append a new one
if (RSTF_STATIC_VEHICLE_SPAWN_EDITOR_INDEX >= 0) then {
	RSTF_STATIC_VEHICLE_SPAWNS_EDITOR set [RSTF_STATIC_VEHICLE_SPAWN_EDITOR_INDEX, _entry];
} else {
	RSTF_STATIC_VEHICLE_SPAWNS_EDITOR pushBack _entry;
};

RSTF_STATIC_VEHICLE_SPAWN_EDITOR_INDEX = -1;

[RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT] call ZUI_fnc_closeDisplay;
RSTF_STATIC_VEHICLE_SPAWN_PICKER_LAYOUT = [];

call RSTF_fnc_updateStaticVehicleSpawnEditor;
