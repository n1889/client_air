package com.riotgames.pvpnet.system.notification
{
   import com.riotgames.pvpnet.system.alerter.IAlerterProvider;
   import com.riotgames.platform.common.services.ServiceProxy;
   import com.riotgames.pvpnet.system.messaging.MessageQueue;
   import com.riotgames.platform.common.services.lcdsproxy.ILcdsProxyMessageRouter;
   import mx.logging.ILogger;
   import mx.collections.ArrayCollection;
   import mx.messaging.events.MessageEvent;
   import com.riotgames.platform.gameclient.notification.LcdsServiceProxyResponse;
   import com.riotgames.platform.gameclient.notification.IClientNotification;
   import com.riotgames.util.json.jsonEncode;
   import com.riotgames.pvpnet.system.alerter.AlerterProviderProxy;
   import com.riotgames.platform.common.services.lcdsproxy.LcdsProxyMessageRouter;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   
   public class ClientNotificationController extends Object implements IClientNotificationProvider
   {
      
      public var alerter:IAlerterProvider;
      
      public var serviceProxy:ServiceProxy;
      
      private var messageQueue:MessageQueue;
      
      private var messageListeners:Array;
      
      public var _lcdsProxyMessageRouter:ILcdsProxyMessageRouter;
      
      private var logger:ILogger;
      
      public function ClientNotificationController()
      {
         this.alerter = AlerterProviderProxy.instance;
         this.serviceProxy = ServiceProxy.instance;
         this.messageListeners = [];
         this._lcdsProxyMessageRouter = new LcdsProxyMessageRouter();
         this.logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         super();
      }
      
      public function getLcdsProxyMessageRouter() : ILcdsProxyMessageRouter
      {
         return this._lcdsProxyMessageRouter;
      }
      
      public function initializeClientNotifications() : void
      {
         if(this.serviceProxy.messageRouterService != null)
         {
            this.messageQueue = new MessageQueue("nonGame",this.onNonGameMessageReceived);
            this.messageQueue.holdMessages();
            this.serviceProxy.messageRouterService.addClientNotificationMessageListener(this.messageQueue.onMessageReceived);
         }
      }
      
      public function enableNotificationProcessing() : void
      {
         this.messageQueue.releaseMessages();
      }
      
      public function addClientNotificationMessageListener(param1:String, param2:Function) : void
      {
         var _loc3_:ArrayCollection = this.messageListeners[param1] as ArrayCollection;
         if(_loc3_ == null)
         {
            _loc3_ = new ArrayCollection();
            this.messageListeners[param1] = _loc3_;
         }
         _loc3_.addItem(param2);
      }
      
      public function removeClientNotificationMessageListener(param1:String, param2:Function) : void
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
      
      private function onNonGameMessageReceived(param1:MessageEvent) : void
      {
         var _loc2_:LcdsServiceProxyResponse = null;
         var _loc3_:String = null;
         if(param1.message.body is IClientNotification)
         {
            this.handleClientNotififcationMessageReceived(param1.message.body as IClientNotification);
         }
         else if(param1.message.body is LcdsServiceProxyResponse)
         {
            _loc2_ = param1.message.body as LcdsServiceProxyResponse;
            _loc3_ = jsonEncode(_loc2_);
            this._lcdsProxyMessageRouter.onMessageReceived(_loc3_);
         }
         
      }
      
      private function handleClientNotififcationMessageReceived(param1:IClientNotification) : void
      {
         var _loc4_:Function = null;
         var _loc2_:ClientNotificationEvent = new ClientNotificationEvent(param1.notificationType,param1);
         var _loc3_:ArrayCollection = this.messageListeners[param1.notificationType] as ArrayCollection;
         if(_loc3_ == null)
         {
            return;
         }
         for each(_loc4_ in _loc3_)
         {
            _loc4_.apply(null,[_loc2_]);
         }
      }
   }
}
