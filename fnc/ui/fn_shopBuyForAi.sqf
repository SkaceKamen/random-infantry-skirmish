private _item = RSTF_SHOP_CURRENT_ITEM;

if (!RSTF_ENABLE_AI_SUPPORT_VEHICLES) exitWith {
	false;
};

if (count(_item) > 0) then {
	private _type = _item select 0;
	private _className = _item select 1;
	private _cost = _item select 2;
	private _aiCost = _cost * RSTF_AI_VEHICLE_SUPPORT_COST_MULTIPLIER;
	private _money = [player] call RSTF_fnc_getPlayerMoney;

	if (_money >= _aiCost) then {
		[RSTF_SHOP_layout] call ZUI_fnc_closeDisplay;

		if (_type == "VEHICLE") then {
			// We have to know if it's AIR for some reason
			private _parents = [configFile >> "cfgVehicles" >> _className, true] call BIS_fnc_returnParents;
			private _air = "Air" in _parents;

			// Ask server to spawn AI vehicle
			[player, _className, _air] remoteExec ["RSTF_fnc_requestAiVehicle", 2];
		};
	} else {
		["You don't have money for that.", "You're poor"] spawn BIS_fnc_guiMessage;
	};
};
