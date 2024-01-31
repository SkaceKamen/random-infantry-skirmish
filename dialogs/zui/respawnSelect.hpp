class RespawnSelectDialog: ZUI_RowLayout
{
	class LeftPanel: ZUI_ColumnLayout
	{
		width = 0.7;
		widthType = ZUI_SIZE_ABSOLUTE;
		margin = 0.1;

		class Title: ZTitle
		{
			text = "PICK A SOLDIER";
			margin[] = SPACING_BOTTOM;
		};

		class List: ZUI_ColumnLayout
		{
			background[] = GUI_BODY_BG;

			class Inner: ZUI_Listview
			{
				id = "list";
				columns[] = { 0, 0.6, 0.8 };
				font = GUI_STANDARD_FONT;
				textSize = GUI_TEXT_SIZE_SMALL;
			};

			margin[] = SPACING_BOTTOM;
		};

		class Refresh: ZUI_Button
		{
			id = "refresh";
			text = "REFRESH";
			height = 0.06;
			heightType = ZUI_SIZE_ABSOLUTE;
			margin[] = SPACING_BOTTOM;
		};

		class Pick: ZUI_Button
		{
			id = "respawn";
			text = "SPAWN";
			height = 0.07;
			heightType = ZUI_SIZE_ABSOLUTE;
		};
	};

	SPACER_COMPONENT;
};
