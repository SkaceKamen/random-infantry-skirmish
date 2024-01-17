class FactionSelectorDialog: ZUI_RowLayout
{
	margin = 0.1;

	class LeftPanel: ZUI_ColumnLayout
	{
		width = 0.4;
		widthType = ZUI_SIZE_ABSOLUTE;

		class Title: ZTitle
		{
			text = "Factions";
		};

		class ListWrapper: ZUI_ColumnLayout
		{
			background[] = GUI_BODY_BG;

			class List: ZUI_Listview
			{
				id = "factionsList";
				columns[] = { 0, 0.6 };
				font = GUI_TITLE_FONT;
				textSize = GUI_TEXT_SIZE_MEDIUM;
				margin = GUI_SPACING;
			};
		};

		class SelectToggle: ZUI_Button
		{
			text = "SELECT";
			id = "factionSelectToggle";
			height = 0.05;
			heightType = ZUI_SIZE_ABSOLUTE;
			margin[] = { GUI_SPACING, 0, 0, 0 };
		};

		class SelectRandom: ZUI_Button
		{
			text = "SELECT RANDOM";
			id = "factionSelectRandom";
			height = 0.05;
			heightType = ZUI_SIZE_ABSOLUTE;
			margin[] = { GUI_SPACING, 0, 0, 0 };
		};

		class Clear: ZUI_Button
		{
			text = "CLEAR";
			id = "factionsClear";
			height = 0.05;
			heightType = ZUI_SIZE_ABSOLUTE;
			margin[] = { GUI_SPACING, 0, 0, 0 };
		};

		class Save: ZUI_Button
		{
			text = "SAVE AND BACK";
			id = "save";
			height = 0.07;
			heightType = ZUI_SIZE_ABSOLUTE;
			margin[] = { GUI_SPACING * 4, 0, 0, 0 };
		};
	};

	class spacer: ZUI_RowLayout {};

	class RightPanel: ZUI_ColumnLayout
	{
		width = 0.45;
		widthType = ZUI_SIZE_ABSOLUTE;

		class Title: ZTitle
		{
			text = "Loaded units";
		};

		class ListWrapper: ZUI_ColumnLayout
		{
			background[] = GUI_BODY_BG;

			class List: ZUI_Listview
			{
				control = "RscTree";
				id = "unitsTree";
				font = GUI_TITLE_FONT;
				textSize = GUI_TEXT_SIZE_SMALL;
				margin = GUI_SPACING;
			};
		};

		class BanToggle: ZUI_Button
		{
			text = "TOGGLE BAN";
			id = "unitBanToggle";
			height = 0.05;
			heightType = ZUI_SIZE_ABSOLUTE;
			margin[] = { GUI_SPACING, 0, 0, 0 };
		};
	};
};
