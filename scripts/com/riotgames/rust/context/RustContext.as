package com.riotgames.rust.context
{
   import blix.context.Context;
   import com.riotgames.rust.components.ViewUtil;
   import blix.action.IAction;
   import blix.assets.IAssetsLoader;
   import flash.net.URLRequest;
   import blix.decorator.IDecoratorManager;
   import com.riotgames.rust.decorator.LocaleDecorator;
   import flash.utils.Dictionary;
   import blix.assets.AssetsLoader;
   import blix.assets.IAssetsManager;
   import blix.decorator.DecoratorManager;
   import com.riotgames.rust.decorator.FontMapDecorator;
   
   public class RustContext extends Context
   {
      
      public var viewUtil:ViewUtil;
      
      public function RustContext(param1:Dictionary = null)
      {
         super(null,param1);
         var _loc2_:AssetsLoader = new AssetsLoader();
         registerDependency(IAssetsLoader,_loc2_);
         registerDependency(IAssetsManager,_loc2_);
         var _loc3_:IDecoratorManager = new DecoratorManager();
         registerDependency(IDecoratorManager,_loc3_);
         _loc3_.addDecorator(new FontMapDecorator());
         this.initViewUtil();
      }
      
      protected function initViewUtil() : void
      {
         this.viewUtil = new ViewUtil();
      }
      
      public function loadAssets(param1:String) : IAction
      {
         var _loc2_:IAssetsLoader = getDependency(IAssetsLoader);
         return _loc2_.loadAssets(new URLRequest(param1));
      }
      
      public function unloadAssets(param1:String) : void
      {
         var _loc2_:IAssetsLoader = getDependency(IAssetsLoader);
         _loc2_.unloadAssets(new URLRequest(param1));
      }
      
      public function enableAutoLocalization(param1:String) : void
      {
         var _loc2_:IDecoratorManager = getDependency(IDecoratorManager);
         _loc2_.addDecorator(new LocaleDecorator(param1));
      }
   }
}
