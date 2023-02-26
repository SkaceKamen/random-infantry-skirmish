#define MODE_SELECTOR_BACKGROUND { 0, 0, 0, 0.7 }
#define MODE_SELECTOR_SPACING 0.005
#define MODE_SELECTOR_ITEM_SPACING 0.005

class ModeSelectorComponents
{
	#include ".\modeSelector\mode.hpp"
};

class ModeSelectorDialog: ZUI_ColumnLayout
{
	margin = 0.1;

	class container: ZUI_ColumnLayout
	{
		class logoContainer: ZUI_RowLayout
		{
			heightType = ZUI_SIZE_ABSOLUTE;
			height = 0.3;

			class logo: ZUI_Picture
			{
				text = "rstf-logo.paa";
			};
		};

		class itemsContainer: ZUI_RowLayout
		{
			margin[] = { 0.05, 0, 0, 0 };
		
			class spacer1: ZUI_ColumnLayout {};

			class container: ZUI_ColumnLayout
			{
				widthType = ZUI_SIZE_ABSOLUTE;
				width = 0.6;

				class items: ZUI_ColumnLayout
				{
					id = "items";
				};

				class skipText: ZUI_RowLayout
				{
					heightType = ZUI_SIZE_ABSOLUTE;
					height = "0.04 * safeZoneW / safeZoneH";

					class spacer: ZUI_ColumnLayout {};

					class skipNextTime: ZUI_Control
					{
						control = "RscCheckBox";
						id = "skipNextTime";

						widthType = ZUI_SIZE_ABSOLUTE;
						width = 0.04;
					};

					class label: ZUI_Text
					{
						text = "Don't show again";
						widthType = ZUI_SIZE_TEXT;
					};
				};
			};

			class spacer2: ZUI_ColumnLayout {};
		};
	};
};
