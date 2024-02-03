class FactionConfig : ZUI_ColumnLayout
{
	class Title: ZUI_Static
	{
		text = "Faction";
		background[] = GUI_TITLE_BG;
		margin[] = { 0, 0, GUI_SPACING, 0 };
		height = 0.05;
		heightType = ZUI_SIZE_ABSOLUTE;
		font = GUI_TITLE_FONT;
		textSize = GUI_TEXT_SIZE_MEDIUM;
	};

	class List: ZUI_RowLayout
	{
		background[] = GUI_BODY_BG;
		padding = 0.005;

		class List: ZUI_Listview
		{
			columns[] = { 0, 0.75 };
			font = GUI_STANDARD_FONT;
			textSize = GUI_TEXT_SIZE_SMALL;
		};
	};

	class Edit: ZUI_Button
	{
		text = "EDIT";
		margin[] = { GUI_SPACING, 0, 0, 0 };
		height = 0.05;
		heightType = ZUI_SIZE_ABSOLUTE;
	};
};

class MainConfigDialog: ZUI_ColumnLayout
{
	class spacerTop : ZUI_RowLayout {};

	class inner: ZUI_RowLayout {
		class spacerLeft: ZUI_RowLayout {};

		class inner: ZUI_ColumnLayout {
			width = 1.5;
			widthType = ZUI_SIZE_ABSOLUTE;

			class BasicConfiguration : ZUI_RowLayout
			{
				height = 0.7;
				heightType = ZUI_SIZE_ABSOLUTE;

				class FactionsConfig : ZUI_RowLayout
				{
					width = 1.75;

					class FirstFactions: ZUI_ColumnLayout
					{
						width = 2;

						class factions: ZUI_RowLayout
						{
							class FriendlyFactions : FactionConfig
							{
								margin[] = { 0, GUI_SPACING, 0, 0 };
								class Title: Title { text = "Friendly factions"; };
								class List: List { class List: List { id = "friendlyList"; }; };
								class Edit: Edit { id = "friendlyEdit"; };
							};

							class EnemyFactions : FactionConfig
							{
								margin[] = { 0, GUI_SPACING, 0, 0 };
								class Title: Title { text = "Enemy factions"; };
								class List: List { class List: List { id = "enemyList"; }; };
								class Edit: Edit { id = "enemyEdit"; };
							};
						};

						class switchSides: ZUI_Button
						{
							id = "switchSides";
							text = "SWITCH FACTIONS";
							margin[] = { GUI_SPACING, GUI_SPACING, 0, 0, 0 };
							heightType = ZUI_SIZE_ABSOLUTE;
							height = 0.05;
						}
					};

					class NeutralFactions : FactionConfig
					{
						margin[] = { 0, GUI_SPACING*2, 0, 0 };
						id = "neutrals";
						class Title: Title { text = "Neutral factions"; };
						class List: List {
							class List: List { id = "neutralList"; };
							/*class NotUsed: ZUI_TextCenter
							{
								id = "neutralsNotUsed";
								text = "Not usable for this mode";
							};*/
						};
						class Edit: Edit { id = "neutralEdit"; };
					};
				};

				class BasicConfigInfo : ZUI_ColumnLayout
				{
					class Title: ZUI_Static
					{
						text = "Configuration";
						background[] = GUI_TITLE_BG;
						margin[] = { 0, 0, GUI_SPACING, 0 };
						heightType = ZUI_SIZE_ABSOLUTE;
						height = 0.05;
						font = GUI_TITLE_FONT;
					};

					class List: ZUI_RowLayout
					{
						background[] = GUI_BODY_BG;
						padding = 0.005;

						class List: ZUI_Listview
						{
							id = "basicConfigList";
							columns[] = { 0, 0.5 };
							font = GUI_STANDARD_FONT;
							textSize = GUI_TEXT_SIZE_SMALL;
						};
					};

					class Presets: ZUI_Button
					{
						id = "showPresets";
						text = "PRESETS";
						heightType = ZUI_SIZE_ABSOLUTE;
						height = 0.05;
						margin[] = { GUI_SPACING, 0, 0, 0 };
					};

					class Edit: ZUI_Button
					{
						id = "editConfig";
						text = "EDIT CONFIGURATION";
						margin[] = { GUI_SPACING, 0, 0, 0 };
						heightType = ZUI_SIZE_ABSOLUTE;
						height = 0.05;
					};
				};
			};

			class ExtraActions : ZUI_RowLayout
			{
				heightType = ZUI_SIZE_ABSOLUTE;
				height = 0.1;
				margin[] = { GUI_SPACING*6, 0, 0, 0 };

				class PickEquipment: ZUI_Button
				{
					id = "pickEquipment";
					text = "PICK EQUIPMENT";
					margin[] = { 0, GUI_SPACING, 0, 0 };
				};
				class spacer : ZUI_RowLayout {};
				class Start: ZUI_Button
				{
					id = "start";
					text = "START";
				};
			};
		};
		
		class spacerRight: ZUI_RowLayout {};
	};

	class spacerBottom : ZUI_RowLayout {};
};
