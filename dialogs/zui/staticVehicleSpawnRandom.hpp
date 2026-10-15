class StaticVehicleSpawnRandomDialog: ZUI_RowLayout
{
	SPACER_COMPONENT;

	class container: ZUI_ColumnLayout
	{
		width = 0.6;
		widthType = ZUI_SIZE_ABSOLUTE;
		margin[] = { 0.15, 0, 0.15, 0 };

		class Title: ZTitle
		{
			text = "RANDOM FILL";
			margin[] = SPACING_BOTTOM;
		};

		class Body: ZUI_ColumnLayout
		{
			background[] = GUI_BODY_BG;
			padding = GUI_SPACING;
			margin[] = SPACING_BOTTOM;

			class Apc: ZUI_RowLayout
			{
				height = 0.05;
				heightType = ZUI_SIZE_ABSOLUTE;
				margin[] = SPACING_BOTTOM;

				class label: ZUI_Text
				{
					text = "APC / IFV:";
					width = 0.15;
					widthType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_RIGHT;
					font = GUI_STANDARD_FONT;
					textSize = GUI_TEXT_SIZE_SMALL;
				};

				class input: ZUI_Edit
				{
					id = "apc";
					width = 0.06;
					widthType = ZUI_SIZE_ABSOLUTE;
				};
			};

			class Air: ZUI_RowLayout
			{
				height = 0.05;
				heightType = ZUI_SIZE_ABSOLUTE;
				margin[] = SPACING_BOTTOM;

				class label: ZUI_Text
				{
					text = "Air:";
					width = 0.15;
					widthType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_RIGHT;
					font = GUI_STANDARD_FONT;
					textSize = GUI_TEXT_SIZE_SMALL;
				};

				class input: ZUI_Edit
				{
					id = "air";
					width = 0.06;
					widthType = ZUI_SIZE_ABSOLUTE;
				};
			};

			class Respawn: ZUI_RowLayout
			{
				height = 0.05;
				heightType = ZUI_SIZE_ABSOLUTE;

				class label: ZUI_Text
				{
					text = "Respawn (sec):";
					width = 0.15;
					widthType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_RIGHT;
					font = GUI_STANDARD_FONT;
					textSize = GUI_TEXT_SIZE_SMALL;
				};

				class input: ZUI_Edit
				{
					id = "respawn";
					width = 0.06;
					widthType = ZUI_SIZE_ABSOLUTE;
				};
			};
		};

		class Actions: ZUI_RowLayout
		{
			height = 0.05;
			heightType = ZUI_SIZE_ABSOLUTE;

			SPACER_COMPONENT;

			class Cancel: ZUI_Button
			{
				id = "cancel";
				text = "CANCEL";
				width = 0.2;
				widthType = ZUI_SIZE_ABSOLUTE;
				margin[] = SPACING_RIGHT;
			};

			class Fill: ZUI_Button
			{
				id = "fill";
				text = "FILL";
				width = 0.2;
				widthType = ZUI_SIZE_ABSOLUTE;
			};
		};
	};

	SPACER_COMPONENT;
};
