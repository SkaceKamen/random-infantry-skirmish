#include "arcadeUI.inc"

class ARCADE_UI
{
	idd = RSTFUI_ARCADE_IDD;
	duration = 100000;
	fadein = 0;
	movingEnable = false;
	enableSimulation = true;
	enableDisplay = true;
	onLoad = "uinamespace setVariable ['ARCADE_UI', _this select 0]";

	class controls
	{
		class LocalMessages : RscStructuredText
		{
			idc = RSTFUI_ARCADE_LOCAL_MESSAGES_IDC;
			x = SafeZoneX + SafeZoneW / 2 - 0.25;
			y = SafeZoneY + SafeZoneH - 0.3;
			w = 0.5;
			h = 0.2;

			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				align = "center";
				shadow = 0;
			};
		};

		class GlobalMessages : RscStructuredText
		{
			idc = RSTFUI_ARCADE_GLOBAL_MESSAGES_IDC;
			x = SafeZoneX + SafeZoneW / 2 - 0.25;
			y = RSTFUI_ARCADE_USER_ICON_Y + RSTFUI_ARCADE_USER_ICON_H + 0.005;
			w = 0.5;
			h = 0.2;

			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				align = "center";
				shadow = 0;
			};
		};

		class ScoreOwner: RscStatic
		{
			idc = RSTFUI_ARCADE_SCORE_OWNER_IDC;
			x = SafeZoneX + SafeZoneW / 2 - RSTFUI_ARCADE_SCORE_W/2;
			y = SafeZoneY + 0.01;
			w = RSTFUI_ARCADE_SCORE_W + 0.01;
			h = RSTFUI_ARCADE_SCORE_H;
			colorBackground[] = { 0, 0, 0, 0.9 };
		};

		class FRScoreBar : RscStatic
		{
			idc = RSTFUI_ARCADE_SCORE_F_IDC;
			style = ST_RIGHT;
			x = SafeZoneX + SafeZoneW / 2 - RSTFUI_ARCADE_SCORE_W - 0.005;
			y = SafeZoneY + 0.01;
			w = RSTFUI_ARCADE_SCORE_W;
			h = RSTFUI_ARCADE_SCORE_H;
			colorBackground[] = { 0, 0, 0.77, 0.9 };
		};

		class ENScoreBar : RscStatic
		{
			idc = RSTFUI_ARCADE_SCORE_E_IDC;
			x = SafeZoneX + SafeZoneW / 2 + 0.005;
			y = SafeZoneY + 0.01;
			w = RSTFUI_ARCADE_SCORE_W;
			h = RSTFUI_ARCADE_SCORE_H;
			colorBackground[] = { 0.9, 0.14, 0.14, 0.9 };
		};

		class MoneyBar : RscStatic
		{
			idc = RSTFUI_ARCADE_MONEY_IDC;
			style = ST_RIGHT | ST_VCENTER;
			shadow = false;
			colorBackground[] = { 0, 0, 0, 0.2 };
			color[] = { 1, 1, 1, 1 };

			x = SafeZoneX + SafeZoneW - 0.2 - 0.05;
			w = 0.2;
			y = SafeZoneY + SafeZoneH - 0.05 - 0.05;
			h = 0.05;
		};

		class UserCountIcon: RscPictureKeepAspect
		{
			idc = RSTFUI_ARCADE_USER_ICON_IDC;

			x = RSTFUI_ARCADE_USER_ICON_X;
			y = RSTFUI_ARCADE_USER_ICON_Y;

			w = RSTFUI_ARCADE_USER_ICON_W;
			h = RSTFUI_ARCADE_USER_ICON_H;

			text = "\A3\ui_f\data\Map\Respawn\icon_limit_ca.paa";
		};

		class FRUserCount: RscStatic
		{
			idc = RSTFUI_ARCADE_FRIENDLY_USER_COUNT_IDC;

			x = RSTFUI_ARCADE_USER_ICON_X - 0.005 - RSTFUI_ARCADE_USER_COUNT_W;
			y = RSTFUI_ARCADE_USER_ICON_Y;

			w = RSTFUI_ARCADE_USER_COUNT_W;
			h = RSTFUI_ARCADE_USER_ICON_H;

			style = ST_RIGHT | ST_VCENTER;

			text = "23";

			colorBackground[] = { 0, 0, 0, 0.2 };
		};

		class ENUserCount: RscStatic
		{
			idc = RSTFUI_ARCADE_ENEMY_USER_COUNT_IDC;

			x = RSTFUI_ARCADE_USER_ICON_X + RSTFUI_ARCADE_USER_ICON_W + 0.005;
			y = RSTFUI_ARCADE_USER_ICON_Y;

			w = RSTFUI_ARCADE_USER_COUNT_W;
			h = RSTFUI_ARCADE_USER_ICON_H;

			style = ST_LEFT | ST_VCENTER;

			text = "20";

			colorBackground[] = { 0, 0, 0, 0.2 };
		};
		
		class PushProgressBackground : RscStatic
		{
			idc = RSTFUI_ARCADE_PUSH_PROGRESS_BACKGROUND_IDC;
			x = SafeZoneX + SafeZoneW / 2 - RSTFUI_ARCADE_PUSH_PROGRESS_W / 2;
			y = SafeZoneY + 0.01;
			w = RSTFUI_ARCADE_PUSH_PROGRESS_W;
			h = RSTFUI_ARCADE_PUSH_PROGRESS_H;
			colorBackground[] = { 0, 0, 0, 0.5 };
		};

		class PushProgressBar : RscStatic
		{
			idc = RSTFUI_ARCADE_PUSH_PROGRESS_IDC;
			style = ST_VCENTER;
			x = SafeZoneX + SafeZoneW / 2 - RSTFUI_ARCADE_PUSH_PROGRESS_W / 2;
			y = SafeZoneY + 0.01;
			w = 0;
			h = RSTFUI_ARCADE_PUSH_PROGRESS_H;
			colorBackground[] = { 0, 0, 0.77, 0.9 };
		};

		class DefenseProgress : RscStatic
		{
			idc = RSTFUI_ARCADE_DEFENSE_PROGRESS_IDC;
			x = SafeZoneX + SafeZoneW / 2 - RSTFUI_ARCADE_PUSH_PROGRESS_W / 2;
			y = SafeZoneY + 0.01;
			w = RSTFUI_ARCADE_PUSH_PROGRESS_W;
			h = RSTFUI_ARCADE_PUSH_PROGRESS_H;
			style = ST_CENTER | ST_VCENTER;
		};
	};
};
