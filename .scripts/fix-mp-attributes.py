
"""
This script converts all templates to have both OPFOR and BLUFOR units.
"""

import glob
import os
import pathlib
import re

templatesPath = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".templates"))

toFind = """class Attributes
			{
			};
			id=47;
		};"""

for variant in glob.glob(os.path.join(templatesPath, "*.sqm")):
  print("Applying new template to " + variant)

  content = pathlib.Path(variant).read_text()
  content = content.replace("maxPlayers=8", "maxPlayers=16")
  content = content.replace("	joinUnassigned=0;\n", "")
  
  with open(variant, "w") as f:
    f.write(content)