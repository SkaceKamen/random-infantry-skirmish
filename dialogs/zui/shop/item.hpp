class ItemsRow: ZUI_RowLayout
{
	heightType = ZUI_SIZE_ABSOLUTE;
	height = 0.4;
};

class ItemSpacer: ZUI_ColumnLayout
{
	margin = 0.02;
	heightType = ZUI_SIZE_ABSOLUTE;
	height = 0.4;
};

#define SHOP_ITEM_SPACING 0.005

class Item: ZUI_ColumnLayout
{
	margin = 0.02;
	heightType = ZUI_SIZE_ABSOLUTE;
	height = 0.4;

	class title: ZUI_Static
	{
		background[] = { 0, 0, 0, 0.8 };
		text = "Title";
		heightType = ZUI_SIZE_ABSOLUTE;
		height = 0.06;
		margin[] = { 0, 0, SHOP_ITEM_SPACING, 0 };
		id = "title";
	};

	class info: ZUI_RowLayout
	{
		margin[] = { 0, 0, SHOP_ITEM_SPACING, 0 };

		class imageContainer: ZUI_RowLayout
		{
			background[] = { 0, 0, 0, 0.8 };
			margin[] = { 0, SHOP_ITEM_SPACING, 0, 0 };
			width = 0.8;

			class image: ZUI_Picture
			{
				margin = 0.05;
				text = "";
				id = "image";
			};
		};

		class infoContainer: ZUI_RowLayout
		{
			background[] = { 0, 0, 0, 0.8 };
			padding = 0.01;

			class infoContainer: ZUI_ColumnLayout
			{
				scrollable = 1;
				class info: ZUI_StructuredText
				{
					text = "Info";
					id = "info";
					// heightType = ZUI_SIZE_TEXT;
				};
			};
		};
	};

	class actions: ZUI_RowLayout
	{
		heightType = ZUI_SIZE_ABSOLUTE;
		height = 0.06;

		class space: ZUI_Static
		{
			background[] = { 0, 0, 0, 0.8 };
			margin[] = { 0, SHOP_ITEM_SPACING, 0, 0 };
		};

		class price: ZUI_TextRight
		{
			background[] = { 0, 0, 0, 0.8 };
			margin[] = { 0, SHOP_ITEM_SPACING, 0, 0 };
			text = "$100";
			widthType = ZUI_SIZE_ABSOLUTE;
			width = 0.2;
			id = "price";
		};

		class buy: ZUI_Button
		{
			text = "Buy";
			widthType = ZUI_SIZE_ABSOLUTE;
			width = 0.1;
			id = "buy";
		};
	};
};