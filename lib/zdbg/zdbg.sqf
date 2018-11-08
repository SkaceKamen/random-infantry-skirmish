ZDBG_Prefix = '';

ZDBG_fnc_point = {
	params ["_label"];
	[_label, diag_tickTime];
};

ZDBG_fnc_end = {
	diag_log text(ZDBG_Prefix + format["%1: %2", _this#0, diag_tickTime - _this#1]);
}