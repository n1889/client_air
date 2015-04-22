package com.riotgames.pvpnet.game.variants
{
   import com.riotgames.pvpnet.system.game.PracticeGameParameters;
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.gameclient.domain.gameconfig.GameTypeConfig;
   import com.riotgames.platform.gameclient.domain.game.GameMap;
   
   class FirstBloodGameFlowVariant extends FeaturedGameFlowVariant
   {
      
      function FirstBloodGameFlowVariant()
      {
         super();
      }
      
      override public function getGameStatsType(param1:int) : String
      {
         return GameStatsType.ARAM;
      }
      
      override public function createPracticeGameParameters() : PracticeGameParameters
      {
         var _loc1_:PracticeGameParameters = super.createPracticeGameParameters();
         _loc1_.overriddenGamePickIds = new ArrayCollection([GameTypeConfig.PICK_ID_SIM_BAN]);
         _loc1_.overriddenMapIds = new ArrayCollection([GameMap.HOWLING_ABYSS]);
         _loc1_.overriddenMaxTeamSize = 2;
         return _loc1_;
      }
   }
}
