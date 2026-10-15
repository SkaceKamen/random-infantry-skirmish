class StaticVehicleSpawnPickerDialog: ZUI_RowLayout
{
	SPACER_COMPONENT;

	class container: ZUI_ColumnLayout
	{
		width = 1.2;
		widthType = ZUI_SIZE_ABSOLUTE;
		margin[] = { 0.2, 0, 0.2, 0 };

		class Title: ZTitle
		{
			id = "title";
			text = "PICK A VEHICLE";
			margin[] = SPACING_BOTTOM;
		};

		class Options: ZUI_RowLayout
		{
			background[] = GUI_BODY_BG;
			height = 0.05;
			heightType = ZUI_SIZE_ABSOLUTE;
			margin[] = SPACING_BOTTOM;

			class sideLabel: ZUI_Text
			{
				text = "Side:";
				width = 0.08;
				widthType = ZUI_SIZE_ABSOLUTE;
				margin[] = SPACING_RIGHT;
				font = GUI_STANDARD_FONT;
				textSize = GUI_TEXT_SIZE_SMALL;
			};

			class side: ZUI_Combo
			{
				id = "side";
				width = 0.15;
				widthType = ZUI_SIZE_ABSOLUTE;
				margin[] = SPACING_RIGHT;
			};

			class countLabel: ZUI_TextRight
			{
				text = "Count:";
				width = 0.08;
				widthType = ZUI_SIZE_ABSOLUTE;
				margin[] = SPACING_RIGHT;
				font = GUI_STANDARD_FONT;
				textSize = GUI_TEXT_SIZE_SMALL;
			};

			class count: ZUI_Edit
			{
				id = "count";
				width = 0.10;
				widthType = ZUI_SIZE_ABSOLUTE;
				margin[] = SPACING_RIGHT;
			};

			class respawnLabel: ZUI_TextRight
			{
				text = "Respawn (sec):";
				width = 0.2;
				widthType = ZUI_SIZE_ABSOLUTE;
				margin[] = SPACING_RIGHT;
				font = GUI_STANDARD_FONT;
				textSize = GUI_TEXT_SIZE_SMALL;
			};

			class respawn: ZUI_Edit
			{
				id = "respawn";
				width = 0.10;
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

				class Filters: ZUI_RowLayout
				{
					height = 0.05;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;

					class category: ZUI_Combo
					{
						id = "category";
						width = 0.15;
						widthType = ZUI_SIZE_ABSOLUTE;
						margin[] = SPACING_RIGHT;
					};

					class search: ZUI_Edit
					{
						id = "search";
					};
				};

				class Items: ZUI_Listview
				{
					id = "vehicles";
					columns[] = { 0, 0.45, 0.75 };
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

		class Actions: ZUI_RowLayout
		{
			margin[] = SPACING_TOP;
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

			class Pick: ZUI_Button
			{
				id = "pick";
				text = "SAVE";
				width = 0.2;
				widthType = ZUI_SIZE_ABSOLUTE;
			};
		};
	};

	SPACER_COMPONENT;
};
