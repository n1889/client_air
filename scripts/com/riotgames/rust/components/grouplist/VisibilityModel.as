package com.riotgames.rust.components.grouplist
{
   import blix.assets.proxy.DisplayObjectContainerProxy;
   import flash.geom.Rectangle;
   import blix.signals.Signal;
   
   public class VisibilityModel extends Object
   {
      
      public var visibilityContext:DisplayObjectContainerProxy;
      
      private var _visibleRect:Rectangle;
      
      public var visibleRectChanged:Signal;
      
      public function VisibilityModel()
      {
         this.visibleRectChanged = new Signal();
         super();
      }
      
      public function get visibleRect() : Rectangle
      {
         return this._visibleRect;
      }
      
      public function set visibleRect(param1:Rectangle) : void
      {
         this._visibleRect = param1;
         this.visibleRectChanged.dispatch(this);
      }
   }
}
