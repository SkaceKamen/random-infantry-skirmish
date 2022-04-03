#define RSTF_BTL_W 0.8
#define RSTF_BTL_H 0.6
#define RSTF_BTL_X (SafeZoneX + SafeZoneW/2 - RSTF_BTL_W/2)
#define RSTF_BTL_Y (SafeZoneY + SafeZoneH - RSTF_BTL_H)

#define RSTF_BTL_P 0.02
#define RSTF_BTL_M 0.01

#define RSTF_BTL_TITLE_H 0.05

#define RSTF_BTL_BTS_W RSTF_BTL_W
#define RSTF_BTL_BTS_H 0.07

#define RSTF_BTL_LIST_X (RSTF_BTL_X)
#define RSTF_BTL_LIST_Y (RSTF_BTL_Y + RSTF_BTL_TITLE_H + RSTF_BTL_M)
#define RSTF_BTL_LIST_W (RSTF_BTL_W)
#define RSTF_BTL_LIST_H (RSTF_BTL_H - RSTF_BTL_TITLE_H - RSTF_BTL_BTS_H - RSTF_BTL_M * 3)

#define RSTF_BTL_BTS_X (RSTF_BTL_X)
#define RSTF_BTL_BTS_Y (RSTF_BTL_LIST_Y + RSTF_BTL_LIST_H + RSTF_BTL_M)

#define RSTF_BTL_VIEWBUTTON_W (RSTF_BTL_BTS_W * 0.2)
#define RSTF_BTL_2DBUTTON_X (RSTF_BTL_BTS_X)
#define RSTF_BTL_VOTEBUTTON_X (RSTF_BTL_BTS_X + RSTF_BTL_BTS_W - RSTF_BTL_VIEWBUTTON_W)

class RSTF_RscDialogBattleSelection
{
    idd = 15;
    enableDisplay = true;
    movingEnable = false;
    class controlsBackground
    {
	};
	class controls
	{
		class map: RscMapControl
		{
			idc = 1;
			x = SafeZoneX;
			y = SafeZoneY;
			w = SafeZoneW;
			h = SafeZoneH;
		};

		class battlesContainer: RscStatic
		{
			idc = 7;
			x = RSTF_BTL_LIST_X;
			y = RSTF_BTL_LIST_Y;
			w = RSTF_BTL_LIST_W;
			h = RSTF_BTL_LIST_H;
			colorBackground[] = { 0, 0, 0, 0.8 };
		};

		class mainTitle: RscStatic
		{
			idc = 2;
			x = RSTF_BTL_X;
			y = RSTF_BTL_Y;
			w = RSTF_BTL_W;
			h = RSTF_BTL_TITLE_H;
			colorBackground[] = { TITLE_BG_RGBA };
			text = "Vote for map";
		};

		class battles: RscListNBox
		{
			idc = 3;
			x = RSTF_BTL_LIST_X + RSTF_BTL_P;
			y = RSTF_BTL_LIST_Y + RSTF_BTL_P;
			w = RSTF_BTL_LIST_W - RSTF_BTL_P*2;
			h = RSTF_BTL_LIST_H - RSTF_BTL_P*2;

			columns[] = { 0, 0.9 };
		};

		class buttonMap: RscButton
		{
			idc = 5;
			x = RSTF_BTL_2DBUTTON_X;
			y = RSTF_BTL_BTS_Y;
			w = RSTF_BTL_VIEWBUTTON_W;
			h = RSTF_BTL_BTS_H;
			text = "2D Map";
		};


		class buttonVote: RscButton
		{
			idc = 6;
			x = RSTF_BTL_VOTEBUTTON_X;
			y = RSTF_BTL_BTS_Y;
			w = RSTF_BTL_VIEWBUTTON_W;
			h = RSTF_BTL_BTS_H;
			text = "Vote";
		};

		class timeout: RscStatic
		{
			idc = 8;
			x = RSTF_BTL_BTS_X + RSTF_BTL_VIEWBUTTON_W + RSTF_BTL_M;
			y = RSTF_BTL_BTS_Y;
			w = RSTF_BTL_W - RSTF_BTL_VIEWBUTTON_W * 3 - RSTF_BTL_M * 3;
			h = RSTF_BTL_BTS_H;
			colorBackground[] = { TITLE_BG_RGBA };
			text = "";
			style = "ST_CENTER | ST_VCENTER";
		};

		class buttonEdit: RscButton
		{
			idc = 9;
			x = RSTF_BTL_VOTEBUTTON_X - RSTF_BTL_VIEWBUTTON_W - RSTF_BTL_M;
			y = RSTF_BTL_BTS_Y;
			w = RSTF_BTL_VIEWBUTTON_W;
			h = RSTF_BTL_BTS_H;
			text = "Edit";
		};
	};
};