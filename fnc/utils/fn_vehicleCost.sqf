private _className = param [0];

private _cost = getNumber(configFile >> "cfgVehicles" >> _className >> "cost");

round((_cost / 1E6) * 2000);