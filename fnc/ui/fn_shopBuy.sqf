private _category = param [0];
private _index = param [1];
private _vehicle = RSTF_SHOP_items#_category#_index;

private _money = [player] call RSTF_fnc_getPlayerMoney;
private _vehicle = _vehicle select 1;
private _cost = [_vehicle] call RSTF_fnc_getVehicleCost;

if (_money >= _cost) then {
	[RSTF_SHOP_layout] call ZUI_fnc_closeDisplay;

	// Ask server to spawn our vehicle
	[player, _vehicle] remoteExec ["RSTF_fnc_requestVehicle", 2];
} else {
	["You don''t have money for that.", "You''re poor"] spawn BIS_fnc_guiMessage;
};
