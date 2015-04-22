package com.riotgames.platform.gameclient.views
{
   import com.riotgames.platform.provider.IProvider;
   import com.riotgames.platform.gameclient.domain.EndOfGameStats;
   import com.riotgames.platform.gameclient.domain.rankedTeams.MatchHistorySummary;
   import flash.utils.Dictionary;
   
   public interface IEndOfGameScoreboardProvider extends IProvider
   {
      
      function getScoreboardForStats(param1:EndOfGameStats, param2:MatchHistorySummary, param3:Boolean) : IScoreboard;
      
      function navigateToEndOfGameScreen(param1:EndOfGameStats, param2:MatchHistorySummary, param3:String, param4:Function, param5:Boolean) : void;
      
      function navigateToFakeEndOfGameScreen(param1:String = "CLASSIC", param2:String = "NONE", param3:Array = null, param4:Boolean = true, param5:Boolean = true, param6:Boolean = false, param7:Boolean = false, param8:int = 28, param9:Boolean = false, param10:Dictionary = null, param11:Number = 666) : void;
      
      function isGameNavigationAllowed() : Boolean;
   }
}
