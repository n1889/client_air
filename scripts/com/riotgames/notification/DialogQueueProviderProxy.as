package com.riotgames.notification
{
   import com.riotgames.platform.provider.ProviderLookup;
   import com.riotgames.riot_internal;
   
   public class DialogQueueProviderProxy extends Object
   {
      
      public function DialogQueueProviderProxy()
      {
         super();
      }
      
      public static function get instance() : IDialogQueueProvider
      {
         return ProviderLookup.getProviderProxy(IDialogQueueProvider);
      }
      
      static function setInstance(param1:IDialogQueueProvider) : void
      {
         ProviderLookup.riot_internal::setProviderProxy(IDialogQueueProvider,param1);
      }
   }
}
