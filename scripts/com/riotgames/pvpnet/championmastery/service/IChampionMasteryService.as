package com.riotgames.pvpnet.championmastery.service
{
   import com.riotgames.pvpnet.championmastery.service.async.response.IGetChampionMasteryServiceResponseHandler;
   import com.riotgames.pvpnet.championmastery.service.async.response.IGetAllChampionMasteriesServiceResponseHandler;
   import com.riotgames.pvpnet.championmastery.service.async.response.IGetTopChampionMasteriesServiceResponseHandler;
   import com.riotgames.pvpnet.championmastery.service.async.response.IGetChampionMasteryRewardsForPlayerServiceResponseHandler;
   
   public interface IChampionMasteryService
   {
      
      function getChampionMastery(param1:Number, param2:Number, param3:IGetChampionMasteryServiceResponseHandler) : void;
      
      function getAllChampionMasteries(param1:Number, param2:IGetAllChampionMasteriesServiceResponseHandler) : void;
      
      function getTopChampionMasteries(param1:Number, param2:int, param3:IGetTopChampionMasteriesServiceResponseHandler) : void;
      
      function getBestChampionForPlayers(param1:Array, param2:Object) : void;
      
      function getChampionMasteryHistory(param1:Number, param2:Number, param3:Object) : void;
      
      function getChampionMasteryHistories(param1:Number, param2:Object) : void;
      
      function getChampionMasteryRewardsForPlayerAndChampion(param1:Number, param2:Number, param3:Object) : void;
      
      function getChampionMasteryRewardsForPlayer(param1:Number, param2:IGetChampionMasteryRewardsForPlayerServiceResponseHandler) : void;
   }
}
