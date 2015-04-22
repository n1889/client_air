package com.riotgames.platform.common.provider
{
   import com.riotgames.platform.provider.IProvider;
   import blix.signals.ISignal;
   import com.riotgames.platform.gameclient.domain.SummonerLeagueItemAndProgressDTO;
   
   public interface ILeagueDataProvider extends IProvider
   {
      
      function get tierReward() : String;
      
      function getApexCountdownUpdated() : ISignal;
      
      function get selfRewardIcon() : int;
      
      function getUpdateApexCountdownMs() : Number;
      
      function setSeasonRewardsEarned(param1:SummonerLeagueItemAndProgressDTO) : void;
      
      function get teamRewardLevel() : int;
      
      function get teamReward() : int;
      
      function getSeasonRewardsUpdateComplete() : ISignal;
      
      function get leaguesUpdateComplete() : ISignal;
   }
}
