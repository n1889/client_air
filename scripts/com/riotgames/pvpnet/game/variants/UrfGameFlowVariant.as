package com.riotgames.pvpnet.game.variants
{
   import com.riotgames.pvpnet.system.game.PracticeGameParameters;
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.gameclient.domain.gameconfig.GameTypeConfig;
   
   class UrfGameFlowVariant extends FeaturedGameFlowVariant
   {
      
      function UrfGameFlowVariant()
      {
         super();
      }
      
      override public function createPracticeGameParameters() : PracticeGameParameters
      {
         var _loc1_:PracticeGameParameters = super.createPracticeGameParameters();
         _loc1_.overriddenGamePickIds = new ArrayCollection([GameTypeConfig.PICK_ID_SIM_BAN_SHORT_TIMER]);
         return _loc1_;
      }
   }
}
