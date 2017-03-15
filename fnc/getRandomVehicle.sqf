private ["_class", "_list"];
_list = (RSTF_VEHICLES select (_this select 0)) select (_this select 1);
_class = _list select round(random(count(_list)-1));
_class;