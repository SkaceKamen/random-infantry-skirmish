#define RSTF_FACTIONS_LEFT_X (SafeZoneX + 0.1)
#define RSTF_FACTIONS_LEFT_Y (SafeZoneY + 0.1)
#define RSTF_FACTIONS_LEFT_W 0.4
#define RSTF_FACTIONS_LEFT_H (SafeZoneY + SafeZoneH - RSTF_FACTIONS_LEFT_Y - 0.1)
#define RSTF_FACTIONS_LEFT_PANEL_H RSTF_FACTIONS_LEFT_H
#define RSTF_FACTIONS_LEFT_LIST_H (RSTF_FACTIONS_LEFT_PANEL_H - RSTF_SUBTITLE_H - RSTF_FACTIONS_BUTTON_H - RSTF_SUBTITLE_M*3 - RSTF_FACTIONS_CLOSE_H)

#define RSTF_FACTIONS_BUTTON_W RSTF_FACTIONS_LEFT_W
#define RSTF_FACTIONS_BUTTON_H 0.05

#define RSTF_FACTIONS_CLOSE_H 0.1

#define RSTF_FACTIONS_RIGHT_W 0.6
#define RSTF_FACTIONS_RIGHT_X (SafeZoneX + SafeZoneW - 0.1 - RSTF_FACTIONS_RIGHT_W)
#define RSTF_FACTIONS_RIGHT_Y (SafeZoneY + 0.1)
#define RSTF_FACTIONS_RIGHT_H (SafeZoneY + SafeZoneH - RSTF_FACTIONS_RIGHT_Y - 0.1)
#define RSTF_FACTIONS_RIGHT_PANEL_H (RSTF_FACTIONS_RIGHT_H - RSTF_SUBTITLE_M)/2
#define RSTF_FACTIONS_RIGHT_LIST_H (RSTF_FACTIONS_RIGHT_PANEL_H - RSTF_SUBTITLE_H - RSTF_FACTIONS_BUTTON_H - RSTF_SUBTITLE_M*2)

class RSTF_Factions_Background : RscStatic
{
	colorBackground[] = { 0, 0, 0, 0.6 };
	x = 0;
	w = RSTF_FACTIONS_LEFT_W;
};

class RSTF_Factions_Subtitle : RscStatic
{
	w = RSTF_FACTIONS_LEFT_W;
	h = RSTF_SUBTITLE_H;
	colorBackground[] = { "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.7 };
	text = "";
};

class RSTF_Factions_Button : RscButton
{
	x = RSTF_FACTIONS_LEFT_X;
	y = RSTF_FACTIONS_LEFT_Y;
	w = RSTF_FACTIONS_BUTTON_W;
	h = RSTF_FACTIONS_BUTTON_H;
	text = "BUTTON";
};

class RSTF_Factions_List : RscListNBox
{
	x = RSTF_FACTIONS_LEFT_X;
	y = RSTF_FACTIONS_LEFT_Y;
	w = RSTF_FACTIONS_LEFT_W;
	h = RSTF_FACTIONS_LEFT_LIST_H;
	columns[] = { 0, 0.6 };
};

class RSTF_Factions_Items_List : RscListNBox
{
	x = RSTF_FACTIONS_RIGHT_X;
	y = RSTF_FACTIONS_RIGHT_Y;
	w = RSTF_FACTIONS_RIGHT_W;
	h = RSTF_FACTIONS_RIGHT_LIST_H;
};

class RSTF_RscDialogFactions
{
    idd = 1005;
    enableDisplay = true;
    movingEnable = true;
    class controlsBackground
    {
		class factionsBack : RSTF_Factions_Background
		{
			x = RSTF_FACTIONS_LEFT_X;
			y = RSTF_FACTIONS_LEFT_Y + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M;
			w = RSTF_FACTIONS_LEFT_W;
			h = RSTF_FACTIONS_LEFT_LIST_H;
		};
		
		class avaibleSoldiersBack : RSTF_Factions_Background
		{
			x = RSTF_FACTIONS_RIGHT_X;
			y = RSTF_FACTIONS_RIGHT_Y + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M;
			w = RSTF_FACTIONS_RIGHT_W;
			h = RSTF_FACTIONS_RIGHT_LIST_H;
		};
		
		class avaibleWeaponsBack : RSTF_Factions_Background
		{
			x = RSTF_FACTIONS_RIGHT_X;
			y = RSTF_FACTIONS_RIGHT_Y + RSTF_FACTIONS_RIGHT_PANEL_H + RSTF_SUBTITLE_M + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M;
			w = RSTF_FACTIONS_RIGHT_W;
			h = RSTF_FACTIONS_RIGHT_LIST_H;
		};
	};
	class controls
	{
		class nothing : RscStatic
		{
			
		};
		
		class factionsTitle : RSTF_Factions_Subtitle
		{
			x = RSTF_FACTIONS_LEFT_X;
			y = RSTF_FACTIONS_LEFT_Y;
			text = "Factions";
		};
		
		class factions : RSTF_Factions_List
		{
			idc = 1;
			x = RSTF_FACTIONS_LEFT_X;
			y = RSTF_FACTIONS_LEFT_Y + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M;
		};
		
		class toggleFaction : RSTF_Factions_Button
		{
			idc = 4;
			x = RSTF_FACTIONS_LEFT_X;
			y = RSTF_FACTIONS_LEFT_Y + RSTF_FACTIONS_LEFT_LIST_H + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M*2;
			text = "Select";
		};
		
		class avaibleSoldiersTitle : RSTF_Factions_Subtitle
		{
			x = RSTF_FACTIONS_RIGHT_X;
			y = RSTF_FACTIONS_RIGHT_Y;
			w = RSTF_FACTIONS_RIGHT_W;
			text = "Soldiers";
		};
		
		class avaibleSoldiers : RSTF_Factions_Items_List
		{
			idc = 5;
			x = RSTF_FACTIONS_RIGHT_X;
			y = RSTF_FACTIONS_RIGHT_Y + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M;
			w = RSTF_FACTIONS_RIGHT_W;
			columns[] = { 0, 0.6, 0.8 };
		};
		
		class banSoldier : RSTF_Factions_Button
		{
			idc = 6;
			x = RSTF_FACTIONS_RIGHT_X;
			y = RSTF_FACTIONS_RIGHT_Y + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M*2 + RSTF_FACTIONS_RIGHT_LIST_H;
			w = RSTF_FACTIONS_RIGHT_W;
			text = "Toggle ban";
		};
		
		class avaibleWeaponsTitle : RSTF_Factions_Subtitle
		{
			x = RSTF_FACTIONS_RIGHT_X;
			y = RSTF_FACTIONS_RIGHT_Y + RSTF_FACTIONS_RIGHT_PANEL_H + RSTF_SUBTITLE_M;
			w = RSTF_FACTIONS_RIGHT_W;
			text = "Weapons (Only if weapons are restricted to faction weapons)";
		};
		
		class avaibleWeapons : RSTF_Factions_Items_List
		{
			idc = 7;
			x = RSTF_FACTIONS_RIGHT_X;
			y = RSTF_FACTIONS_RIGHT_Y + RSTF_FACTIONS_RIGHT_PANEL_H + RSTF_SUBTITLE_M + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M;
			w = RSTF_FACTIONS_RIGHT_W;
			columns[] = { 0, 0.8 };
		};
		
		class banWeapon : RSTF_Factions_Button
		{
			idc = 8;
			x = RSTF_FACTIONS_RIGHT_X;
			y = RSTF_FACTIONS_RIGHT_Y + RSTF_FACTIONS_RIGHT_PANEL_H + RSTF_SUBTITLE_M + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M*2 + RSTF_FACTIONS_RIGHT_LIST_H;
			text = "Toggle ban";
			w = RSTF_FACTIONS_RIGHT_W;
		};
		
		class close : RscButton
		{
			idc = 9;
			x = RSTF_FACTIONS_LEFT_X;
			y = RSTF_FACTIONS_LEFT_Y + RSTF_FACTIONS_LEFT_H - RSTF_FACTIONS_CLOSE_H;
			w =	RSTF_FACTIONS_LEFT_W;
			h = RSTF_FACTIONS_CLOSE_H;
			text = "Save and back";
		};
	};
};