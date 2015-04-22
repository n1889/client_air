package com.riotgames.platform.gameclient.domain.store
{
   import com.riotgames.platform.gameclient.notification.IClientNotification;
   import com.riotgames.platform.gameclient.notification.ClientNotificationType;
   
   public class RentalUpdateNotification extends Object implements IClientNotification
   {
      
      public var inventoryType:String;
      
      public var data:Object;
      
      public function RentalUpdateNotification()
      {
         super();
      }
      
      public function get notificationType() : String
      {
         return ClientNotificationType.RENTAL_UPDATE;
      }
   }
}
