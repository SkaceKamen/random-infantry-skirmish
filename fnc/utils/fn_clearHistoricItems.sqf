private _center = param [0, nil, [[0, 0, 0]]];
private _radius = param [1, nil, [0]];

private _entities = nearestTerrainObjects [_center, [], _radius];
private _hidden = [
	// Modern car wrecks
	'wreck_car_f.p3d',
	'wreck_car2_f.p3d',
	'wreck_car3_f.p3d',
	'wreck_skodovka_f.p3d',
	'wreck_offroad_f.p3d',
	'wreck_offroad2_f.p3d',
	'wreck_cardismantled_f.p3d',
	'wreck_ural_f.p3d',
	'wreck_truck_f.p3d',
	'wreck_truck_dropside_f.p3d',
	'wreck_uaz_f.p3d',
	'wreck_hunter_f.p3d',
	// TODO: CUP Wrecks
	// Some other modern buildings and props
	'toiletbox_f.p3d',
	'kiosk_blueking_f.p3d',
	'signt_infohotel.p3d'
];

{
	private _entity = _x;
	private _entityStr = str(_entity);
	{
		if (_entityStr find _x >= 0) exitWith {
			_entity hideObjectGlobal true;
		};
	} forEach _hidden;
} forEach _entities;
