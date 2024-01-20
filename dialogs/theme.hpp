#define GUI_GRID_WAbs		((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs		(((safezoneW / safezoneH) min 1.2)/ 1.2)
#define GUI_GRID_W			(((safezoneW / safezoneH) min 1.2)/ 40)
#define GUI_GRID_H			((((safezoneW / safezoneH) min 1.2)/ 1.2)/ 25)
#define GUI_GRID_X			(safezoneX)
#define GUI_GRID_Y			(safezoneY + safezoneH - (((safezoneW / safezoneH) min 1.2)/ 1.2))

#define GUI_STANDARD_FONT "PuristaMedium"
#define GUI_TITLE_FONT    "PuristaLight"
#define GUI_BUTTON_FONT   "PuristaLight"
#define GUI_TEXT_SIZE_SMALL 	(GUI_GRID_H * 0.8)
#define GUI_TEXT_SIZE_MEDIUM 	(GUI_GRID_H * 1)
#define GUI_TEXT_SIZE_LARGE 	(GUI_GRID_H * 1.2)
#define GUI_TITLE_BG { "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])" }
#define GUI_BODY_BG { 0, 0, 0, 0.7 }
#define GUI_BUTTON_BG { 0, 0, 0, 0.8 }
#define GUI_SPACING 0.005

#define USER_BG_RGB "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])"
#define TITLE_BG_RGBA USER_BG_RGB,0.8

#define SPACER_COMPONENT class spacer##__LINE__ : ZUI_RowLayout {}

#define SPACING_TOP { GUI_SPACING * 1, 0, 0, 0 }
#define SPACING_RIGHT { 0, GUI_SPACING * 1, 0, 0 }
#define SPACING_BOTTOM { 0, 0, GUI_SPACING * 1, 0 }
#define SPACING_LEFT { 0, 0, 0, GUI_SPACING * 1 }

class ZTitle: ZUI_Static
{
	background[] = GUI_TITLE_BG;
	font = GUI_TITLE_FONT;
	textSize = GUI_TEXT_SIZE_MEDIUM;
	height = 0.05;
	heightType = ZUI_SIZE_ABSOLUTE;
}