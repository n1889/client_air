package com.riotgames.pvpnet.system.messaging
{
   import com.riotgames.platform.common.services.ServiceProxy;
   import mx.logging.ILogger;
   import mx.collections.ArrayCollection;
   import mx.messaging.events.MessageEvent;
   import com.riotgames.platform.gameclient.notification.IClientNotification;
   import com.riotgames.platform.common.event.BroadcastMessageEvent;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   
   public class BroadcastMessageController extends Object implements IBroadcastMessageProvider
   {
      
      public var serviceProxy:ServiceProxy;
      
      private var messageQueue:MessageQueue;
      
      private var messageListeners:Array;
      
      private var logger:ILogger;
      
      public function BroadcastMessageController()
      {
         this.serviceProxy = ServiceProxy.instance;
         this.messageListeners = new Array();
         this.logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         super();
      }
      
      public function initialize() : void
      {
         if(this.serviceProxy.messageRouterService != null)
         {
            this.messageQueue = new MessageQueue("nonGame",this.onBroadcastMessageReceived);
            this.serviceProxy.messageRouterService.addBroadcastMessageListener(this.messageQueue.onMessageReceived);
         }
      }
      
      public function addMessageListener(param1:String, param2:Function) : void
      {
         var _loc3_:ArrayCollection = this.messageListeners[param1] as ArrayCollection;
         if(_loc3_ == null)
         {
            _loc3_ = new ArrayCollection();
            this.messageListeners[param1] = _loc3_;
         }
         _loc3_.addItem(param2);
      }
      
      public function removeMessageListener(param1:String, param2:Function) : void
      {
         var _loc3_:ArrayCollection = this.messageListeners[param1] as ArrayCollection;
         if(_loc3_ == null)
         {
            _loc3_ = new ArrayCollection();
            this.messageListeners[param1] = _loc3_;
         }
         var _loc4_:int = _loc3_.getItemIndex(param2);
         if(_loc4_ >= 0)
         {
            _loc3_.removeItemAt(_loc4_);
         }
      }
      
      private function onBroadcastMessageReceived(param1:MessageEvent) : void
      {
         var _loc5_:Function = null;
         var _loc2_:IClientNotification = param1.message.body as IClientNotification;
         var _loc3_:BroadcastMessageEvent = new BroadcastMessageEvent(_loc2_.notificationType,_loc2_);
         var _loc4_:ArrayCollection = this.messageListeners[_loc2_.notificationType] as ArrayCollection;
         if(_loc4_ == null)
         {
            return;
         }
         for each(_loc5_ in _loc4_)
         {
            _loc5_.apply(null,[_loc3_]);
         }
      }
   }
}
