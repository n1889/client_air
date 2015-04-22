package com.riotgames.pvpnet.system.dataload.actions
{
   import blix.action.BasicAction;
   import com.riotgames.pvpnet.system.config.ClientConfig;
   import com.riotgames.platform.provider.ProviderLookup;
   
   public class InitializeItemSets extends BasicAction
   {
      
      public function InitializeItemSets()
      {
         super(false);
      }
      
      override protected function doInvocation() : void
      {
         if(ClientConfig.instance.showItemSets)
         {
            ProviderLookup.instance.requestProvider("com.riotgames.pvpnet.itembrowser::IItemBrowserProvider");
         }
         complete();
      }
   }
}
