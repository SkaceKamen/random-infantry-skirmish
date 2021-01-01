class Category: ZUI_RowLayout
{
	margin = 0.001;
	height = 0.15;
	heightType = ZUI_SIZE_ABSOLUTE;

	class Title: ZUI_Button
	{
		id = "title";
		width = 0.7;
		widthType = ZUI_SIZE_PERCENTS;
	};

	class Count: ZUI_TextCenter
	{
		id = "count";
		text = "0?";
		background[] = { 0, 0, 0, 0.8 };
	};
};
