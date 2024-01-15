#include "../dialogs.inc"

class ChangelogDialog: ZUI_ColumnLayout
{
	margin = 0.1;

	class centeredContainer: ZUI_RowLayout
	{
		class spacer: ZUI_ColumnLayout {};
		class container: ZUI_ColumnLayout
		{
			widthType = ZUI_SIZE_ABSOLUTE;
			width = 0.7;

			class headerContainer: ZUI_RowLayout {
				heightType = ZUI_SIZE_ABSOLUTE;
				height = 0.06;

				class header: ZUI_Text {
					text = "New update!";
					background[] = GUI_TITLE_BG;
				};
			};

			class bodyContainer: ZUI_RowLayout
			{
				background[] = GUI_BODY_BG;
				margin[] = { 0, 0, 0.01, 0 };

				class text: ZUI_StructuredText {
					id = "text";
					textSize = GUI_TEXT_SIZE_MEDIUM;
					margin[] = { 0.01, 0.01, 0.01, 0.01 };
				};
			};

			class actionsConatiner: ZUI_RowLayout
			{
				heightType = ZUI_SIZE_ABSOLUTE;
				height = 0.07;

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
};