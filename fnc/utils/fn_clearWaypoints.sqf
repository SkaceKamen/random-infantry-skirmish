private _group = param [0];

while { count(waypoints _group) > 0 } do {
	deleteWaypoint ((waypoints _group) select 0);
};
