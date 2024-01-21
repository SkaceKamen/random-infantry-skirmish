class DeathDialog: ZUI_ColumnLayout
{
	SPACER_COMPONENT;

	class inner: ZUI_RowLayout
	{
		SPACER_COMPONENT;

		height = 0.5;
		heightType = ZUI_SIZE_ABSOLUTE;

		class window: ZUI_ColumnLayout
		{
			width = 0.5;
			widthType = ZUI_SIZE_ABSOLUTE;

			SPACER_COMPONENT;

			class killer: ZUI_TextCenter
			{
				height = 0.05;
				heightType = ZUI_SIZE_ABSOLUTE;
				id = "killer";
				text = "Killed by Kamen";
				background[] = GUI_TITLE_BG;
				margin[] = SPACING_BOTTOM;
			};

			class weapon: ZUI_TextCenter
			{
				height = 0.05;
				heightType = ZUI_SIZE_ABSOLUTE;
				id = "weapon";
				text = "With Revolver";
				background[] = GUI_TITLE_BG;
				margin[] = SPACING_BOTTOM;
			};

			class imageContainer: ZUI_RowLayout
			{
				heightType = ZUI_SIZE_ABSOLUTE;
				height = 0.2;
				background[] = {0,0,0,0.5};
				margin[] = SPACING_BOTTOM;

				class image: ZUI_Picture
				{
					id = "weaponImage";
				};
			};

			class bottomActions: ZUI_RowLayout
			{
				heightType = ZUI_SIZE_ABSOLUTE;
				height = 0.06;
				margin[] = SPACING_BOTTOM;

				class changeEquipment: ZUI_Button
				{
					id = "equipment";
					text = "CHANGE EQUIPMENT";
					margin[] = SPACING_RIGHT;
				};

				class editSettings: ZUI_Button
				{
					id = "settings";
					text = "RIS SETTINGS";
				};
			};

			class respawn: ZUI_Button
			{
				id = "respawn";
				text = "RESPAWN";
				margin[] = SPACING_BOTTOM;

				heightType = ZUI_SIZE_ABSOLUTE;
				height = 0.08;
			};
		};

		SPACER_COMPONENT;
	};
};
