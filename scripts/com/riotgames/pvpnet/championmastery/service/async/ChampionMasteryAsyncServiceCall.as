package com.riotgames.pvpnet.championmastery.service.async
{
   import com.riotgames.platform.common.services.lcdsproxy.servicecalls.AsyncLcdsProxyServiceCall;
   import com.riotgames.platform.common.services.lcdsproxy.ILcdsProxyServiceMessenger;
   import com.riotgames.platform.common.utils.encode.IEncode;
   import com.riotgames.pvpnet.championmastery.service.ChampionMasteryServiceInternal;
   
   public class ChampionMasteryAsyncServiceCall extends AsyncLcdsProxyServiceCall
   {
      
      private var _requireResponse:Boolean;
      
      private var _onSuccess:Function;
      
      private var _onFail:Function;
      
      public function ChampionMasteryAsyncServiceCall(param1:ILcdsProxyServiceMessenger, param2:String, param3:IEncode, param4:Boolean, param5:Function, param6:Function)
      {
         super(param1,ChampionMasteryServiceInternal.DESTINATION_SERVICE_NAME,param2,param3);
         this._requireResponse = param4;
         this._onSuccess = param5;
         this._onFail = param6;
      }
      
      public function get requireResponse() : *
      {
         return this._requireResponse;
      }
      
      public function processSuccess(param1:Object) : void
      {
         this._onSuccess(this.processResponsePayload(param1));
      }
      
      public function processFail(param1:Error) : void
      {
         this._onFail(param1);
      }
      
      protected function processResponsePayload(param1:Object) : Object
      {
         throw new Error("processResponsePayload is abstract and must be implemented");
      }
   }
}
