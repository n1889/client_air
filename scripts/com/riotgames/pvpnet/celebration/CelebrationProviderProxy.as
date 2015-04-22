package com.riotgames.pvpnet.celebration
{
   import com.riotgames.platform.provider.ProviderLookup;
   import com.riotgames.riot_internal;
   
   public class CelebrationProviderProxy extends Object
   {
      
      public function CelebrationProviderProxy()
      {
         super();
      }
      
      public static function get instance() : ICelebrationProvider
      {
         return ProviderLookup.getProviderProxy(ICelebrationProvider);
      }
      
      static function setInstance(param1:ICelebrationProvider) : void
      {
         ProviderLookup.riot_internal::setProviderProxy(ICelebrationProvider,param1);
      }
   }
}
