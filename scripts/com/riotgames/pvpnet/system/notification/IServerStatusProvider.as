package com.riotgames.pvpnet.system.notification
{
   import com.riotgames.platform.provider.IProvider;
   import com.riotgames.platform.gameclient.domain.broadcast.BroadcastMessage;
   import mx.collections.ArrayCollection;
   import blix.signals.ISignal;
   import com.riotgames.platform.gameclient.controllers.notification.TickerMessageListener;
   
   public interface IServerStatusProvider extends IProvider
   {
      
      function initializePoller() : void;
      
      function stopPolling() : void;
      
      function addRemoteMessage(param1:BroadcastMessage) : void;
      
      function addLocalMessage(param1:BroadcastMessage) : void;
      
      function addPlatformMessage(param1:BroadcastMessage) : void;
      
      function initiateServerStatusMonitoring(param1:String, param2:String) : void;
      
      function clearPlatformMessages() : void;
      
      function clearRemoteMessages() : void;
      
      function clearLocalMessages() : void;
      
      function clearAllMessages() : void;
      
      function getAllMessages() : ArrayCollection;
      
      function getAllMessagesChanged() : ISignal;
      
      function addMessageListener(param1:TickerMessageListener) : void;
      
      function removeMessageListener(param1:TickerMessageListener) : void;
      
      function getStatusRefreshed() : ISignal;
   }
}
