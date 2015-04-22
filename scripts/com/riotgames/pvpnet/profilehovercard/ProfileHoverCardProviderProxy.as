package com.riotgames.pvpnet.profilehovercard
{
   import com.riotgames.platform.provider.ProviderLookup;
   
   public class ProfileHoverCardProviderProxy extends Object
   {
      
      public function ProfileHoverCardProviderProxy()
      {
         super();
      }
      
      public static function get instance() : IProfileHoverCardProvider
      {
         return ProviderLookup.getProviderProxy(IProfileHoverCardProvider);
      }
   }
}
