#define RSTF_CONFIG_X SafeZoneX + 0.2
#define RSTF_CONFIG_Y SafeZoneY + 0.2
#define RSTF_CONFIG_W SafeZoneW - 0.4
#define RSTF_CONFIG_H SafeZoneH - 0.4
#define RSTF_SUBCONFIG_M 0.05
#define RSTF_SUBCONFIG_W ((RSTF_CONFIG_W - RSTF_SUBCONFIG_M*2) / 3)
#define RSTF_SUBCONFIG_H ((RSTF_CONFIG_H - RSTF_SUBCONFIG_M)/2)
#define RSTF_SUBCONFIG_P 0.03
#define RSTF_SUBCONFIG_SX RSTF_SUBCONFIG_P
#define RSTF_SUBCONFIG_SY (RSTF_SUBCONFIG_P + RSTF_SUBTITLE_H + RSTF_SUBTITLE_M)
#define RSTF_SUBCONFIG_SW (RSTF_SUBCONFIG_W - RSTF_SUBCONFIG_SX - RSTF_SUBCONFIG_P)
#define RSTF_SUBCONFIG_SH (RSTF_SUBCONFIG_H - RSTF_SUBCONFIG_SY - RSTF_SUBCONFIG_P)
#define RSTF_SUBTITLE_H 0.05
#define RSTF_SUBTITLE_M 0.01
#define RSTF_SUBCONFIG_SP 0.01
#define RSTF_SUBCONFIG_BUTTON_W RSTF_SUBCONFIG_SW
#define RSTF_SUBCONFIG_BUTTON_H 0.05
#define RSTF_CONFIG_START_H 0.1

#define RSTF_CONFIG_LINE_H 0.05
#define RSTF_CONFIG_LINE_P 0.01
#define RSTF_CONFIG_LINE_HP (RSTF_CONFIG_LINE_H + RSTF_CONFIG_LINE_P)
#define RSTF_CONFIG_LABEL_W (RSTF_SUBCONFIG_SW * 0.5)
#define RSTF_CONFIG_INPUT_W (RSTF_SUBCONFIG_SW * 0.4)

class RSTF_Background : RscStatic
{
	colorText[] = { 1, 1, 1, 1 };
	colorBackground[] = { 0, 0, 0, 0.6 };
	x = 0;
	y = RSTF_SUBTITLE_H + RSTF_SUBTITLE_M;
	w = RSTF_SUBCONFIG_W;
	h = RSTF_SUBCONFIG_H - (RSTF_SUBTITLE_H + RSTF_SUBTITLE_M);
};

class RSTF_Subtitle : RscStatic
{
	w = RSTF_SUBCONFIG_W;
	h = RSTF_SUBTITLE_H;
	colorBackground[] = { "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.7 };
	text = "";
};

class RSTF_Label : RscStatic
{
	idc = -1;
    colorText[] = { 1,1,1,1 };
    colorBackground[] = {0,0,0,0};
	sizeEx = 0.032;
    x = RSTF_SUBCONFIG_SX;
    y = RSTF_SUBCONFIG_SY;
	w = RSTF_CONFIG_LABEL_W;
    h = RSTF_CONFIG_LINE_H;
};

class RSTF_Combo : RscCombo
{
	x = RSTF_SUBCONFIG_SX + RSTF_SUBCONFIG_SW - RSTF_CONFIG_INPUT_W;
	y = RSTF_SUBCONFIG_SY;
	w = RSTF_CONFIG_INPUT_W;
    h = RSTF_CONFIG_LINE_H;
};

class RSTF_Checkbox : RscCheckBox
{
	x = RSTF_SUBCONFIG_SX + RSTF_SUBCONFIG_SW - RSTF_CONFIG_INPUT_W;
	y = RSTF_SUBCONFIG_SY;
	w = RSTF_CONFIG_INPUT_W;
	h = RSTF_CONFIG_LINE_H;
};

class RSTF_Subconfig : RscControlsGroup
{
	x = RSTF_CONFIG_X;
	y = RSTF_CONFIG_Y;
	w = RSTF_SUBCONFIG_W;
	h = RSTF_SUBCONFIG_H;
};

class RSTF_Subconfig_Factions : RscListNBox
{
	x = RSTF_SUBCONFIG_SX;
	y = RSTF_SUBCONFIG_SY;
	w = RSTF_SUBCONFIG_SW;
	h = RSTF_SUBCONFIG_SH - RSTF_SUBCONFIG_BUTTON_H - RSTF_SUBCONFIG_SP;
	columns[] = {0, 0.6};
};

class RSTF_Subconfig_Factions_Back : RSTF_Background
{
	x = RSTF_SUBCONFIG_SX;
	y = RSTF_SUBCONFIG_SY;
	w = RSTF_SUBCONFIG_SW;
	h = RSTF_SUBCONFIG_SH - RSTF_SUBCONFIG_BUTTON_H - RSTF_SUBCONFIG_SP;
};

class RSTF_Subconfig_Button : RscButton
{
	x = RSTF_SUBCONFIG_SX;
	y = RSTF_SUBCONFIG_SY + RSTF_SUBCONFIG_SH - RSTF_SUBCONFIG_BUTTON_H;
	w = RSTF_SUBCONFIG_BUTTON_W;
	h = RSTF_SUBCONFIG_BUTTON_H;
	text = "EDIT";
};

class RSTF_Edit : RscEdit
{
	x = RSTF_SUBCONFIG_SX + RSTF_SUBCONFIG_SW - RSTF_CONFIG_INPUT_W;
	y = RSTF_SUBCONFIG_SY;
	w = RSTF_CONFIG_INPUT_W;
	h = RSTF_CONFIG_LINE_H;
};

class RSTF_RscDialogConfig
{
    idd = 5;
    enableDisplay = true;
    movingEnable = true;
    class controlsBackground
    {
		
	};
	class controls
	{
		class nothing : RscStatic
		{
			
		};
		
		class sideFriendly : RSTF_Subconfig
		{
			class controls
			{
				class title : RSTF_Subtitle
				{
					x = 0;
					y = 0;
					w = RSTF_SUBCONFIG_W;
					text = "Friendly factions";
				};
				class background : RSTF_Background
				{
				};
				class factionsBackground : RSTF_Subconfig_Factions_Back
				{
				};
				class factions : RSTF_Subconfig_Factions
				{
					idc = 5;
				};
				class edit : RSTF_Subconfig_Button
				{
					idc = 6;
				};
			};
		};
		class sideNeutral : RSTF_Subconfig
		{
			x = RSTF_CONFIG_X + RSTF_SUBCONFIG_W + RSTF_SUBCONFIG_M;
			class controls
			{
				class title : RSTF_Subtitle
				{
					x = 0;
					y = 0;
					w = RSTF_SUBCONFIG_W;
					text = "Neutral factions";
				};
				class background : RSTF_Background
				{
				};
				class factionsBackground : RSTF_Subconfig_Factions_Back
				{
				};
				class factions : RSTF_Subconfig_Factions
				{
					idc = 7;
				};
				class edit : RSTF_Subconfig_Button
				{
					idc = 8;
				};
			};
		};
		class sideEnemy : RSTF_Subconfig
		{
			x = RSTF_CONFIG_X + (RSTF_SUBCONFIG_W + RSTF_SUBCONFIG_M) * 2;
			class controls
			{
				class title : RSTF_Subtitle
				{
					x = 0;
					y = 0;
					w = RSTF_SUBCONFIG_W;
					text = "Enemy factions";
				};
				class background : RSTF_Background
				{
				};
				class factionsBackground : RSTF_Subconfig_Factions_Back
				{
				};
				class factions : RSTF_Subconfig_Factions
				{
					idc = 9;
				};
				class edit : RSTF_Subconfig_Button
				{
					idc = 10;
				};
			};
		};
		class gameConfig : RSTF_Subconfig
		{
			y = RSTF_CONFIG_Y + (RSTF_SUBCONFIG_H + RSTF_SUBCONFIG_M);
			class controls
			{
				class title : RSTF_Subtitle
				{
					x = 0;
					y = 0;
					w = RSTF_SUBCONFIG_W;
					text = "Game options";
				};
				class background : RSTF_Background
				{
				};
				class scoreLimitLabel : RSTF_Label
				{
					text = "Score to win";
					tooltip = "Score required for winning the game";
				};
				class scoreLimit : RSTF_Edit
				{
					idc = 12;
				};
				class scorePerKillLabel : RSTF_Label
				{
					text = "Score per kill";
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_HP;
					tooltip = "Score you get for killing soldier";
				};
				class scorePerKill : RSTF_Edit
				{
					idc = 13;
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_HP;
				};
				class scorePerTaskLabel : RSTF_Label
				{
					text = "Score per task";
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_HP * 2;
					tooltip = "Score you get for completing task";
				};
				class scorePerTask : RSTF_Edit
				{
					idc = 14;
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_HP * 2;
				};
				
				class groupsLimitLabel : RSTF_Label
				{
					text = "Groups per side";
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_P*2 + RSTF_CONFIG_LINE_HP * 3;
					tooltip = "Number of groups spawned for each side";
				};
				class groupsLimit : RSTF_Edit
				{
					idc = 15;
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_P*2 + RSTF_CONFIG_LINE_HP * 3;
				};
				class unitsLimitLabel : RSTF_Label
				{
					text = "Units per group";
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_P*2 + RSTF_CONFIG_LINE_HP * 4;
					tooltip = "Number of soldiers in single group";
				};
				class unitsLimit : RSTF_Edit
				{
					idc = 16;
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_P*2 + RSTF_CONFIG_LINE_HP * 4;
				};
				
				class neutralsLimitLabel : RSTF_Label
				{
					text = "Neutral groups";
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_P*2 + RSTF_CONFIG_LINE_HP * 5;
					tooltip = "Maximum number of neutral groups spawned";
				};
				class neutralsLimit : RSTF_Edit
				{
					idc = 17;
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_P*2 + RSTF_CONFIG_LINE_HP * 5;
				};
				
				class spawnTimeLabel : RSTF_Label
				{
					text = "Wave spawn time";
					tooltip = "Interval in seconds in which reinforcements are spawned";
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_P*2 + RSTF_CONFIG_LINE_HP * 6;
				};
				class spawnTime : RSTF_Edit
				{
					idc = 20;
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_P*2 + RSTF_CONFIG_LINE_HP * 6;
				};
			};
		};
		class spawnConfig : RSTF_Subconfig
		{
			x = RSTF_CONFIG_X + RSTF_SUBCONFIG_W + RSTF_SUBCONFIG_M;
			y = RSTF_CONFIG_Y + (RSTF_SUBCONFIG_H + RSTF_SUBCONFIG_M);
			class controls
			{
				class title : RSTF_Subtitle
				{
					x = 0;
					y = 0;
					w = RSTF_SUBCONFIG_W;
					text = "Spawn options";
				};
				class background : RSTF_Background
				{
				};
				class spawnTypeLabel : RSTF_Label
				{
					text = "Spawn to";
					tooltip = "How to select unit to spawn to. Closest - unit closest to your death, Group - unit in your group, Random - random unit";
				};
				class spawnType : RSTF_Combo
				{
					idc = 21;
				};
				class randomizeWeaponsLabel : RSTF_Label
				{
					text = "Randomize weapons";
					tooltip = "Each soldier will be given random weapon";
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_HP;
				};
				class randomizeWeapons : RSTF_Checkbox
				{
					idc = 18;
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_HP;
				};
				class restrictWeaponsLabel : RSTF_Label
				{
					text = "Restrict weapons to sides";
					tooltip = "When weapons are randomized, only use weapons that origins from unit faction. (Useful for mods)";
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_HP * 2;
				};
				class restrictWeapons : RSTF_Checkbox
				{
					idc = 19;
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_HP * 2;
				};
				class enableCustomLabel : RSTF_Label
				{
					text = "Enable custom equipment";
					tooltip = "Enable player to customize his equipment, which will be used when switching to soldier";
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_HP * 3;
				};
				class enableCustom : RSTF_Checkbox
				{
					idc = 22;
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_HP * 3;
				};
				class changeCustom : RscButton
				{
					idc = 23;
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_HP * 4;
					x = RSTF_SUBCONFIG_SX;
					w = RSTF_SUBCONFIG_SW;
					h = RSTF_CONFIG_LINE_H;
					text = "Customize equipment";
				};
			};
		};
		class otherConfig : RSTF_Subconfig
		{
			x = RSTF_CONFIG_X + (RSTF_SUBCONFIG_W + RSTF_SUBCONFIG_M) * 2;
			y = RSTF_CONFIG_Y + (RSTF_SUBCONFIG_H + RSTF_SUBCONFIG_M);
			class controls
			{
				class title : RSTF_Subtitle
				{
					x = 0;
					y = 0;
					w = RSTF_SUBCONFIG_W;
					text = "Other options";
				};
				class background : RSTF_Background
				{
					h = RSTF_SUBCONFIG_H - (RSTF_SUBTITLE_H + RSTF_SUBTITLE_M * 2 + RSTF_CONFIG_START_H);
				};
				
				class clearDeadBodiesLabel : RSTF_Label
				{
					text = "Clear dead bodies";
					tooltip = "Dead bodies will be destroyed after 3 minutes. This helps performance.";
				};
				class clearDeadBodies : RSTF_Checkbox
				{
					idc = 11;
				};
				
				class weatherLabel : RSTF_Label
				{
					text = "Weather";
					tooltip = "Which weather will be at mission start.";
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_HP;
				};
				class weather : RSTF_Combo
				{
					idc = 24;
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_HP;
				};
				
				class timeLabel : RSTF_Label
				{
					text = "Daytime";
					tooltip = "Mission daytime.";
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_HP * 2;
				};
				class time : RSTF_Combo
				{
					idc = 25;
					y = RSTF_SUBCONFIG_SY + RSTF_CONFIG_LINE_HP * 2;
				};
				
				class reset : RscButton
				{
					idc = 501;
					x = RSTF_SUBCONFIG_SX;
					y = RSTF_SUBCONFIG_SY + (RSTF_SUBCONFIG_SH - RSTF_CONFIG_START_H - RSTF_SUBTITLE_M - RSTF_CONFIG_LINE_H);
					w = RSTF_SUBCONFIG_SW;
					h = RSTF_CONFIG_LINE_H;
					text = "Reset configuration";
				};
				
				/*class switchIsland : RscButton
				{
					idc = 502;
					x = RSTF_SUBCONFIG_SX;
					y = RSTF_SUBCONFIG_SY + (RSTF_SUBCONFIG_SH - RSTF_CONFIG_START_H - RSTF_SUBTITLE_M - RSTF_CONFIG_LINE_H * 2);
					w = RSTF_SUBCONFIG_SW;
					h = RSTF_CONFIG_LINE_H;
					text = "Switch island";
				};*/
				
				class start : RscButton
				{
					idc = 500;
					x = 0;
					y = RSTF_SUBCONFIG_H - RSTF_CONFIG_START_H;
					w = RSTF_SUBCONFIG_W;
					h = RSTF_CONFIG_START_H;
					text = "Start";
				};
			};
		};
	};
};