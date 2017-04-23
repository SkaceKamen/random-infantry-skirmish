import os
import re

fcs = ["addPlayerScore","assignPlayer","configUpdateFactions","configValidate","countTurrets","createNeutral","createRandomUnit","createRandomVehicle","equipSoldier","factionsUpdate","getAttachments","getCtrl","getDisplay","getRandomSoldier","getRandomVehicle","groupVehicle","isUsableWeapon","loadClasses","loadSoldiers","loadVehicles","loadWeapons","loop","mapsShow","playerKilled","profileLoad","profileReset","profileSave","randomElement","randomLocation","randomPoint","randomPosition","randomWeather2","sailorKilled","scoreChanged","showConfig","showDeath","showEquip","showFactions","spawnCommando","spawnNeutrals","spawnPlayer","spawnSpawnDefenses","start","superRandomTime","superRandomWeather","switchIsland","UI_addMessage","UI_start","unitKilled"]

for root, dirs, files in os.walk('.'):
	for filename in files:
		fullpath = os.path.join(root, filename)

		if re.match(r'.*\.sqf$', filename):
			contents = None
			with open(fullpath, 'r') as f:
				contents = f.read()
				for fun in fcs:
					contents = contents.replace('RSTF_%s' % fun, 'RSTF_fnc_%s' % fun)
			with open(fullpath, 'w') as f:
				f.write(contents)

			print("Updated %s" % fullpath)