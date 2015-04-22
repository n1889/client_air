package com.riotgames.platform.gameclient.contextAlert
{
   public class AlertType extends Object
   {
      
      public static const TOP_LEFT:String = "topLeft";
      
      public static const TOP_RIGHT:String = "topRight";
      
      public static const BOTTOM_RIGHT:String = "bottomRight";
      
      public static const BOTTOM_LEFT:String = "bottomLeft";
      
      public static const TOP_MIDDLE:String = "topMiddle";
      
      public function AlertType()
      {
         super();
         throw new Error("Cannot create an instance of this class.");
      }
   }
}
