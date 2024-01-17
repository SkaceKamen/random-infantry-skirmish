class RSTF_BUYABLE_SUPPORTS
{	
	class ArtillerySmoke
	{
		title = "Smoke artillery support (5x)";
		description = "5 rounds of 120mm smoke shells";
		picture = "\a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa";
		cost = 600;
		execute = "[_this#1, 'Smoke_120mm_AMOS_White', 5, 40, [1,1.5], [30,40]] call RSTF_fnc_initArtillerySupport";
	};

	class Artillery82mm
	{
		title = "82mm artillery support (10x)";
		description = "10 rounds of 82mm HE shells";
		picture = "\a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa";
		cost = 800;
		execute = "[_this#1, 'Sh_82mm_AMOS', 10, 30, [1,2], [30,40]] call RSTF_fnc_initArtillerySupport";
	};
	
	class Artillery155mmSmall
	{
		title = "155mm artillery support (5x)";
		description = "5 rounds of 155mm HE shells";
		picture = "\a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa";
		cost = 1000;
		execute = "[_this#1, 'Sh_155mm_AMOS', 5, 50, [2,2.5], [50,60]] call RSTF_fnc_initArtillerySupport";
	};

	class Artillery155mmBig
	{
		title = "155mm artillery support (10x)";
		description = "5 rounds of 155mm HE shells";
		picture = "\a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa";
		cost = 1500;
		execute = "[_this#1, 'Sh_155mm_AMOS', 10, 70, [2,2.5], [50,60]] call RSTF_fnc_initArtillerySupport";
	};

	class Artillery230mm
	{
		title = "230mm rockets support (5x)";
		description = "10 rounds of 230mm HE shells";
		picture = "\a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa";
		cost = 2000;
		execute = "[_this#1, 'R_230mm_HE', 10, 60, [1,1.5], [30,40]] call RSTF_fnc_initArtillerySupport";
	};

	class Artillery230mmCluster
	{
		title = "230mm cluster rockets support (5x)";
		description = "10 rounds of 230mm HE shells";
		picture = "\a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa";
		cost = 2500;
		execute = "[_this#1, 'R_230mm_Cluster', 10, 60, [1,1.5], [30,40]] call RSTF_fnc_initArtillerySupport";
	};

	class InfantryAmmo
	{
		title = "Infantry ammo drop";
		description = "Drops infantry ammo crate";
		picture = "\a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa";
		cost = 500;
		execute = "[_this#1] call RSTF_fnc_initSupplyDrop";
	};

	class ArsenalBox
	{
		title = "Arsenal box";
		description = "Drops infantry ammo crate";
		picture = "\a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa";
		cost = 1500;
		execute = "[_this#1] call RSTF_fnc_initSupplyDrop";
	};

	class VehicleAmmo
	{
		title = "Vehicle ammo drop";
		description = "Drops vehicle ammo crate";
		picture = "\a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa";
		cost = 2000;
		execute = "[_this#1] call RSTF_fnc_initSupplyDrop";
	};
};
