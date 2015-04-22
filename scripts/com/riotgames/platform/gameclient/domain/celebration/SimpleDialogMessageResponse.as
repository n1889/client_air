package com.riotgames.platform.gameclient.domain.celebration
{
   public class SimpleDialogMessageResponse extends Object
   {
      
      public static const ACKNOWLEDGE_COMMAND:String = "ack";
      
      public var accountId:Number;
      
      public var command:String;
      
      public var msgId:String;
      
      public function SimpleDialogMessageResponse()
      {
         super();
      }
   }
}
