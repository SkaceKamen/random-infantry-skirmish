#include "supportDialog.inc"

class RSTF_RscSupportDialog
{
	idd = RSTF_DIALOG_SUPPORT_IDD;
	enableDisplay = true;
	movingEnable = false;
	class controlsBackground
	{

	};
	class controls
	{
		class ButtonVehicle: RscButton {
			idc = RSTF_DIALOG_SUPPORT_VEHICLE_IDC;

			x = SafeZoneX + SafeZoneW / 2 - 0.25;
			y = 0.2;
			w = 0.5;
			h = 0.06;

			text = "Request vehicle";
		};

		class ButtonEquipment: RscButton {
			idc = RSTF_DIALOG_SUPPORT_EQUIPMENT_IDC;

			x = SafeZoneX + SafeZoneW / 2 - 0.25;
			y = 0.2 + 0.06 + 0.01;
			w = 0.5;
			h = 0.06;

			text = "Request equipment";
		};

		class ButtonSupport: RscButton {
			idc = RSTF_DIALOG_SUPPORT_SUPPORT_IDC;

			x = SafeZoneX + SafeZoneW / 2 - 0.25;
			y = 0.2 + (0.06 + 0.01) * 2;
			w = 0.5;
			h = 0.06;

			text = "Request support";
		};
	};
};