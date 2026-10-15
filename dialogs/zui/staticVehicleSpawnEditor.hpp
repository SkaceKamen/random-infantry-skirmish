class StaticVehicleSpawnEditorDialog: ZUI_RowLayout
{
	SPACER_COMPONENT;

	class container: ZUI_ColumnLayout
	{
		width = 1.1;
		widthType = ZUI_SIZE_ABSOLUTE;
		margin[] = { 0.15, 0, 0.15, 0 };

		class Title: ZTitle
		{
			text = "STATIC VEHICLE SPAWNS";
			margin[] = SPACING_BOTTOM;
		};

		class Body: ZUI_RowLayout
		{
			class List: ZUI_ColumnLayout
			{
				background[] = GUI_BODY_BG;
				padding = GUI_SPACING;
				margin[] = SPACING_RIGHT;
				width = 3;

				class CurrentList: ZUI_Listview
				{
					id = "vehicles";
					columns[] = { 0, 0.1, 0.22, 0.6, 0.85 };
					shadow = 1;
					font = GUI_STANDARD_FONT;
					textSize = GUI_TEXT_SIZE_SMALL;
				};
			};

			class Actions: ZUI_ColumnLayout
			{
				class Add: ZUI_Button
				{
					id = "add";
					text = "ADD VEHICLE";
					height = 0.05;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;
				};

				class Edit: ZUI_Button
				{
					id = "edit";
					text = "EDIT VEHICLE";
					height = 0.05;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;
				};

				class Remove: ZUI_Button
				{
					id = "remove";
					text = "REMOVE VEHICLE";
					height = 0.05;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;
				};

				class spacer: ZUI_RowLayout
				{
					background[] = GUI_BODY_BG;
					margin[] = SPACING_BOTTOM;
					height = 0.075;
					heightType = ZUI_SIZE_ABSOLUTE;
				};

				class Clear: ZUI_Button
				{
					id = "clear";
					text = "CLEAR";
					height = 0.05;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;
				};

				class spacer3: ZUI_RowLayout
				{
					background[] = GUI_BODY_BG;
					margin[] = SPACING_BOTTOM;
					height = 0.075;
					heightType = ZUI_SIZE_ABSOLUTE;
				};

				class Random: ZUI_Button
				{
					id = "random";
					text = "RANDOM FILL";
					height = 0.05;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;
					tooltip = "Generate a random vehicle list for both sides, matching vehicles by price";
				};

				class spacer2: ZUI_RowLayout
				{
					background[] = GUI_BODY_BG;
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
				width = 0.2;
				widthType = ZUI_SIZE_ABSOLUTE;

				id = "cancel";
				text = "CANCEL";

				margin[] = SPACING_RIGHT;
			};

			class Save: ZUI_Button
			{
				width = 0.2;
				widthType = ZUI_SIZE_ABSOLUTE;

				id = "save";
				text = "SAVE";
			};
		};
	};

	SPACER_COMPONENT;
};
