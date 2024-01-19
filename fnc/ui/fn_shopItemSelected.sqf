private _index = param [1];


if (_index >= 0 && _index < count(RSTF_SHOP_CURRENT_ITEMS)) then {
	private _item = RSTF_SHOP_CURRENT_ITEMS select _index;
	private _layout = RSTF_SHOP_layout;
	private _money = [player] call RSTF_fnc_getPlayerMoney;
	private _crewListCtrl = ([_layout, "crewList"] call ZUI_fnc_getControlById);
	lbClear _crewListCtrl;

	if (!isNil("_item")) then {
		RSTF_SHOP_CURRENT_ITEM = _item;

		private _type = _item#0;
		private _className = _item#1;
		private _cost = _item#2;

		private _title = "";
		private _image = "";
		private _description = "";
		
		if (_type == "VEHICLE") then {
			// Load vehicle info
			private _c = configFile >> "cfgVehicles" >> _className;
			_title = getText(_c >> "displayName");
			_image = getText(_c >> "picture");

			if (isText(_c >> "editorPreview")) then {
				_image = getText(_c >> "editorPreview");
			};

			private _weapons = [_className] call RSTF_fnc_getVehicleWeapons;
			
			private _crew = ([_className] call RSTF_fnc_getVehicleClassCrew);
			_description = _description + "<t size='1.2'>CREW</t><br />" + ((_crew apply { _x#0 }) joinString "<br />") + "<br />";
			_description = _description + "<t size='1.2'>WEAPONS</t><br />";

			{
				_description = _description + getText(configFile >> "cfgWeapons" >> _x >> "displayName") + "<br/>";
			} foreach _weapons;

			_crewListCtrl lbAdd "Effective commander";

			{
				_crewListCtrl lbAdd (_x#0);
			} foreach _crew;

			_crewListCtrl lbSetCurSel 0;
		};

		if (_type == "SUPPORT") then {
			// Load vehicle info
			private _c = missionConfigFile >> "RSTF_BUYABLE_SUPPORTS" >> _className;
			_title = getText(_c >> "title");
			_description = getText(_c >> "description");

			if (isText(_c >> "picture")) then {
				getText(_c >> "picture");
			};
		};

		// Set shop item variables
		([_layout, "detail_title"] call ZUI_fnc_getControlById) ctrlSetText _title;
		([_layout, "detail_image"] call ZUI_fnc_getControlById) ctrlSetText _image;
		([_layout, "detail_info"] call ZUI_fnc_getControlById) ctrlSetStructuredText parseText(_description);
		([_layout, "price"] call ZUI_fnc_getControlById) ctrlSetText ("$" + str(_cost));

		if (_money >= _cost) then {
			([_layout, "buy"] call ZUI_fnc_getControlById) ctrlEnable true;
			([_layout, "price"] call ZUI_fnc_getControlById) ctrlSetBackgroundColor [0.2, 0.6, 0.2, 1];
		} else {
			([_layout, "buy"] call ZUI_fnc_getControlById) ctrlEnable false;
			([_layout, "price"] call ZUI_fnc_getControlById) ctrlSetBackgroundColor [0.3, 0, 0, 1];
		};
	};
};
