package com.riotgames.rust.popup
{
   import blix.view.ILayoutElement;
   import blix.view.ILayoutData;
   
   public class PopUpManager extends Object
   {
      
      private static var _instance:IPopUpManager;
      
      public function PopUpManager()
      {
         super();
      }
      
      public static function get instance() : IPopUpManager
      {
         return _instance;
      }
      
      public static function set instance(param1:IPopUpManager) : void
      {
         _instance = param1;
      }
      
      public static function addPopUp(param1:ILayoutElement, param2:ILayoutData = null, param3:Boolean = false) : void
      {
         instance.addPopUp(param1,param2,param3);
      }
      
      public static function removePopUp(param1:ILayoutElement) : Boolean
      {
         return instance.removePopUp(param1);
      }
      
      public static function removeAllPopUps() : void
      {
         instance.removeAllPopUps();
      }
   }
}
