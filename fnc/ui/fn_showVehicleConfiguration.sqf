private _className = param [0];

private _config = configFile >> "CfgVehicles" >> _className;
private _cost = [_className] call RSTF_fnc_getVehicleCost;
private _crew = [_className] call RSTF_fnc_getVehicleClassCrew;
private _skins = [_className] call RSTF_fnc_getVehicleClassSkins;
private _components = [_className] call RSTF_fnc_getVehicleClassComponents;

RSTF_VEHICLE_CONFIG_layout = [missionConfigFile >> "VehicleConfigurationDialog"] call ZUI_fnc_createDisplay;
RSTF_VEHICLE_CONFIG_CLASS = _className;
RSTF_VEHICLE_CONFIG_COMPONENTS = [];

private _ctrl = [RSTF_VEHICLE_CONFIG_layout, "vehicle"] call ZUI_fnc_getControlById;
_ctrl ctrlSetText getText(_config >> "displayName");

_ctrl = [RSTF_VEHICLE_CONFIG_layout, "cost"] call ZUI_fnc_getControlById;
_ctrl ctrlSetText "$" + str(_cost);

_ctrl = [RSTF_VEHICLE_CONFIG_layout, "seat"] call ZUI_fnc_getControlById;
_ctrl lbAdd "Default";

{
	_ctrl lbAdd (_x#0);
} forEach _crew;

_ctrl lbSetCurSel 0;

_ctrl = [RSTF_VEHICLE_CONFIG_layout, "skin"] call ZUI_fnc_getControlById;
_ctrl lbAdd "Default";
{
	_ctrl lbAdd (_x#1);
} forEach _skins;

_ctrl lbSetCurSel 0;


_ctrl = [RSTF_VEHICLE_CONFIG_layout, "components"] call ZUI_fnc_getControlById;

{
	_ctrl lnbAddRow ["", _x#1];
	_ctrl lnbSetPicture [[_forEachIndex, 0], "\A3\ui_f\data\gui\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa"];
	_ctrl lnbSetPictureColor [[_forEachIndex, 0], [1,1,1,1]];
} forEach _components;

_ctrl ctrlAddEventHandler ["LBSelChanged", {
	params ["_ctrl", "_selected"];
	private _components = [RSTF_VEHICLE_CONFIG_CLASS] call RSTF_fnc_getVehicleClassComponents;
	private _selectedComp = (_components#_selected)#0;

	if (_selectedComp in RSTF_VEHICLE_CONFIG_COMPONENTS) then {
		RSTF_VEHICLE_CONFIG_COMPONENTS = RSTF_VEHICLE_CONFIG_COMPONENTS - [_selectedComp];
	} else {
		RSTF_VEHICLE_CONFIG_COMPONENTS pushBack _selectedComp;
	};

	{
		if (_x#0 in RSTF_VEHICLE_CONFIG_COMPONENTS) then {
			_ctrl lnbSetPicture [[_forEachIndex, 0], "\A3\ui_f\data\gui\RscCommon\RscCheckBox\CheckBox_checked_ca.paa"];
		} else {
			_ctrl lnbSetPicture [[_forEachIndex, 0], "\A3\ui_f\data\gui\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa"];
		};
	} forEach _components;
}];

_ctrl = [RSTF_VEHICLE_CONFIG_layout, "cancel"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	([RSTF_VEHICLE_CONFIG_layout] call ZUI_fnc_display) closeDisplay 0;
}];


_ctrl = [RSTF_VEHICLE_CONFIG_layout, "buy"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	private _className = RSTF_VEHICLE_CONFIG_CLASS;
	private _cost = [_className] call RSTF_fnc_getVehicleCost;
	private _crew = [_className] call RSTF_fnc_getVehicleClassCrew;
	private _skins = [_className] call RSTF_fnc_getVehicleClassSkins;
	private _components = [_className] call RSTF_fnc_getVehicleClassComponents;

	private _seatCtrl = [RSTF_VEHICLE_CONFIG_layout, "seat"] call ZUI_fnc_getControlById;
	private _skinCtrl = [RSTF_VEHICLE_CONFIG_layout, "skin"] call ZUI_fnc_getControlById;
	private _componentsCtrl = [RSTF_VEHICLE_CONFIG_layout, "components"] call ZUI_fnc_getControlById;

	private _crewIndex = lbCurSel _seatCtrl;
	private _crewParam = ["", "effectiveCommander"];
	if (_crewIndex > 0) then {
		_crewParam = _crew select (_crewIndex - 1);
	};

	private _camouflage = false;
	private _camouflageIndex = lbCurSel _skinCtrl;
	if (_camouflageIndex > 0) then {
		_camouflage = (_skins select (_camouflageIndex - 1))#0;
	};

	private _components = false;
	if (count(RSTF_VEHICLE_CONFIG_COMPONENTS) > 0) then {
		_components = RSTF_VEHICLE_CONFIG_COMPONENTS;	
	};

	[player, _className, _crewParam, _camouflage, _components] remoteExec ["RSTF_fnc_requestVehicle", 2];
	([RSTF_VEHICLE_CONFIG_layout] call ZUI_fnc_display) closeDisplay 0;
}];
