package com.riotgames.pvpnet.system.boot.actions
{
   import blix.action.BasicAction;
   import com.riotgames.platform.module.RiotModuleInfo;
   import com.riotgames.pvpnet.system.config.ClientConfig;
   import mx.core.Singleton;
   import flash.utils.getQualifiedClassName;
   import mx.core.IEmbeddedFontRegistry;
   import mx.core.EmbeddedFontRegistry;
   
   public class LoadFontsAction extends BasicAction
   {
      
      var riotModuleInfo:RiotModuleInfo;
      
      var pathChecker:LoadFontsPathChecker;
      
      public function LoadFontsAction()
      {
         this.riotModuleInfo = new RiotModuleInfo();
         this.pathChecker = new LoadFontsPathChecker();
         super(false);
      }
      
      override protected function doInvocation() : void
      {
         var _loc1_:String = "css/fonts_" + ClientConfig.instance.locale + ".swf";
         if(!this.pathChecker.checkIfPathExists(_loc1_))
         {
            _loc1_ = "/css/fonts.swf";
         }
         Singleton.registerClass(getQualifiedClassName(IEmbeddedFontRegistry),EmbeddedFontRegistry);
         this.riotModuleInfo.setUrl(_loc1_);
         this.riotModuleInfo.getCompleted().add(complete);
         this.riotModuleInfo.getErred().add(this.erredHandler);
         this.riotModuleInfo.load();
      }
      
      private function erredHandler(param1:RiotModuleInfo) : void
      {
         err(param1.getError());
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.riotModuleInfo.getCompleted().remove(complete);
         this.riotModuleInfo.getErred().remove(this.erredHandler);
      }
   }
}
