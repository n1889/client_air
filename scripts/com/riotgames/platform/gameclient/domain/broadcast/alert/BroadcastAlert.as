package com.riotgames.platform.gameclient.domain.broadcast.alert
{
   import com.riotgames.platform.gameclient.notification.IClientNotification;
   import com.riotgames.platform.gameclient.notification.ClientNotificationType;
   
   public class BroadcastAlert extends Object implements IClientNotification
   {
      
      public var alertMessage:String = null;
      
      public function BroadcastAlert()
      {
         super();
      }
      
      public function get notificationType() : String
      {
         return ClientNotificationType.ALERT;
      }
   }
}
