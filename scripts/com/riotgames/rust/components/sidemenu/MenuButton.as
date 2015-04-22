package com.riotgames.rust.components.sidemenu
{
   import blix.components.button.LabelButtonX;
   import flash.geom.Rectangle;
   import flash.display.InteractiveObject;
   import blix.context.IContext;
   
   public class MenuButton extends LabelButtonX
   {
      
      private var _menuItem:SideBarMenuItem;
      
      public function MenuButton(param1:IContext)
      {
         super(param1);
      }
      
      public function setMenuItem(param1:SideBarMenuItem) : void
      {
         this._menuItem = param1;
      }
      
      public function getMenuItem() : SideBarMenuItem
      {
         return this._menuItem;
      }
      
      public function get header() : String
      {
         return this._menuItem.header;
      }
      
      public function get title() : String
      {
         return this._menuItem.name;
      }
      
      public function get path() : String
      {
         return this._menuItem.path;
      }
      
      override protected function updateLayout(param1:Number, param2:Number) : Rectangle
      {
         var _loc4_:Rectangle = null;
         var _loc3_:InteractiveObject = assetProxy.hitArea;
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.getBounds(_asset);
            return _loc4_;
         }
         return super.updateLayout(param1,param2);
      }
   }
}
