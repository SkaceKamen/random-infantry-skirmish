#define ZUI_DIALOG_MARGIN 0.01

class LauncherDialog: ZUI_RowLayout
{
	margin[] = { 0.5, 0.8, 0.5, 0.8 };

	class container: ZUI_ColumnLayout
	{
		class title: ZUI_Text
		{
			id = "title";
			text = "Start Random Infantry Skirmish";
			background[] = {
				"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
			};
			heightType = ZUI_SIZE_ABSOLUTE;
			height = 0.06;
			margin[] = { 0, 0, ZUI_DIALOG_MARGIN, 0 };
		};

		class contents: ZUI_RowLayout
		{
			background[] = { 0, 0, 0, 0.5 };
			margin[] = { 0, 0, ZUI_DIALOG_MARGIN, 0 };
			padding = 0.01;

			class list: ZUI_Listview
			{
				id = "list";
				columns[] = { 0, 0.5 };
			};
		};

		class controls: ZUI_RowLayout
		{
			heightType = ZUI_SIZE_ABSOLUTE;
			height = 0.06;

			class spacer: ZUI_text
			{
				margin[] = { 0, ZUI_DIALOG_MARGIN, 0, 0 };
			};

			class cancel: ZUI_Button
			{
				id = "cancel";
				text = "Cancel";
				tooltip = "Exit mission";
				margin[] = { 0, 0, 0, ZUI_DIALOG_MARGIN };
			};

			class start: ZUI_Button
			{
				id = "start";
				text = "Start";
				tooltip = "Start Random Infantry Skirmish on this map";
			};
		};
	};
};