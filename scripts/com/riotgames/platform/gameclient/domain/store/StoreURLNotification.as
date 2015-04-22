package com.riotgames.platform.gameclient.domain.store
{
   import com.riotgames.platform.gameclient.notification.IClientNotification;
   import com.riotgames.platform.gameclient.notification.ClientNotificationType;
   
   public class StoreURLNotification extends Object implements IClientNotification
   {
      
      public var token:String;
      
      public var storeBaseUrl:String;
      
      public function StoreURLNotification()
      {
         super();
      }
      
      public function get notificationType() : String
      {
         return ClientNotificationType.STORE_URL;
      }
      
      public function get storeURL() : String
      {
         return this.storeBaseUrl + "?sessionId=" + this.token;
      }
   }
}
