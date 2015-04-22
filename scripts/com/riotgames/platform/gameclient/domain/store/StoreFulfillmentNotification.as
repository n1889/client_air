package com.riotgames.platform.gameclient.domain.store
{
   import com.riotgames.platform.gameclient.notification.IClientNotification;
   import com.riotgames.platform.gameclient.notification.ClientNotificationType;
   
   public class StoreFulfillmentNotification extends Object implements IClientNotification
   {
      
      public var inventoryType:String;
      
      public var ip:Number;
      
      public var data:Object;
      
      public var rp:Number;
      
      public function StoreFulfillmentNotification()
      {
         super();
      }
      
      public function get notificationType() : String
      {
         return ClientNotificationType.FULFILLMENT;
      }
   }
}
