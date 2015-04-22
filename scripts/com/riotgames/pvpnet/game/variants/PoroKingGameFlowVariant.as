package com.riotgames.pvpnet.game.variants
{
   import com.riotgames.pvpnet.system.game.PracticeGameParameters;
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.gameclient.domain.gameconfig.GameTypeConfig;
   import com.riotgames.platform.gameclient.domain.game.GameMap;
   
   class PoroKingGameFlowVariant extends FeaturedGameFlowVariant
   {
      
      function PoroKingGameFlowVariant()
      {
         super();
      }
      
      override public function createPracticeGameParameters() : PracticeGameParameters
      {
         var _loc1_:PracticeGameParameters = super.createPracticeGameParameters();
         _loc1_.overriddenGamePickIds = new ArrayCollection([GameTypeConfig.PICK_ID_SIM_BAN_SHORT_TIMER]);
         _loc1_.overriddenMapIds = new ArrayCollection([GameMap.HOWLING_ABYSS]);
         return _loc1_;
      }
   }
}
