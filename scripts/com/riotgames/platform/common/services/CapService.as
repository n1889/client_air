package com.riotgames.platform.common.services
{
   import com.riotgames.platform.common.responder.Responder;
   import com.riotgames.platform.common.services.lcdsproxy.ILcdsProxyServiceMessenger;
   import com.riotgames.platform.common.services.lcdsproxy.servicecalls.IAsyncLcdsProxyServiceCall;
   import com.riotgames.platform.common.utils.decode.IDecode;
   import flash.utils.Timer;
   import com.riotgames.platform.gameclient.services.IBaseLcdsService;
   import flash.utils.Dictionary;
   import flash.events.TimerEvent;
   import com.riotgames.platform.common.services.lcdsproxy.servicecalls.ILcdsProxyServiceCall;
   import com.riotgames.pvpnet.tracking.Dradis;
   import blix.signals.Signal;
   
   public class CapService extends Responder implements ILcdsProxyServiceMessenger
   {
      
      public static const STATUS_KEY:String = "status";
      
      public static const DEFAULT_TIMEOUT:Number = 30000;
      
      public static const SERVICE_CALL_SUCCESS_STATUS:String = "OK";
      
      public static const ACK_STATUS:String = "ACK";
      
      public static const METHOD_NAME_KEY:String = "methodName";
      
      public static const SERVICE_NAME_KEY:String = "serviceName";
      
      public static const PAYLOAD_KEY:String = "payload";
      
      public static const METHOD_NAME:String = "call";
      
      public static const MESSAGE_ID_KEY:String = "messageId";
      
      public static const ENDPOINT_NAME:String = "lcdsServiceProxy";
      
      public static const TRACKING_IDENTIFIER:String = "pb__teambuilder__service_call_timeout";
      
      private var _decoder:IDecode;
      
      private var _timer:Timer;
      
      private var _lcdsService:IBaseLcdsService;
      
      protected var callDictionary:Dictionary;
      
      public var useTimeouts:Boolean = true;
      
      private var numPendingResponses:int = 0;
      
      public var timeoutDelay:Number = 30000;
      
      public var timeoutSignal:Signal;
      
      public function CapService(param1:IBaseLcdsService, param2:IDecode)
      {
         this.timeoutSignal = new Signal();
         super();
         this.callDictionary = new Dictionary();
         this._lcdsService = param1;
         this._decoder = param2;
      }
      
      public function invokeAsyncProxyServiceWithoutSession(param1:IAsyncLcdsProxyServiceCall) : String
      {
         this.callDictionary[param1.uuid] = param1;
         param1.getCompleted().addOnce(this.handleServiceCallComplete);
         param1.getErred().addOnce(this.handleServiceCallError);
         if(param1.eligibleForTimeout)
         {
            this.numPendingResponses++;
            this.startTimerIfNeeded();
         }
         return this.invokeProxyServiceWithoutSession(param1);
      }
      
      protected function handleServiceCallComplete(param1:IAsyncLcdsProxyServiceCall) : void
      {
         if(this.callDictionary[param1.uuid])
         {
            delete this.callDictionary[param1.uuid];
            true;
         }
      }
      
      private function startTimerIfNeeded() : void
      {
         this.createTimerIfNeeded();
         if(this.useTimeouts)
         {
            this._timer.reset();
            this._timer.start();
         }
      }
      
      private function handleTimerComplete(param1:TimerEvent) : void
      {
         this._timer.stop();
         this._timer.reset();
         this.numPendingResponses = 0;
         this.signalTimeout();
      }
      
      public function invokeProxyServiceWithoutSession(param1:ILcdsProxyServiceCall) : String
      {
         this._lcdsService.invokeServiceWithoutSession(ENDPOINT_NAME,METHOD_NAME,param1.toMessage(),this.onResult,param1.handleComplete,null,param1.asyncObject,false,false,false);
         return param1.uuid;
      }
      
      public function invokeAsyncProxyServiceWithSession(param1:IAsyncLcdsProxyServiceCall) : String
      {
         this.callDictionary[param1.uuid] = param1;
         param1.getCompleted().addOnce(this.handleServiceCallComplete);
         param1.getErred().addOnce(this.handleServiceCallError);
         if(param1.eligibleForTimeout)
         {
            this.numPendingResponses++;
            this.startTimerIfNeeded();
         }
         return this.invokeProxyServiceWithSession(param1);
      }
      
      protected function signalTimeout() : void
      {
         this.timeoutSignal.dispatch();
         Dradis.track(TRACKING_IDENTIFIER);
      }
      
      protected function handleServiceCallError(param1:IAsyncLcdsProxyServiceCall) : void
      {
         if(this.callDictionary[param1.uuid])
         {
            delete this.callDictionary[param1.uuid];
            true;
         }
      }
      
      public function onMessageReceived(param1:String, param2:String = null, param3:String = null, param4:String = null) : void
      {
         var _loc5_:IAsyncLcdsProxyServiceCall = null;
         if(this.callDictionary[param1])
         {
            _loc5_ = this.callDictionary[param1] as IAsyncLcdsProxyServiceCall;
         }
         if(_loc5_)
         {
            if(!param2)
            {
               _loc5_.handleError(param2);
            }
            else if(param2 == ACK_STATUS)
            {
               _loc5_.handleAck();
            }
            else if(param2 == SERVICE_CALL_SUCCESS_STATUS)
            {
               if(_loc5_.eligibleForTimeout)
               {
                  this.numPendingResponses--;
               }
               this.stopTimerIfNeeded();
               _loc5_.handleResponse(param3,param4);
            }
            else
            {
               _loc5_.handleError(param2);
            }
            
            
         }
      }
      
      public function invokeProxyServiceWithSession(param1:ILcdsProxyServiceCall) : String
      {
         this._lcdsService.invokeServiceWithSession(ENDPOINT_NAME,METHOD_NAME,param1.toMessage(),onResult,param1.handleComplete,null,param1.asyncObject,false,false,false);
         return param1.uuid;
      }
      
      private function stopTimerIfNeeded() : void
      {
         if(this.shouldStopTimer())
         {
            this._timer.stop();
         }
      }
      
      private function shouldStopTimer() : Boolean
      {
         return (this.numPendingResponses <= 0) && (!(this._timer == null));
      }
      
      public function destroy() : void
      {
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.handleTimerComplete);
            this._timer = null;
         }
      }
      
      private function createTimerIfNeeded() : void
      {
         if(!this._timer)
         {
            this._timer = new Timer(this.timeoutDelay);
            this._timer.addEventListener(TimerEvent.TIMER,this.handleTimerComplete);
         }
      }
   }
}
