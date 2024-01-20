#define SHOP_BACKGROUND { 0, 0, 0, 0.85 }
#define SHOP_SPACING GUI_SPACING
#define SHOP_ITEM_SPACING GUI_SPACING

class ShopComponents
{
	#include "shop\category.hpp"
	#include "shop\item.hpp"
};

class ShopDialog: ZUI_ColumnLayout
{
	margin[] = { 0.2, 0.6, 0.2, 0.6 };

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
				background[] = GUI_TITLE_BG;
				margin[] = { 0, SHOP_SPACING, 0, 0 };
				font = GUI_TITLE_FONT;
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

			class categories: ZUI_RowLayout
			{
				background[] = SHOP_BACKGROUND;

				width = 0.2;
				margin[] = { 0, SHOP_SPACING, 0, 0 };
				padding = SHOP_SPACING;

				class categoriesItems: ZUI_Listview
				{
					id = "categories";
					columns[] = { 0, 0.8 };
				};
			};

			class items: ZUI_ColumnLayout
			{
				class search: ZUI_RowLayout
				{
					background[] = SHOP_BACKGROUND;
					heightType = ZUI_SIZE_ABSOLUTE;
					height = 0.06;

					class label: ZUI_Static
					{
						text = "Search:";
						width = 0.1;
						widthType = ZUI_SIZE_ABSOLUTE;
					};
					class input: ZUI_Edit
					{
						width = 0.5;
						widthType = ZUI_SIZE_ABSOLUTE;
						id = "search";
						margin[] = { GUI_SPACING, 0, GUI_SPACING, 0 };
					};

					class spacer: ZUI_RowLayout {};

					class moneyLabel: ZUI_TextRight
					{
						text = "Your money:";
						width = 0.15;
						widthType = ZUI_SIZE_ABSOLUTE;
					};
					class money: ZUI_TextRight
					{
						width = 0.15;
						widthType = ZUI_SIZE_ABSOLUTE;
						id = "money";
						text = "$1000";
						margin[] = { 0, GUI_SPACING*4, 0, 0 };
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
				width = 0.5;
				margin[] = { 0, 0, 0, SHOP_SPACING };

				class detailInfo: ZUI_ColumnLayout
				{
					class imageContainer: ZUI_RowLayout
					{
						background[] = SHOP_BACKGROUND;
						margin[] = { 0, 0, GUI_SPACING, 0 };
						height = 0.4;
						heightType = ZUI_SIZE_ABSOLUTE;

						class image: ZUI_Picture
						{
							margin = 0.005;
							text = "";
							id = "detail_image";
						};
					};

					class detailTitle: ZUI_TextCenter
					{
						background[] = SHOP_BACKGROUND;
						text = "";
						heightType = ZUI_SIZE_ABSOLUTE;
						height = 0.07;
						margin[] = { 0, 0, GUI_SPACING, 0 };
						id = "detail_title";
						textSize = GUI_TEXT_SIZE_LARGE;
					};

					class infoContainer: ZUI_RowLayout
					{
						background[] = SHOP_BACKGROUND;
						margin[] = { 0, 0, GUI_SPACING, 0 };

						class infoContainer: ZUI_ColumnLayout
						{
							scrollable = 1;
							padding = GUI_SPACING;

							class info: ZUI_StructuredText
							{
								text = "";
								id = "detail_info";
								textSize = GUI_TEXT_SIZE_SMALL;
								font = GUI_STANDARD_FONT;
								heightType = ZUI_SIZE_TEXT;
							};
						};
					};
				};
				
				class actionsAi: ZUI_RowLayout
				{
					heightType = ZUI_SIZE_ABSOLUTE;
					height = 0.05;
					margin[] = SPACING_BOTTOM;

					class price: ZUI_TextRight
					{
						id = "priceAi";
						text = "";
						background[] = SHOP_BACKGROUND;
						margin[] = { 0, GUI_SPACING, 0, 0 };
					}

					class buyButton: ZUI_Button
					{
						id = "buyAi";
						text = "BUY AS AI";
						margin[] = { 0, 0, 0, 0 };
						tooltip = "Vehicle will be spawned with AI crew that will support your team";
					}
				};

				class actions: ZUI_RowLayout
				{
					heightType = ZUI_SIZE_ABSOLUTE;
					height = 0.07;

					class price: ZUI_TextRight
					{
						id = "price";
						text = "";
						background[] = SHOP_BACKGROUND;
						margin[] = { 0, GUI_SPACING, 0, 0 };
					}

					class buyButton: ZUI_Button
					{
						id = "buy";
						text = "BUY FOR ME";
						margin[] = { 0, 0, 0, 0 };
					}
				};
			};
		};
	};
};