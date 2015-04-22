package com.riotgames.platform.gameclient.controllers.game.builders
{
   import com.riotgames.platform.gameclient.controllers.game.controllers.ChampionSelectionController;
   import blix.context.IContext;
   import com.riotgames.platform.gameclient.championselection.GameSelectionData;
   import com.riotgames.platform.gameclient.controllers.game.model.ChampionSelectionModel;
   
   public class ChampionSelectionControllerGenerator extends Object
   {
      
      public function ChampionSelectionControllerGenerator()
      {
         super();
      }
      
      public static function generateChampionSelectionController(param1:IContext, param2:GameSelectionData, param3:ChampionSelectionModel) : ChampionSelectionController
      {
         return new ChampionSelectionController(param1,param2,param3);
      }
   }
}
