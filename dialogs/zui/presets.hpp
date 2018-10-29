class PresetsDialog: ZUI_RowLayout
{
	margin[] = { 0.5, 0.8, 0.5, 0.8 };

	class container: ZUI_ColumnLayout
	{
		class title: ZUI_Text
		{
			id = "title";
			text = "Presets";
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

			class info: ZUI_StructuredText
			{
				id = "info";
				width = 0.5;
			};
		};

		class controls: ZUI_RowLayout
		{
			heightType = ZUI_SIZE_ABSOLUTE;
			height = 0.06;

			class add: ZUI_Button
			{
				id = "saveAs";
				text = "Save as";
				tooltip = "Save current settings as new preset";
				margin[] = { 0, ZUI_DIALOG_MARGIN * 3, 0, 0 };
			};

			class load: ZUI_Button
			{
				id = "load";
				text = "Load";
				tooltip = "Load selected preset";
			};

			class replace: ZUI_Button
			{
				id = "replace";
				text = "Replace";
				tooltip = "Replace selected preset with current settings";
				margin[] = { 0, 0, 0, ZUI_DIALOG_MARGIN };
			};

			class delete: ZUI_Button
			{
				id = "delete";
				text = "Delete";
				tooltip = "Remove selected preset";
				margin[] = { 0, 0, 0, ZUI_DIALOG_MARGIN };
			};

			class close: ZUI_Button
			{
				id = "close";
				text = "Close";
				margin[] = { 0, 0, 0, ZUI_DIALOG_MARGIN * 3 };
			};
		};
	};
};