private _ctrl = [RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "vehicles"] call ZUI_fnc_getControlById;
private _index = lnbCurSelRow _ctrl;
if (_index < 0) exitWith {};

private _class = _ctrl lnbData [_index, 0];

private _count = parseNumber(ctrlText ([RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "count"] call ZUI_fnc_getControlById));
if (_count < 1) then { _count = 1; };

private _respawn = parseNumber(ctrlText ([RSTF_VEHICLE_SPAWN_PICKER_LAYOUT, "respawn"] call ZUI_fnc_getControlById));
if (_respawn < 0) then { _respawn = 0; };

RSTF_VEHICLE_SPAWNS_EDITOR pushBack [RSTF_VEHICLE_SPAWN_PICKER_SIDE, _class, _count, _respawn];

[RSTF_VEHICLE_SPAWN_PICKER_LAYOUT] call ZUI_fnc_closeDisplay;
RSTF_VEHICLE_SPAWN_PICKER_LAYOUT = [];

call RSTF_fnc_updateVehicleSpawnEditor;
