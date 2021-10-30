#define SHOP_BACKGROUND { 0, 0, 0, 0.7 }
#define SHOP_SPACING 0.005
#define SHOP_ITEM_SPACING 0.005

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
			height = 0.06;

			class dialogTitleSpacer: ZUI_Text
			{
				width = 0;
				widthType = ZUI_SIZE_ABSOLUTE;
			};

			class dialogTitle: ZUI_Text
			{
				text = "REQUEST VEHICLE";
				background[] = {
					"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
					"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
					"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
					"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
				};
				margin[] = { 0, SHOP_SPACING, 0, 0 };
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
			margin[] = { SHOP_SPACING, 0, 0, 0 };

			class categories: ZUI_ColumnLayout
			{
				id = "categories";
				background[] = SHOP_BACKGROUND;

				width = 0.2;
				margin[] = { 0, SHOP_SPACING, 0, 0 };
				scrollable = 1;
			};

			class items: ZUI_ColumnLayout
			{
				class search: ZUI_RowLayout
				{
					background[] = SHOP_BACKGROUND;
					heightType = ZUI_SIZE_ABSOLUTE;
					height = 0.06;

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

				class items: ZUI_RowLayout
				{
					margin[] = { SHOP_SPACING, 0, 0, 0 };
					background[] = SHOP_BACKGROUND;

					class container: ZUI_Listview
					{
						id = "items";
						width = 0.6;
						background[] = SHOP_BACKGROUND;
						padding = SHOP_SPACING;
					};
				};
			};

			class detail: ZUI_ColumnLayout
			{
				width = 0.4;
				margin[] = { 0, 0, 0, SHOP_SPACING };

				class detailTitle: ZUI_Text
				{
					background[] = SHOP_BACKGROUND;
					text = "";
					heightType = ZUI_SIZE_ABSOLUTE;
					height = 0.06;
					margin[] = { 0, 0, SHOP_ITEM_SPACING, 0 };
					id = "detail_title";
				};

				class detailInfo: ZUI_ColumnLayout
				{
					margin[] = { 0, 0, SHOP_ITEM_SPACING, 0 };

					class imageContainer: ZUI_RowLayout
					{
						background[] = SHOP_BACKGROUND;
						margin[] = { 0, 0, SHOP_ITEM_SPACING, 0 };
						height = 0.45;
						heightType = ZUI_SIZE_ABSOLUTE;

						class image: ZUI_Picture
						{
							margin = 0.005;
							text = "";
							id = "detail_image";
						};
					};

					class infoContainer: ZUI_RowLayout
					{
						background[] = SHOP_BACKGROUND;
						padding = 0.01;

						class infoContainer: ZUI_ColumnLayout
						{
							scrollable = 1;
							class info: ZUI_StructuredText
							{
								text = "";
								id = "detail_info";
								// heightType = ZUI_SIZE_TEXT;
							};
						};
					};
				};

				class actions: ZUI_RowLayout
				{
					heightType = ZUI_SIZE_ABSOLUTE;
					height = 0.06;

					class spacer: ZUI_ColumnLayout
					{
						background[] = SHOP_BACKGROUND;
						margin[] = { 0, SHOP_ITEM_SPACING, 0, 0 };
					}

					class price: ZUI_TextRight
					{
						id = "price";
						widthType = ZUI_SIZE_ABSOLUTE;
						width = 0.2;
						text = "";
						background[] = SHOP_BACKGROUND;
						margin[] = { 0, SHOP_ITEM_SPACING, 0, 0 };
					}

					class buyButton: ZUI_Button
					{
						id = "buy";
						widthType = ZUI_SIZE_ABSOLUTE;
						width = 0.1;
						text = "Buy";
						margin[] = { 0, 0, 0, 0 };
					}
				};
			};
		};
	};
};