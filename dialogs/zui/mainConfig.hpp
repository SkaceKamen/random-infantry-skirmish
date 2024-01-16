#define MAIN_CONFIG_SPACING 0.005

class FactionConfig : ZUI_ColumnLayout
{
	class Title: ZUI_Static
	{
		text = "Faction";
		background[] = GUI_TITLE_BG;
		margin[] = { 0, 0, MAIN_CONFIG_SPACING, 0 };
		height = 0.05;
		heightType = ZUI_SIZE_ABSOLUTE;
		font = UI_BASIC_FONT;
		textSize = GUI_TEXT_SIZE_MEDIUM;
	};

	class List: ZUI_RowLayout
	{
		background[] = GUI_BODY_BG;
		padding = 0.005;

		class List: ZUI_Listview
		{
			columns[] = { 0, 0.75 };
		};
	};

	class Edit: ZUI_Button
	{
		text = "Edit";
		margin[] = { MAIN_CONFIG_SPACING, 0, 0, 0 };
		height = 0.06;
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

					class FriendlyFactions : FactionConfig
					{
						margin[] = { 0, MAIN_CONFIG_SPACING, 0, 0 };
						class Title: Title { text = "Friendly factions" };
						class List: List { class List: List { id = "friendlyList"; }; };
						class Edit: Edit { id = "friendlyEdit"; };
					};

					class EnemyFactions : FactionConfig
					{
						margin[] = { 0, MAIN_CONFIG_SPACING, 0, 0 };
						class Title: Title { text = "Enemy factions" };
						class List: List { class List: List { id = "enemyList"; }; };
						class Edit: Edit { id = "enemyEdit"; };
					};

					class NeutralFactions : FactionConfig
					{
						margin[] = { 0, MAIN_CONFIG_SPACING*2, 0, 0 };
						id = "neutral";
						class Title: Title { text = "Neutral factions" };
						class List: List { class List: List { id = "neutralList"; }; };
						class Edit: Edit { id = "neutralEdit"; };
					};
				};

				class BasicConfigInfo : ZUI_ColumnLayout
				{
					class Title: ZUI_Static
					{
						text = "Basic configuration";
						background[] = GUI_TITLE_BG;
						margin[] = { 0, 0, MAIN_CONFIG_SPACING, 0 };
						heightType = ZUI_SIZE_ABSOLUTE;
						height = 0.05;
					};

					class List: ZUI_RowLayout
					{
						background[] = GUI_BODY_BG;
						padding = 0.005;

						class List: ZUI_Listview
						{
							id = "basicConfigList";
							columns[] = { 0, 0.5 };
						};
					};

					class Edit: ZUI_Button
					{
						id = "editConfig";
						text = "Edit";
						margin[] = { MAIN_CONFIG_SPACING, 0, 0, 0 };
						heightType = ZUI_SIZE_ABSOLUTE;
						height = 0.06;
					};
				};
			};

			class ExtraActions : ZUI_RowLayout
			{
				heightType = ZUI_SIZE_ABSOLUTE;
				height = 0.1;
				margin[] = { MAIN_CONFIG_SPACING*6, 0, 0, 0 };

				class Presets: ZUI_Button
				{
					id = "showPresets";
					text = "Presets";
					heightType = ZUI_SIZE_ABSOLUTE;
					height = 0.06;
				};
				class spacer : ZUI_RowLayout {};
				class PickEquipment: ZUI_Button
				{
					id = "pickEquipment"
					text = "Pick Equipment";
					margin[] = { 0, MAIN_CONFIG_SPACING, 0, 0 };
				};
				class Start: ZUI_Button
				{
					id = "start";
					text = "Start";
				};
			};
		};
		
		class spacerRight: ZUI_RowLayout {};
	};

	class spacerBottom : ZUI_RowLayout {};
};
