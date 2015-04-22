package com.riotgames.pvpnet.game.variants
{
   import com.riotgames.platform.gameclient.domain.game.GameMode;
   
   class ARAMGameFlowVariant extends StandardGameFlowVariant
   {
      
      function ARAMGameFlowVariant()
      {
         super();
         initializeKey(GameMode.ARAM);
      }
      
      override public function getGameStatsType(param1:int) : String
      {
         return GameStatsType.ARAM;
      }
   }
}
