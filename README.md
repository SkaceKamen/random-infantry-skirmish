# Random Infantry Skirmish

## How to add a new map

1. Create mission on desired island, call it "mapLoader"
2. Copy included scripts to the newly created mission folder (`mapLoader.[island]`)
3. Start the mission in editor and quit it immediately
4. Paste clipboard contents to `mission.sqm` file that's inside the mission folder (`mapLoader.[island]`)
5. Load the mission again, you should now see all the mission markers
6. Move the markers and add a new ones as you need
7. Run `.scripts/copy-missions-to-templates.py` or just copy the resulting `mission.sqm` into `.templates/[island].sqm`
8. To build the mission, run `.scripts/build-individual.py --only [island]`, this will create `RIS-Build.[island]` mission
9. If you're satisfied, feel free to open a [Pull Request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) with the new template

## How to add a new emplacement

1. Place your objects in editor, see the emplacements in this mission for examples how they should look.
2. Select all objects that should be in the emplacement and save it as a new custom composition (Right Click > Save Custom Composition), pick any name
3. Go to `C:\Users\<<username>>\Arma 3\compositions` (or wherever your profile is located) and find your composition by name
4. Copy composition.sqe to `compositions/new/<<your_name>>.sqe`
5. Create a new file, `compositions/new/<<your_name>>.hpp` with following contents:

```
class <<yourName>> {
	tags[] = {"PushDefense"};
	#include "<<your_name>>.sqe"
};

```

6. Add new include line to `/compositions.hpp`

```
#include "compositions\new\<<your_name>>.hpp"
```

Your emplacement should now be used by the mission.
