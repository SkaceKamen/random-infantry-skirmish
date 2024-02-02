class GunGameEditorWeaponPickDialog: ZUI_RowLayout
{
	SPACER_COMPONENT;

	class container: ZUI_ColumnLayout
	{
		width = 1;
		widthType = ZUI_SIZE_ABSOLUTE;
		margin[] = { 0.3, 0, 0.3, 0 };

		class Title: ZTitle
		{
			text = "PICK A WEAPON";
			margin[] = SPACING_BOTTOM;
		};

		class Body: ZUI_RowLayout
		{
			class List: ZUI_ColumnLayout
			{
				width = 2;
				background[] = GUI_BODY_BG;
				padding = GUI_SPACING;
				margin[] = SPACING_RIGHT;

				class Search: ZUI_Edit
				{
					id = "search";
					height = 0.05;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;
				};

				class Items: ZUI_Listview
				{
					id = "weapons";
					columns[] = { 0, 0.5 };
					shadow = 1;
					font = GUI_STANDARD_FONT;
					textSize = GUI_TEXT_SIZE_SMALL;
				};
			};

			class Detail: ZUI_ColumnLayout
			{
				background[] = GUI_BODY_BG;
				padding = GUI_SPACING;

				class text: ZUI_StructuredText
				{
					id = "detail";
					font = GUI_STANDARD_FONT;
					textSize = GUI_TEXT_SIZE_SMALL;
				};
			};
		};

		class Actions: ZUI_RowLayout
		{
			margin[] = SPACING_TOP;
			height = 0.05;
			heightType = ZUI_SIZE_ABSOLUTE;

			SPACER_COMPONENT;

			class Cancel: ZUI_Button
			{
				id = "cancel";
				text = "CANCEL";
				width = 0.2;
				widthType = ZUI_SIZE_ABSOLUTE;
				margin[] = SPACING_RIGHT;
			};

			class Pick: ZUI_Button
			{
				id = "pick";
				text = "PICK";
				width = 0.2;
				widthType = ZUI_SIZE_ABSOLUTE;
			};
		};
	};

	SPACER_COMPONENT;
};