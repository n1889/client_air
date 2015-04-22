package com.riotgames.pvpnet.communities
{
   import com.riotgames.platform.provider.ProviderLookup;
   
   public class CommunitiesProviderProxy extends Object
   {
      
      public function CommunitiesProviderProxy()
      {
         super();
      }
      
      public static function get instance() : ICommunitiesProvider
      {
         return ProviderLookup.getProviderProxy(ICommunitiesProvider);
      }
   }
}
