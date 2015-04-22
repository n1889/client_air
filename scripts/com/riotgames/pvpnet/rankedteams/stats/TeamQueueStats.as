package com.riotgames.pvpnet.rankedteams.stats
{
   import com.riotgames.platform.gameclient.domain.LeagueListDTO;
   import com.riotgames.platform.gameclient.domain.rankedTeams.PlayerAggregatedStats;
   import com.riotgames.platform.gameclient.domain.AggregatedStat;
   
   public class TeamQueueStats extends Object
   {
      
      public static const ALL:String = "ALL";
      
      public var teamName:String = "";
      
      public var wins:int = 0;
      
      public var losses:int = 0;
      
      public var isRanked:Boolean = false;
      
      public var isLeague:Boolean = false;
      
      public var league:LeagueListDTO;
      
      public var leaguePoints:int;
      
      public var queueId:String;
      
      public var players:Array;
      
      public var allPlayers:TeamQueuePlayerStats;
      
      public function TeamQueueStats()
      {
         this.players = [];
         this.allPlayers = new TeamQueuePlayerStats();
         super();
      }
      
      public function processPlayerStats(param1:PlayerAggregatedStats) : void
      {
         var _loc3_:AggregatedStat = null;
         var _loc2_:TeamQueuePlayerStats = this.players[param1.playerId];
         if(!_loc2_)
         {
            _loc2_ = new TeamQueuePlayerStats();
            _loc2_.playerId = param1.playerId;
            this.players[_loc2_.playerId] = _loc2_;
         }
         for each(_loc3_ in param1.aggregatedStats.lifetimeStatistics)
         {
            _loc2_.processStat(_loc3_);
            this.allPlayers.processStat(_loc3_);
         }
      }
   }
}
