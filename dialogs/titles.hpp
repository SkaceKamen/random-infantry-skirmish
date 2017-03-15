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
				x = SafeZoneX + SafeZoneW / 2 - 0.15;
				y = SafeZoneY + SafeZoneH - 0.3;
				w = 0.3;
				h = 0.2;
				class Attributes
				{
					font = "PuristaMedium";
					color = "#ffffff";
					align = "center";
					shadow = 0;
				};
			};
			
			class FRScoreBar : RscText
			{
				idc = 3;
				x = SafeZoneX + SafeZoneW - 0.2;
				y = SafeZoneY + SafeZoneH - 0.3;
				w = 0.10;
				h = 0.05;
				colorBackground[] = { 0, 0.77, 0, 0.9 };
			};
			
			class ENScoreBar : RscText
			{
				idc = 2;
				x = SafeZoneX + SafeZoneW - 0.1;
				y = SafeZoneY + SafeZoneH - 0.3;
				w = 0.1;
				h = 0.05;
				colorBackground[] = { 0.9, 0.14, 0.14, 0.9 };
			};
		};
	};
};