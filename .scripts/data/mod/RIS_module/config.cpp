
class CfgPatches
{
  class RIS_module
  {
    units[] = { "RIS_ModuleInit" };
    requiredVersion = 1.0;
    requiredAddons[] = {"A3_Modules_F"};
  };
};

class CfgFactionClasses
{
  class NO_CATEGORY;
  class RIS_modules: NO_CATEGORY
  {
    displayName = "Random Skirmish";
  };
};

class CfgVehicles
{
  class Logic;
  class Module_F: Logic
  {
    class AttributesBase
    {
      class Default;
      class ModuleDescription;
    };
    class ModuleDescription
    {
    };
  };

  class RIS_ModuleInit: Module_F
  {
    scope = 2;
    displayName = "Random Skirmish - Init";
    // TODO: icon
    category = "RIS_modules";
    function = "RSTF_fnc_missionInit";
    isGlobal = 0;
    isTriggerActivated = 0;
    isDisposable = 0;
    is3DEN = 0;
  };
};

class CfgFunctions
{
  #include "lib\zui\zui-functions.hpp"
	#include "fnc\functions.hpp"
	#include "fnc\ui.hpp"
	#include "fnc\gc.hpp"
};

#include "lib\zui\zui-classes.hpp"
#include "dialogs\theme.hpp"
#include "dialogs\base.hpp"
#include "dialogs\components.hpp"
#include "dialogs\titles.hpp"
#include "dialogs\advancedConfigDialog.hpp"
#include "dialogs\deathDialog.hpp"
#include "dialogs\battleSelectionDialog.hpp"
#include "dialogs\waitingDialog.hpp"

#define ZUI_DIALOG_MARGIN 0.005

#include "dialogs\zui\input.hpp"
#include "dialogs\zui\presets.hpp"
#include "dialogs\zui\shop.hpp"
#include "dialogs\zui\artillery.hpp"
#include "dialogs\zui\modeSelector.hpp"
#include "dialogs\zui\customSelector.hpp"
#include "dialogs\zui\changelog.hpp"
#include "dialogs\zui\mainConfig.hpp"
#include "dialogs\zui\factionSelector.hpp"
#include "dialogs\zui\supplyDrop.hpp"
#include "dialogs\zui\vehicleConfiguration.hpp"
#include "dialogs\zui\battleStart.hpp"
#include "dialogs\zui\death.hpp"
#include "dialogs\zui\deathTitle.hpp"
#include "dialogs\zui\respawnSelect.hpp"
#include "dialogs\zui\gunGameOverlay.hpp"
#include "dialogs\zui\gunGameEditor.hpp"
#include "dialogs\zui\gunGameEditorWeaponPick.hpp"
#include "dialogs\zui\gunGameEditorPreset.hpp"

#include "modes.hpp"
#include "options-menu.hpp"
#include "supports.hpp"
#include "compositions.hpp"
