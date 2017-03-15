#define RSTF_MAP_W (SafeZoneW - 0.4)
#define RSTF_MAP_H (SafeZoneH - 0.4)
#define RSTF_MAP_X (SafeZoneX + SafeZoneW/2 - RSTF_MAP_W/2)
#define RSTF_MAP_Y (SafeZoneY + SafeZoneH/2 - RSTF_MAP_H/2)

#define RSTF_MAP_BUTTON_H 0.05

#define RSTF_MAP_LIST_W (0.4 * RSTF_MAP_W)
#define RSTF_MAP_LIST_H (RSTF_MAP_H - 0.05 - 0.025 - RSTF_MAP_BUTTON_H)
#define RSTF_MAP_LIST_X (RSTF_MAP_X + 0.025)
#define RSTF_MAP_LIST_Y (RSTF_MAP_Y + 0.025)

#define RSTF_MAP_IMAGE_W (RSTF_MAP_W - RSTF_MAP_LIST_W)
#define RSTF_MAP_IMAGE_H RSTF_MAP_H
#define RSTF_MAP_IMAGE_X (RSTF_MAP_LIST_X + RSTF_MAP_LIST_W)
#define RSTF_MAP_IMAGE_Y RSTF_MAP_Y

class RSTF_Map_Background : RscStatic
{
	colorBackground[] = { 0, 0, 0, 0.6 };
	x = RSTF_MAP_X;
	y = RSTF_MAP_Y;
	w = RSTF_MAP_W;
	h = RSTF_MAP_H;
};


class RSTF_RscDialogMaps
{
    idd = 1012;
    enableDisplay = true;
    movingEnable = true;
    class controlsBackground
	{
		class mapsBack : RSTF_Map_Background {};
		class listBack : RSTF_Map_Background
		{
			w = RSTF_MAP_LIST_W;
			h = RSTF_MAP_LIST_H;
			x = RSTF_MAP_LIST_X;
			y = RSTF_MAP_LIST_Y;
		};
	};
	
	class controls
	{
		class mapsList : RscListNBox
		{
			idc = 2;
			
			w = RSTF_MAP_LIST_W;
			h = RSTF_MAP_LIST_H;
			x = RSTF_MAP_LIST_X;
			y = RSTF_MAP_LIST_Y;
			columns[] = { 0, 0.8 };
		};
		
		class select: RscButton
		{
			idc = 3;
			
			x = RSTF_MAP_LIST_X;
			y = RSTF_MAP_LIST_Y + RSTF_MAP_LIST_H + 0.025;
			w = RSTF_MAP_LIST_W;
			h = RSTF_MAP_BUTTON_H;
			
			text = "Select";
		};
		
		class mapsImage : RscPictureKeepAspect
		{
			idc = 4;
			
			w = RSTF_MAP_IMAGE_W;
			h = RSTF_MAP_IMAGE_H;
			x = RSTF_MAP_IMAGE_X;
			y = RSTF_MAP_IMAGE_Y;
		};
	};
};