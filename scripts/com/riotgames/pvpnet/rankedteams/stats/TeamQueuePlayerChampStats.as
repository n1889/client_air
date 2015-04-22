package com.riotgames.pvpnet.rankedteams.stats
{
   import flash.utils.Dictionary;
   import com.riotgames.platform.gameclient.domain.AggregatedStat;
   import com.riotgames.platform.gameclient.domain.AggregatedStatType;
   
   public class TeamQueuePlayerChampStats extends Object
   {
      
      public var champId:int;
      
      public var champStatsMap:Dictionary;
      
      public function TeamQueuePlayerChampStats()
      {
         this.champStatsMap = new Dictionary();
         super();
      }
      
      public function processStat(param1:AggregatedStat) : void
      {
         var _loc2_:AggregatedStat = this.champStatsMap[param1.statType];
         if(!_loc2_)
         {
            _loc2_ = param1.duplicate();
            this.champStatsMap[param1.statType] = _loc2_;
         }
         else
         {
            _loc2_.combine(param1);
         }
      }
      
      public function getStat(param1:String) : AggregatedStat
      {
         return this.champStatsMap[param1];
      }
      
      public function getStatValue(param1:String) : Number
      {
         var _loc2_:AggregatedStat = this.getStat(param1);
         return _loc2_?_loc2_.value:0;
      }
      
      public function getGamesPlayed() : int
      {
         return this.getStatValue(AggregatedStatType.STAT_TYPE_WINS) + this.getStatValue(AggregatedStatType.STAT_TYPE_LOSSES);
      }
   }
}
