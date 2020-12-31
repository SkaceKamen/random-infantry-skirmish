private _items = param [0];

// Component that is prepared for items
private _itemsContainer = [RSTF_SHOP_layout, "items"] call ZUI_fnc_getComponentById;
// Load search text
private _search = ctrlText ([RSTF_SHOP_layout, "search"] call ZUI_fnc_getControlById);

// Removes all items from previously selected category
[_itemsContainer] call ZUI_fnc_clearChildren;
// Hide items while loading
[_itemsContainer, false] call ZUI_fnc_setVisible;

private _money = [player] call RSTF_fnc_getPlayerMoney;

private _row = [];
private _index = 0;
{
	// Load vehicle info
	private _className = _x#1;
	private _cost = _x#2;
	private _c = configFile >> "cfgVehicles" >> _className;
	private _title = getText(_c >> "displayName");
	private _image = getText(_c >> "picture");

	private _weapons = [_className] call RSTF_fnc_getVehicleWeapons;
	private _description = "<t size='0.75'>";

	{
		_description = _description + getText(configFile >> "cfgWeapons" >> _x >> "displayName") + "<br/>";
	} foreach _weapons;

	_description = _description + '</t>';

	// Filter vehicles using search string if specified
	if (count(_search) == 0 || { [_search, _title] call BIS_fnc_inString }) then {
		// We need to split the items into rows, so at every odd item, we will create a new row
		if (_index % 2 == 0) then {
			_row = [_itemsContainer, missionConfigFile >> "ShopComponents" >> "ItemsRow", false] call ZUI_fnc_createChild;
		};

		private _item = [_row, missionConfigFile >> "ShopComponents" >> "Item", false] call ZUI_fnc_createChild;

		// Set shop item variables
		([_item, "title"] call ZUI_fnc_getControlById) ctrlSetText _title;
		([_item, "image"] call ZUI_fnc_getControlById) ctrlSetText _image;
		([_item, "price"] call ZUI_fnc_getControlById) ctrlSetText ("$" + str(_cost));
		([_item, "info"] call ZUI_fnc_getControlById) ctrlSetStructuredText parseText(_description);

		if (_money >= _cost) then {
			([_item, "buy"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", format["[%1, %2] spawn RSTFUI_fnc_shopBuy", RSTF_SHOP_lastCategory, _foreachIndex]];
			([_item, "price"] call ZUI_fnc_getControlById) ctrlSetBackgroundColor [0.2, 0.6, 0.2, 1];
		} else {
			([_item, "buy"] call ZUI_fnc_getControlById) ctrlEnable false;
			([_item, "price"] call ZUI_fnc_getControlById) ctrlSetBackgroundColor [0.3, 0, 0, 1];
		};

		_index = _index + 1;
	};
} foreach _items;

// We need to fill the last space if the item count was odd
if (_index % 2 != 0) then {
	[_row, missionConfigFile >> "ShopComponents" >> "ItemSpacer", false] call ZUI_fnc_createChild;
};

// Refresh layout, this positions all the newly added items to correct places
[_itemsContainer] call ZUI_fnc_refresh;

// Show the new items
[_itemsContainer, true] call ZUI_fnc_setVisible;

/*
// Because some bugs when measuring text height, we need to refresh the layout again
[_itemsContainer] call ZUI_fnc_refresh;
*/