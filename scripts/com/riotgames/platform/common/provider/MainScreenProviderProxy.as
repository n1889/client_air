package com.riotgames.platform.common.provider
{
   import com.riotgames.platform.provider.ProviderLookup;
   
   public class MainScreenProviderProxy extends Object
   {
      
      public function MainScreenProviderProxy()
      {
         super();
      }
      
      public static function get instance() : IMainScreenProvider
      {
         return ProviderLookup.getProviderProxy(IMainScreenProvider);
      }
   }
}
