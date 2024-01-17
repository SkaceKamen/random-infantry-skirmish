params ["_target", "_caller", "_actionId", "_arguments"];

private _primaryWeaponMagazines = primaryWeaponMagazine _caller;
private _secondaryWeaponMagazines = secondaryWeaponMagazine _caller;

private _callerItems = items _caller;

{
	if (!(_x in _callerItems)) then {
		_caller addItem _x;
	};
} forEach ["FirstAidKit"];

if (count(_secondaryWeaponMagazines) > 0) then {
	_caller addMagazines [_secondaryWeaponMagazines#0, 2];
};

if (count(_primaryWeaponMagazines) > 0) then {
	_caller addMagazines [_primaryWeaponMagazines#0, 5];
};