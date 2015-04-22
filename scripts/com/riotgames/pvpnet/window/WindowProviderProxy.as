package com.riotgames.pvpnet.window
{
   import com.riotgames.platform.provider.ProviderLookup;
   
   public class WindowProviderProxy extends Object
   {
      
      public function WindowProviderProxy()
      {
         super();
      }
      
      public static function get instance() : IWindowProvider
      {
         return ProviderLookup.getProviderProxy(IWindowProvider);
      }
   }
}
