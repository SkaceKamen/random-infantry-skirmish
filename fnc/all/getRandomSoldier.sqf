private ["_class"];
if (count(RSTF_MEN select _this) == 0) then {
	diag_log format["%1 doesn't have any men!", _this];
};

_class = (RSTF_MEN select _this) select round(random(count(RSTF_MEN select _this)-1));
_class;