package com.riotgames.pvpnet.championmastery.service.async.response
{
   import com.riotgames.platform.gameclient.championmastery.ChampionMasteryDTO;
   
   public interface IGetAllChampionMasteriesServiceResponseHandler
   {
      
      function handleGetAllChampionMasteriesDataSuccess(param1:Vector.<ChampionMasteryDTO>) : void;
      
      function handleGetAllChampionMasteriesDataFail(param1:Error) : void;
   }
}
