package com.riotgames.pvpnet.game.variants
{
   import com.riotgames.pvpnet.system.game.GameFlowVariant;
   
   public class VariantDevPanelSupport extends Object
   {
      
      public function VariantDevPanelSupport()
      {
         super();
      }
      
      static function setCustomGameBotsEnabled() : void
      {
         var _loc1_:GameFlowVariant = null;
         for each(_loc1_ in GameFlowVariantFactory.instance.variants)
         {
            if(_loc1_ is FeaturedGameFlowVariant)
            {
               FeaturedGameFlowVariant(_loc1_)._customGameBotsEnabled = true;
            }
         }
      }
   }
}
