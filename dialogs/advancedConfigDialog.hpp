#define RSTF_ADV_X (SafeZoneX + 0.2)
#define RSTF_ADV_Y (SafeZoneY + 0.2)
#define RSTF_ADV_W (SafeZoneW - 0.4)
#define RSTF_ADV_H (SafeZoneH - 0.4)

#define RSTF_ADV_M 0.01

#define RSTF_ADV_TITLE_H 0.04

#define RSTF_ADV_CNT_Y (RSTF_ADV_Y + RSTF_ADV_TITLE_H + RSTF_ADV_M)
#define RSTF_ADV_CNT_H (RSTF_ADV_H - RSTF_ADV_TITLE_H - RSTF_ADV_M)

#define RSTF_ADV_CAT_W (RSTF_ADV_W * 0.2)

#define RSTF_ADV_OPS_X (RSTF_ADV_X + RSTF_ADV_CAT_W)
#define RSTF_ADV_OPS_W (RSTF_ADV_W * 0.8)

#define RSTF_ADV_BUTTON_W 0.1
#define RSTF_ADV_BUTTON_H 0.05
#define RSTF_ADV_BUTTON_Y (RSTF_ADV_Y + RSTF_ADV_H + RSTF_ADV_M)

#define RSTF_ADV_SAVE_X (RSTF_ADV_X + RSTF_ADV_W - RSTF_ADV_BUTTON_W)
#define RSTF_ADV_REST_X (RSTF_ADV_X + RSTF_ADV_W - RSTF_ADV_BUTTON_W * 2 - RSTF_ADV_M)

class RSTF_RscDialogAdvancedConfig
{
    idd = 12;
    enableDisplay = true;
    movingEnable = false;
    class controlsBackground
    {
		
	};
	class controls
	{
		class mainTitle: RscStatic
		{
			idc = 1;
			x = RSTF_ADV_X;
			y = RSTF_ADV_Y;
			w = RSTF_ADV_W;
			h = RSTF_ADV_TITLE_H;
			colorBackground[] = { TITLE_BG_RGBA };
			text = "Advanced configuration";
		};

		class categoriesContainer: RscControlsGroup
		{
			idc = 2;
			x = RSTF_ADV_X;
			y = RSTF_ADV_CNT_Y;
			w = RSTF_ADV_CAT_W;
			h = RSTF_ADV_CNT_H;
		};

		class optionsContainer: RscControlsGroup
		{
			idc = 3;
			x = RSTF_ADV_OPS_X;
			y = RSTF_ADV_CNT_Y;
			w = RSTF_ADV_OPS_W;
			h = RSTF_ADV_CNT_H;
		};

		class saveButton: RscButton
		{
			idc = 4;
			w = RSTF_ADV_BUTTON_W;
			h = RSTF_ADV_BUTTON_H;
			x = RSTF_ADV_SAVE_X;
			y = RSTF_ADV_BUTTON_Y;
			text = "Save";
		};

		class resetButton: RscButton
		{
			idc = 5;
			w = RSTF_ADV_BUTTON_W;
			h = RSTF_ADV_BUTTON_H;
			x = RSTF_ADV_REST_X;
			y = RSTF_ADV_BUTTON_Y;
			text = "Reset";
		};
	};
};