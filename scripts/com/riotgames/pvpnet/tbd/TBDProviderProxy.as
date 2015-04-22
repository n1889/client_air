package com.riotgames.pvpnet.tbd
{
   import com.riotgames.platform.provider.proxy.ProviderProxyBase;
   import mx.core.UIComponent;
   
   public class TBDProviderProxy extends ProviderProxyBase implements ITBDProvider
   {
      
      private static var _instance:ITBDProvider;
      
      public function TBDProviderProxy()
      {
         super(ITBDProvider);
      }
      
      public static function get instance() : ITBDProvider
      {
         if(!_instance)
         {
            _instance = new TBDProviderProxy();
         }
         return _instance;
      }
      
      public function enterViewAsCaptain(param1:UIComponent) : void
      {
         _invoke("enterViewAsCaptain",[param1]);
      }
      
      public function enterViewAsInvitee(param1:UIComponent) : void
      {
         _invoke("enterViewAsInvitee",[param1]);
      }
      
      public function isModuleActive() : Boolean
      {
         return _invoke("isModuleActive");
      }
      
      public function quit(param1:Function = null, param2:Function = null) : void
      {
         _invoke("quit",[param1,param2]);
      }
   }
}
