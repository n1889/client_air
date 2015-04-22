package com.riotgames.pvpnet.system.notification
{
   import flash.events.Event;
   import com.riotgames.platform.gameclient.notification.IClientNotification;
   
   public class ClientNotificationEvent extends Event
   {
      
      public var notification:IClientNotification;
      
      public function ClientNotificationEvent(param1:String, param2:IClientNotification, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.notification = param2;
      }
   }
}
