private _killed = param [0];
private _killer = param [1];

if (count(_this) > 2) then {
	_killer = param [2];
};

// Possibly support kill?
/*
private _supportKiller = _killer getVariable ["SUPPORT_ORIGIN", objNull];
if (!isNull(_supportKiller)) then {
	_killer = _supportKiller;
};
*/

// Side is forgotten shortly after dying for some reason
private _side = _killed getVariable ["SPAWNED_SIDE", civilian];

private _isLegit = _side != side(_killer) && _killer != _killed;

if (RSTF_MONEY_ENABLED) then {
	if (isPlayer(_killer)) then {
		if (_side != side(_killer) && _killer != _killed) then {
			[_killer, RSTF_MONEY_PER_KILL] call RSTF_fnc_addPlayerMoney;
		} else {
			[_killer, RSTF_MONEY_PER_TEAMKILL] call RSTF_fnc_addPlayerMoney;
		};
	} else {
		if (_side != side(_killer) && _killer != _killed) then {
			[_killer getVariable ["ORIGINAL_NAME", name(_killer)], RSTF_MONEY_PER_KILL * RSTF_AI_MONEY_MULTIPLIER] call RSTF_fnc_addUnitMoney;
		};
	};
};

// Award vehicle commander assist if applicable
if (RSTF_MONEY_ENABLED && _isLegit) then {
	if (vehicle(_killer) != _killer && effectiveCommander(vehicle(_killer)) != _killer && isPlayer(effectiveCommander(vehicle(_killer)))) then {
		private _commander = effectiveCommander(vehicle(_killer));
		[_commander, RSTF_MONEY_PER_VEHICLE_COMMANDER_ASSIST] call RSTF_fnc_addPlayerMoney;
		[format["+$%1 <t color='#dddddd'>Commander assist</t>", RSTF_MONEY_PER_VEHICLE_COMMANDER_ASSIST], 5] remoteExec ["RSTFUI_fnc_addMessage", _commander];
	};
};

// Dispatch message if necessary
if (isPlayer(_killer)) then {
	private _message = "";
	private _distance = round(_killed distance _killer);

	if (_isLegit) then {
		if (RSTF_MONEY_ENABLED) then {
			_message = format["+$%1 <t color='#dddddd'>Kill</t>", RSTF_MONEY_PER_KILL];
		} else {
			_message = format["<t color='#dddddd'>Kill</t>"];
		};

		if (_distance >= RSTF_KILL_DISTANCE_BONUS) then {
			_message = _message + format[" (%1m)", _distance];
		};
	} else {
		if (RSTF_MONEY_ENABLED) then {
			_message = format["-$%1 <t color='#dddddd'>Teamkill</t>", -RSTF_MONEY_PER_TEAMKILL];
		} else {
			_message = format["<t color='#dddddd'>Teamkill</t>"];
		};
	};

	[_message, 5] remoteExec ["RSTFUI_fnc_addMessage", _killer];
};