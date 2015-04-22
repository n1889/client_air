package com.riotgames.platform.common.services.lcdsproxy.servicecalls
{
   import com.riotgames.platform.common.services.lcdsproxy.responses.factory.ILcdsProxyMessageActionFactory;
   import blix.action.IAction;
   import com.riotgames.platform.common.services.lcdsproxy.ILcdsProxyServiceMessenger;
   import com.riotgames.platform.common.utils.encode.IEncode;
   
   public class AsyncLcdsProxyServiceCall extends LcdsProxyServiceCall implements IAsyncLcdsProxyServiceCall
   {
      
      public static const TIMEOUT_LIFETIME_DEFAULT:int = 5 * 1000;
      
      public static const SERVICE_CALL_TIMEOUT_STATUS:String = "ASYNC_TIMEOUT";
      
      private var _ackReceived:Boolean = false;
      
      private var _responseFactory:ILcdsProxyMessageActionFactory;
      
      private var _timeoutLifetime:Number;
      
      private var _timeoutDuration:Number;
      
      private var _responseReceived:Boolean = false;
      
      private var _completeReceived:Boolean = false;
      
      protected var _eligibleForTimeout:Boolean = true;
      
      public function AsyncLcdsProxyServiceCall(param1:ILcdsProxyServiceMessenger, param2:String, param3:String, param4:IEncode = null, param5:ILcdsProxyMessageActionFactory = null, param6:int = 5000.0)
      {
         super(param1,param2,param3,param4);
         this._timeoutDuration = 0;
         this._timeoutLifetime = param6;
         this._responseFactory = param5;
      }
      
      public function handleAck() : void
      {
         this._ackReceived = true;
         this.joinAsyncComplete();
      }
      
      override public function handleResponse(param1:String = null, param2:String = null) : void
      {
         super.handleResponse(param1,param2);
         this._responseReceived = true;
         this.joinAsyncComplete();
      }
      
      public function get timeoutLifetime() : Number
      {
         return this._timeoutLifetime;
      }
      
      public function get eligibleForTimeout() : Boolean
      {
         return this._eligibleForTimeout;
      }
      
      public function handleTimeout() : void
      {
         handleError(SERVICE_CALL_TIMEOUT_STATUS);
      }
      
      private function joinAsyncComplete() : void
      {
         if((this._responseReceived) && (this._completeReceived))
         {
            this.onAsyncComplete();
         }
      }
      
      public function get timeoutDuration() : Number
      {
         return this._timeoutDuration;
      }
      
      public function set timeoutDuration(param1:Number) : void
      {
         this._timeoutDuration = param1;
      }
      
      protected function onAsyncComplete() : void
      {
         var _loc1_:IAction = !(this._responseFactory == null)?this._responseFactory.createAction(_responseMethodName,_responsePayload):null;
         if(_loc1_)
         {
            _loc1_.getErred().addOnce(err);
            _loc1_.invoke();
         }
         super.handleComplete();
      }
      
      override public function handleComplete(param1:Object = null) : void
      {
         this._completeReceived = true;
         this.joinAsyncComplete();
      }
      
      override protected function doInvocation() : void
      {
         this._lcdsProxyMessenger.invokeAsyncProxyServiceWithoutSession(this);
         logServiceRequest();
      }
   }
}
