package com.riotgames.pvpnet.championmastery.service
{
   import com.riotgames.platform.common.responder.Responder;
   import com.riotgames.platform.common.services.lcdsproxy.ILcdsProxyServiceMessenger;
   import flash.utils.Dictionary;
   import com.riotgames.platform.gameclient.services.IBaseLcdsService;
   import com.riotgames.platform.common.utils.decode.IDecode;
   import com.riotgames.pvpnet.system.notification.IClientNotificationProvider;
   import com.riotgames.platform.common.services.lcdsproxy.servicecalls.ILcdsProxyServiceCall;
   import com.riotgames.platform.common.services.lcdsproxy.servicecalls.IAsyncLcdsProxyServiceCall;
   import com.riotgames.pvpnet.championmastery.service.async.ChampionMasteryAsyncServiceCall;
   import com.riotgames.platform.provider.ProviderLookup;
   
   public class ChampionMasteryServiceInternal extends Responder implements ILcdsProxyServiceMessenger
   {
      
      public static const DESTINATION_SERVICE_NAME:String = "championMastery";
      
      private static const SERVICE_ENDPOINT_NAME:String = "lcdsServiceProxy";
      
      private static const SERVICE_METHOD_NAME:String = "call";
      
      public static const SERVICE_STATUS_SUCCESS:String = "OK";
      
      private var _callRoster:Dictionary;
      
      private var _callsPendingResponse:Dictionary;
      
      private var _lcdsService:IBaseLcdsService;
      
      private var _decoder:IDecode;
      
      public function ChampionMasteryServiceInternal(param1:IBaseLcdsService, param2:IDecode)
      {
         super();
         this._callRoster = new Dictionary();
         this._callsPendingResponse = new Dictionary();
         this._lcdsService = param1;
         this._decoder = param2;
         ProviderLookup.getProvider(IClientNotificationProvider,this.onNotificationProvider);
      }
      
      private function onNotificationProvider(param1:IClientNotificationProvider) : void
      {
         param1.getLcdsProxyMessageRouter().setServiceCallListener(DESTINATION_SERVICE_NAME,this);
      }
      
      public function invokeProxyServiceWithSession(param1:ILcdsProxyServiceCall) : String
      {
         this._lcdsService.invokeServiceWithSession(SERVICE_ENDPOINT_NAME,SERVICE_METHOD_NAME,param1.toMessage(),onResult,param1.handleComplete,null,param1.asyncObject,false,false,false);
         return param1.uuid;
      }
      
      public function invokeAsyncProxyServiceWithSession(param1:IAsyncLcdsProxyServiceCall) : String
      {
         this._callRoster[param1.uuid] = param1;
         param1.getCompleted().addOnce(this.onCallComplete);
         this.addPendingResponse(param1);
         return this.invokeProxyServiceWithSession(param1);
      }
      
      public function invokeProxyServiceWithoutSession(param1:ILcdsProxyServiceCall) : String
      {
         this._lcdsService.invokeServiceWithoutSession(SERVICE_ENDPOINT_NAME,SERVICE_METHOD_NAME,param1.toMessage(),onResult,param1.handleComplete,null,param1.asyncObject,false,false,false);
         return param1.uuid;
      }
      
      public function invokeAsyncProxyServiceWithoutSession(param1:IAsyncLcdsProxyServiceCall) : String
      {
         this._callRoster[param1.uuid] = param1;
         param1.getCompleted().addOnce(this.onCallComplete);
         this.addPendingResponse(param1);
         return this.invokeProxyServiceWithoutSession(param1);
      }
      
      public function onMessageReceived(param1:String, param2:String = null, param3:String = null, param4:String = null) : void
      {
         var _loc5_:ChampionMasteryAsyncServiceCall = this._callsPendingResponse[param1];
         if(_loc5_)
         {
            delete this._callsPendingResponse[param1];
            true;
            if(param2 != SERVICE_STATUS_SUCCESS)
            {
               _loc5_.processFail(new Error(param4 + " failed (" + param2 + "): " + param3));
            }
            else
            {
               _loc5_.processSuccess(this._decoder.decode(param3));
            }
         }
      }
      
      private function addPendingResponse(param1:IAsyncLcdsProxyServiceCall) : void
      {
         var _loc2_:ChampionMasteryAsyncServiceCall = null;
         if(param1 is ChampionMasteryAsyncServiceCall)
         {
            _loc2_ = param1 as ChampionMasteryAsyncServiceCall;
            if(_loc2_.requireResponse)
            {
               this._callsPendingResponse[_loc2_.uuid] = _loc2_;
            }
         }
      }
      
      private function onCallComplete(param1:IAsyncLcdsProxyServiceCall) : void
      {
         if(this._callRoster[param1.uuid])
         {
            delete this._callRoster[param1.uuid];
            true;
         }
      }
      
      public function destroy() : void
      {
         this._callRoster = null;
         this._callsPendingResponse = null;
         this._lcdsService = null;
         this._decoder = null;
      }
   }
}
