package com.riotgames.platform.common.components
{
   import mx.core.IDataRenderer;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getDefinitionByName;
   import mx.core.ClassFactory;
   
   public class RendererCache extends Object
   {
      
      protected var generator:Class;
      
      protected var _itemRenderer:ClassFactory;
      
      protected var availableRenderers:Array;
      
      public function RendererCache()
      {
         this.availableRenderers = [];
         super();
      }
      
      public function cacheRenderer(param1:IDataRenderer) : void
      {
         var _loc2_:String = getQualifiedClassName(param1);
         var _loc3_:Class = getDefinitionByName(_loc2_) as Class;
         if((this.generator) && (this.generator == _loc3_))
         {
            this.availableRenderers.push(param1);
         }
      }
      
      public function getRenderer() : IDataRenderer
      {
         if(this.availableRenderers.length > 0)
         {
            return this.availableRenderers.pop();
         }
         if(this.itemRenderer)
         {
            return this.itemRenderer.newInstance();
         }
         return null;
      }
      
      public function set itemRenderer(param1:ClassFactory) : void
      {
         this._itemRenderer = param1;
         if(this._itemRenderer)
         {
            this.generator = this._itemRenderer.generator;
         }
         else
         {
            this.generator = null;
         }
         this.availableRenderers = [];
      }
      
      public function get itemRenderer() : ClassFactory
      {
         return this._itemRenderer;
      }
   }
}
