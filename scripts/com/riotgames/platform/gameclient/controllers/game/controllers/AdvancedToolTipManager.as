package com.riotgames.platform.gameclient.controllers.game.controllers
{
   import mx.managers.ToolTipManager;
   import mx.core.IToolTip;
   import mx.managers.ISystemManager;
   import flash.display.DisplayObject;
   import mx.core.IUIComponent;
   import com.riotgames.platform.common.utils.app.ApplicationUtil;
   
   public class AdvancedToolTipManager extends ToolTipManager
   {
      
      private static var _currentToolTip:IToolTip;
      
      private static var _toolTipOpen:Boolean = false;
      
      public function AdvancedToolTipManager()
      {
         super();
      }
      
      private static function destroyToolTip(param1:IToolTip) : void
      {
         var _loc2_:ISystemManager = param1.systemManager;
         _loc2_.toolTipChildren.removeChild(DisplayObject(param1));
         _currentToolTip = null;
         _toolTipOpen = false;
      }
      
      public static function destroyCurrentToolTip() : void
      {
         if(currentToolTip)
         {
            destroyToolTip(currentToolTip);
         }
      }
      
      public static function createCustomToolTip(param1:Number, param2:Number, param3:IToolTip, param4:IUIComponent = null) : void
      {
         if(!param3 is DisplayObject)
         {
            throw new Error("createCustomTooltip called and tooltip is not a DisplayObject!");
         }
         else
         {
            destroyCurrentToolTip();
            var _loc5_:ISystemManager = param4?param4.systemManager:ApplicationUtil.application.systemManager;
            _loc5_.toolTipChildren.addChild(param3 as DisplayObject);
            _currentToolTip = param3;
            param3.move(param1,param2);
            _toolTipOpen = true;
            return;
         }
      }
      
      public static function get currentToolTip() : IToolTip
      {
         return _currentToolTip;
      }
      
      public static function get toolTipOpen() : Boolean
      {
         return _toolTipOpen;
      }
   }
}
