package com.riotgames.pvpnet.summonerprofile
{
   import com.riotgames.platform.provider.ProviderLookup;
   
   public class SummonerProfileProviderContainerProxy extends Object
   {
      
      public function SummonerProfileProviderContainerProxy()
      {
         super();
      }
      
      public static function get instance() : ISummonerProfileContainerProvider
      {
         return ProviderLookup.getProviderProxy(ISummonerProfileContainerProvider);
      }
   }
}
