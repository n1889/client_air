package com.riotgames.pvpnet.suggestedplayers
{
   import com.riotgames.platform.provider.ProviderLookup;
   
   public class SuggestedPlayersProviderProxy extends Object
   {
      
      public function SuggestedPlayersProviderProxy()
      {
         super();
      }
      
      public static function get instance() : ISuggestedPlayersProvider
      {
         return ProviderLookup.getProviderProxy(ISuggestedPlayersProvider);
      }
   }
}
