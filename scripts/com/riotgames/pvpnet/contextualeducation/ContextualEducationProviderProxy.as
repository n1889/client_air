package com.riotgames.pvpnet.contextualeducation
{
   import com.riotgames.platform.provider.ProviderLookup;
   
   public class ContextualEducationProviderProxy extends Object
   {
      
      public function ContextualEducationProviderProxy()
      {
         super();
      }
      
      public static function get instance() : IContextualEducationProvider
      {
         return ProviderLookup.getProviderProxy(IContextualEducationProvider);
      }
   }
}
