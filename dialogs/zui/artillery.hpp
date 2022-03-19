#define SPACING 0.005

class ArtilleryDialog: ZUI_ColumnLayout
{
	margin = 0.2;

	class container: ZUI_ColumnLayout
	{
		class titleBar: ZUI_RowLayout
		{
			heightType = ZUI_SIZE_ABSOLUTE;
			height = 0.06;
			margin[] = { 0, 0, SPACING, 0 };

			class dialogTitle: ZUI_Text
			{
				text = "ARTILLERY SUPPORT";
				background[] = {
					"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
					"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
					"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
					"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
				};
				margin[] = { 0, 0, 0, 0 };
			};
		};

		class contentContainer: ZUI_RowLayout
		{

			class mapContainer: ZUI_ColumnLayout
			{
				class map: ZUI_Control
				{
					id = "map";
					control = "RscMapControl";
				};
			};

			class infoContainer: ZUI_ColumnLayout
			{
				width = 0.25;
				margin[] = { 0, 0, 0, SPACING };

				class infoTextContainer: ZUI_ColumnLayout
				{
					margin[] = { 0, 0, SPACING, 0 };

					class infoText: ZUI_StructuredText
					{
						id = "info";
						background[] = { 0, 0, 0, 0.7 };
					};
				};

				class controlsContainer: ZUI_RowLayout
				{
					height = 0.06;
					heightType = ZUI_SIZE_ABSOLUTE;

					class spacer: ZUI_ColumnLayout
					{
						background[] = { 0, 0, 0, 0.7 };
						margin[] = { 0, SPACING, 0, 0 };
					};
					class cancel: ZUI_Button
					{
						id = "cancel";
						width = 0.2;
						widthType = ZUI_SIZE_ABSOLUTE;
						margin[] = { 0, SPACING, 0, 0 };
						text = "CANCEL";
					};
					class confirm: ZUI_Button
					{
						id = "confirm";
						width = 0.2;
						widthType = ZUI_SIZE_ABSOLUTE;
						text = "CONFIRM";
					};
				};
			};
		};
	};
};