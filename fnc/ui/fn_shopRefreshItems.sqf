private _items = param [0];

// Component that is prepared for items
private _itemsContainer = [RSTF_SHOP_layout, "items"] call ZUI_fnc_getControlById;
// Load search text
private _search = ctrlText ([RSTF_SHOP_layout, "search"] call ZUI_fnc_getControlById);

private _money = [player] call RSTF_fnc_getPlayerMoney;

_itemsContainer lnbSetColumnsPos [0, 0.6, 0.8];
lnbClear _itemsContainer;
_itemsContainer lnbSetCurSelRow -1;

RSTF_SHOP_CURRENT_ITEMS = [];

private _index = 0;
{
	private _type = _x#0;
	private _className = _x#1;
	private _cost = _x#2;

	if (_type == "VEHICLE") then {
		// Load vehicle info
		private _c = configFile >> "cfgVehicles" >> _className;
		private _title = getText(_c >> "displayName");
		private _image = getText(_c >> "picture");

		private _faction = getText(configFile >> "cfgFactionClasses" >> getText(_c >> "faction") >> "displayName");
		private _factionIcon = getText(configFile >> "cfgFactionClasses" >> getText(_c >> "faction") >> "icon");

		// Filter vehicles using search string if specified
		if (count(_search) == 0 || { [_search, _title] call BIS_fnc_inString }) then {
			_itemsContainer lnbAddRow [_title, _faction, ""];
			_itemsContainer lnbSetPicture [[_index, 0], _image];
			_itemsContainer lnbSetPicture [[_index, 1], _factionIcon];
			_itemsContainer lnbSetTextRight [[_index, 2], "$" + str(_cost) + "   "];

			if (_money >= _cost) then {
				_itemsContainer lnbSetColorRight [[_index, 2], [0.6, 0.9, 0.6, 1]];
			} else {
				_itemsContainer lnbSetColorRight [[_index, 2], [0.9, 0.6, 0.6, 1]];
			};

			_index = _index + 1;
			RSTF_SHOP_CURRENT_ITEMS pushBack _x;
		};
	};

	if (_type == "SUPPORT") then {
		private _c = missionConfigFile >> "RSTF_BUYABLE_SUPPORTS" >> _className;
		private _title = getText(_c >> "title");
		private _image = "";
		if (isText(_c >> "picture")) then {
			_image = getText(_c >> "picture");
		};

		if (count(_search) == 0 || { [_search, _title] call BIS_fnc_inString }) then {
			_itemsContainer lnbAddRow [_title, "", ""];
			if (_image != "") then {
				_itemsContainer lnbSetPicture [[_index, 0], _image];
			};

			_itemsContainer lnbSetTextRight [[_index, 2], "$" + str(_cost) + "   "];

			_index = _index + 1;
			RSTF_SHOP_CURRENT_ITEMS pushBack _x;
		};
	};
} foreach _items;
