class GunGameEditorPresetDialog: ZUI_RowLayout
{
	SPACER_COMPONENT;

	class container: ZUI_ColumnLayout
	{
		width = 1;
		widthType = ZUI_SIZE_ABSOLUTE;
		margin[] = { 0.4, 0, 0.4, 0 };

		class Title: ZTitle
		{
			text = "SAVE AS GUN GAME PRESET";
			margin[] = SPACING_BOTTOM;
		};

		class Body: ZUI_RowLayout
		{
			class Left: ZUI_ColumnLayout
			{
				background[] = GUI_BODY_BG;
				padding = GUI_SPACING;
				margin[] = SPACING_RIGHT;

				class ExistingList: ZUI_Listview
				{
					id = "presets";
					columns[] = { 0, 0.3 };
					shadow = 1;
					font = GUI_STANDARD_FONT;
					textSize = GUI_TEXT_SIZE_SMALL;
				};
			};

			class Right: ZUI_ColumnLayout
			{
				background[] = GUI_BODY_BG;
				padding = GUI_SPACING;

				class detail: ZUI_StructuredText
				{
					id = "detail";
					shadow = 1;
					font = GUI_STANDARD_FONT;
					textSize = GUI_TEXT_SIZE_SMALL;
				};
			};
		};

		class Input: ZUI_RowLayout
		{
			id = "input";
			margin[] = SPACING_TOP;
			height = 0.06;
			heightType = ZUI_SIZE_ABSOLUTE;
			background[] = GUI_BODY_BG;
			
			class label: ZUI_TextRight
			{
				width = 0.15;
				widthType = ZUI_SIZE_ABSOLUTE;
				text = "Preset Name:";
				maring[] = SPACING_RIGHT;
				font = GUI_STANDARD_FONT;
				textSize = GUI_TEXT_SIZE_SMALL;
			};

			class input: ZUI_Edit
			{
				id = "name";
				margin = GUI_SPACING;
			};
		};

		class Actions: ZUI_RowLayout
		{
			margin[] = SPACING_TOP;
			height = 0.05;
			heightType = ZUI_SIZE_ABSOLUTE;

			class Remove: ZUI_Button
			{
				id = "remove";
				text = "REMOVE SELECTED";
				width = 0.3;
				widthType = ZUI_SIZE_ABSOLUTE;
				margin[] = SPACING_RIGHT;
			};

			SPACER_COMPONENT;

			class Cancel: ZUI_Button
			{
				id = "cancel";
				text = "CANCEL";
				width = 0.2;
				widthType = ZUI_SIZE_ABSOLUTE;
				margin[] = SPACING_RIGHT;
			};

			class Save: ZUI_Button
			{
				id = "save";
				text = "SAVE";
				width = 0.2;
				widthType = ZUI_SIZE_ABSOLUTE;
			};

			class Load: ZUI_Button
			{
				id = "load";
				text = "LOAD";
				width = 0.2;
				widthType = ZUI_SIZE_ABSOLUTE;
			};
		};
	};

	SPACER_COMPONENT;
};