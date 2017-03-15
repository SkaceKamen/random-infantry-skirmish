#define RSTF_EQUIP_LEFT_X (SafeZoneX + 0.1)
#define RSTF_EQUIP_LEFT_Y (SafeZoneY + 0.2)
#define RSTF_EQUIP_LEFT_W 0.5
#define RSTF_EQUIP_LEFT_H (SafeZoneH - 0.4)
#define RSTF_EQUIP_RIGHT_W 0.5
#define RSTF_EQUIP_RIGHT_H (SafeZoneH - 0.4)
#define RSTF_EQUIP_RIGHT_X (SafeZoneX + SafeZoneW - RSTF_EQUIP_RIGHT_W - 0.1)
#define RSTF_EQUIP_RIGHT_Y (SafeZoneY + 0.2)

#define RSTF_EQUIP_WEAPONS_H (RSTF_EQUIP_LEFT_H*0.6)
#define RSTF_EQUIP_SECONDARY_H (RSTF_EQUIP_LEFT_H*0.4)
#define RSTF_EQUIP_ATTACHMENTS_H (RSTF_EQUIP_LEFT_H*0.6)
#define RSTF_EQUIP_EQUIPPED_H (RSTF_EQUIP_LEFT_H*0.6)
#define RSTF_EQUIP_BUTTON_H 0.05

class RSTF_RscDialogEquip
{
    idd = 1007;
    enableDisplay = true;
    movingEnable = true;
    class controlsBackground
    {
		class primaryBack : RSTF_Background
		{
			x = RSTF_EQUIP_LEFT_X;
			y = RSTF_EQUIP_LEFT_Y + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M;
			w = RSTF_EQUIP_LEFT_W;
			h = RSTF_EQUIP_WEAPONS_H - RSTF_SUBTITLE_H - RSTF_EQUIP_BUTTON_H - RSTF_SUBTITLE_M*3;
			colorBackground[] = { 0.5, 0.5, 0.5, 0.8 };
		};
		
		class secondaryBack : RSTF_Background
		{
			x = RSTF_EQUIP_LEFT_X;
			y = RSTF_EQUIP_LEFT_Y + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M + RSTF_EQUIP_WEAPONS_H;
			w = RSTF_EQUIP_LEFT_W;
			h = RSTF_EQUIP_SECONDARY_H - RSTF_SUBTITLE_H - RSTF_EQUIP_BUTTON_H - RSTF_SUBTITLE_M*2;
			colorBackground[] = { 0.5, 0.5, 0.5, 0.8 };
		};
		
		class attachmentsBack : RSTF_Background
		{
			x = RSTF_EQUIP_RIGHT_X;
			y = RSTF_EQUIP_RIGHT_Y + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M;
			w = RSTF_EQUIP_RIGHT_W;
			h = RSTF_EQUIP_ATTACHMENTS_H - RSTF_SUBTITLE_H - RSTF_EQUIP_BUTTON_H - RSTF_SUBTITLE_M*2;
			colorBackground[] = { 0.5, 0.5, 0.5, 0.8 };
		};
		
		class equippedBack : RSTF_Background
		{
			x = RSTF_EQUIP_RIGHT_X;
			y = RSTF_EQUIP_RIGHT_Y + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M + RSTF_EQUIP_ATTACHMENTS_H;
			w = RSTF_EQUIP_RIGHT_W;
			h = RSTF_EQUIP_SECONDARY_H - RSTF_SUBTITLE_H - RSTF_EQUIP_BUTTON_H - RSTF_SUBTITLE_M*2;
			colorBackground[] = { 0.5, 0.5, 0.5, 0.8 };
		};
	};
	class controls
	{
		class nothing : RscStatic
		{
			
		};
		
		class primaryTitle : RSTF_Subtitle
		{
			x = RSTF_EQUIP_LEFT_X;
			y = RSTF_EQUIP_LEFT_Y;
			w = RSTF_EQUIP_LEFT_W;
			text = "Primary";
		};
		
		class primary : RscListNBox
		{
			idc = 1;
			x = RSTF_EQUIP_LEFT_X;
			y = RSTF_EQUIP_LEFT_Y + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M;
			w = RSTF_EQUIP_LEFT_W;
			h = RSTF_EQUIP_WEAPONS_H - RSTF_SUBTITLE_H - RSTF_EQUIP_BUTTON_H - RSTF_SUBTITLE_M*3;
			columns[] = { 0, 0.6 };
			rowHeight = 0.1;
		};
		
		/*
		class selectWeapon : RscButton
		{
			idc = 2;
			x = RSTF_EQUIP_LEFT_X;
			y = RSTF_EQUIP_LEFT_Y + RSTF_EQUIP_WEAPONS_H - RSTF_EQUIP_BUTTON_H - RSTF_SUBTITLE_M;
			w = RSTF_EQUIP_LEFT_W;
			h = RSTF_EQUIP_BUTTON_H;
			text = "Select";
		};
		*/
		
		class secondaryTitle : RSTF_Subtitle
		{
			x = RSTF_EQUIP_LEFT_X;
			y = RSTF_EQUIP_LEFT_Y + RSTF_EQUIP_WEAPONS_H;
			w = RSTF_EQUIP_LEFT_W;
			text = "Secondary";
		};
		
		class secondary : RscListNBox
		{
			idc = 3;
			x = RSTF_EQUIP_LEFT_X;
			y = RSTF_EQUIP_LEFT_Y + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M + RSTF_EQUIP_WEAPONS_H;
			w = RSTF_EQUIP_LEFT_W;
			h = RSTF_EQUIP_SECONDARY_H - RSTF_SUBTITLE_H - RSTF_EQUIP_BUTTON_H - RSTF_SUBTITLE_M*2;
			columns[] = { 0, 0.6 };
			rowHeight = 0.1;
		};
		
		/*
		class selectSecondary : RscButton
		{
			idc = 4;
			x = RSTF_EQUIP_LEFT_X;
			y = RSTF_EQUIP_LEFT_Y + RSTF_EQUIP_WEAPONS_H + RSTF_EQUIP_SECONDARY_H - RSTF_EQUIP_BUTTON_H;
			w = RSTF_EQUIP_LEFT_W;
			h = RSTF_EQUIP_BUTTON_H;
			text = "Select";
		};
		*/
		
		class attachmentsTitle : RSTF_Subtitle
		{
			x = RSTF_EQUIP_RIGHT_X;
			y = RSTF_EQUIP_RIGHT_Y;
			w = RSTF_EQUIP_RIGHT_W;
			text = "Attachments";
		};
		
		class attachments : RscListNBox
		{
			idc = 4;
			x = RSTF_EQUIP_RIGHT_X;
			y = RSTF_EQUIP_RIGHT_Y + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M;
			w = RSTF_EQUIP_RIGHT_W;
			h = RSTF_EQUIP_ATTACHMENTS_H - RSTF_SUBTITLE_H - RSTF_EQUIP_BUTTON_H - RSTF_SUBTITLE_M*2;
			columns[] = { 0, 0.6 };
			rowHeight = 0.05;
		};
		
		class buttonAttach : RscButton
		{
			idc = 6;
			x = RSTF_EQUIP_RIGHT_X;
			y = RSTF_EQUIP_RIGHT_Y + RSTF_EQUIP_ATTACHMENTS_H - RSTF_EQUIP_BUTTON_H - RSTF_SUBTITLE_M;
			w = RSTF_EQUIP_RIGHT_W;
			h = RSTF_EQUIP_BUTTON_H;
			text = "Attach";
		};
		
		class equippedTitle : RSTF_Subtitle
		{
			x = RSTF_EQUIP_RIGHT_X;
			y = RSTF_EQUIP_RIGHT_Y + RSTF_EQUIP_ATTACHMENTS_H;
			w = RSTF_EQUIP_RIGHT_W;
			text = "Equipped";
		};
		
		class equipped : RscListNBox
		{
			idc = 5;
			x = RSTF_EQUIP_RIGHT_X;
			y = RSTF_EQUIP_RIGHT_Y + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M + RSTF_EQUIP_ATTACHMENTS_H;
			w = RSTF_EQUIP_RIGHT_W;
			h = RSTF_EQUIP_EQUIPPED_H - RSTF_SUBTITLE_H - RSTF_EQUIP_BUTTON_H - RSTF_SUBTITLE_M*2;
			columns[] = { 0, 0.6 };
			rowHeight = 0.05;
		};
		
		class buttonDeattach : RscButton
		{
			idc = 7;
			x = RSTF_EQUIP_RIGHT_X;
			y = RSTF_EQUIP_RIGHT_Y + RSTF_EQUIP_ATTACHMENTS_H + RSTF_EQUIP_EQUIPPED_H - RSTF_EQUIP_BUTTON_H;
			w = RSTF_EQUIP_RIGHT_W;
			h = RSTF_EQUIP_BUTTON_H;
			text = "Remove";
		};
		
		class buttonBack : RscButton
		{
			idc = 8;
			x = SafeZoneX + SafeZoneW /2 - 0.15;
			y = SafeZoneY + SafeZoneH - 0.1 - 0.05;
			w = 0.3;
			h = 0.1;
			text = "Save";
		};
	};
};