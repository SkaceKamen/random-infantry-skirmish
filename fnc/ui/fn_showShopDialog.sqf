/* INITIALIZATION OF VARIABLES */

// Selected category in shop
RSTF_SHOP_lastCategory = 0;

// Categorized list of vehicles
RSTF_SHOP_items = [];

// Create categorized list of vehicles
private _vehicles = RSTF_BUYABLE_VEHICLES select SIDE_FRIENDLY;
private _categories = [ "All", "Wheeled", "Tracked", "Planes", "Helicopters", "Other" ];
private _parents = [ "*", "Car", "Tank", "Plane", "Helicopter", "*" ];

{
	RSTF_SHOP_items pushBack [];
} foreach _categories;

{
	private _data = _x;
	private _cat = _x#0;
	private _className = _x#1;
	private _target = 0;
	{
		if (_x != '*' && { _className isKindOf _x }) then {
			_target = _foreachIndex;
		};
	} foreach _parents;

	if (_target == 0) then {
		_target = count(_categories) - 1;
	};

	(RSTF_SHOP_items#0) pushBack _data;
	(RSTF_SHOP_items#_target) pushBack _data;
} foreach _vehicles;

/* INTIALIZATION OF DIALOG */

RSTF_SHOP_CURRENT_ITEMS = [];
RSTF_SHOP_layout = [missionConfigFile >> "ShopDialog"] call ZUI_fnc_createDisplay;
[RSTF_SHOP_layout, "search", "KeyUp", { [RSTF_SHOP_lastCategory] call RSTFUI_fnc_shopCategoryClicked; }] call ZUI_fnc_on;

private _categoriesContainer = [RSTF_SHOP_layout, "categories"] call ZUI_fnc_getComponentById;
{
	private _count = count(RSTF_SHOP_items#_foreachIndex);
	if (_count > 0) then {
		private _cat = [_categoriesContainer, missionConfigFile >> "ShopComponents" >> "Category", false] call ZUI_fnc_createChild;
		private _titleCtrl = [_cat, 'title'] call ZUI_fnc_getControlById;
		private _countCtrl = [_cat, 'count'] call ZUI_fnc_getControlById;

		_titleCtrl ctrlSetText _x;
		_titleCtrl ctrlAddEventHandler ["ButtonClick", format["[%1] spawn RSTFUI_fnc_shopCategoryClicked", _foreachIndex]];
		_countCtrl ctrlSetText str(_count);
	};
} foreach _categories;

[_categoriesContainer] call ZUI_fnc_refresh;

([RSTF_SHOP_layout, "money"] call ZUI_fnc_getControlById) ctrlSetText ("$" + str([player] call RSTF_fnc_getPlayerMoney));

// Display first category items
[RSTF_SHOP_lastCategory] call RSTFUI_fnc_shopCategoryClicked;

// Show item detail when selected
([RSTF_SHOP_layout, "items"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["LBSelChanged", RSTFUI_fnc_shopItemSelected];

// Close when requested
([RSTF_SHOP_layout, "close"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", {
	[RSTF_SHOP_layout] call ZUI_fnc_closeDisplay;
}];
