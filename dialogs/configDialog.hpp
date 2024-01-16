#define RSTF_CONFIG_W (SafeZoneW - 0.4)
#define RSTF_CONFIG_H 0.8
#define RSTF_CONFIG_X (SafeZoneX + 0.2)
#define RSTF_CONFIG_Y (SafeZoneY + SafeZoneH/2 - RSTF_CONFIG_H/2)

#define RSTF_SUBCONFIG_M 0.05
#define RSTF_SUBCONFIG_W ((RSTF_CONFIG_W - RSTF_SUBCONFIG_M*2) / 3)
#define RSTF_SUBCONFIG_H RSTF_CONFIG_H
#define RSTF_SUBCONFIG_P 0.03
#define RSTF_SUBCONFIG_SX RSTF_SUBCONFIG_P
#define RSTF_SUBCONFIG_SY (RSTF_SUBCONFIG_P + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M)
#define RSTF_SUBCONFIG_SW (RSTF_SUBCONFIG_W - RSTF_SUBCONFIG_SX - RSTF_SUBCONFIG_P)
#define RSTF_SUBCONFIG_SH (RSTF_SUBCONFIG_H - RSTF_SUBCONFIG_SY - RSTF_SUBCONFIG_P)
#define RSTF_SUBTITLE_H 0.05
#define RSTF_SUBTITLE_M 0.005
#define RSTF_SUBCONFIG_SP 0.01
#define RSTF_SUBCONFIG_BUTTON_W RSTF_SUBCONFIG_SW
#define RSTF_SUBCONFIG_BUTTON_H 0.05

#define RSTF_CONFIG_START_W 0.4
#define RSTF_CONFIG_START_H 0.1

#define RSTF_CONFIG_WEAPON_W 0.5
#define RSTF_CONFIG_WEAPON_H 0.1

#define RSTF_CONFIG_CONFIG_W 0.4

class RSTF_Background : RscStatic
{
	colorText[] = { 1, 1, 1, 1 };
	colorBackground[] = { 0, 0, 0, 0.6 };
	x = 0;
	y = RSTF_SUBTITLE_H + RSTF_SUBTITLE_M;
	w = RSTF_SUBCONFIG_W;
	h = RSTF_SUBCONFIG_H - (RSTF_SUBTITLE_H + RSTF_SUBTITLE_M);
};

class RSTF_Subtitle : RscStatic
{
	w = RSTF_SUBCONFIG_W;
	h = RSTF_SUBTITLE_H;
	colorBackground[] = { "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.7 };
	text = "";
};

class RSTF_Subconfig : RscControlsGroup
{
	x = RSTF_CONFIG_X;
	y = RSTF_CONFIG_Y;
	w = RSTF_SUBCONFIG_W;
	h = RSTF_SUBCONFIG_H;
};

class RSTF_Subconfig_Factions : RscListNBox
{
	x = RSTF_SUBCONFIG_SX;
	y = RSTF_SUBCONFIG_SY;
	w = RSTF_SUBCONFIG_SW;
	h = RSTF_SUBCONFIG_SH - RSTF_SUBCONFIG_BUTTON_H - RSTF_SUBCONFIG_SP;
	columns[] = {0, 0.6};
};

class RSTF_Subconfig_Factions_Back : RSTF_Background
{
	x = RSTF_SUBCONFIG_SX;
	y = RSTF_SUBCONFIG_SY;
	w = RSTF_SUBCONFIG_SW;
	h = RSTF_SUBCONFIG_SH - RSTF_SUBCONFIG_BUTTON_H - RSTF_SUBCONFIG_SP;
};

class RSTF_Subconfig_Button : RscButton
{
	x = RSTF_SUBCONFIG_SX;
	y = RSTF_SUBCONFIG_SY + RSTF_SUBCONFIG_SH - RSTF_SUBCONFIG_BUTTON_H;
	w = RSTF_SUBCONFIG_BUTTON_W;
	h = RSTF_SUBCONFIG_BUTTON_H;
	text = "EDIT";
};

class RSTF_RscDialogConfig
{
    idd = 5;
    enableDisplay = true;
    movingEnable = true;
    class controlsBackground
    {

	};
	class controls
	{
		class nothing : RscStatic
		{

		};

		class sideFriendly : RSTF_Subconfig
		{
			class controls
			{
				class title : RSTF_Subtitle
				{
					x = 0;
					y = 0;
					w = RSTF_SUBCONFIG_W;
					text = "Friendly factions";
				};
				class background : RSTF_Background {};
				class factionsBackground : RSTF_Subconfig_Factions_Back {};
				class factions : RSTF_Subconfig_Factions
				{
					idc = 5;
				};
				class edit : RSTF_Subconfig_Button
				{
					idc = 6;
				};
			};
		};
		class sideNeutral : RSTF_Subconfig
		{
			x = RSTF_CONFIG_X + RSTF_SUBCONFIG_W + RSTF_SUBCONFIG_M;
			idc = 11;
			class controls
			{
				class title : RSTF_Subtitle
				{
					x = 0;
					y = 0;
					w = RSTF_SUBCONFIG_W;
					text = "Neutral factions";
				};
				class background : RSTF_Background {};
				class factionsBackground : RSTF_Subconfig_Factions_Back {};
				class factions : RSTF_Subconfig_Factions
				{
					idc = 7;
				};
				class edit : RSTF_Subconfig_Button
				{
					idc = 8;
				};
			};
		};
		class sideEnemy : RSTF_Subconfig
		{
			x = RSTF_CONFIG_X + (RSTF_SUBCONFIG_W + RSTF_SUBCONFIG_M) * 2;
			class controls
			{
				class title : RSTF_Subtitle
				{
					x = 0;
					y = 0;
					w = RSTF_SUBCONFIG_W;
					text = "Enemy factions";
				};
				class background : RSTF_Background {};
				class factionsBackground : RSTF_Subconfig_Factions_Back {};
				class factions : RSTF_Subconfig_Factions
				{
					idc = 9;
				};
				class edit : RSTF_Subconfig_Button
				{
					idc = 10;
				};
			};
		};

		class start : RscButton
		{
			idc = 500;
			x = RSTF_CONFIG_X + RSTF_CONFIG_W - RSTF_CONFIG_START_W;
			y = RSTF_CONFIG_Y + RSTF_CONFIG_H + RSTF_SUBCONFIG_M;
			w = RSTF_CONFIG_START_W;
			h = RSTF_CONFIG_START_H;
			text = "Start";
		};

		class weaponButton : RscButton
		{
			idc = 501;
			x = RSTF_CONFIG_X + RSTF_CONFIG_W - RSTF_CONFIG_START_W - RSTF_SUBCONFIG_M * 2 - RSTF_CONFIG_WEAPON_W;
			y = RSTF_CONFIG_Y + RSTF_CONFIG_H + RSTF_SUBCONFIG_M;
			w = RSTF_CONFIG_WEAPON_W * 0.4;
			h = RSTF_CONFIG_START_H;
			text = "Equipment";
		};

		class weaponText: RscText
		{
			idc = 502;
			x = RSTF_CONFIG_X + RSTF_CONFIG_W - RSTF_CONFIG_START_W - RSTF_SUBCONFIG_M * 2 - RSTF_CONFIG_WEAPON_W * 0.6;
			y = RSTF_CONFIG_Y + RSTF_CONFIG_H + RSTF_SUBCONFIG_M;
			w = RSTF_CONFIG_WEAPON_W * 0.6;
			h = RSTF_CONFIG_START_H;
			colorBackground[] = { 0.2, 0.2, 0.2, 0.9 };
			text = "Random";
		};

		class configButton : RscButton
		{
			idc = 503;
			x = RSTF_CONFIG_X;
			y = RSTF_CONFIG_Y + RSTF_CONFIG_H + RSTF_SUBCONFIG_M;
			w = RSTF_CONFIG_CONFIG_W;
			h = RSTF_CONFIG_START_H;
			text = "Advanced configuration";
		};

		class presetsButton : RscButton
		{
			idc = 504;
			x = RSTF_CONFIG_X + RSTF_CONFIG_W - RSTF_CONFIG_START_W - RSTF_SUBCONFIG_M * 3 - RSTF_CONFIG_WEAPON_W * 1.4;
			y = RSTF_CONFIG_Y + RSTF_CONFIG_H + RSTF_SUBCONFIG_M;
			w = RSTF_CONFIG_WEAPON_W * 0.4;
			h = RSTF_CONFIG_START_H;
			text = "Presets";
		};
	};
};