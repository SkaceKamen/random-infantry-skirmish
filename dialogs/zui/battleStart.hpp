class BattleStartDialog: ZUI_ColumnLayout
{
	background[] = { 0, 0, 0, 0.5 };

	SPACER_COMPONENT;

	class container: ZUI_RowLayout
	{
		height = 1;
		heightType = ZUI_SIZE_ABSOLUTE;

		SPACER_COMPONENT;

		class container: ZUI_ColumnLayout
		{
			width = 1.2;
			widthType = ZUI_SIZE_ABSOLUTE;

			class title: ZUI_TextCenter
			{
				heightType = ZUI_SIZE_ABSOLUTE;
				height = 0.2;
				font = "PuristaBold";
				textSize = GUI_TEXT_SIZE_LARGE * 3;
				text = "";
				id = "title";
				shadow = 1;
			};

			class subTitle: ZUI_TextCenter
			{
				heightType = ZUI_SIZE_ABSOLUTE;
				height = 0.15;
				font = GUI_STANDARD_FONT;
				textSize = GUI_TEXT_SIZE_LARGE * 1.5;
				text = "";
				id = "mode";
				shadow = 1;
			};

			class sides: ZUI_RowLayout
			{
				heightType = ZUI_SIZE_ABSOLUTE;
				height = 0.3;

				class blufor: ZUI_ColumnLayout
				{
					margin[] = SPACING_RIGHT;

					class list: ZUI_Listview
					{
						id = "bluforFactions";
						columns[] = { 0, 0.9 };
						font = GUI_STANDARD_FONT;
						shadow = 2;
					};
				};

				class opfor: ZUI_ColumnLayout
				{
					margin[] = SPACING_LEFT;

					class list: ZUI_Listview
					{
						id = "opforFactions";
						columns[] = { 0 };
						font = GUI_STANDARD_FONT;
						shadow = 2;
					};
				};
			};
		};

		SPACER_COMPONENT;
	};

	SPACER_COMPONENT;
};