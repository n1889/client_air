package com.riotgames.platform.common.provider
{
   import com.riotgames.platform.provider.ProviderLookup;
   
   public class ChampionDetailProviderProxy extends Object
   {
      
      public function ChampionDetailProviderProxy()
      {
         super();
      }
      
      public static function get instance() : IChampionDetailProvider
      {
         return ProviderLookup.getProviderProxy(IChampionDetailProvider);
      }
   }
}
