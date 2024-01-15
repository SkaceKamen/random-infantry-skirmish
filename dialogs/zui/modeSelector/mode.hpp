#include "../../dialogs.inc"

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

	class Background: ZUI_RowLayout
	{
		background[] = { 0, 0, 0, 0.8 };
		
		class Description: ZUI_StructuredText
		{
			margin = 0.005;
			id = "description";
			height = 1;
			textSize = GUI_TEXT_SIZE_SMALL;
		};
	};
};
