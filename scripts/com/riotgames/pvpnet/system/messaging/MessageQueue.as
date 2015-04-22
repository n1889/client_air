package com.riotgames.pvpnet.system.messaging
{
   import mx.logging.ILogger;
   import mx.messaging.events.MessageEvent;
   import com.riotgames.pvpnet.system.alerter.AlertAction;
   import com.riotgames.pvpnet.system.config.ClientConfig;
   import com.riotgames.util.logging.UncaughtErrorRelay;
   import com.riotgames.platform.common.utils.RiotResourceLoader;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   
   public class MessageQueue extends Object
   {
      
      private var _name:String;
      
      private var _messageHandlerFunction:Function;
      
      private var _queue:Array;
      
      private var _isBusy:Boolean = false;
      
      private var logger:ILogger;
      
      public function MessageQueue(param1:String, param2:Function)
      {
         this._queue = [];
         this.logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         super();
         this._name = param1;
         this._messageHandlerFunction = param2;
      }
      
      public function holdMessages() : void
      {
         this._isBusy = true;
      }
      
      public function releaseMessages() : void
      {
         this._isBusy = false;
         this.processNextQueuedMessage();
      }
      
      public function onMessageReceived(param1:MessageEvent) : void
      {
         this.queueMessage(param1);
      }
      
      private function queueMessage(param1:MessageEvent) : void
      {
         this._queue.push(param1);
         this.processNextQueuedMessage();
      }
      
      private function processNextQueuedMessage() : void
      {
         var alertAction:AlertAction = null;
         if((this._isBusy) || (this._queue.length == 0))
         {
            return;
         }
         this._isBusy = true;
         var event:MessageEvent = this._queue.shift() as MessageEvent;
         if(ClientConfig.instance.debugMessageQueue)
         {
            this._messageHandlerFunction.apply(null,[event]);
            this._isBusy = false;
            this.processNextQueuedMessage();
         }
         else
         {
            try
            {
               this._messageHandlerFunction.apply(null,[event]);
            }
            catch(error:Error)
            {
               UncaughtErrorRelay.pushError("MessageQueue",error);
               alertAction = new AlertAction(RiotResourceLoader.getString("general_generalAlertErrorTitle","Error"),RiotResourceLoader.getString("generalMessageQueueErrorMessage","An unhandled error has occurred. Please restart your client."));
               alertAction.add();
            }
            finally
            {
               this._isBusy = false;
               this.processNextQueuedMessage();
            }
         }
         if(ClientConfig.instance.debugMessageQueue)
         {
            return;
         }
      }
   }
}
