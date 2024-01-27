private _layout = param [0];
private _id = param [1];
private _event = param [2];
private _handler = param [3];

([_layout, _id] call ZUI_fnc_getControlById) ctrlAddEventHandler [_event, _handler];