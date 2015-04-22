package com.riotgames.platform.gameclient.chat
{
   import com.riotgames.platform.provider.IProvider;
   import com.riotgames.platform.gameclient.chat.domain.DockedPrompt;
   import blix.signals.ISignal;
   
   public interface INotificationsProvider extends IProvider
   {
      
      function getNotifications() : Vector.<DockedPrompt>;
      
      function showDockedPrompt(param1:DockedPrompt) : void;
      
      function getNotificationRemoved() : ISignal;
      
      function getNotificationsChanged() : ISignal;
      
      function getNotificationAdded() : ISignal;
      
      function removeNotification(param1:DockedPrompt, param2:String, param3:String = null, param4:Boolean = true) : void;
   }
}
