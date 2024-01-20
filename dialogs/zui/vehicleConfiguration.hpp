class VehicleConfigurationDialog: ZUI_ColumnLayout
{
	SPACER_COMPONENT;

	class inner: ZUI_RowLayout
	{
		height = 0.75;
		heightType = ZUI_SIZE_ABSOLUTE;

		SPACER_COMPONENT;

		class window: ZUI_ColumnLayout
		{
			width = 0.75;
			widthType = ZUI_SIZE_ABSOLUTE;

			class title: ZTitle
			{
				text = "Vehicle Configuration";
				margin[] = SPACING_BOTTOM;
			};

			class body: ZUI_ColumnLayout
			{
				margin[] = SPACING_BOTTOM;
				background[] = GUI_BODY_BG;
				padding = GUI_SPACING;

				class vehicleItem: ZUI_RowLayout
				{
					margin[] = SPACING_BOTTOM;
					height = 0.06;
					heightType = ZUI_SIZE_ABSOLUTE;

					class label: ZUI_TextRight
					{
						text = "Vehicle:";
						width = 0.5;
					};

					class input: ZUI_Text
					{
						id = "vehicle";
					};
				};

				class costItem: ZUI_RowLayout
				{
					margin[] = SPACING_BOTTOM;
					height = 0.06;
					heightType = ZUI_SIZE_ABSOLUTE;

					class label: ZUI_TextRight
					{
						text = "Cost:";
						width = 0.5;
					};

					class input: ZUI_Text
					{
						id = "cost";
					};
				};

				class seatItem: ZUI_RowLayout
				{
					margin[] = SPACING_BOTTOM;
					height = 0.06;
					heightType = ZUI_SIZE_ABSOLUTE;

					class label: ZUI_TextRight
					{
						text = "Seat:";
						width = 0.5;
					};

					class input: ZUI_Combo
					{
						id = "seat";
					};
				};

				class skinItem: ZUI_RowLayout
				{
					margin[] = SPACING_BOTTOM;
					height = 0.06;
					heightType = ZUI_SIZE_ABSOLUTE;

					class label: ZUI_TextRight
					{
						text = "Camouflage:";
						width = 0.5;
					};

					class input: ZUI_Combo
					{
						id = "skin";
					};
				};

				class componentsItem: ZUI_RowLayout
				{
					margin[] = SPACING_BOTTOM;

					class label: ZUI_TextRight
					{
						text = "Components:";
						width = 0.5;
					};

					class inputContainer: ZUI_ColumnLayout
					{
						background[] = GUI_BODY_BG;
						
						class input: ZUI_Listview
						{
							id = "components";
							columns[] = { 0, 0.075, 0.6 };
							font = GUI_TITLE_FONT;
							textSize = GUI_TEXT_SIZE_SMALL;
							margin = GUI_SPACING;
						};
					};
				};
			};

			class actions: ZUI_RowLayout
			{
				height = 0.05;
				heightType = ZUI_SIZE_ABSOLUTE;

				SPACER_COMPONENT;

				class cancel: ZUI_Button
				{
					id = "cancel";
					text = "CANCEL";
					margin[] = SPACING_RIGHT;
				};

				class confirm: ZUI_Button
				{
					id = "buy";
					text = "BUY";
				};
			};
		};

		SPACER_COMPONENT;
	}

	SPACER_COMPONENT;
}