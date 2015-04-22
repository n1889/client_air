package com.riotgames.pvpnet.system.boot.actions
{
   import blix.action.BasicAction;
   import com.riotgames.pvpnet.system.config.PlatformConfigController;
   import com.riotgames.platform.provider.ProviderLookup;
   import com.riotgames.pvpnet.system.config.IPlatformConfigProvider;
   
   public class InitializePlatformConfigAction extends BasicAction
   {
      
      public function InitializePlatformConfigAction()
      {
         super(false);
      }
      
      override protected function doInvocation() : void
      {
         var _loc1_:PlatformConfigController = new PlatformConfigController();
         ProviderLookup.publishProvider(IPlatformConfigProvider,_loc1_);
         complete();
      }
   }
}
