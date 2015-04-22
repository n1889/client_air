package com.riotgames.platform.common.services
{
   import com.riotgames.platform.common.responder.Responder;
   import com.riotgames.platform.common.services.lcdsproxy.ILcdsProxyServiceMessenger;
   import com.riotgames.platform.common.services.lcdsproxy.servicecalls.IAsyncLcdsProxyServiceCall;
   import com.riotgames.platform.common.services.lcdsproxy.servicecalls.ILcdsProxyServiceCall;
   import com.riotgames.platform.gameclient.services.IBaseLcdsService;
   import flash.utils.Dictionary;
   
   public class PartyRewardsService extends Responder implements ILcdsProxyServiceMessenger
   {
      
      public static const ENDPOINT_NAME:String = "lcdsServiceProxy";
      
      public static const ACK_STATUS:String = "ACK";
      
      public static const METHOD_NAME:String = "call";
      
      public static const SERVICE_CALL_SUCCESS_STATUS:String = "OK";
      
      private var _lcdsService:IBaseLcdsService;
      
      private var callDictionary:Dictionary;
      
      public function PartyRewardsService(param1:IBaseLcdsService)
      {
         super();
         this.callDictionary = new Dictionary();
         this._lcdsService = param1;
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
               _loc5_.handleResponse(param3,param4);
            }
            else
            {
               _loc5_.handleError(param2);
            }
            
            
         }
      }
      
      public function invokeAsyncProxyServiceWithSession(param1:IAsyncLcdsProxyServiceCall) : String
      {
         this.callDictionary[param1.uuid] = param1;
         return this.invokeProxyServiceWithSession(param1);
      }
      
      public function invokeProxyServiceWithSession(param1:ILcdsProxyServiceCall) : String
      {
         this._lcdsService.invokeServiceWithSession(ENDPOINT_NAME,METHOD_NAME,param1.toMessage(),onResult,param1.handleComplete,null,param1.asyncObject,false,false,false);
         return param1.uuid;
      }
      
      public function invokeProxyServiceWithoutSession(param1:ILcdsProxyServiceCall) : String
      {
         this._lcdsService.invokeServiceWithoutSession(ENDPOINT_NAME,METHOD_NAME,param1.toMessage(),this.onResult,param1.handleComplete,null,param1.asyncObject,false,false,false);
         return param1.uuid;
      }
      
      public function invokeAsyncProxyServiceWithoutSession(param1:IAsyncLcdsProxyServiceCall) : String
      {
         this.callDictionary[param1.uuid] = param1;
         return this.invokeProxyServiceWithoutSession(param1);
      }
      
      public function destroy() : void
      {
      }
   }
}
