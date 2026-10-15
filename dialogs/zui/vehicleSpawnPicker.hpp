class VehicleSpawnPickerDialog: ZUI_RowLayout
{
	SPACER_COMPONENT;

	class container: ZUI_ColumnLayout
	{
		width = 1.2;
		widthType = ZUI_SIZE_ABSOLUTE;
		margin[] = { 0.2, 0, 0.2, 0 };

		class Title: ZTitle
		{
			text = "PICK A VEHICLE";
			margin[] = SPACING_BOTTOM;
		};

		class Side: ZUI_RowLayout
		{
			background[] = GUI_BODY_BG;
			height = 0.05;
			heightType = ZUI_SIZE_ABSOLUTE;
			margin[] = SPACING_BOTTOM;

			class label: ZUI_Text
			{
				text = "Side:";
				width = 0.05;
				widthType = ZUI_SIZE_ABSOLUTE;
				margin[] = SPACING_RIGHT;
				font = GUI_STANDARD_FONT;
				textSize = GUI_TEXT_SIZE_SMALL;
			};

			class combo: ZUI_Combo
			{
				id = "side";
				width = 0.2;
				widthType = ZUI_SIZE_ABSOLUTE;
			};
		};

		class Body: ZUI_RowLayout
		{
			class List: ZUI_ColumnLayout
			{
				width = 2;
				background[] = GUI_BODY_BG;
				padding = GUI_SPACING;
				margin[] = SPACING_RIGHT;

				class Search: ZUI_Edit
				{
					id = "search";
					height = 0.05;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;
				};

				class Categories: ZUI_Listview
				{
					id = "categories";
					columns[] = { 0, 0.8 };
					height = 0.25;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;
					shadow = 1;
					font = GUI_STANDARD_FONT;
					textSize = GUI_TEXT_SIZE_SMALL;
				};

				class Items: ZUI_Listview
				{
					id = "vehicles";
					columns[] = { 0, 0.6 };
					shadow = 1;
					font = GUI_STANDARD_FONT;
					textSize = GUI_TEXT_SIZE_SMALL;
				};
			};

			class Detail: ZUI_ColumnLayout
			{
				background[] = GUI_BODY_BG;
				padding = GUI_SPACING;

				class text: ZUI_StructuredText
				{
					id = "detail";
					font = GUI_STANDARD_FONT;
					textSize = GUI_TEXT_SIZE_SMALL;
				};
			};
		};

		class Inputs: ZUI_RowLayout
		{
			margin[] = SPACING_TOP;
			height = 0.05;
			heightType = ZUI_SIZE_ABSOLUTE;

			class countLabel: ZUI_Text
			{
				text = "Count:";
				width = 0.05;
				widthType = ZUI_SIZE_ABSOLUTE;
				margin[] = SPACING_RIGHT;
				font = GUI_STANDARD_FONT;
				textSize = GUI_TEXT_SIZE_SMALL;
			};

			class count: ZUI_Edit
			{
				id = "count";
				width = 0.05;
				widthType = ZUI_SIZE_ABSOLUTE;
				margin[] = SPACING_RIGHT;
			};

			class respawnLabel: ZUI_Text
			{
				text = "Respawn (sec):";
				width = 0.1;
				widthType = ZUI_SIZE_ABSOLUTE;
				margin[] = SPACING_RIGHT;
				font = GUI_STANDARD_FONT;
				textSize = GUI_TEXT_SIZE_SMALL;
			};

			class respawn: ZUI_Edit
			{
				id = "respawn";
				width = 0.06;
				widthType = ZUI_SIZE_ABSOLUTE;
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

			class Pick: ZUI_Button
			{
				id = "pick";
				text = "ADD";
				width = 0.2;
				widthType = ZUI_SIZE_ABSOLUTE;
			};
		};
	};

	SPACER_COMPONENT;
};
