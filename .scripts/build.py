import shutil
import glob
import os

risPath = os.path.join(os.path.dirname(__file__), "..")
missionsPath = os.path.join(os.path.dirname(__file__), "../../RIS-Build.%s")

for variant in glob.glob(os.path.join(risPath, ".templates", "*.sqm")):
  island = os.path.splitext(os.path.basename(variant))[0]
  missionPath = missionsPath % island

  if os.path.exists(missionPath):
    shutil.rmtree(missionPath)
  shutil.copytree(risPath, missionPath, ignore=shutil.ignore_patterns('.*', 'mission.sqm'))
  shutil.copyfile(variant, os.path.join(missionPath, 'mission.sqm'))
