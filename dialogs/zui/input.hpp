class InputDialog: ZUI_RowLayout
{
	margin[] = { 0.8, 0.90, 0.8, 0.90 };

	class container: ZUI_ColumnLayout
	{
		class title: ZUI_Text
		{
			id = "title";
			text = "Input";
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

		class contents: ZUI_ColumnLayout
		{
			background[] = { 0, 0, 0, 0.8 };
			margin[] = { 0, 0, ZUI_DIALOG_MARGIN, 0 };
			padding = 0.01;

			class input: ZUI_Edit
			{
				id = "input";
			};
		};

		class buttons: ZUI_RowLayout
		{
			heightType = ZUI_SIZE_ABSOLUTE;
			height = 0.06;

			class filler: ZUI_ColumnLayout
			{
				background[] = { 0, 0, 0, 0.8 };
			};

			class ok: ZUI_Button
			{
				id = "ok";
				text = "Ok";

				widthType = ZUI_SIZE_ABSOLUTE;
				width = 0.2;
				margin[] = { 0, 0, 0, ZUI_DIALOG_MARGIN };
			};

			class cancel: ZUI_Button
			{
				id = "cancel";
				text = "Cancel";

				widthType = ZUI_SIZE_ABSOLUTE;
				width = 0.2;
				margin[] = { 0, 0, 0, ZUI_DIALOG_MARGIN };
			};
		};
	};
};