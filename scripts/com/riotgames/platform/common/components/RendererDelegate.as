package com.riotgames.platform.common.components
{
   import mx.core.IDataRenderer;
   import mx.core.UIComponent;
   import mx.collections.IList;
   import flash.utils.Dictionary;
   import mx.core.ClassFactory;
   
   public class RendererDelegate extends Object
   {
      
      protected var rendererCache:RendererCache;
      
      public var renderers:Dictionary;
      
      public function RendererDelegate()
      {
         this.renderers = new Dictionary();
         this.rendererCache = new RendererCache();
         super();
      }
      
      public function getRendererForItem(param1:Object) : IDataRenderer
      {
         return this.renderers[param1];
      }
      
      public function destroyRenderers(param1:UIComponent, param2:IList) : void
      {
         var _loc3_:IDataRenderer = null;
         for each(_loc3_ in this.renderers)
         {
            this.rendererCache.cacheRenderer(_loc3_);
         }
         this.renderers = new Dictionary();
         if(!param1)
         {
            return;
         }
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
      }
      
      public function addRenderers(param1:UIComponent, param2:IList) : void
      {
         var _loc3_:Object = null;
         if(!param1)
         {
            return;
         }
         for each(_loc3_ in param2)
         {
            if(this.renderers[_loc3_])
            {
               param1.addChild(this.renderers[_loc3_]);
            }
         }
      }
      
      public function set itemRenderer(param1:ClassFactory) : void
      {
         this.rendererCache.itemRenderer = param1;
      }
      
      public function deleteRendererForItem(param1:Object) : void
      {
         delete this.renderers[param1];
         true;
      }
      
      public function setRendererData(param1:IList) : void
      {
         var _loc2_:Object = null;
         var _loc3_:IDataRenderer = null;
         var _loc4_:* = 0;
         if((!param1) || (param1.length == 0))
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = param1.getItemAt(_loc4_);
            if(this.renderers[_loc2_])
            {
               _loc3_ = this.renderers[_loc2_];
               _loc3_.data = _loc2_;
            }
            _loc4_++;
         }
      }
      
      public function associateDataWithRenderer(param1:Object, param2:Object) : void
      {
         this.renderers[param1] = param2;
      }
      
      public function createRenderers(param1:IList) : void
      {
         var _loc2_:Object = null;
         var _loc3_:IDataRenderer = null;
         this.renderers = new Dictionary();
         for each(_loc2_ in param1)
         {
            _loc3_ = this.createRenderer();
            if(_loc3_)
            {
               this.renderers[_loc2_] = _loc3_;
            }
         }
      }
      
      public function rebuildRenderers(param1:IList, param2:UIComponent) : void
      {
         this.destroyRenderers(param2,param1);
         this.createRenderers(param1);
         this.addRenderers(param2,param1);
         this.setRendererData(param1);
      }
      
      public function get itemRenderer() : ClassFactory
      {
         return this.rendererCache.itemRenderer;
      }
      
      public function recycleRenderer(param1:IDataRenderer) : void
      {
         this.rendererCache.cacheRenderer(param1);
      }
      
      public function createRenderer() : IDataRenderer
      {
         if(this.itemRenderer)
         {
            return this.rendererCache.getRenderer();
         }
         return null;
      }
   }
}
