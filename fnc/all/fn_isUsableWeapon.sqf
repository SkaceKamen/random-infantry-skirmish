private ["_magazine", "_type", "_usable"];

_magazine = getArray(_this >> "magazines");
_type = getNumber(_this >> "type");
_usable = (!isNil("_magazine") && count(_magazine) > 0 && (_type == 1 || _type == 2 || _type == 4));
_usable;