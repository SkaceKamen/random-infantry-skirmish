class CustomSelectorDialog: ZUI_ColumnLayout
{
	margin[] = { 0.05, 0.2, 0.05, 0.2 };

	class titleBar: ZUI_RowLayout
	{
		heightType = ZUI_SIZE_ABSOLUTE;
		height = 0.06;
		margin[] = { 0, 0, SPACING, 0 };

		class dialogTitle: ZUI_Text
		{
			text = "CUSTOM BATTLE EDITOR";
			background[] = {
				"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
			};
			margin[] = { 0, 0, 0, 0 };
		};
	};

	class map: ZUI_Control
	{
		id = "map";
		control = "RscMapControl";
	};

	class actionsContainer: ZUI_RowLayout
	{
		heightType = ZUI_SIZE_ABSOLUTE;
		height = 0.08;
		margin[] = { 0.005, 0, 0, 0 };
		background[] = { 0, 0, 0, 0.75 };
		padding = 0.005;
		
		class viewSwitch: ZUI_Button
		{
			id = "viewSwitch";
			text = "2D Map";
		};

		class spacer1: ZUI_ColumnLayout
		{
			width = 2;
		};

		class rotationContainer: ZUI_RowLayout
		{
			class rotatePrev: ZUI_Button
			{
				id = "rotatePrev";
				text = "<";
				margin[] = { 0, ZUI_DIALOG_MARGIN, 0, 0 };
				colorBackground[] = { 0, 0, 0, 0.9 };
			};

			class rotation: ZUI_Control
			{
				id = "rotation";
				control = "RscEdit";
				width = 2;
				colorBackground[] = { 0, 0, 0, 0.9 };
			};

			class rotateNext: ZUI_Button
			{
				id = "rotateNext";
				text = ">";
				margin[] = { 0, 0, 0, ZUI_DIALOG_MARGIN };
				colorBackground[] = { 0, 0, 0, 0.9 };
			};
		};

		class confirm: ZUI_Button
		{
			id = "confirm";
			text = "Confirm";
			margin[] = { 0, 0, 0, ZUI_DIALOG_MARGIN * 3 };
			colorBackground[] = { 0, 0, 0, 0.9 };
		};
	};
};
