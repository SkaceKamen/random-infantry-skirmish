
"""
This script converts all templates to have both OPFOR and BLUFOR units.
"""

import shutil
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
  matched = re.search(r"items=([0-9]+);", content[content.find("class Entities"):])
  if matched is None:
    raise Exception("Could not find items count in " + variant)
  count = int(matched.group(1))
  
  content = content.replace("items=" + str(count) + ";", "items=" + str(count + 8) + ";")
  content = re.sub(r"class Item([0-9]+)", lambda m: "class Item" + str(int(m.group(1)) + 8) if int(m.group(1)) > 8 else m.group(0), content)
  content = content.replace(toFind, toFind + """
		class Item9
		{
			dataType="Group";
			side="East";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={14172.246,16.797678,16493.863};
					};
					side="East";
					flags=7;
					class Attributes
					{
						init="this allowDamage false;";
						description="SLOT";
						isPlayable=1;
					};
					id=4197;
					type="O_Soldier_unarmed_F";
					class CustomAttributes
					{
						class Attribute0
						{
							property="speaker";
							expression="_this setspeaker _value;";
							class Value
							{
								class data
								{
									singleType="STRING";
									value="Male02PER";
								};
							};
						};
						class Attribute1
						{
							property="pitch";
							expression="_this setpitch _value;";
							class Value
							{
								class data
								{
									singleType="SCALAR";
									value=1.02;
								};
							};
						};
						nAttributes=2;
					};
				};
			};
			class Attributes
			{
			};
			id=4001;
		};
		class Item10
		{
			dataType="Group";
			side="East";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={14172.246,16.797678,16493.863};
					};
					side="East";
					flags=7;
					class Attributes
					{
						init="this allowDamage false;";
						description="SLOT";
						isPlayable=1;
					};
					id=4197;
					type="O_Soldier_unarmed_F";
					class CustomAttributes
					{
						class Attribute0
						{
							property="speaker";
							expression="_this setspeaker _value;";
							class Value
							{
								class data
								{
									singleType="STRING";
									value="Male02PER";
								};
							};
						};
						class Attribute1
						{
							property="pitch";
							expression="_this setpitch _value;";
							class Value
							{
								class data
								{
									singleType="SCALAR";
									value=1.02;
								};
							};
						};
						nAttributes=2;
					};
				};
			};
			class Attributes
			{
			};
			id=4002;
		};
		class Item11
		{
			dataType="Group";
			side="East";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={14172.246,16.797678,16493.863};
					};
					side="East";
					flags=7;
					class Attributes
					{
						init="this allowDamage false;";
						description="SLOT";
						isPlayable=1;
					};
					id=4197;
					type="O_Soldier_unarmed_F";
					class CustomAttributes
					{
						class Attribute0
						{
							property="speaker";
							expression="_this setspeaker _value;";
							class Value
							{
								class data
								{
									singleType="STRING";
									value="Male02PER";
								};
							};
						};
						class Attribute1
						{
							property="pitch";
							expression="_this setpitch _value;";
							class Value
							{
								class data
								{
									singleType="SCALAR";
									value=1.02;
								};
							};
						};
						nAttributes=2;
					};
				};
			};
			class Attributes
			{
			};
			id=4003;
		};
		class Item12
		{
			dataType="Group";
			side="East";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={14172.246,16.797678,16493.863};
					};
					side="East";
					flags=7;
					class Attributes
					{
						init="this allowDamage false;";
						description="SLOT";
						isPlayable=1;
					};
					id=4197;
					type="O_Soldier_unarmed_F";
					class CustomAttributes
					{
						class Attribute0
						{
							property="speaker";
							expression="_this setspeaker _value;";
							class Value
							{
								class data
								{
									singleType="STRING";
									value="Male02PER";
								};
							};
						};
						class Attribute1
						{
							property="pitch";
							expression="_this setpitch _value;";
							class Value
							{
								class data
								{
									singleType="SCALAR";
									value=1.02;
								};
							};
						};
						nAttributes=2;
					};
				};
			};
			class Attributes
			{
			};
			id=4003;
		};
		class Item13
		{
			dataType="Group";
			side="East";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={14172.246,16.797678,16493.863};
					};
					side="East";
					flags=7;
					class Attributes
					{
						init="this allowDamage false;";
						description="SLOT";
						isPlayable=1;
					};
					id=4197;
					type="O_Soldier_unarmed_F";
					class CustomAttributes
					{
						class Attribute0
						{
							property="speaker";
							expression="_this setspeaker _value;";
							class Value
							{
								class data
								{
									singleType="STRING";
									value="Male02PER";
								};
							};
						};
						class Attribute1
						{
							property="pitch";
							expression="_this setpitch _value;";
							class Value
							{
								class data
								{
									singleType="SCALAR";
									value=1.02;
								};
							};
						};
						nAttributes=2;
					};
				};
			};
			class Attributes
			{
			};
			id=4005;
		};
		class Item14
		{
			dataType="Group";
			side="East";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={14172.246,16.797678,16493.863};
					};
					side="East";
					flags=7;
					class Attributes
					{
						init="this allowDamage false;";
						description="SLOT";
						isPlayable=1;
					};
					id=4197;
					type="O_Soldier_unarmed_F";
					class CustomAttributes
					{
						class Attribute0
						{
							property="speaker";
							expression="_this setspeaker _value;";
							class Value
							{
								class data
								{
									singleType="STRING";
									value="Male02PER";
								};
							};
						};
						class Attribute1
						{
							property="pitch";
							expression="_this setpitch _value;";
							class Value
							{
								class data
								{
									singleType="SCALAR";
									value=1.02;
								};
							};
						};
						nAttributes=2;
					};
				};
			};
			class Attributes
			{
			};
			id=4006;
		};
		class Item15
		{
			dataType="Group";
			side="East";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={14172.246,16.797678,16493.863};
					};
					side="East";
					flags=7;
					class Attributes
					{
						init="this allowDamage false;";
						description="SLOT";
						isPlayable=1;
					};
					id=4197;
					type="O_Soldier_unarmed_F";
					class CustomAttributes
					{
						class Attribute0
						{
							property="speaker";
							expression="_this setspeaker _value;";
							class Value
							{
								class data
								{
									singleType="STRING";
									value="Male02PER";
								};
							};
						};
						class Attribute1
						{
							property="pitch";
							expression="_this setpitch _value;";
							class Value
							{
								class data
								{
									singleType="SCALAR";
									value=1.02;
								};
							};
						};
						nAttributes=2;
					};
				};
			};
			class Attributes
			{
			};
			id=4007;
		};
		class Item16
		{
			dataType="Group";
			side="East";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={14172.246,16.797678,16493.863};
					};
					side="East";
					flags=7;
					class Attributes
					{
						init="this allowDamage false;";
						description="SLOT";
						isPlayable=1;
					};
					id=4197;
					type="O_Soldier_unarmed_F";
					class CustomAttributes
					{
						class Attribute0
						{
							property="speaker";
							expression="_this setspeaker _value;";
							class Value
							{
								class data
								{
									singleType="STRING";
									value="Male02PER";
								};
							};
						};
						class Attribute1
						{
							property="pitch";
							expression="_this setpitch _value;";
							class Value
							{
								class data
								{
									singleType="SCALAR";
									value=1.02;
								};
							};
						};
						nAttributes=2;
					};
				};
			};
			class Attributes
			{
			};
			id=4008;
		};""")
  with open(variant, "w") as f:
    f.write(content)