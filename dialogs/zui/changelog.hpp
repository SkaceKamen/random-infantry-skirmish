class ChangelogDialog: ZUI_ColumnLayout
{
	margin = 0.1;

	class centeredContainer: ZUI_RowLayout
	{
		class spacer: ZUI_ColumnLayout {};
		class rowContainer: ZUI_ColumnLayout
		{
			widthType = ZUI_SIZE_ABSOLUTE;
			width = 1;

			class spacer: ZUI_ColumnLayout {};
			class container: ZUI_ColumnLayout
			{
				heightType = ZUI_SIZE_ABSOLUTE;
				height = 1;

				class headerContainer: ZUI_TextCenter {
					heightType = ZUI_SIZE_ABSOLUTE;
					height = 0.05;
					text = "New update!";
					background[] = GUI_TITLE_BG;
					font = GUI_TITLE_FONT;
					textSize = GUI_TEXT_SIZE_MEDIUM;
				};

				class bodyBackground: ZUI_ColumnLayout
				{	
					background[] = GUI_BODY_BG;
					margin[] = { 0, 0, GUI_SPACING, 0 };
					class bodyContainer: ZUI_ColumnLayout
					{
						scrollable = 1;
						margin[] = { GUI_SPACING*3, 0, GUI_SPACING*3, 0 };

						class text: ZUI_StructuredText
						{
							id = "text";
							textSize = GUI_TEXT_SIZE_SMALL;
							margin = GUI_SPACING;
							font = GUI_STANDARD_FONT;
							heightType = ZUI_SIZE_TEXT;
						};
					};
				};

				class actionsConatiner: ZUI_RowLayout
				{
					heightType = ZUI_SIZE_ABSOLUTE;
					height = 0.06;

					class spacer: ZUI_ColumnLayout
					{
					};

					class ok: ZUI_Button
					{
						widthType = ZUI_SIZE_ABSOLUTE;
						width = 0.2;

						id = "confirm";
						text = "OK";
					};
				};
			};
			class spacer2: ZUI_ColumnLayout {};
		};
		class spacer2: ZUI_ColumnLayout {};
	};
};