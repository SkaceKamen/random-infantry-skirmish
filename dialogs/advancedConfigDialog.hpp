#include "advancedConfigDialog.inc"

class RSTF_ADV_CATEGORY: RscButton
{
	x = 0;
	y = 0;
	w = RSTF_ADV_CAT_W;
	h = 0.1;
	font = GUI_BUTTON_FONT;
	colorBackground[] = { 0, 0, 0, 0.8 };
	colorBackgroundDisabled[] = { 0, 0, 0, 0.5 };
};

class RSTF_ADV_LABEL: RscTextRight
{
	shadow = 0;
	font = GUI_STANDARD_FONT;
	sizeEx = GUI_TEXT_SIZE_SMALL;
};

class RSTF_RscDialogAdvancedConfig
{
    idd = 12;
    enableDisplay = true;
    movingEnable = false;
    class controlsBackground
    {
		class optionsContainer: RscStatic
		{
			x = RSTF_ADV_OPS_X;
			y = RSTF_ADV_CNT_Y;
			w = RSTF_ADV_OPS_W;
			h = RSTF_ADV_CNT_H;
			colorBackground[] = { 0, 0, 0, 0.8 };
		};
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
			font = GUI_TITLE_FONT;
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

			class controls
			{
				class spacer: RscText
				{
					idc = 6;
					w = RSTF_ADV_OPS_W;
					h = 0.04;
				};
			};
		};

		class saveButton: RscButton
		{
			idc = 4;
			w = RSTF_ADV_BUTTON_W;
			h = RSTF_ADV_BUTTON_H;
			x = RSTF_ADV_SAVE_X;
			y = RSTF_ADV_BUTTON_Y;
			text = "SAVE";
		};

		class resetButton: RscButton
		{
			idc = 5;
			w = RSTF_ADV_BUTTON_W;
			h = RSTF_ADV_BUTTON_H;
			x = RSTF_ADV_REST_X;
			y = RSTF_ADV_BUTTON_Y;
			text = "RESET";
		};
	};
};