#include "zui-defines.inc"

class RscTextCenter
{
	idc = -1;
	moving = -1;

	type = CT_STATIC;
	style = ST_CENTER;

	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

	colorBackground[] = { 0, 0, 0, 0 };
	colorText[] = { 1, 1, 1, 1 };

	font = "RobotoCondensed";

	shadow = 1;

	text = "";

	x = 0;
	y = 0;
	w = 0;
	h = 0;
};

class RscTextRight: RscTextCenter
{
	style = ST_RIGHT;
};

class ZUI_Component
{
	type = ZUI_CONTAINER_ID;
	width = 1;
	widthType = ZUI_SIZE_RELATIVE;
	height = 1;
	heightType = ZUI_SIZE_RELATIVE;
	padding = 0;
	margin = 0;
	layout = ZUI_LAYOUT_COLUMN;
};

class ZUI_Control: ZUI_Component
{
	type = ZUI_CONTROL_ID;
};

class ZUI_Button: ZUI_Control
{
	control = "RscButton";
	font = "PuristaLight";
};

class ZUI_Static: ZUI_Control
{
	control = "RscText";
};

class ZUI_Text: ZUI_Control
{
	control = "RscText";
};

class ZUI_TextCenter: ZUI_Control
{
	control = "RscTextCenter";
};

class ZUI_TextRight: ZUI_Control
{
	control = "RscTextRight";
};

class ZUI_Listview: ZUI_Control
{
	control = "RscListNBox";
};

class ZUI_Edit: ZUI_Control
{
	control = "RscEdit";
};

class ZUI_Picture: ZUI_Control
{
	control = "RscPictureKeepAspect";
};

class ZUI_StructuredText: ZUI_Control
{
	control = "RscStructuredText";
};

class ZUI_Container: ZUI_Component
{
	type = ZUI_CONTAINER_ID;
	scrollable = 0;
};

class ZUI_RowLayout: ZUI_Container
{
	layout = ZUI_LAYOUT_ROW;
};

class ZUI_ColumnLayout: ZUI_Container
{
	layout = ZUI_LAYOUT_COLUMN;
};
