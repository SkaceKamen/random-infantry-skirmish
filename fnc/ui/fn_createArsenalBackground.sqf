private _centerPos = param [0];

private _sphere = createvehicle ["Sphere_3DEN",_centerPos,[],0,"none"];
_sphere setposatl _centerPos;
_sphere setdir 0;
_sphere setobjecttexture [0,"#(argb,8,8,3)color(0.93,1.0,0.98,0.028,co)"];
_sphere setobjecttexture [1,"#(argb,8,8,3)color(0.93,1.0,0.98,0.01,co)"];

private _center = createagent ["C_Soldier_VR_F", _centerPos, [], 0, "none"];
_center setposatl _centerPos;
_center setdir 0;
_center switchmove animationstate _center;
_center switchaction "playerstand";
_center enablesimulation false;

//--- Create light for night editing (code based on BIS_fnc_3DENFlashlight)
private _intensity = 20;
private _light = "#lightpoint" createvehicle _centerPos;
_light setlightbrightness _intensity;
_light setlightambient [1,1,1];
_light setlightcolor [0,0,0];
_light lightattachobject [_sphere,[0,0,-_intensity * 7]];

//--- Save to global variables, so it can be deleted latger
missionnamespace setvariable ["BIS_fnc_arsenal_light",_light];
missionnamespace setvariable ["BIS_fnc_arsenal_sphere",_sphere];
missionNamespace setVariable ["BIS_fnc_arsenal_drawGrid", addMissionEventHandler ["draw3D", {
	_sphere = missionnamespace getvariable ["BIS_fnc_arsenal_sphere",objnull];
	for "_x" from -5 to 5 step 1 do {
		drawLine3D [
			_sphere modeltoworld [_x,-5,0],
			_sphere modeltoworld [_x,+5,0],
			[0.03,0.03,0.03,1]
		];
	};
	for "_y" from -5 to 5 step 1 do {
		drawLine3D [
			_sphere modeltoworld [-5,_y,0],
			_sphere modeltoworld [+5,_y,0],
			[0.03,0.03,0.03,1]
		];
	};
}]];

_center;
