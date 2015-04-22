package
{
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.core.IFlexModuleFactory;
   import com.riotgames.platform.gameclient.controllers.game.views.ChampionSkinSelector;
   import mx.binding.PropertyWatcher;
   
   public class _com_riotgames_platform_gameclient_controllers_game_views_ChampionSkinSelectorWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      
      public function _com_riotgames_platform_gameclient_controllers_game_views_ChampionSkinSelectorWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         ChampionSkinSelector.watcherSetupUtil = new _com_riotgames_platform_gameclient_controllers_game_views_ChampionSkinSelectorWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("fadeIn",{"propertyChange":true},[param3[0],param3[3]],param2);
         param4[2] = new PropertyWatcher("championSkinUnlock_txt",{"propertyChange":true},[param3[2]],param2);
         param4[4] = new PropertyWatcher("height",{"heightChanged":true},[param3[2]],null);
         param4[3] = new PropertyWatcher("y",{"yChanged":true},[param3[2]],null);
         param4[5] = new PropertyWatcher("chromaButtonContainerHBox",{"propertyChange":true},[param3[5]],param2);
         param4[7] = new PropertyWatcher("height",{"heightChanged":true},[param3[5]],null);
         param4[6] = new PropertyWatcher("y",{"yChanged":true},[param3[5]],null);
         param4[9] = new PropertyWatcher("championSkinName_txt",{"propertyChange":true},[param3[6],param3[8]],param2);
         param4[11] = new PropertyWatcher("height",{"heightChanged":true},[param3[6],param3[8]],null);
         param4[10] = new PropertyWatcher("y",{"yChanged":true},[param3[6],param3[8]],null);
         param4[1] = new PropertyWatcher("fadeOut",{"propertyChange":true},[param3[1],param3[4]],param2);
         param4[0].updateParent(param1);
         param4[2].updateParent(param1);
         param4[2].addChild(param4[4]);
         param4[2].addChild(param4[3]);
         param4[5].updateParent(param1);
         param4[5].addChild(param4[7]);
         param4[5].addChild(param4[6]);
         param4[9].updateParent(param1);
         param4[9].addChild(param4[11]);
         param4[9].addChild(param4[10]);
         param4[1].updateParent(param1);
      }
   }
}
