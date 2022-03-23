#define MODE_SELECTOR_BACKGROUND { 0, 0, 0, 0.7 }
#define MODE_SELECTOR_SPACING 0.005
#define MODE_SELECTOR_ITEM_SPACING 0.005

class ModeSelectorComponents
{
	#include ".\modeSelector\mode.hpp"
};

class ModeSelectorDialog: ZUI_ColumnLayout
{
	margin = 0.2;

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

			class items: ZUI_ColumnLayout
			{
				id = "items";
				widthType = ZUI_SIZE_ABSOLUTE;
				width = 0.6;
				heightType = ZUI_SIZE_ABSOLUTE;
				height = 0.5;
			};

			class spacer2: ZUI_ColumnLayout {};
		}
	};
};
