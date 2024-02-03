"""
This script builds a mod version of the RIS missions
"""

import shutil
import glob
import os
import subprocess

ADDON_BUILDER = 'c:\\Program Files (x86)\\Steam\\steamapps\\common\\Arma 3 Tools\\AddonBuilder\\AddonBuilder.exe'

risPath = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
missionsPath = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "RIS-Build.%s"))
dataPath = os.path.join(os.path.dirname(__file__), "data")
modSourcePath = os.path.join(dataPath, "mod")
modTargetPath = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "@RIS"))
modAddonsPath = os.path.join(modTargetPath, "AddOns")
modBuildPath = os.path.join(modTargetPath, "ris-missions")
modMissionsPath = os.path.join(modBuildPath, "missions")
modBuildConfigPath = os.path.join(modBuildPath, "config.cpp")
includePath = os.path.join(os.path.dirname(__file__), "include.txt")

if os.path.exists(modTargetPath):
  shutil.rmtree(modTargetPath)

shutil.copytree(modSourcePath, modTargetPath)
# os.makedirs(modMissionsPath)
os.makedirs(modAddonsPath)

shutil.copy(os.path.join(risPath, "random.paa"), os.path.join(modBuildPath, "random.paa"))

missionsConfig = ""

for variant in glob.glob(os.path.join(risPath, ".templates", "*.sqm")):
  island = os.path.splitext(os.path.basename(variant))[0]
  missionPath = missionsPath % island

  if os.path.exists(missionPath):
    shutil.rmtree(missionPath)
  shutil.copytree(risPath, missionPath, ignore=shutil.ignore_patterns('.*', 'mission.sqm'))
  shutil.copyfile(variant, os.path.join(missionPath, 'mission.sqm'))

  modMissionPath = os.path.join(modMissionsPath, "RIS-Build.%s" % island)

  shutil.copytree(missionPath, modMissionPath)

  description = ""
  with open(os.path.join(modMissionPath, 'description.ext'), 'r') as f:
    description = f.read()
  
  with open(os.path.join(modMissionPath, 'description.ext'), 'w') as f:
    description = f.write(description.replace(
      'overviewPicture = "random.paa";',
      'overviewPicture = "RIS\\random.paa";'
    ))

  with open(os.path.join(modMissionPath, 'variables.sqf'), 'r') as f:
    variablesSqf = f.read()
	
  with open(os.path.join(modMissionPath, 'variables.sqf'), 'w') as f:
    variablesSqf = f.write(variablesSqf.replace(
      'RSTF_DEBUG = true;',
      'RSTF_DEBUG = false;'
    ))

  missionsConfig += """
			class RIS_%s
			{
				directory = "RIS\missions\RIS-Build.%s";
				risMap = "%s";
			};
  """ % (island.replace('-', ''), island, island)

configFile = """
class CfgPatches
{
	class RIS
	{
		name = "Random Infantry Skirmish";
		author = "SkaceKamen";

		requiredVersion = 1.60;
		requiredAddons[] = { "A3_Functions_F" };
		units[] = {};
		weapons[] = {};
	};
};

class CfgMissions
{
	class missions
	{
		/*
		DISABLED FOR NOW
		class RIS_Launcher
		{
			directory = "RIS\missions\RIS_Launcher.Altis";
		};
		*/

		class RIS_Missions
		{
			briefingName = "Random Infantry Skirmish";
			author = "SkaceKamen";
			description = "Collection of random dynamic skirmish missions for various maps.";

			%s
		};
	};

	class MPMissions
	{
		class RIS_Missions
		{
			briefingName = "Random Infantry Skirmish";
			author = "SkaceKamen";
			description = "Collection of random dynamic skirmish missions for various maps.";

			%s
		};
	};
};
""" % (missionsConfig, missionsConfig)

with open(modBuildConfigPath, "w") as f:
  f.write(configFile)

subprocess.check_call(
	[ADDON_BUILDER, modBuildPath, os.path.join(modAddonsPath), "-prefix=RIS", "-include=%s" % includePath],
	stdout=subprocess.DEVNULL
)

#shutil.move(os.path.join(modAddonsPath, 'MPScenarios.pbo'), os.path.join(modAddonsPath, 'ris_missions.pbo'))
shutil.rmtree(modBuildPath)
