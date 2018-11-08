private _categoryIndex = param [0];
RSTF_SHOP_lastCategory = _categoryIndex;
[RSTF_SHOP_items select _categoryIndex] call RSTFUI_fnc_shopRefreshItems;