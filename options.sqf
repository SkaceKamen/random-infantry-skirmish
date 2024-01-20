//Default factions
FRIENDLY_FACTIONS = [ "BLU_F" ];
NEUTRAL_FACTIONS = [ "IND_C_F","IND_G_F","BLU_G_F","OPF_G_F" ];
ENEMY_FACTIONS = [ "OPF_F" ];

//List of banned weapons and soldiers
RSTF_WEAPONS_BANNED = [];
// TODO: Add more default banned - usually crews and pilots
RSTF_SOLDIERS_BANNED = [
	"B_diver_F",
	"B_diver_exp_F",
	"B_diver_TL_F",
	"O_diver_F",
	"O_diver_exp_F",
	"O_diver_TL_F",
	"I_diver_F",
	"I_diver_exp_F",
	"I_diver_TL_F",
	"B_Helipilot_F", // helicopter pilot 
	"B_crew_F", // crewman 
	//"B_officer_F", // officer 
	"B_Pilot_F", // pilot 
	"B_helicrew_F", // helicopter crew 
	"B_diver_F", // assault diver 
	"B_diver_TL_F", // diver team leader 
	"B_diver_exp_F", // diver explosive specialist 
	"C_man_pilot_F", // pilot 
	//"I_G_officer_F", // officer 
	//"B_G_officer_F", // officer 
	//"O_G_officer_F", // officer 
	"I_crew_F", // crewman 
	"I_helipilot_F", // helicopter pilot 
	"I_pilot_F", // pilot 
	"I_helicrew_F", // helicopter crew 
	//"I_officer_F", // officer 
	"I_diver_F", // assault diver 
	"I_diver_exp_F", // diver explosive specialist 
	"I_diver_TL_F", // diver team leader 
	//"O_officer_F", // officer 
	"O_helipilot_F", // helicopter pilot 
	"O_crew_F", // crewman 
	"O_Pilot_F", // pilot 
	"O_helicrew_F", // helicopter crew 
	"O_diver_F", // assault diver 
	"O_diver_TL_F", // diver team leader 
	"O_diver_exp_F", // diver explosive specialist 
	"C_Driver_1_F", // driver (fuel) 
	"I_C_Pilot_F", // pilot 
	"I_C_Helipilot_F", // helicopter pilot 
	"B_T_Crew_F", // crewman 
	"B_T_Helicrew_F", // helicopter crew 
	"B_T_Helipilot_F", // helicopter pilot 
	//"B_T_Officer_F", // officer 
	"B_T_Pilot_F", // pilot 
	"B_T_Diver_F", // assault diver 
	"B_T_Diver_Exp_F", // diver explosive specialist 
	"B_T_Diver_TL_F", // diver team leader 
	"O_T_Crew_F", // crewman 
	"O_T_Helicrew_F", // helicopter crew 
	"O_T_Helipilot_F", // helicopter pilot 
	//"O_T_Officer_F", // officer 
	"O_T_Pilot_F", // pilot 
	"O_T_Diver_F", // assault diver 
	"O_T_Diver_Exp_F", // diver explosive specialist 
	"O_T_Diver_TL_F", // diver team leader 
	"B_Deck_Crew_F", // deck crew 
	"B_Fighter_Pilot_F", // fighter pilot 
	"O_Fighter_Pilot_F", // fighter pilot 
	"I_Fighter_Pilot_F", // fighter pilot 
	"C_IDAP_Pilot_01_F", // pilot 
	"B_W_Crew_F", // crewman 
	"B_W_Helicrew_F", // helicopter crew 
	"B_W_Helipilot_F", // helicopter pilot 
	//"B_W_Officer_F", // officer 
	//"I_E_Officer_F", // officer 
	"I_E_Soldier_MP_F", // military police officer 
	"I_E_Crew_F", // crewman 
	"I_E_Helipilot_F", // helicopter pilot 
	"I_E_Helicrew_F", // helicopter crew 
	"B_Officer_Parade_F", // officer (parade dress) 
	"B_Officer_Parade_Veteran_F", // officer (veteran, parade dress) 
	"I_Officer_Parade_F", // officer (parade dress) 
	"I_Officer_Parade_Veteran_F", // officer (veteran, parade dress) 
	"I_E_Officer_Parade_F", // officer (parade dress) 
	"I_E_Officer_Parade_Veteran_F", // officer (veteran, parade dress) 
	"O_Officer_Parade_F", // officer (parade dress) 
	"O_Officer_Parade_Veteran_F", // officer (veteran, parade dress) 
	"rhs_msv_officer_armored", // officer (armored) 
	"rhs_msv_officer", // officer 
	"rhs_msv_driver_armored", // driver (armored) 
	"rhs_msv_driver", // driver 
	"rhs_msv_crew", // crew 
	"rhs_msv_armoredcrew", // crew (armored) 
	"rhs_msv_combatcrew", // crew (combat) 
	"rhs_msv_crew_commander", // crew commander 
	"rhs_pilot", // pilot 
	"rhs_pilot_tan", // pilot (tan) 
	"rhs_pilot_combat_heli", // pilot (combat helicopter) 
	"rhs_pilot_transport_heli", // pilot (transport) 
	"rhs_msv_emr_officer_armored", // officer (armored) 
	"rhs_msv_emr_officer", // officer 
	"rhs_msv_emr_driver_armored", // driver (armored) 
	"rhs_msv_emr_driver", // driver 
	"rhs_msv_emr_crew", // crew 
	"rhs_msv_emr_armoredcrew", // crew (armored) 
	"rhs_msv_emr_combatcrew", // crew (combat) 
	"rhs_msv_emr_crew_commander", // crew commander 
	"rhs_vdv_officer_armored", // officer (armored) 
	"rhs_vdv_officer", // officer 
	"rhs_vdv_driver_armored", // driver (armored) 
	"rhs_vdv_driver", // driver 
	"rhs_vdv_crew", // crew 
	"rhs_vdv_armoredcrew", // crew (armored) 
	"rhs_vdv_combatcrew", // crew (combat) 
	"rhs_vdv_crew_commander", // crew commander 
	"rhs_vdv_des_officer_armored", // officer (armored) 
	"rhs_vdv_des_officer", // officer 
	"rhs_vdv_des_driver_armored", // driver (armored) 
	"rhs_vdv_des_driver", // driver 
	"rhs_vdv_des_crew", // crew 
	"rhs_vdv_des_armoredcrew", // crew (armored) 
	"rhs_vdv_des_combatcrew", // crew (combat) 
	"rhs_vdv_des_crew_commander", // crew commander 
	"rhs_vdv_flora_officer_armored", // officer (armored) 
	"rhs_vdv_flora_officer", // officer 
	"rhs_vdv_flora_driver_armored", // driver (armored) 
	"rhs_vdv_flora_driver", // driver 
	"rhs_vdv_flora_crew", // crew 
	"rhs_vdv_flora_crew_commander", // crew commander 
	"rhs_vdv_flora_armoredcrew", // crew (armored) 
	"rhs_vdv_flora_combatcrew", // crew (combat) 
	"rhs_vdv_mflora_officer_armored", // officer (armored) 
	"rhs_vdv_mflora_officer", // officer 
	"rhs_vdv_mflora_driver_armored", // driver (armored) 
	"rhs_vdv_mflora_driver", // driver 
	"rhs_vdv_mflora_crew", // crew 
	"rhs_vdv_mflora_crew_commander", // crew commander 
	"rhs_vdv_mflora_armoredcrew", // crew (armored) 
	"rhs_vdv_mflora_combatcrew", // crew (combat) 
	"rhs_vdv_recon_officer_armored", // officer (armored) 
	"rhs_vdv_recon_officer", // officer 
	"rhs_vmf_emr_officer_armored", // officer (armored) 
	"rhs_vmf_emr_officer", // officer 
	"rhs_vmf_emr_driver_armored", // driver (armored) 
	"rhs_vmf_emr_driver", // driver 
	"rhs_vmf_emr_crew", // crew 
	"rhs_vmf_emr_crew_commander", // crew commander 
	"rhs_vmf_emr_armoredcrew", // crew (armored) 
	"rhs_vmf_emr_combatcrew", // crew (combat) 
	"rhs_vmf_flora_officer_armored", // officer (armored) 
	"rhs_vmf_flora_officer", // officer 
	"rhs_vmf_flora_driver_armored", // driver (armored) 
	"rhs_vmf_flora_driver", // driver 
	"rhs_vmf_flora_crew", // crew 
	"rhs_vmf_flora_crew_commander", // crew commander 
	"rhs_vmf_flora_armoredcrew", // crew (armored) 
	"rhs_vmf_flora_combatcrew", // crew (combat) 
	"rhs_vmf_recon_officer_armored", // officer (armored) 
	"rhs_vmf_recon_officer", // officer 
	"rhs_rva_crew", // driver 
	"rhs_rva_crew_armored", // driver (armored) 
	"rhs_rva_crew_officer", // officer 
	"rhs_rva_crew_officer_armored", // officer (armored) 
	"rhsusf_army_ocp_officer", // officer 
	"rhsusf_army_ocp_fso", // fire support officer 
	"rhsusf_army_ocp_crewman", // crew 
	"rhsusf_army_ocp_combatcrewman", // crew (combat) 
	"rhsusf_army_ocp_driver", // driver 
	"rhsusf_army_ocp_driver_armored", // driver (armored) 
	"rhsusf_army_ocp_helipilot", // helicopter pilot 
	"rhsusf_army_ocp_ah64_pilot", // ah-64 pilot 
	"rhsusf_army_ocp_helicrew", // helicopter crew 
	"rhsusf_army_ucp_officer", // officer 
	"rhsusf_army_ucp_fso", // fire support officer 
	"rhsusf_army_ucp_crewman", // crew 
	"rhsusf_army_ucp_combatcrewman", // crew (combat) 
	"rhsusf_army_ucp_driver", // driver 
	"rhsusf_army_ucp_driver_armored", // driver (armored) 
	"rhsusf_army_ucp_helipilot", // helicopter pilot 
	"rhsusf_army_ucp_ah64_pilot", // ah-64 pilot 
	"rhsusf_army_ucp_helicrew", // helicopter crew 
	"rhsusf_usmc_marpat_wd_officer", // officer 
	"rhsusf_usmc_marpat_wd_fso", // fire support officer 
	"rhsusf_usmc_marpat_wd_crewman", // crew 
	"rhsusf_usmc_marpat_wd_combatcrewman", // crew (combat) 
	"rhsusf_usmc_marpat_wd_driver", // driver 
	"rhsusf_usmc_marpat_wd_helipilot", // helicopter pilot 
	"rhsusf_usmc_marpat_wd_helicrew", // helicopter crew 
	"rhsusf_usmc_marpat_d_officer", // officer 
	"rhsusf_usmc_marpat_d_fso", // fire support officer 
	"rhsusf_usmc_marpat_d_crewman", // crew 
	"rhsusf_usmc_marpat_d_combatcrewman", // crew (combat) 
	"rhsusf_usmc_marpat_d_driver", // driver 
	"rhsusf_usmc_marpat_d_helipilot", // helicopter pilot 
	"rhsusf_usmc_marpat_d_helicrew", // helicopter crew 
	"rhsusf_usmc_lar_marpat_wd_crewman", // crew 
	"rhsusf_usmc_lar_marpat_wd_combatcrewman", // crew (combat) 
	"rhsusf_usmc_lar_marpat_wd_machinegunner", // crew (m240b) 
	"rhsusf_usmc_lar_marpat_d_crewman", // crew 
	"rhsusf_usmc_lar_marpat_d_combatcrewman", // crew (combat) 
	"rhsusf_usmc_lar_marpat_d_machinegunner", // crew (m240b) 
	"rhsusf_usmc_recon_marpat_wd_officer", // officer 
	"rhsusf_usmc_recon_marpat_d_officer", // officer 
	"rhsusf_socom_swcc_crewman", // crew 
	"rhsusf_socom_swcc_officer", // officer 
	"rhsusf_airforce_jetpilot", // jet pilot 
	"rhsusf_airforce_pilot", // pilot 
	"rhsgref_cdf_ngd_officer", // officer 
	"rhsgref_cdf_ngd_crew", // crew 
	"rhsgref_cdf_reg_officer", // officer 
	"rhsgref_cdf_reg_crew", // crew 
	"rhsgref_cdf_reg_crew_commander", // crew commander 
	"rhsgref_cdf_air_pilot", // pilot 
	"rhsgref_cdf_para_officer", // officer 
	"rhsgref_cdf_para_crew", // crew 
	"rhsgref_cdf_b_ngd_officer", // officer 
	"rhsgref_cdf_b_ngd_crew", // crew 
	"rhsgref_cdf_b_reg_officer", // officer 
	"rhsgref_cdf_b_reg_crew", // crew 
	"rhsgref_cdf_b_reg_crew_commander", // crew commander 
	"rhsgref_cdf_b_air_pilot", // pilot 
	"rhsgref_cdf_b_para_officer", // officer 
	"rhsgref_cdf_b_para_crew", // crew 
	"rhsgref_cdf_un_officer", // officer 
	"rhsgref_cdf_un_crew", // crew 
	"rhsgref_cdf_un_pilot", // pilot 
	"rhsgref_nat_crew", // crew 
	"rhsgref_nat_pmil_crew", // crew 
	"rhsgref_ins_squadleader", // officer 
	"rhsgref_ins_crew", // crew 
	"rhsgref_ins_pilot", // pilot 
	"rhsgref_ins_g_squadleader", // officer 
	"rhsgref_ins_g_crew", // crew 
	"rhsgref_ins_g_pilot", // pilot 
	"rhsgref_hidf_crewman", // crew 
	"rhsgref_hidf_helipilot", // helicopter pilot 
	"rhsgref_hidf_boat_driver", // driver (boat) 
	"rhsgref_tla_crew", // crewman 
	"rhsgref_tla_g_crew", // crewman 
	"rhssaf_airforce_pilot_transport_heli", // pilot (helicopter) 
	"rhssaf_airforce_pilot_mig29", // mig-29 pilot 
	"rhssaf_airforce_o_pilot_transport_heli", // pilot (helicopter) 
	"rhssaf_airforce_o_pilot_mig29", // mig-29 pilot 
	"rhssaf_army_m10_digital_crew", // crewman (light) 
	"rhssaf_army_m10_digital_crew_armored", // crewman (armored) 
	"rhssaf_army_m10_digital_crew_armored_nco", // crew commander (armored) 
	"rhssaf_army_m10_digital_officer", // officer 
	"rhssaf_army_o_m10_digital_crew", // crewman (light) 
	"rhssaf_army_o_m10_digital_crew_armored", // crewman (armored) 
	"rhssaf_army_o_m10_digital_officer", // officer 
	"rhssaf_army_m93_oakleaf_summer_crew", // crewman (light) 
	"rhssaf_army_m93_oakleaf_summer_officer", // officer 
	"rhssaf_army_o_m93_oakleaf_summer_crew", // crewman (light) 
	"rhssaf_army_o_m93_oakleaf_summer_officer", // officer 
	"rhssaf_army_m10_para_crew", // crewman (light) 
	"rhssaf_army_m10_para_officer", // officer 
	"rhssaf_army_o_m10_para_crew", // crewman (light) 
	"rhssaf_army_o_m10_para_officer", // officer 
	"rhssaf_un_m10_digital_desert_crew", // crewman (light) 
	"rhssaf_un_m10_digital_desert_officer", // officer 
	"rhssaf_un_m10_digital_crew", // crewman (light) 
	"rhssaf_un_m10_digital_officer", // officer 
	"CUP_B_BAF_Soldier_Crew_DPM", // crewman 
	"CUP_B_BAF_Soldier_DeckCrew_DPM", // deck crew 
	"CUP_B_BAF_Soldier_FighterPilot_DPM", // fighter pilot 
	"CUP_B_BAF_Soldier_Helicrew_DPM", // helicopter crew 
	"CUP_B_BAF_Soldier_Helipilot_DPM", // helicopter pilot 
	"CUP_B_BAF_Soldier_Officer_DPM", // officer 
	"CUP_B_BAF_Soldier_Pilot_DPM", // pilot 
	"CUP_B_BAF_Soldier_Diver_DPM", // diver (woodland) 
	"CUP_B_BAF_Soldier_Crew_DDPM", // crewman 
	"CUP_B_BAF_Soldier_DeckCrew_DDPM", // deck crew 
	"CUP_B_BAF_Soldier_FighterPilot_DDPM", // fighter pilot 
	"CUP_B_BAF_Soldier_Helicrew_DDPM", // helicopter crew 
	"CUP_B_BAF_Soldier_Helipilot_DDPM", // helicopter pilot 
	"CUP_B_BAF_Soldier_Officer_DDPM", // officer 
	"CUP_B_BAF_Soldier_Pilot_DDPM", // pilot 
	"CUP_B_BAF_Soldier_Diver_DDPM", // diver (desert) 
	"CUP_B_BAF_Soldier_Crew_MTP", // crewman 
	"CUP_B_BAF_Soldier_DeckCrew_MTP", // deck crew 
	"CUP_B_BAF_Soldier_FighterPilot_MTP", // fighter pilot 
	"CUP_B_BAF_Soldier_Helicrew_MTP", // helicopter crew 
	"CUP_B_BAF_Soldier_Helipilot_MTP", // helicopter pilot 
	"CUP_B_BAF_Soldier_Officer_MTP", // officer 
	"CUP_B_BAF_Soldier_Pilot_MTP", // pilot 
	"CUP_B_BAF_Soldier_Diver_MTP", // assault diver 
	"CUP_B_GER_Crew", // crewman 
	"CUP_B_GER_HPilot", // helicopter pilot 
	"CUP_B_GER_Fleck_Crew", // crewman 
	"CUP_B_GER_Fleck_HPilot", // helicopter pilot 
	"CUP_I_GUE_Crew", // crewman 
	"CUP_I_GUE_Pilot", // pilot 
	"CUP_I_PMC_Crew", // tactical driver 
	"CUP_I_PMC_Pilot", // tactical pilot 
	"CUP_I_PMC_Winter_Crew", // tactical driver 
	"CUP_I_PMC_Winter_Pilot", // tactical pilot 
	"CUP_O_RU_Pilot", // pilot 
	"CUP_O_RU_Crew", // crewman 
	"CUP_O_RU_Officer", // officer 
	"CUP_O_RU_Pilot_EMR", // pilot 
	"CUP_O_RU_Crew_EMR", // crewman 
	"CUP_O_RU_Officer_EMR", // officer 
	"CUP_O_RU_Pilot_VDV", // pilot 
	"CUP_O_RU_Crew_VDV", // crewman 
	"CUP_O_RU_Officer_VDV", // officer 
	"CUP_O_RU_Pilot_VDV_EMR", // pilot 
	"CUP_O_RU_Crew_VDV_EMR", // crewman 
	"CUP_O_RU_Officer_VDV_EMR", // officer 
	"CUP_O_RUS_Commander", // spetsnaz officer 
	"CUP_O_RUS_Commander_Autumn", // spetsnaz officer 
	"CUP_O_RU_Pilot_M_EMR", // pilot 
	"CUP_O_RU_Pilot_VDV_M_EMR", // pilot 
	"CUP_O_RU_Officer_M_EMR_V2", // officer 
	"CUP_O_RU_Soldier_Crew_M_EMR_V2", // crewman 
	"CUP_O_RU_Officer_M_VDV_EMR_V2", // officer 
	"CUP_O_RU_Soldier_Crew_M_VDV_EMR_V2", // crewman 
	"CUP_O_RU_Officer_M_BeigeDigital", // officer 
	"CUP_O_RU_Soldier_Crew_M_BeigeDigital", // crewman 
	"CUP_O_TK_Officer", // officer 
	"CUP_O_TK_Crew", // crewman 
	"CUP_O_TK_Pilot", // pilot 
	"CUP_B_USMC_Officer", // officer 
	"CUP_B_USMC_Pilot", // pilot 
	"CUP_B_USMC_Crew", // crewman 
	"CUP_B_USNavy_LHD_Crew_Blue", // lhd crew (blue) 
	"CUP_B_USNavy_LHD_Crew_Brown", // lhd crew (brown) 
	"CUP_B_USNavy_LHD_Crew_Green", // lhd crew (green) 
	"CUP_B_USNavy_LHD_Crew_Red", // lhd crew (red) 
	"CUP_B_USNavy_LHD_Crew_Violet", // lhd crew (violet) 
	"CUP_B_USNavy_LHD_Crew_White", // lhd crew (white) 
	"CUP_B_USNavy_LHD_Crew_Yellow", // lhd crew (yellow) 
	"CUP_B_USMC_Officer_des", // officer 
	"CUP_B_USMC_Pilot_des", // pilot 
	"CUP_B_USMC_Crew_des", // crewman 
	"CUP_B_USMC_Crewman_FROG_WDL", // crewman 
	"CUP_B_USMC_Officer_FROG_WDL", // officer 
	"CUP_B_USMC_Crewman_FROG_DES", // crewman 
	"CUP_B_USMC_Officer_FROG_DES", // officer 
	"CUP_C_C_Pilot_01", // pilot 
	"CUP_C_R_Pilot_01", // pilot 
	"CUP_B_CZ_Crew_DES", // crewman 
	"CUP_B_CZ_Officer_DES", // officer 
	"CUP_B_CZ_Pilot_DES", // pilot 
	"CUP_B_CZ_Crew_WDL", // crewman 
	"CUP_B_CZ_Officer_WDL", // officer 
	"CUP_B_CZ_Pilot_WDL", // pilot 
	"CUP_B_CDF_Officer_MNT", // officer 
	"CUP_B_CDF_Pilot_MNT", // pilot 
	"CUP_B_CDF_Crew_MNT", // crewman 
	"CUP_B_CDF_Officer_DST", // officer 
	"CUP_B_CDF_Pilot_DST", // pilot 
	"CUP_B_CDF_Crew_DST", // crewman 
	"CUP_B_CDF_Officer_FST", // officer 
	"CUP_B_CDF_Pilot_FST", // pilot 
	"CUP_B_CDF_Crew_FST", // crewman 
	"CUP_B_CDF_Officer_SNW", // officer 
	"CUP_B_CDF_Pilot_SNW", // pilot 
	"CUP_B_CDF_Crew_SNW", // crewman 
	"CUP_I_UN_CDF_Officer_MNT", // officer 
	"CUP_I_UN_CDF_Pilot_MNT", // pilot 
	"CUP_I_UN_CDF_Crew_MNT", // crewman 
	"CUP_I_UN_CDF_Officer_DST", // officer 
	"CUP_I_UN_CDF_Pilot_DST", // pilot 
	"CUP_I_UN_CDF_Crew_DST", // crewman 
	"CUP_I_UN_CDF_Officer_FST", // officer 
	"CUP_I_UN_CDF_Pilot_FST", // pilot 
	"CUP_I_UN_CDF_Crew_FST", // crewman 
	"CUP_O_INS_Officer", // officer 
	"CUP_O_INS_Crew", // crewman 
	"CUP_O_INS_Pilot", // pilot 
	"CUP_I_RACS_Officer", // officer 
	"CUP_I_RACS_Crew", // crewman 
	"CUP_I_RACS_Pilot", // pilot 
	"CUP_I_RACS_Officer_Urban", // officer 
	"CUP_I_RACS_Officer_wdl", // officer 
	"CUP_I_RACS_Officer_Mech", // officer 
	"CUP_O_sla_Officer", // officer 
	"CUP_O_sla_Crew", // crewman 
	"CUP_O_sla_Pilot", // pilot 
	"CUP_O_sla_Officer_militia", // militia officer 
	"CUP_O_sla_Officer_urban", // officer 
	"CUP_O_sla_Officer_desert", // officer 
	"CUP_B_US_Officer_UCP", // officer 
	"CUP_B_US_Crew_UCP", // crewman 
	"CUP_B_US_Officer_OCP", // officer 
	"CUP_B_US_Crew_OCP", // crewman 
	"CUP_B_US_Officer_OEFCP", // officer 
	"CUP_B_US_Crew_OEFCP", // crewman 
	"CUP_B_US_Pilot", // pilot 
	"CUP_B_US_Pilot_Light", // pilot (unarmed) 
	"CUP_B_HIL_Officer_Res", // officer 
	"CUP_B_HIL_Officer", // officer 
	"CUP_B_HIL_Crew", // crewman 
	"CUP_B_HIL_Pilot", // pilot 
	"CUP_B_HIL_Diver_MP5_SF", // diver (mp5) 
	"CUP_B_HIL_Diver_MP7_SF" // diver (mp7)"
];

//Where to spawn
RSTF_SPAWN_TYPE = RSTF_SPAWN_CLOSEST;

// Currently selected gamemode in modes list
RSTF_MODE_SELECTED = "Push";

//Randomize weapons ? (turn off if you're using mod)
RSTF_RANDOMIZE_WEAPONS = false;

//Randomize only weapons from origin faction
RSTF_RANDOMIZE_WEAPONS_RESTRICT = false;

RSTF_PLAYER_EQUIPMENT = [];
RSTF_CUSTOM_EQUIPMENT = false;

//Groups per side
RSTF_LIMIT_GROUPS = 5;
//Units per gruop
RSTF_LIMIT_UNITS = 4;
//Time to spawn new units
RSTF_LIMIT_SPAWN = 30;

// Minimum skill
RSTF_SKILL_MIN = 0.5;
// Maximum skill
RSTF_SKILL_MAX = 1;

// Number of neutral groups in location
RSTF_NEUTRALS_GROUPS = 5;
// Radius of neutrals placement
RSTF_NEUTRALS_RADIUS = 500;
// Number of units in neutral group
RSTF_NEUTRALS_UNITS_MIN = 1;
RSTF_NEUTRALS_UNITS_MAX = 5;

// Should neutrals be friendly with east
RSTF_NEUTRALS_EAST = true;
// Should we spawn emplacements
RSTF_NEUTRALS_EMPLACEMENTS = true;

// Score needed to win
RSTF_SCORE_LIMIT = 10000;
// Score per single kill
RSTF_SCORE_PER_KILL = 100;
// Score per teamkill
RSTF_SCORE_PER_TEAMKILL = -200;
// Score awarded for completing task
RSTF_SCORE_PER_TASK = 200;
// Score awarded for killing vehicle
RSTF_SCORE_PER_VEHICLE = 500;

// Money awarded for kill
RSTF_MONEY_PER_KILL = 100;
// Money awarded for task
RSTF_MONEY_PER_TASK = 200;
// Money per teamkill
RSTF_MONEY_PER_TEAMKILL = -200;
// Bonus for each kill of multikill
RSTF_MULTIKILL_BONUS = 50;
// Money for vehicle kill as commander
RSTF_MONEY_PER_VEHICLE_COMMANDER_ASSIST = 50;
// Money for killing vehicle
RSTF_MONEY_PER_VEHICLE_KILL = 500;

//Random weather and time
RSTF_WEATHER = 0;
RSTF_TIME = 13;

// How much more groups will enemy have
RSTF_ENEMY_ADVANTAGE_GROUPS = 0;
// How much more units prer groups will enemy have
RSTF_ENEMY_ADVANTAGE_UNITS = 0;
// Enemy score multiplier
RSTF_ENEMY_ADVANTAGE_SCORE = 1;

// Should spawn have transport vehicles
RSTF_SPAWN_TRANSPORTS = true;

// Allow voting/selecting battle position
RSTF_MAP_VOTE = true;
// Number of proposed positions, 0 for unlimited
RSTF_MAP_VOTE_COUNT = 10;
// Time in seconds to wait for votes
RSTF_MAP_VOTE_TIMEOUT = 60;

// Destroy IFV task
RSTF_TASKS_IFV_ENABLED = true;
// Clear house task
RSTF_TASKS_CLEAR_ENABLED = true;
// Destroy emplacement
RSTF_TASKS_EMP_ENABLED = true;

// Enable money system
RSTF_MONEY_ENABLED = true;

// Enable vehicles for money system
RSTF_MONEY_VEHICLES_ENABLED = true;

// Maximum number of AI vehicles per side
RSTF_MONEY_VEHICLES_AI_LIMIT = 5;
// Apply limits per vehicle class
RSTF_MONEY_VEHICLES_AI_CLASS_LIMITS = false;
// Maximum number of air AI vehicles per side
RSTF_MONEY_VEHICLES_AI_AIR_LIMIT = RSTF_MONEY_VEHICLES_AI_LIMIT;
// Maximum number of land AI vehicles per side
RSTF_MONEY_VEHICLES_AI_LAND_LIMIT = RSTF_MONEY_VEHICLES_AI_LIMIT;

// Money at start
RSTF_MONEY_START = 0;

// From wich distance is kill considered far enought to be special
RSTF_KILL_DISTANCE_BONUS = 100;

// Multiplier applied to AI money earning
RSTF_AI_MONEY_MULTIPLIER = 5;

// Money added to each AI per-side per second
RSTF_AI_MONEY_PER_SECOND = 2;

// Interval in which are points awarded to side holding objective in KOTH
RSTF_MODE_KOTH_SCORE_INTERVAL = 10;

// Score limit in KOTH
RSTF_MODE_KOTH_SCORE_LIMIT = 100;

// Display support menu hint
RSTF_HINT_SUPPORT_MENU = true;

// Show 3D vehicle markers
RSTF_UI_SHOW_VEHICLE_MARKERS = true;

// Show player feed
RSTF_UI_SHOW_PLAYER_FEED = true;

// Show player money
RSTF_UI_SHOW_PLAYER_MONEY = true;

// Show gamemode info
RSTF_UI_SHOW_GAMEMODE_SCORE = true;

// Show unit capture count in game mode if there's any
RSTF_UI_SHOW_GAMEMODE_UNIT_COUNT = true;

// Garbage collector settings
RSTF_CLEAN = true;
RSTF_CLEAN_INTERVAL = 3*60;
RSTF_CLEAN_INTERVAL_VEHICLES = 3*60;

RSTF_BUY_MENU_ACTION = 0;

// Minimal infantry spawn distance in meters
RSTF_SPAWN_DISTANCE_MIN = 350;
// Maximal infantry spawn distance in meters
RSTF_SPAWN_DISTANCE_MAX = 400;

RSTF_MODE_PUSH_SCORE_INTERVAL = 2;
RSTF_MODE_PUSH_SCORE_LIMIT = 20;
RSTF_MODE_PUSH_POINT_COUNT = 5;
// Number of defensive emplacements spawned per point
RSTF_MODE_PUSH_EMPLACEMENTS_PER_POINT = 5;
// Spawn emplacements on the first point
RSTF_MODE_PUSH_FIRST_POINT_EMPLACEMENTS = true;
// Attackers will have this much more groups
RSTF_MODE_PUSH_ATTACKERS_ADVANTAGE = 1;

// Remove un-historical items from map
RSTF_CLEAR_HISTORIC_ITEMS = false;

// Always set player as a leader of squad
RSTF_PLAYER_ALWAYS_LEADER = true;

// Enable players to buy support artillery
RSTF_ENABLE_SUPPORTS = true;

RSTF_MODE_DEFEND_SCORE_INTERVAL = 2;
RSTF_MODE_DEFEND_SCORE_LIMIT = 20;
RSTF_MODE_DEFEND_DURATION = 30*60;
RSTF_MODE_DEFEND_RADIUS = 50;

// Allow player to access AI vehicles
RSTF_SPAWN_VEHICLES_UNLOCKED = false;

// Enable AI vehicles
RSTF_AI_VEHICLES_ENABLED = true;

// Skip initial mode select screen
RSTF_SKIP_MODE_SELECT = false;

// Reuse existing groups when respawning units
RSTF_SPAWN_REUSE_GROUPS = false;

// Spawn near leader of the group when reusing existing groups
RSTF_SPAWN_AT_OWN_GROUP = true;

RSTF_DATE_YEAR = (date select 0);
RSTF_DATE_MONTH = (date select 1) - 1;
RSTF_DATE_DAY = (date select 2) - 1;

// Load default date from world config
RSTF_USE_DEFAULT_DATE = true;

// Enable players to buy AI support vehicles
RSTF_ENABLE_AI_SUPPORT_VEHICLES = true;
// Vehicle cost multiplier when buying as AI support
RSTF_AI_VEHICLE_SUPPORT_COST_MULTIPLIER = 0.75;

RSTF_VEHICLE_COST_MULTIPLIER = 1;
