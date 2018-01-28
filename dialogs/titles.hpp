class rscTitles
{
	class ARCADE_UI
	{
		idd = 5;
		duration = 100000;
        fadein = 0;
        movingEnable = false;
        enableSimulation = true;
        enableDisplay = true;
        onLoad = "uinamespace setVariable ['ARCADE_UI', _this select 0]";

		class controls
		{
			class GameScore : RscStructuredText
			{
				idc = 1;
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

			class FRScoreBar : RscStatic
			{
				idc = 3;
				style = ST_RIGHT;
				x = SafeZoneX + SafeZoneW / 2 - 0.105;
				y = SafeZoneY + 0.01;
				w = 0.10;
				h = 0.05;
				colorBackground[] = { 0, 0.77, 0, 0.9 };
			};

			class ENScoreBar : RscStatic
			{
				idc = 2;
				x = SafeZoneX + SafeZoneW / 2 + 0.005;
				y = SafeZoneY + 0.01;
				w = 0.10;
				h = 0.05;
				colorBackground[] = { 0.9, 0.14, 0.14, 0.9 };
			};

			class MoneyBar : RscStatic
			{
				idc = 5;
				style = ST_RIGHT | ST_VCENTER;
				shadow = false;
				colorBackground[] = { 0, 0, 0, 0.8 };
				color[] = { 1, 1, 1, 1 };

				x = SafeZoneX + SafeZoneW - 0.2 - 0.05;
				w = 0.2;
				y = SafeZoneY + SafeZoneH - 0.05 - 0.05;
				h = 0.05;
			};
		};
	};
};