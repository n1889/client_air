package com.riotgames.pvpnet.summonerprofile
{
   import com.riotgames.platform.provider.ProviderLookup;
   
   public class SummonerProfileProviderProxy extends Object
   {
      
      public function SummonerProfileProviderProxy()
      {
         super();
      }
      
      public static function get instance() : ISummonerProfileProvider
      {
         return ProviderLookup.getProviderProxy(ISummonerProfileProvider);
      }
   }
}
