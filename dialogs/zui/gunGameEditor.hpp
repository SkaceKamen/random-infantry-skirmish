class GunGameEditorDialog: ZUI_RowLayout
{
	SPACER_COMPONENT;

	class container: ZUI_ColumnLayout
	{
		width = 0.8;
		widthType = ZUI_SIZE_ABSOLUTE;
		margin[] = { 0.2, 0, 0.2, 0 };

		class Title: ZTitle
		{
			text = "GUN GAME EDITOR";
			margin[] = SPACING_BOTTOM;
		};

		class Body: ZUI_RowLayout
		{
			class List: ZUI_ColumnLayout
			{
				background[] = GUI_BODY_BG;
				padding = GUI_SPACING;
				margin[] = SPACING_RIGHT;
				width = 2;

				class CurrentList: ZUI_Listview
				{
					id = "weapons";
					columns[] = { 0 };
					shadow = 1;
					font = GUI_STANDARD_FONT;
					textSize = GUI_TEXT_SIZE_MEDIUM;
				};
			};

			class Actions: ZUI_ColumnLayout
			{
				class Add: ZUI_Button
				{
					id = "add";
					text = "ADD WEAPON";
					height = 0.05;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;
				};

				class Remove: ZUI_Button
				{
					id = "remove";
					text = "REMOVE WEAPON";
					height = 0.05;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;
				};

				class Up: ZUI_Button
				{
					id = "up";
					text = "MOVE UP";
					height = 0.05;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;
				};

				class Down: ZUI_Button
				{
					id = "down";
					text = "MOVE DOWN";
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

				class Randomize: ZUI_Button
				{
					id = "random";
					text = "ADD 5 RANDOM";
					height = 0.05;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;
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

				class SavePreset: ZUI_Button
				{
					id = "savePreset";
					text = "SAVE AS PRESET";
					height = 0.05;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;
				};

				class LoadPreset: ZUI_Button
				{
					id = "loadPreset";
					text = "LOAD PRESET";
					height = 0.05;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;
				};

				class spacer2: ZUI_RowLayout
				{
					background[] = GUI_BODY_BG;
				};

				/*
				SPACER_COMPONENT;

				class SaveAsPreset: ZUI_Button
				{
					id = "savePreset";
					text = "SAVE AS PRESET";
					height = 0.05;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;
				};

				class LoadPreset: ZUI_Button
				{
					id = "loadPreset";
					text = "LOAD PRESET";
					height = 0.05;
					heightType = ZUI_SIZE_ABSOLUTE;
					margin[] = SPACING_BOTTOM;
				};
				*/
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