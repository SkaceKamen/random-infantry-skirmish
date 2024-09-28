"""
This script builds a module version
"""

import shutil
import glob
import os
import subprocess
import dotenv
import argparse

dotenv.load_dotenv()

ADDON_BUILDER = os.getenv('ADDON_BUILDER')
ADDON_SIGNER = os.getenv('ADDON_SIGNER')
ADDON_PUBLISHER = os.getenv('ADDON_PUBLISHER')
PRIVATE_KEY_PATH = os.getenv('PRIVATE_KEY_PATH')
MOD_WORKSHOP_ID = os.getenv('MOD_WORKSHOP_ID')

parser = argparse.ArgumentParser(description='Build and publish RIS module')
parser.add_argument('--publish', action='store_true', help='Publish the mod to workshop')

args = parser.parse_args()

PUBLISH = args.publish

risPath = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
dataPath = os.path.join(os.path.dirname(__file__), "data")
changelogPath = os.path.join(dataPath, "info", "changelog-mod.txt")
modSourcePath = os.path.join(dataPath, "mod")
modTargetPath = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "@RIS"))
modAddonsPath = os.path.join(modTargetPath, "AddOns")
modBuildPath = os.path.join(modTargetPath, "RIS_module")
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
			f.write(everything
					 	.replace("RSTF_fnc_", "RSTFM_fnc_")
						.replace("RSTFGC_fnc_", "RSTFMGC_fnc_")
						.replace("RSTFUI_fnc_", "RSTFMUI_fnc_")
					)
			
def fixRisFunction(path):
	with open(path, "r") as f:
		everything = f.read()
	with open(path, "w") as f:
			f.write(everything
					 	.replace("class RSTF\n{", "class RSTFM\n{")
						.replace("class RSTFGC\n{", "class RSTFMGC\n{")
						.replace("class RSTFUI\n{", "class RSTFMUI\n{")
			)

def fixImagesUsage(path):
	with open(path, "r") as f:
		everything = f.read()
	with open(path, "w") as f:
			f.write(
				everything
					.replace("'arrow-white.paa'", "'\\RIS\\arrow-white.paa'")
					.replace('"arrow-white.paa"', '"\\RIS\\arrow-white.paa"')
					.replace("'rstf-logo.paa'", "'\\RIS\\rstf-logo.paa'")
					.replace('"rstf-logo.paa"', '"\\RIS\\rstf-logo.paa"')
			)

fixIncludePaths(os.path.join(modBuildPath, "fnc/functions.hpp"))
fixIncludePaths(os.path.join(modBuildPath, "fnc/gc.hpp"))
fixIncludePaths(os.path.join(modBuildPath, "fnc/ui.hpp"))
fixIncludePaths(os.path.join(modBuildPath, "lib/zui/zui-functions.hpp"))

for file in glob.glob(os.path.join(modBuildPath, "**", "*"), recursive=True):
	if file.endswith(".hpp"):
		fixImagesUsage(file)
		fixRisPrefix(file)
		fixRisFunction(file)
	if file.endswith(".sqf"):
		fixImagesUsage(file)
		fixConfigUsage(file)
		fixRisPrefix(file)

# os.makedirs(modMissionsPath)
os.makedirs(modAddonsPath)

shutil.copy(os.path.join(risPath, "random.paa"), os.path.join(modBuildPath, "random.paa"))

print("Building mod...")

subprocess.check_call(
	[ADDON_BUILDER, modBuildPath, os.path.join(modAddonsPath), "-prefix=RIS", "-include=%s" % includePath]
)

print("Signing mod...")

subprocess.check_call(
	[ADDON_SIGNER, PRIVATE_KEY_PATH, os.path.join(modAddonsPath, "RIS_module.pbo")]
)

print("Cleaning up...")

shutil.rmtree(modBuildPath)

if PUBLISH:
	print("Publishing mod...")

	if MOD_WORKSHOP_ID is None or len(MOD_WORKSHOP_ID) == 0:
		raise Exception("MOD_WORKSHOP_ID is not set")

	subprocess.check_call(
		[ADDON_PUBLISHER, "update", "/id:%s" % MOD_WORKSHOP_ID, "/changeNoteFile:%s" % changelogPath, "/path:%s" % modTargetPath, "/nologo"],
		stderr=subprocess.STDOUT, shell=True, universal_newlines=True
	)
