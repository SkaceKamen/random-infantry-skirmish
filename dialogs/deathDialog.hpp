#define RSTF_DEATH_X (SafeZoneX + SafeZoneW/2 - RSTF_DEATH_W/2)
#define RSTF_DEATH_Y (SafeZoneY + SafeZoneH/2 - RSTF_DEATH_H/2)
#define RSTF_DEATH_W 0.7
#define RSTF_DEATH_H (SafeZoneH - 0.2)
#define RSTF_DEATH_TITLE_H 0.15
#define RSTF_DEATH_IMAGE_H 0.25
#define RSTF_DEATH_BUTTON_H 0.1

class RSTF_DEATH_Button : RscButton
{
	shadow = 0;
	colorBackground[] = { 0, 0, 0, 1 };
	colorText[] = { 1, 1, 1, 1 };
	colorShadow[] = { 0,0,0,0 };
};

class RSTF_RscDeathDialog
{
    idd = 1006;
    enableDisplay = true;
    movingEnable = false;
	class controlsBackground
	{
		class weaponImageBack : RSTF_Background
		{
			x = RSTF_DEATH_X;
			y = RSTF_DEATH_Y + RSTF_DEATH_TITLE_H + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M;
			w = RSTF_DEATH_W;
			h = RSTF_DEATH_IMAGE_H;
			colorBackground[] = { 0.6, 0.6, 0.6, 0.6 };
		};
	};
	class controls
	{
		class nothing : RscStatic
		{
			
		};
		class title : RscStatic
		{
			x = RSTF_DEATH_X;
			y = RSTF_DEATH_Y;
			w = RSTF_DEATH_W;
			h = RSTF_DEATH_TITLE_H;
			sizeEx = 0.1;
			shadow = 1;
			text = "You've been killed";
			style = ST_CENTER;
		};
		class weaponName : RSTF_Subtitle
		{
			idc = 5;
			x = RSTF_DEATH_X;
			y = RSTF_DEATH_Y + RSTF_DEATH_TITLE_H;
			w = RSTF_DEATH_W;
			text = "By M4A1";
			style = ST_CENTER;
		};
		class weaponImage : RscPictureKeepAspect
		{
			idc = 4;
			x = RSTF_DEATH_X;
			y = RSTF_DEATH_Y + RSTF_DEATH_TITLE_H + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M;
			w = RSTF_DEATH_W;
			h = RSTF_DEATH_IMAGE_H;
			colorBackground[] = { 0,0,0,1 };
		};
		class distance : RSTF_Subtitle
		{
			idc = 3;
			x = RSTF_DEATH_X;
			y = RSTF_DEATH_Y + RSTF_DEATH_TITLE_H + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M*2 + RSTF_DEATH_IMAGE_H;
			w = RSTF_DEATH_W;
			text = "From distance of 100m";
			style = ST_CENTER;
		};
		class equip : RSTF_DEATH_Button
		{
			idc = 6;
			x = RSTF_DEATH_X;
			y = RSTF_DEATH_Y + RSTF_DEATH_H - RSTF_DEATH_BUTTON_H * 2 - 0.01;
			w = RSTF_DEATH_W;
			h = RSTF_DEATH_BUTTON_H;
			text = "EQUIPMENT";
		};
		class spawn : RSTF_DEATH_Button
		{
			idc = 2;
			x = RSTF_DEATH_X;
			y = RSTF_DEATH_Y + RSTF_DEATH_H - RSTF_DEATH_BUTTON_H;
			w = RSTF_DEATH_W;
			h = RSTF_DEATH_BUTTON_H;
			text = "SPAWN";
		};
	};
};