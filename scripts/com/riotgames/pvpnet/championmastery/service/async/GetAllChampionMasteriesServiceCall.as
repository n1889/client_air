package com.riotgames.pvpnet.championmastery.service.async
{
   import com.riotgames.platform.gameclient.championmastery.ChampionMasteryDTO;
   import com.riotgames.platform.common.services.lcdsproxy.ILcdsProxyServiceMessenger;
   import com.riotgames.platform.common.utils.encode.IEncode;
   import com.riotgames.pvpnet.championmastery.service.async.response.IGetAllChampionMasteriesServiceResponseHandler;
   
   public class GetAllChampionMasteriesServiceCall extends ChampionMasteryAsyncServiceCall
   {
      
      private static const METHOD_NAME:String = "getAllChampionMasteries";
      
      private var _summonerId:Number;
      
      public function GetAllChampionMasteriesServiceCall(param1:ILcdsProxyServiceMessenger, param2:IEncode, param3:IGetAllChampionMasteriesServiceResponseHandler, param4:Number)
      {
         var _loc5_:Function = param3.handleGetAllChampionMasteriesDataSuccess;
         var _loc6_:Function = param3.handleGetAllChampionMasteriesDataFail;
         super(param1,METHOD_NAME,param2,true,_loc5_,_loc6_);
         this._summonerId = param4;
      }
      
      override public function getRequestPayload(param1:Object = null) : Object
      {
         return [this._summonerId];
      }
      
      override protected function processResponsePayload(param1:Object) : Object
      {
         if((!param1) || (!param1 is Array))
         {
            return null;
         }
         var _loc2_:Array = param1 as Array;
         var _loc3_:Vector.<ChampionMasteryDTO> = new Vector.<ChampionMasteryDTO>(_loc2_.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_[_loc4_] = ChampionMasteryDTO.fromObject(_loc2_[_loc4_]);
            _loc4_++;
         }
         return _loc3_;
      }
   }
}
