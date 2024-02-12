"""
This script builds and publishes the RIS missions to the workshop
"""

import argparse
import shutil
import glob
import os
import subprocess
import json
import time
import sys
import re
from PIL import Image
from utils import buildPreview
import dotenv

dotenv.load_dotenv()

ADDON_BUILDER = os.getenv('ADDON_BUILDER')
PUBLISHER = os.getenv('MISSION_PUBLISHER')

parser = argparse.ArgumentParser(description='Build and publish RIS missions')
parser.add_argument('--publish', action='store_true', help='Skip publishing')
parser.add_argument('--skip-published', action='store_true', help='Skip already published missions')
parser.add_argument('--only', action='append', help='Only publish specific mission')

args = parser.parse_args()

SKIP_PUBLISH = not args.publish
SKIP_PUBLISHED = args.skip_published
ONLY_PUBLISH = args.only if args.only != None and len(args.only) > 0 else None

risPath = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
missionsPath = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "RIS-Build.%s"))
includePath = os.path.join(os.path.dirname(__file__), "include.txt")
resultsPath = os.path.join(os.path.dirname(__file__), "..", "..", "RIS-Addons")
dataPath = os.path.join(os.path.dirname(__file__), "data")
workshopDataPath = os.path.join(resultsPath, "workshopItem.json")
descriptionPath = os.path.join(dataPath, "info", "description.txt")
changelogPath = os.path.join(dataPath, "info", "changelog.txt")
idsPath = os.path.join(os.path.dirname(__file__), 'ids.json')
previewsPath = os.path.join(dataPath, "images")
logoOverlayPath = os.path.join(dataPath, "info", "logo-overlay.png")
previewTempPath = os.path.abspath(os.path.join(resultsPath, "preview.png"))

ids = {}

print("Building RIS missions")
print(" Publish to workshop: %r" % (not SKIP_PUBLISH))
print(" Skip already published: %r" % (SKIP_PUBLISHED))
print(" Only publish: " + str(ONLY_PUBLISH if ONLY_PUBLISH != None else "all"))

if not SKIP_PUBLISH and not os.path.exists(ADDON_BUILDER):
  raise Exception("Addon Builder not found")

if not SKIP_PUBLISH and not os.path.exists(PUBLISHER):
  raise Exception("Workshop Publisher not found")

if os.path.exists(idsPath):
  with open(idsPath, 'r') as f:
    ids = json.load(f)

def removeSteamDebug(dbg):
  return re.sub(
    'Setting breakpad minidump AppID = [0-9]+\nSteam_SetMinidumpSteamID:  Caching Steam ID:  [0-9]+ \\[API loaded no\\]',
    '',
    str(dbg).replace('\r', '')
  )

logoOverlay = Image.open(logoOverlayPath)

for variant in glob.glob(os.path.join(risPath, ".templates", "*.sqm")):
  island = os.path.splitext(os.path.basename(variant))[0]
  missionPath = missionsPath % island
  resultPath = os.path.abspath(os.path.join(resultsPath, "RIS-Build.%s.pbo" % island))
  previewPath = os.path.join(previewsPath, "%s.jpg" % island)
  missionTitle = "RIS - %s" % island
  uploadPreview = False
  existingId = ids[island] if island in ids else 0

  if not os.path.exists(previewPath):
    previewPath = os.path.join(previewsPath, "%s.jpg" % 'unknown')

  if ONLY_PUBLISH != None and not island in ONLY_PUBLISH:
    continue

  if SKIP_PUBLISHED and existingId != 0:
    print("Skip %s because it was already published" % island)
    continue

  if SKIP_PUBLISH:
    print("Build %s" % island)
  else:
    print("Build & Publish %s" % island)

  print(" Assembling mission...")

  if os.path.exists(missionPath):
    shutil.rmtree(missionPath)

  shutil.copytree(risPath, missionPath, ignore=shutil.ignore_patterns('.*', 'mission.sqm', 'local.sqf'))
  shutil.copyfile(variant, os.path.join(missionPath, 'mission.sqm'))

  with open(os.path.join(missionPath, 'mission.sqm'), 'r', encoding='utf-8') as f:
    data = f.read()
    missionTitle = re.search("briefingName=\"([^\"]*)\"", data)[1]

  with open(os.path.join(missionPath, 'fnc/all/fn_initVariables.sqf'), 'r') as f:
    variablesSqf = f.read()

  with open(os.path.join(missionPath, 'fnc/all/fn_initVariables.sqf'), 'w') as f:
    f.write(variablesSqf.replace(
      'RSTF_DEBUG = true;',
      'RSTF_DEBUG = false;'
    ))

  if SKIP_PUBLISH:
    continue

  if existingId == 0 and os.path.exists(previewPath):
    title = missionTitle.split(' - ')[1]

    previewImage = buildPreview(Image.open(previewPath), logoOverlay, title)
    previewImage.save(previewTempPath)

    uploadPreview = True

  with open(os.path.join(missionPath, 'config.cpp'), 'w') as f:
    f.write("""class cfgMods
{
	author="";
	timepacked="%s";
};
""" % str(round(time.time())))

  print(" Building pbo...")

  output = subprocess.run(
    [ADDON_BUILDER, missionPath, resultsPath, "-include=%s" % includePath],
    stdout=subprocess.DEVNULL, stderr=subprocess.PIPE
  )

  if output.returncode != 0:
    print(removeSteamDebug(output.stderr.decode('utf-8').strip()))
    raise Exception("PBO Builder returned non-zero code")

  print(" Publishing...")

  with open(workshopDataPath, 'w') as f:
    json.dump({
      "id": existingId,
	    "tags": ["multiplayer","singleplayer","infantry","coop","vehicles","scenario","dependency","air","altis" if island == 'Altis' else 'othermap',"tag review"],
      "title": missionTitle,
      "descriptionFile": descriptionPath,
      "previewImageFile": previewTempPath if uploadPreview else None,
      "changelogFile": changelogPath,
      "contentFile": resultPath
    }, f, indent = 2)

  tries = 0

  while True:
    output = removeSteamDebug(subprocess.check_output(
      [PUBLISHER, workshopDataPath],
      stderr=subprocess.STDOUT
    ).decode('utf-8').strip())

    print("  " + "\n  ".join(output.split('\n')))

    if "RESULT = k_EResultAccessDenied" in output:
      raise "Failed to publish: Access Denied"

    if "RESULT = k_EResultTooManyPending" in output:
      tries += 1

      if tries > 10:
        print(" !! PUBLISH WAS NOT SUCCESSFULL")
        break

      print(" ... Waiting one second before trying again")
      time.sleep(1)
    else:
      match = re.search("WID = ([0-9]+)", output)

      if match:
        newId = int(match[1])
        ids[island] = newId

        with open(idsPath, "w") as f:
          json.dump(ids, f, indent=2)

      break



