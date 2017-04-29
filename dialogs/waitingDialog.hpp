class RSTF_RscDialogWaiting
{
    idd = 1050;
    enableDisplay = true;
    movingEnable = false;

    class controlsBackground
    {
		
	};

	class controls
	{
		class title : RscStatic
		{
			x = 0.5-0.2;
			y = 0;
			w = 0.4;
			h = 0.1;
			colorBackground[] = { "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.7 };
			text = "Waiting for host";
			style = ST_CENTER;
		};
	};
};