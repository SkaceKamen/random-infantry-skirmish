#include "vehicleDialog.inc"

class RSTF_VehicleDialog_VehicleContainer: RscStatic
{
	colorBackground[] = { 0, 0, 0, 0.5 };

	w = RSTF_VEHDG_VEH_W;
	h = RSTF_VEHDG_VEH_H;

	fade = 1;
};

class RSTF_VehicleDialog_VehicleImage: RscPictureKeepAspect
{
	w = RSTF_VEHDG_VEH_PIC_W;
	h = RSTF_VEHDG_VEH_PIC_H;

	fade = 1;
};

class RSTF_VehicleDialog_VehicleName: RscStatic
{
	w = RSTF_VEHDG_VEH_TITLE_W;
	h = RSTF_VEHDG_VEH_TITLE_H;
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * 1.2";

	fade = 1;
};

class RSTF_VehicleDialog_VehicleDesc: RscStructuredText
{
	w = RSTF_VEHDG_VEH_DESC_W;
	h = RSTF_VEHDG_VEH_DESC_H;
	Size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * 0.8";
	class Attributes
	{
		font = "PuristaMedium";
		color = "#cccccc";
		align = "left";
		shadow = 0;
	};

	fade = 1;
};

class RSTF_VehicleDialog_VehicleCost: RscStatic
{
	w = RSTF_VEHDG_VEH_PRICE_W;
	h = RSTF_VEHDG_VEH_PRICE_H;

	fade = 1;
};

class RSTF_VehicleDialog_VehicleBuy: RscButton
{
	w = RSTF_VEHDG_VEH_BUY_W;
	h = RSTF_VEHDG_VEH_BUY_H;
	text = "BUY";

	fade = 1;
};

class RSTF_RscVehicleDialog
{
	idd = RSTF_VEHDG_IDD;
	enableDisplay = true;
	movingEnable = false;

	class controlsBackground
	{
		class VehicleBack: RscStatic
		{
			x = RSTF_VEHDG_LIST_X - RSTF_VEHDG_LIST_PADDING;
			y = RSTF_VEHDG_LIST_Y - RSTF_VEHDG_LIST_PADDING;

			w = RSTF_VEHDG_LIST_W + RSTF_VEHDG_LIST_PADDING * 2;
			h = RSTF_VEHDG_LIST_H + RSTF_VEHDG_LIST_PADDING * 2;

			colorBackground[] = { 0, 0, 0, 0.5 };
		};
	};
	class controls
	{
		class VehicleSelect: RscControlsGroup
		{
			idc = RSTF_VEHDG_LIST_IDC;

			x = RSTF_VEHDG_LIST_X;
			y = RSTF_VEHDG_LIST_Y;

			w = RSTF_VEHDG_LIST_W;
			h = RSTF_VEHDG_LIST_H;
		};

		class ButtonCancel: RscButton
		{
			idc = RSTF_VEHDG_CANCEL_IDC;

			x = RSTF_VEHDG_CANCEL_X;
			y = RSTF_VEHDG_CANCEL_Y;

			w = RSTF_VEHDG_CANCEL_W;
			h = RSTF_VEHDG_CANCEL_H;

			text = "Cancel";
		};
	};
};