#define SHOP_BACKGROUND { 0.2, 0.2, 0.2, 0.8 }
#define SHOP_SPACING 0.005

class ShopComponents
{
	#include "shop\category.hpp"
	#include "shop\item.hpp"
};

class ShopDialog: ZUI_ColumnLayout
{
	margin = 0.2;

	class container: ZUI_ColumnLayout
	{
		class titleBar: ZUI_RowLayout
		{
			heightType = ZUI_SIZE_ABSOLUTE;
			height = 0.1;

			class title: ZUI_TextCenter
			{
				text = "Request vehicle";
				background[] = {
					"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
					"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
					"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
					"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
				};
				marginRight = SHOP_SPACING;
			};
			class close: ZUI_Button
			{
				id = "close";
				widthType = ZUI_SIZE_ABSOLUTE;
				width = 0.1 * (SafeZoneH/SafeZoneW);
				text = "X";
			};
		};

		class rest: ZUI_RowLayout
		{
			marginTop = SHOP_SPACING;

			class categories: ZUI_ColumnLayout
			{
				id = "categories";
				background[] = SHOP_BACKGROUND;

				width = 0.2;
				marginRight = SHOP_SPACING;
				scrollable = 1;
			};

			class items: ZUI_ColumnLayout
			{
				class search: ZUI_RowLayout
				{
					background[] = SHOP_BACKGROUND;

					heightType = ZUI_SIZE_ABSOLUTE;
					height = 0.10 + SHOP_SPACING;

					padding = SHOP_SPACING;

					class moneyLabel: ZUI_Text
					{
						text = "Money:";
						width = 0.12;
						widthType = ZUI_SIZE_ABSOLUTE;
					};
					class money: ZUI_Text
					{
						width = 0.3;
						widthType = ZUI_SIZE_ABSOLUTE;
						id = "money";
						text = "$1000";
					};

					class spacer: ZUI_RowLayout {};

					class label: ZUI_Static
					{
						text = "Search:";
						width = 0.14;
						widthType = ZUI_SIZE_ABSOLUTE;
					};
					class input: ZUI_Edit
					{
						width = 0.5;
						widthType = ZUI_SIZE_ABSOLUTE;
						id = "search";
					};
				};

				class items: ZUI_ColumnLayout
				{
					marginTop = SHOP_SPACING;
					background[] = SHOP_BACKGROUND;
					padding = SHOP_SPACING;

					class container: ZUI_ColumnLayout
					{
						id = "items";
						scrollable = 1;
					};
				};
			};
		};
	};
};