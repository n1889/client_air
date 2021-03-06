package com.riotgames.pvpnet.system.boot.actions
{
   import blix.action.MultiAction;
   import mx.logging.ILogger;
   import flash.system.LoaderContext;
   import blix.action.LoaderAction;
   import flash.system.ApplicationDomain;
   import flash.net.URLRequest;
   import com.riotgames.util.logging.getLogger;
   
   public class InitializeSharedAssetsAction extends MultiAction
   {
      
      private var logger:ILogger;
      
      public function InitializeSharedAssetsAction()
      {
         this.logger = getLogger(this);
         super();
         this.addSharedSwf("app:/assets/shared/chrome.swf");
         this.addSharedSwf("app:/assets/shared/components.swf");
         this.addSharedSwf("app:/assets/shared/buttons.swf");
         this.addSharedSwf("app:/assets/shared/widgets.swf");
      }
      
      private function addSharedSwf(param1:String) : void
      {
         var sharedSwfPath:String = param1;
         var context:LoaderContext = new LoaderContext();
         context.applicationDomain = ApplicationDomain.currentDomain;
         var action:LoaderAction = new LoaderAction(new URLRequest(sharedSwfPath),context);
         addAction(action);
         action.getInvoked().add(function():void
         {
            logger.info("Loading shared swf: " + sharedSwfPath);
         });
      }
   }
}
