package com.riotgames.platform.common.provider
{
   import com.riotgames.platform.provider.proxy.ProviderProxyBase;
   import com.riotgames.platform.provider.ProviderLookup;
   
   public class RerollProviderProxy extends ProviderProxyBase
   {
      
      private static var _instance:IRerollProvider;
      
      public function RerollProviderProxy()
      {
         super(IRerollProvider);
      }
      
      public static function get instance() : IRerollProvider
      {
         return ProviderLookup.getProviderProxy(IRerollProvider);
      }
   }
}
