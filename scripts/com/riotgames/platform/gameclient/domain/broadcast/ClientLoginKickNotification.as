package com.riotgames.platform.gameclient.domain.broadcast
{
   import com.riotgames.platform.gameclient.notification.IClientNotification;
   import com.riotgames.platform.gameclient.notification.ClientNotificationType;
   
   public class ClientLoginKickNotification extends Object implements IClientNotification
   {
      
      public var sessionToken:String;
      
      public function ClientLoginKickNotification()
      {
         super();
      }
      
      public function get notificationType() : String
      {
         return ClientNotificationType.LOGIN_KICK;
      }
   }
}
