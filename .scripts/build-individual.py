from datetime import datetime
import shutil
import glob
import os
import subprocess
import json
import time
import sys
import re
from PIL import Image, ImageFont, ImageDraw

ADDON_BUILDER = 'c:\\Program Files (x86)\\Steam\\steamapps\\common\\Arma 3 Tools\\AddonBuilder\\AddonBuilder.exe'
PUBLISHER = "c:\\Users\\KaKa\\source\\repos\\A3MissionPublisher\\A3MissionPublisher\\bin\\x64\\Release\\net6.0\\A3MissionPublisher.exe"

risPath = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
missionsPath = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "RIS-Build.%s"))
includePath = os.path.join(os.path.dirname(__file__), "include.txt")
resultsPath = os.path.join(os.path.dirname(__file__), "..", "..", "RIS-Addons")
workshopDataPath = os.path.join(resultsPath, "workshopItem.json")
descriptionPath = os.path.join(os.path.dirname(__file__), "info", "description.txt")
changelogPath = os.path.join(os.path.dirname(__file__), "info", "changelog.txt")
idsPath = os.path.join(os.path.dirname(__file__), 'ids.json')
previewsPath = os.path.join(os.path.dirname(__file__), "images")
logoOverlayPath = os.path.join(os.path.dirname(__file__), "info", "logo-overlay.png")
previewTempPath = os.path.abspath(os.path.join(resultsPath, "preview.png"))
previewFont = r'c:\Windows\Fonts\seguibl.ttf'

ids = {}

if os.path.exists(idsPath):
  with open(idsPath, 'r') as f:
    ids = json.load(f)

logoOverlay = Image.open(logoOverlayPath)

for variant in glob.glob(os.path.join(risPath, ".templates", "*.sqm")):
  island = os.path.splitext(os.path.basename(variant))[0]
  missionPath = missionsPath % island
  resultPath = os.path.abspath(os.path.join(resultsPath, "RIS-Build.%s.pbo" % island))
  previewPath = os.path.join(previewsPath, "%s.jpg" % island)
  missionTitle = "Random Skirmish - %s" % island
  uploadPreview = False

  if (island != "vt7"):
    continue

  if os.path.exists(missionPath):
    shutil.rmtree(missionPath)

  shutil.copytree(risPath, missionPath, ignore=shutil.ignore_patterns('.*', 'mission.sqm'))
  shutil.copyfile(variant, os.path.join(missionPath, 'mission.sqm'))

  with open(os.path.join(missionPath, 'mission.sqm'), 'r') as f:
    data = f.read()
    missionTitle = re.search("briefingName=\"([^\"]*)\"", data)[1]

  with open(os.path.join(missionPath, 'variables.sqf'), 'r') as f:
    variablesSqf = f.read()

  if os.path.exists(previewPath):
    previewTitle = missionTitle.split(' - ')[1]
    img = Image.open(previewPath).convert('RGBA').resize((512, 512))
    img.alpha_composite(Image.new('RGBA', (512,512), (0, 0, 0, 80)))
    img.alpha_composite(logoOverlay)

    draw = ImageDraw.Draw(img)
    size = 70
    font = None
    while True and size > 10:
      font = ImageFont.truetype(previewFont, size)
      w, h = font.getsize(previewTitle)

      if w > 500:
        size -= 10
      else:
        break
    
    draw.text((256, 350), previewTitle, anchor="mt", font = font, fill=(255,255,255,200), align ="center") 

    img.save(previewTempPath)

    uploadPreview = True
    sys.exit(1)

  with open(os.path.join(missionPath, 'config.cpp'), 'w') as f:
    f.write("""class cfgMods
{
	author="";
	timepacked="%s";
};
""" % str(round(time.time())))
  
  with open(os.path.join(missionPath, 'variables.sqf'), 'w') as f:
    variablesSqf = f.write(variablesSqf.replace(
      'RSTF_DEBUG = true;',
      'RSTF_DEBUG = false;'
    ))

    subprocess.check_call(
      [ADDON_BUILDER, missionPath, resultsPath, "-include=%s" % includePath],
      stdout=subprocess.DEVNULL
    )

  with open(workshopDataPath, 'w') as f:
    json.dump({
      "id": ids[island] if island in ids else 0,
	    "tags": ["multiplayer","singleplayer","infantry","coop","vehicles","scenario","dependency","air","altis" if island == 'Altis' else 'othermap',"tag review"],
      "title": missionTitle,
      "descriptionFile": descriptionPath,
      "previewImageFile": previewTempPath if uploadPreview else None,
      "changelogFile": changelogPath,
      "contentFile": resultPath
    }, f, indent = 2)

  output = subprocess.check_output(
    [PUBLISHER, workshopDataPath]
  ).decode('utf-8').strip()

  print(output)

  match = re.search("ID = ([0-9]+)", output)

  if match:
    newId = int(match[1])
    ids[island] = newId

    with open(idsPath, "w") as f:
      json.dump(ids, f, indent=2)

  sys.exit(1)



