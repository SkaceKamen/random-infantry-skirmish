version=53;
class EditorData
{
	moveGridStep=1;
	angleGridStep=0.2617994;
	scaleGridStep=1;
	autoGroupingDist=10;
	toggles=1;
	class ItemIDProvider
	{
		nextID=79;
	};
	class MarkerIDProvider
	{
		nextID=1;
	};
	class Camera
	{
		pos[]={14083.045,39.067047,16442.834};
		dir[]={-0.0030744011,-0.9995234,-0.030823361};
		up[]={-0.099202663,0.030955145,-0.99458575};
		aside[]={-0.99506563,8.934876e-009,0.099250555};
	};
};
binarizationWanted=0;
addons[]=
{
	"A3_Ui_F",
	"A3_Characters_F"
};
class AddonsMetaData
{
	class List
	{
		items=2;
		class Item0
		{
			className="A3_Ui_F";
			name="Arma 3 - User Interface";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
		class Item1
		{
			className="A3_Characters_F";
			name="Arma 3 Alpha - Characters and Clothing";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
	};
};
randomSeed=11268658;
class ScenarioData
{
	author="Kamen";
	overviewText="Instant infantry battle for randomly selected place on the map.";
	overViewPicture="random.paa";
	joinUnassigned=0;
	class Header
	{
		gameType="Coop";
		minPlayers=1;
		maxPlayers=8;
	};
};
class CustomAttributes
{
	class Category0
	{
		name="Multiplayer";
		class Attribute0
		{
			property="RespawnTemplates";
			expression="true";
			class Value
			{
				class data
				{
					class type
					{
						type[]=
						{
							"ARRAY"
						};
					};
					class value
					{
						items=1;
						class Item0
						{
							class data
							{
								class type
								{
									type[]=
									{
										"STRING"
									};
								};
								value="None";
							};
						};
					};
				};
			};
		};
		nAttributes=1;
	};
	class Category1
	{
		name="Scenario";
		class Attribute0
		{
			property="EnableDebugConsole";
			expression="true";
			class Value
			{
				class data
				{
					class type
					{
						type[]=
						{
							"SCALAR"
						};
					};
					value=0;
				};
			};
		};
		nAttributes=1;
	};
};
class Mission
{
	class Intel
	{
		briefingName="(SP/CO-8) Random Skirmish (%3)";
		overviewText="Random infantry skirmish on random place on island";
		resistanceWest=0;
		startWeather=0.28999999;
		startWind=0.099999994;
		startWaves=0.099999994;
		forecastWeather=0.29999998;
		forecastWind=0.099999994;
		forecastWaves=0.099999994;
		forecastLightnings=0.099999994;
		year=2035;
		month=6;
		day=24;
		hour=12;
		minute=0;
		startFogDecay=0.013;
		forecastFogDecay=0.013;
	};
	class Entities
	{
		items=%1;
		class Item0
		{
			dataType="Marker";
			position[]={14521.83,17.889999,16065.266};
			name="RSTF_FACTION_CAM";
			type="Empty";
			id=0;
		};
		class Item1
		{
			dataType="Group";
			side="West";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={14090.172,16.810787,16447.982};
						angles[]={0.0077281403,0,0.001381068};
					};
					side="West";
					flags=6;
					class Attributes
					{
						skill=0.60000002;
						init="this allowDamage false;";
						description="Player";
						isPlayer=1;
						isPlayable=1;
					};
					id=2;
					type="B_Soldier_unarmed_F";
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
									class type
									{
										type[]=
										{
											"STRING"
										};
									};
									value="Male10ENG";
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
									class type
									{
										type[]=
										{
											"SCALAR"
										};
									};
									value=0.97000003;
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
			id=1;
		};
		class Item2
		{
			dataType="Group";
			side="West";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={14088.729,16.819086,16446.58};
						angles[]={0.0071558496,0,0.0013788101};
					};
					side="West";
					flags=6;
					class Attributes
					{
						skill=0.60000002;
						init="this allowDamage false;";
						description="Player";
						isPlayable=1;
					};
					id=23;
					type="B_Soldier_unarmed_F";
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
									class type
									{
										type[]=
										{
											"STRING"
										};
									};
									value="Male11ENG";
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
									class type
									{
										type[]=
										{
											"SCALAR"
										};
									};
									value=1.04;
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
			id=22;
		};
		class Item3
		{
			dataType="Group";
			side="West";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={14091.606,16.821819,16446.752};
						angles[]={0.0071596238,0,0.001381068};
					};
					side="West";
					flags=6;
					class Attributes
					{
						skill=0.60000002;
						init="this allowDamage false;";
						description="Player";
						isPlayable=1;
					};
					id=25;
					type="B_Soldier_unarmed_F";
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
									class type
									{
										type[]=
										{
											"STRING"
										};
									};
									value="Male07ENG";
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
									class type
									{
										type[]=
										{
											"SCALAR"
										};
									};
									value=1.03;
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
			id=24;
		};
		class Item4
		{
			dataType="Group";
			side="West";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={14087.487,16.82905,16444.885};
						angles[]={0.0045281379,0,0.0039967569};
					};
					side="West";
					flags=6;
					class Attributes
					{
						skill=0.60000002;
						init="this allowDamage false;";
						description="Player";
						isPlayable=1;
					};
					id=40;
					type="B_Soldier_unarmed_F";
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
									class type
									{
										type[]=
										{
											"STRING"
										};
									};
									value="Male11ENG";
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
									class type
									{
										type[]=
										{
											"SCALAR"
										};
									};
									value=1.04;
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
			id=39;
		};
		class Item5
		{
			dataType="Group";
			side="West";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={14093.141,16.845703,16444.75};
						angles[]={0.0071596238,0,0.012974046};
					};
					side="West";
					flags=6;
					class Attributes
					{
						skill=0.60000002;
						init="this allowDamage false;";
						description="Player";
						isPlayable=1;
					};
					id=42;
					type="B_Soldier_unarmed_F";
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
									class type
									{
										type[]=
										{
											"STRING"
										};
									};
									value="Male07ENG";
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
									class type
									{
										type[]=
										{
											"SCALAR"
										};
									};
									value=1.03;
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
			id=41;
		};
		class Item6
		{
			dataType="Group";
			side="West";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={14088.74,16.841209,16443.307};
						angles[]={0.0045204028,0,0.0039968039};
					};
					side="West";
					flags=6;
					class Attributes
					{
						skill=0.60000002;
						init="this allowDamage false;";
						description="Player ";
						isPlayable=1;
					};
					id=44;
					type="B_Soldier_unarmed_F";
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
									class type
									{
										type[]=
										{
											"STRING"
										};
									};
									value="Male11ENG";
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
									class type
									{
										type[]=
										{
											"SCALAR"
										};
									};
									value=1.04;
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
			id=43;
		};
		class Item7
		{
			dataType="Group";
			side="West";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={14091.398,16.846361,16443.283};
						angles[]={0.0071558496,0,0.0013788101};
					};
					side="West";
					flags=6;
					class Attributes
					{
						skill=0.60000002;
						init="this allowDamage false;";
						description="Player";
						isPlayable=1;
					};
					id=46;
					type="B_Soldier_unarmed_F";
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
									class type
									{
										type[]=
										{
											"STRING"
										};
									};
									value="Male07ENG";
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
									class type
									{
										type[]=
										{
											"SCALAR"
										};
									};
									value=1.03;
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
			id=45;
		};
		class Item8
		{
			dataType="Group";
			side="West";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={14090.202,16.853712,16441.84};
						angles[]={0.0045204028,0,0.0039968039};
					};
					side="West";
					flags=6;
					class Attributes
					{
						skill=0.60000002;
						init="this allowDamage false;";
						description="Player";
						isPlayable=1;
					};
					id=48;
					type="B_Soldier_unarmed_F";
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
									class type
									{
										type[]=
										{
											"STRING"
										};
									};
									value="Male11ENG";
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
									class type
									{
										type[]=
										{
											"SCALAR"
										};
									};
									value=1.04;
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
			id=47;
		};
		%2
	};
};