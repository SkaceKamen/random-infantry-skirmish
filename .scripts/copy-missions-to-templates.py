import shutil
import glob
import os
import subprocess

templatesPath = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".templates", "%s.sqm"))
missionsPath = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))

for variant in glob.glob(os.path.join(missionsPath, "mapLoader.*")):
  island = os.path.splitext(os.path.basename(variant))[1][1:]
  result = templatesPath % island

  print("Copy %s -> %s" % (variant, result))

  shutil.copy(os.path.join(variant, 'mission.sqm'), result)
