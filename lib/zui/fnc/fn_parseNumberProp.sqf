private _prop = param [0];
if (typeName(_prop) == typeName("")) exitWith {
	call compile _prop;
};
_prop;