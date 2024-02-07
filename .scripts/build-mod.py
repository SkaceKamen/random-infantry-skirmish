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
modBuildPath = os.path.join(modTargetPath, "RIS_module")
modMissionsPath = os.path.join(modBuildPath, "missions")
modBuildConfigPath = os.path.join(modBuildPath, "config.cpp")
includePath = os.path.join(os.path.dirname(__file__), "include.txt")

modFunctionsPath = os.path.join(risPath, "fnc")
modDialogsPath = os.path.join(risPath, "dialogs")
modLibPath = os.path.join(risPath, "lib")

if os.path.exists(modTargetPath):
  shutil.rmtree(modTargetPath)

shutil.copytree(modSourcePath, modTargetPath)
shutil.copytree(modFunctionsPath, os.path.join(modBuildPath, "fnc"))
shutil.copytree(modDialogsPath, os.path.join(modBuildPath, "dialogs"))
shutil.copytree(modLibPath, os.path.join(modBuildPath, "lib"))
shutil.copytree(os.path.join(risPath, "compositions"), os.path.join(modBuildPath, "compositions"))

shutil.copy(os.path.join(risPath, "modes.hpp"), os.path.join(modBuildPath, "modes.hpp"))
shutil.copy(os.path.join(risPath, "options-menu.hpp"), os.path.join(modBuildPath, "options-menu.hpp"))
shutil.copy(os.path.join(risPath, "supports.hpp"), os.path.join(modBuildPath, "supports.hpp"))
shutil.copy(os.path.join(risPath, "compositions.hpp"), os.path.join(modBuildPath, "compositions.hpp"))
shutil.copy(os.path.join(risPath, "scripts.inc"), os.path.join(modBuildPath, "scripts.inc"))
shutil.copy(os.path.join(risPath, "random.paa"), os.path.join(modBuildPath, "random.paa"))
shutil.copy(os.path.join(risPath, "rstf-logo.paa"), os.path.join(modBuildPath, "rstf-logo.paa"))
shutil.copy(os.path.join(risPath, "arrow-white.paa"), os.path.join(modBuildPath, "arrow-white.paa"))

def fixIncludePaths(path):
	with open(path, "r") as f:
		lines = f.readlines()
	with open(path, "w") as f:
		for line in lines:
			if "file = \"" in line:
				f.write(line.replace("file = \"", "file = \"\\RIS\\"))
			else:
				f.write(line)

def fixConfigUsage(path):
	with open(path, "r") as f:
		everything = f.read()
	with open(path, "w") as f:
			f.write(everything.replace("missionConfigFile", "configFile"))

def fixRisPrefix(path):
	with open(path, "r") as f:
		everything = f.read()
	with open(path, "w") as f:
			f.write(everything.replace("RIS_fnc_", "RISM_fnc_"))

def fixImagesUsage(path):
	with open(path, "r") as f:
		everything = f.read()
	with open(path, "w") as f:
			f.write(
				everything
					.replace("'arrow-white.paa'", "'\\RIS\\arrow-white.paa'")
					.replace("'rstf-logo.paa'", "'\\RIS\\rstf-logo.paa'")
			)

fixIncludePaths(os.path.join(modBuildPath, "fnc/functions.hpp"))
fixIncludePaths(os.path.join(modBuildPath, "fnc/gc.hpp"))
fixIncludePaths(os.path.join(modBuildPath, "fnc/ui.hpp"))
fixIncludePaths(os.path.join(modBuildPath, "lib/zui/zui-functions.hpp"))

for file in glob.glob(os.path.join(modBuildPath, "**", "*"), recursive=True):
	if file.endswith(".hpp"):
		fixImagesUsage(file)
	if file.endswith(".sqf"):
		fixImagesUsage(file)
		fixConfigUsage(file)

# os.makedirs(modMissionsPath)
os.makedirs(modAddonsPath)

shutil.copy(os.path.join(risPath, "random.paa"), os.path.join(modBuildPath, "random.paa"))

subprocess.check_call(
	[ADDON_BUILDER, modBuildPath, os.path.join(modAddonsPath), "-prefix=RIS", "-include=%s" % includePath]
)

#shutil.move(os.path.join(modAddonsPath, 'MPScenarios.pbo'), os.path.join(modAddonsPath, 'ris_missions.pbo'))
shutil.rmtree(modBuildPath)
