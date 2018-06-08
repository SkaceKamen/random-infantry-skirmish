
{
	deleteVehicle _x;
} foreach [
	missionnamespace getVariable "BIS_fnc_arsenal_light",
	missionnamespace getVariable "BIS_fnc_arsenal_sphere"
];

removeMissionEventHandler ["draw3D", missionNamespace getVariable "BIS_fnc_arsenal_drawGrid"];