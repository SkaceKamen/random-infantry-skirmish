class DeathTitle: ZUI_ColumnLayout
{
	background[] = { 0, 0, 0, 0.5 };

	class title: ZUI_TextCenter
	{
		text = "YOU'RE DEAD";
		textSize = GUI_TEXT_SIZE_LARGE * 3;
		shadow = 1;
		height = 0.5;
		heightType = ZUI_SIZE_ABSOLUTE;
	};
};
