disableSerialization;

private _parent = param [0, displayNull];

// Load preset from list
RSTF_Presets = profilenamespace getVariable ["RSTF_PRESETS", []];
RSTF_Presets_Selected = -1;

if (!isNull(_parent)) then {
	_parent = _parent createDisplay "RscDisplayEmpty";
};

// Create dialog
private _layout  = [missionConfigFile >> "PresetsDialog", _parent] call ZUI_fnc_createDisplay;
RSTF_Presets_Layout = _layout;

RSTF_Presets_Refresh = {
	// Populate presets list
	private _list = [RSTF_Presets_Layout, "list"] call ZUI_fnc_getControlById;
	lnbClear _list;
	{
		_list lnbAddRow [_x select 0];
	} foreach RSTF_Presets;
};

RSTF_Presets_Close = {
	[RSTF_Presets_Layout] call ZUI_fnc_closeDisplay;

	{
		0 spawn compile format['["%1", %2] call RSTF_fnc_configUpdateFactions',_x select 0,_x select 1];
	} foreach [
		["sideFriendly", "FRIENDLY_FACTIONS"],
		["sideNeutral", "NEUTRAL_FACTIONS"],
		["sideEnemy", "ENEMY_FACTIONS"]
	];

	0 spawn RSTF_fnc_updateEquipment;
};

RSTF_Presets_RefreshInfo = {
	private _text = "<t align='center' underline='true'>Preset info</t><br /><br />";

	if (RSTF_Presets_Selected >= 0) then {
		private _preset = RSTF_Presets select RSTF_Presets_Selected;

		private _mode = 0;
		private _friendly = [];
		private _enemy = [];
		private _neutrals = [];

		{
			private _name = _x#0;
			private _value = _x#1;

			switch (_name) do {
				case "ENEMY_FACTIONS": { _enemy = _value; };
				case "FRIENDLY_FACTIONS": { _friendly = _value; };
				case "NEUTRAL_FACTIONS": { _neutrals = _value; };
				case "RSTF_MODE_INDEX": { _mode = _value; };
			};
		} foreach (_preset select 1);

		{
			private _label = _x#0;
			private _values = _x#1;

			_text = _text + "<t align='center'>" + _label + "</t><br />";
			{
				private _faction = _x;
				private _nameConfig = configFile >> "CfgFactionClasses" >> _faction >> "displayName";
				private _name = if (isText(_nameConfig)) then {
					getText(_nameConfig)
				} else {
					"<t color='#FF9999'>" + _faction + "</t> <t color='#666666' align='right'>not found</t>";
				};
				_text = _text + _name + "<br />";
			} foreach _values;
		} foreach [
			["Friendly", _friendly],
			["Neutral", _neutrals],
			["Enemy", _enemy]
		];
	} else {
		_text = _text + "<br /><br /><t align='center' color='#999999'>Select preset</t>";
	};

	([RSTF_Presets_Layout, "info"] call ZUI_fnc_getControlById) ctrlSetStructuredText parseText(_text);
};

([_layout, "list"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["LBSelChanged", {
	RSTF_Presets_Selected = lnbCurSelRow ([RSTF_Presets_Layout, "list"] call ZUI_fnc_getControlById);
	0 spawn RSTF_Presets_RefreshInfo;
}];

([_layout, "load"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", {
	if (RSTF_Presets_Selected >= 0) then {
		private _preset = RSTF_Presets select RSTF_Presets_Selected;
		{
			private _name = _x select 0;
			private _value = _x select 1;
			missionNamespace setVariable [_name, _value];
		} foreach (_preset select 1);

		call RSTF_Presets_Close;
	};
}];

([_layout, "saveAs"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", {
	[
		([RSTF_Presets_Layout] call ZUI_fnc_display) createDisplay "RscDisplayEmpty",
		"Enter preset name",
		{
			private _name = _this;
			private _values = [];
			{
				_values pushBack [_x, missionnamespace getVariable _x];
			} foreach RSTF_PROFILE_VALUES;

			RSTF_Presets pushBack [
				_name,
				_values
			];
			profileNamespace setVariable ["RSTF_PRESETS", RSTF_Presets];

			call RSTF_Presets_Refresh;
		},
		{}
	] spawn RSTFUI_fnc_showInputDialog;
}];

([_layout, "replace"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", {
	if (RSTF_Presets_Selected >= 0) then {
		private _preset = RSTF_Presets select RSTF_Presets_Selected;

		private _values = [];
		{
			_values pushBack [_x, missionnamespace getVariable _x];
		} foreach RSTF_PROFILE_VALUES;
		_preset set [1, _values];

		RSTF_Presets set [RSTF_Presets_Selected, _preset];
		profileNamespace setVariable ["RSTF_PRESETS", RSTF_Presets];

		call RSTF_Presets_Refresh;
		call RSTF_Presets_RefreshInfo;
	};
}];

([_layout, "delete"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", {
	0 spawn {
		if (RSTF_Presets_Selected >= 0) then {
			private _preset = RSTF_Presets select RSTF_Presets_Selected;
			private _result = [
				format["Do you really want to delete preset %1", _preset#0],
				"Confirmation",
				"Yes",
				"No"
			] call BIS_fnc_guiMessage;

			if (_result) then {
				RSTF_Presets deleteAt RSTF_Presets_Selected;
				profileNamespace setVariable ["RSTF_PRESETS", RSTF_Presets];

				call RSTF_Presets_Refresh;
				RSTF_Presets_Selected = -1;
				call RSTF_Presets_RefreshInfo;
			};
		};
	};
}];

([_layout, "close"] call ZUI_fnc_getControlById) ctrlAddEventHandler ["ButtonClick", {
	call RSTF_Presets_Close;
}];

0 spawn RSTF_Presets_Refresh;

[_layout, true] call ZUI_fnc_setVisible;