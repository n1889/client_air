package com.riotgames.platform.gameclient.chat
{
   import com.riotgames.platform.provider.proxy.ProviderProxyNoop;
   import blix.signals.ISignal;
   
   public class ChatStateProviderProxy extends ProviderProxyNoop implements IChatStateProvider
   {
      
      private static var _instance:IChatStateProvider;
      
      public function ChatStateProviderProxy()
      {
         super(IChatStateProvider);
      }
      
      public static function get instance() : IChatStateProvider
      {
         if(_instance == null)
         {
            _instance = new ChatStateProviderProxy();
         }
         return _instance;
      }
      
      static function setInstance(param1:IChatStateProvider) : void
      {
         _instance = param1;
      }
      
      public function getCurrentState() : String
      {
         return _invoke("getCurrentState");
      }
      
      public function getCurrentStateChanged() : ISignal
      {
         return _getSignal("getCurrentStateChanged");
      }
   }
}
