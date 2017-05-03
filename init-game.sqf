params [["_root", ""], ["_player", false]];

//Make sure we can spawn everything
EQ = createcenter east;
WQ = createcenter west;
RQ = createcenter resistance;
CQ = createcenter civilian;

WEST setFriend [EAST, 0];
WEST setFriend [RESISTANCE, 0];
EAST setFriend [WEST, 0];
EAST setFriend [RESISTANCE, 0];
RESISTANCE setFriend [WEST, 0];
RESISTANCE setFriend [EAST, 0];

SCRIPTS_ROOT = _root;

//Create player if needed
if (_player) then {
	_unit = (creategroup west) createUnit [ "B_Soldier_F", [0, 0, 0], [], 0, "NONE" ];
	_unit allowDamage false;
	{
		_unit disableAI _x;
	} foreach ["TARGET", "AUTOTARGET", "MOVE", "ANIM", "FSM"];
	
	setPlayable _unit;
	selectPlayer _unit;
};
