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
