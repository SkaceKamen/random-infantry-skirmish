import shutil
import glob
import os
import subprocess

templatesPath = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".templates"))
missionsPath = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "mapLoader.%s"))

for variant in glob.glob(os.path.join(templatesPath, "*.sqm")):
  island = os.path.splitext(os.path.basename(variant))[0]
  result = missionsPath % island

  if not os.path.exists(result):
    os.mkdir(result)

  print("Copy %s -> %s" % (variant, result))

  shutil.copy(variant, os.path.join(result, 'mission.sqm'))
