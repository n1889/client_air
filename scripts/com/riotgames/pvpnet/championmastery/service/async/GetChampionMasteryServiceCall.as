package com.riotgames.pvpnet.championmastery.service.async
{
   import com.riotgames.platform.gameclient.championmastery.ChampionMasteryDTO;
   import com.riotgames.platform.common.services.lcdsproxy.ILcdsProxyServiceMessenger;
   import com.riotgames.platform.common.utils.encode.IEncode;
   import com.riotgames.pvpnet.championmastery.service.async.response.IGetChampionMasteryServiceResponseHandler;
   
   public class GetChampionMasteryServiceCall extends ChampionMasteryAsyncServiceCall
   {
      
      private static const METHOD_NAME:String = "getChampionMastery";
      
      private var _summonerId:Number;
      
      private var _championId:Number;
      
      public function GetChampionMasteryServiceCall(param1:ILcdsProxyServiceMessenger, param2:IEncode, param3:IGetChampionMasteryServiceResponseHandler, param4:Number, param5:Number)
      {
         var _loc6_:Function = param3.handleGetChampionMasteryDataSuccess;
         var _loc7_:Function = param3.handleGetChampionMasteryDataFail;
         super(param1,METHOD_NAME,param2,true,_loc6_,_loc7_);
         this._summonerId = param4;
         this._championId = param5;
      }
      
      override public function getRequestPayload(param1:Object = null) : Object
      {
         return [this._summonerId,this._championId];
      }
      
      override protected function processResponsePayload(param1:Object) : Object
      {
         if(!param1)
         {
            return null;
         }
         return ChampionMasteryDTO.fromObject(param1);
      }
   }
}
