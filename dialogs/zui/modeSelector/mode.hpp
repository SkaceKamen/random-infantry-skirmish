class Mode: ZUI_ColumnLayout
{
	margin[] = { 0.01, 0, 0, 0 };
	height = 0.17;
	heightType = ZUI_SIZE_ABSOLUTE;

	class Title: ZUI_Button
	{
		id = "title";
		width = 0.7;
		widthType = ZUI_SIZE_PERCENTS;
		height = 0.05;
		heightType = ZUI_SIZE_ABSOLUTE;
	};

	class Wrapper: ZUI_RowLayout
	{
		height = 1;
		background[] = { 0, 0, 0, 0.8 };
		padding[] = { 0.005, 0, 0, 0 };

		class Description: ZUI_StructuredText
		{
			margin[] = { 0, 0, 0, 0 };
			id = "description";
			textSize = GUI_TEXT_SIZE_SMALL;
			font = GUI_STANDARD_FONT;
		};
	};
};
