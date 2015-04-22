package com.riotgames.platform.common.provider
{
   import com.riotgames.platform.provider.IProvider;
   import blix.signals.Signal;
   import blix.assets.proxy.DisplayAdapter;
   
   public interface IChampionMasteryEndOfGameStatsProvider extends IProvider
   {
      
      function setEndOfGameStatsController(param1:*) : void;
      
      function processLatestMessage(param1:Object) : Boolean;
      
      function get updateMessageReceivedSignal() : Signal;
      
      function showEndOfStatsView(param1:DisplayAdapter) : void;
   }
}
