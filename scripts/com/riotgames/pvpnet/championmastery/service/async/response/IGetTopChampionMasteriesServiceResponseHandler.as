package com.riotgames.pvpnet.championmastery.service.async.response
{
   import com.riotgames.platform.gameclient.championmastery.ChampionMasteryDTO;
   
   public interface IGetTopChampionMasteriesServiceResponseHandler
   {
      
      function handleGetTopChampionMasteriesDataSuccess(param1:Vector.<ChampionMasteryDTO>) : void;
      
      function handleGetTopChampionMasteriesDataFail(param1:Error) : void;
   }
}
