package com.riotgames.pvpnet.game.variants
{
   import com.riotgames.pvpnet.system.game.PracticeGameParameters;
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.gameclient.domain.game.GameMap;
   
   class HexakillGameFlowVariant extends FeaturedGameFlowVariant
   {
      
      function HexakillGameFlowVariant()
      {
         super();
      }
      
      override public function createPracticeGameParameters() : PracticeGameParameters
      {
         var _loc1_:PracticeGameParameters = super.createPracticeGameParameters();
         _loc1_.overriddenMaxTeamSize = 6;
         if(_gameKey == "sr6")
         {
            _loc1_.overriddenMapIds = new ArrayCollection([GameMap.SUMMONERS_RIFT_UPDATE_SHIPPING]);
         }
         else if(_gameKey = "tt6")
         {
            _loc1_.overriddenMapIds = new ArrayCollection([GameMap.TWISTED_TREELINE_ID]);
         }
         
         return _loc1_;
      }
   }
}
