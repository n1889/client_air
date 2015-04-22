package com.riotgames.pvpnet.summonerprofile
{
   import blix.signals.Signal;
   import com.riotgames.platform.gameclient.domain.BaseSummoner;
   import mx.collections.ArrayCollection;
   import blix.signals.ISignal;
   import com.riotgames.platform.gameclient.domain.Summoner;
   import flash.display.BitmapData;
   import com.riotgames.platform.gameclient.domain.summoner.LevelUpInfo;
   import com.riotgames.platform.gameclient.domain.PlayerStatSummaries;
   
   public interface ISummonerProfileProvider
   {
      
      function get closeLeagueStats() : Signal;
      
      function get baseSummoner() : BaseSummoner;
      
      function set baseSummoner(param1:BaseSummoner) : void;
      
      function get statsSummoner() : BaseSummoner;
      
      function set statsSummoner(param1:BaseSummoner) : void;
      
      function get customSortedChampionList() : ArrayCollection;
      
      function get championStatsChanged() : Signal;
      
      function get serviceBusySignal() : ISignal;
      
      function get isLocalSummoner() : Boolean;
      
      function set isLocalSummoner(param1:Boolean) : void;
      
      function get currentSummoner() : Summoner;
      
      function set currentSummoner(param1:Summoner) : void;
      
      function get currentSummonerIconSource() : BitmapData;
      
      function get currentSummonerLevelUpInfo() : LevelUpInfo;
      
      function get playerStatSummaries() : PlayerStatSummaries;
      
      function getPlayerStatSummariesChangedSignal() : ISignal;
      
      function getCurrentSummonerChangedSignal() : ISignal;
      
      function updateStatsBySummonerName(param1:String) : void;
   }
}
