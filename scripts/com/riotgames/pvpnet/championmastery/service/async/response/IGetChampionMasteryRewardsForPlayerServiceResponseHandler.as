package com.riotgames.pvpnet.championmastery.service.async.response
{
   import com.riotgames.platform.gameclient.championmastery.ChampionMasteryRewardDTO;
   
   public interface IGetChampionMasteryRewardsForPlayerServiceResponseHandler
   {
      
      function handleGetChampionMasteryRewardsForPlayerDataSuccess(param1:Vector.<ChampionMasteryRewardDTO>) : void;
      
      function handleGetChampionMasteryRewardsForPlayerDataFail(param1:Error) : void;
   }
}
