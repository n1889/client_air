package com.riotgames.pvpnet.system.boot.actions
{
   import blix.action.BasicAction;
   import mx.core.Singleton;
   import flash.utils.getQualifiedClassName;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManagerImpl;
   import mx.resources.ResourceManager;
   import com.riotgames.pvpnet.system.config.ClientConfig;
   
   public class InitializeResourceLoaderAction extends BasicAction
   {
      
      public function InitializeResourceLoaderAction()
      {
         super(false);
      }
      
      override protected function doInvocation() : void
      {
         Singleton.registerClass(getQualifiedClassName(IResourceManager),ResourceManagerImpl);
         ResourceManager.getInstance().localeChain = ClientConfig.instance.locale == null?ClientConfig.instance.locales:[ClientConfig.instance.locale];
         complete();
      }
   }
}
