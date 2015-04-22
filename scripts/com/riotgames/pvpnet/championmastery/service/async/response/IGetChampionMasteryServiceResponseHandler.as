package com.riotgames.pvpnet.championmastery.service.async.response
{
   import com.riotgames.platform.gameclient.championmastery.ChampionMasteryDTO;
   
   public interface IGetChampionMasteryServiceResponseHandler
   {
      
      function handleGetChampionMasteryDataSuccess(param1:ChampionMasteryDTO) : void;
      
      function handleGetChampionMasteryDataFail(param1:Error) : void;
   }
}
