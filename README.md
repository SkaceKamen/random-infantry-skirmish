# Random Infantry Skirmish

## How to add a new map

TODO

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
