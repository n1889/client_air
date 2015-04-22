package com.riotgames.platform.common.provider
{
   import com.riotgames.platform.provider.ProviderLookup;
   
   public class StoreProviderProxy extends Object
   {
      
      public function StoreProviderProxy()
      {
         super();
      }
      
      public static function get instance() : IStoreProvider
      {
         return ProviderLookup.getProviderProxy(IStoreProvider);
      }
   }
}
