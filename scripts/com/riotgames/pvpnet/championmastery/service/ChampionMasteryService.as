package com.riotgames.pvpnet.championmastery.service
{
   import com.riotgames.platform.common.utils.encode.IEncode;
   import com.riotgames.platform.common.utils.decode.IDecode;
   import com.riotgames.pvpnet.championmastery.service.async.response.IGetChampionMasteryServiceResponseHandler;
   import com.riotgames.pvpnet.championmastery.service.async.GetChampionMasteryServiceCall;
   import com.riotgames.pvpnet.championmastery.service.async.response.IGetAllChampionMasteriesServiceResponseHandler;
   import com.riotgames.pvpnet.championmastery.service.async.GetAllChampionMasteriesServiceCall;
   import com.riotgames.pvpnet.championmastery.service.async.response.IGetTopChampionMasteriesServiceResponseHandler;
   import com.riotgames.pvpnet.championmastery.service.async.GetTopChampionMasteriesServiceCall;
   import com.riotgames.pvpnet.championmastery.service.async.response.IGetChampionMasteryRewardsForPlayerServiceResponseHandler;
   import com.riotgames.pvpnet.championmastery.service.async.GetChampionMasteryRewardsForPlayerServiceCall;
   import com.riotgames.platform.common.utils.encode.JSONEncoder;
   import com.riotgames.platform.common.utils.decode.JSONDecoder;
   
   public class ChampionMasteryService extends Object implements IChampionMasteryService
   {
      
      private var _proxy:ChampionMasteryServiceInternal;
      
      private var _encoder:IEncode;
      
      private var _decoder:IDecode;
      
      public function ChampionMasteryService(param1:ChampionMasteryServiceInternal)
      {
         super();
         this._proxy = param1;
         this._encoder = new JSONEncoder();
         this._decoder = new JSONDecoder();
      }
      
      public function getChampionMastery(param1:Number, param2:Number, param3:IGetChampionMasteryServiceResponseHandler) : void
      {
         var _loc4_:GetChampionMasteryServiceCall = new GetChampionMasteryServiceCall(this._proxy,this._encoder,param3,param1,param2);
         _loc4_.invoke();
      }
      
      public function getAllChampionMasteries(param1:Number, param2:IGetAllChampionMasteriesServiceResponseHandler) : void
      {
         var _loc3_:GetAllChampionMasteriesServiceCall = new GetAllChampionMasteriesServiceCall(this._proxy,this._encoder,param2,param1);
         _loc3_.invoke();
      }
      
      public function getTopChampionMasteries(param1:Number, param2:int, param3:IGetTopChampionMasteriesServiceResponseHandler) : void
      {
         var _loc4_:GetTopChampionMasteriesServiceCall = new GetTopChampionMasteriesServiceCall(this._proxy,this._encoder,param3,param1,param2);
         _loc4_.invoke();
      }
      
      public function getBestChampionForPlayers(param1:Array, param2:Object) : void
      {
         throw new Error("getBestChampionForPlayers not yet implemented");
      }
      
      public function getChampionMasteryHistory(param1:Number, param2:Number, param3:Object) : void
      {
         throw new Error("getChampionMasteryHistory not yet implemented");
      }
      
      public function getChampionMasteryHistories(param1:Number, param2:Object) : void
      {
         throw new Error("getChampionMasteryHistories not yet implemented");
      }
      
      public function getChampionMasteryRewardsForPlayerAndChampion(param1:Number, param2:Number, param3:Object) : void
      {
         throw new Error("getChampionMasteryRewardsForPlayerAndChampion not yet implemented");
      }
      
      public function getChampionMasteryRewardsForPlayer(param1:Number, param2:IGetChampionMasteryRewardsForPlayerServiceResponseHandler) : void
      {
         var _loc3_:GetChampionMasteryRewardsForPlayerServiceCall = new GetChampionMasteryRewardsForPlayerServiceCall(this._proxy,this._encoder,param2,param1);
         _loc3_.invoke();
      }
   }
}
