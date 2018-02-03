#include "vehicleDialog.inc"

class RSTF_RscVehicleDialog
{
	idd = RSTF_VEHDG_IDD;
	enableDisplay = true;
	movingEnable = false;

	class controlsBackground
	{
		class VehicleBack: RscStatic
		{
			x = SafeZoneX + SafeZoneW / 2 - 0.4;
			y = 0;

			w = 0.8;
			h = 0.5;

			colorBackground[] = { 0, 0, 0, 0.8 };
		};
	};
	class controls
	{
		class VehicleSelect: RscListNBox
		{
			idc = RSTF_VEHDG_LIST_IDC;

			x = SafeZoneX + SafeZoneW / 2 - 0.4 + 0.02;
			y = 0 + 0.02;

			w = 0.8 - 0.04;
			h = 0.5 - 0.04;

			columns[] = { 0, 0.8 };
		};

		class ButtonCancel: RscButton
		{
			idc = RSTF_VEHDG_CANCEL_IDC;

			x = SafeZoneX + SafeZoneW / 2 - 0.4;
			y = 0.5 + 0.005;

			w = 0.10;
			h = 0.08;

			text = "Cancel";
		};

		class ButtonBuy: RscButton
		{
			idc = RSTF_VEHDG_BUY_IDC;

			x = SafeZoneX + SafeZoneW / 2 + 0.4 - 0.10;
			y = 0.5 + 0.005;

			w = 0.10;
			h = 0.08;

			text = "Buy";
		};
	};
};