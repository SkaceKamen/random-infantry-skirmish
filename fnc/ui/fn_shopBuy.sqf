private _item = RSTF_SHOP_CURRENT_ITEM;

if (count(_item) > 0) then {
	private _type = _item select 0;
	private _className = _item select 1;
	private _cost = _item select 2;

	private _money = [player] call RSTF_fnc_getPlayerMoney;

	if (_money >= _cost) then {
		[RSTF_SHOP_layout] call ZUI_fnc_closeDisplay;

		if (_type == "VEHICLE") then {
			// Ask server to spawn our vehicle
			[player, _className] remoteExec ["RSTF_fnc_requestVehicle", 2];
		} else {
			private _execute = getText(missionConfigFile >> "RSTF_BUYABLE_SUPPORTS" >> _className >> "execute");
			_item spawn (compile(_execute));
		};
	} else {
		["You don''t have money for that.", "You''re poor"] spawn BIS_fnc_guiMessage;
	};
};
