private _index = param [1];

if (_index >= 0 && _index < count(RSTF_SHOP_CURRENT_ITEMS)) then {
	private _item = RSTF_SHOP_CURRENT_ITEMS select _index;
	private _layout = RSTF_SHOP_layout;
	private _money = [player] call RSTF_fnc_getPlayerMoney;

	if (!isNil("_item")) then {
		// Load vehicle info
		private _className = _item#1;
		private _cost = _item#2;
		private _c = configFile >> "cfgVehicles" >> _className;
		private _title = getText(_c >> "displayName");
		private _image = getText(_c >> "picture");

		if (isText(_c >> "editorPreview")) then {
			_image = getText(_c >> "editorPreview");
		};

		private _weapons = [_className] call RSTF_fnc_getVehicleWeapons;
		private _description = "WEAPONS:<br /><t size='0.75'>";

		{
			_description = _description + getText(configFile >> "cfgWeapons" >> _x >> "displayName") + "<br/>";
		} foreach _weapons;

		_description = _description + '</t>';

		// Set shop item variables
		([_layout, "detail_title"] call ZUI_fnc_getControlById) ctrlSetText _title;
		([_layout, "detail_image"] call ZUI_fnc_getControlById) ctrlSetText _image;
		([_layout, "detail_info"] call ZUI_fnc_getControlById) ctrlSetStructuredText parseText(_description);
		([_layout, "price"] call ZUI_fnc_getControlById) ctrlSetText ("$" + str(_cost));

		if (_money >= _cost) then {
			([_layout, "buy"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", format["[%1] spawn RSTFUI_fnc_shopBuy", _index]];
			([_layout, "price"] call ZUI_fnc_getControlById) ctrlSetBackgroundColor [0.2, 0.6, 0.2, 1];
		} else {
			([_layout, "buy"] call ZUI_fnc_getControlById) ctrlEnable false;
			([_layout, "price"] call ZUI_fnc_getControlById) ctrlSetBackgroundColor [0.3, 0, 0, 1];
		};
	};
};
