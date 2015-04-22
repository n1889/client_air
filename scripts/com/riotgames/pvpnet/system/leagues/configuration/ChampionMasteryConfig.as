package com.riotgames.pvpnet.system.leagues.configuration
{
   import com.riotgames.pvpnet.system.config.cdc.DynamicClientConfigManager;
   
   public class ChampionMasteryConfig extends Object
   {
      
      private static const NAMESPACE:String = "ChampionMasteryConfig";
      
      private static const ENABLED:String = "Enabled";
      
      private static const EOG_ENABLED:String = "EndOfGameEnabled";
      
      private static const GRADE_ENABLED:String = "GradeEnabled";
      
      private static const MIN_SUMMONER_LEVEL:String = "MinSummonerLevel";
      
      private static const MAX_CHAMPION_LEVEL:String = "MaxChampionLevel";
      
      private static const CAP_UNLOCK_CHAMPION_LEVEL:String = "CapUnlockChampionLevel";
      
      private static const SUPPORTED_QUEUE_TYPES:String = "SupportedQueueTypes";
      
      private static const DEFAULT_SUPPORTED_QUEUE_TYPES:String = "RANKED_SOLO_5x5,RANKED_SOLO_3x3,RANKED_TEAM_5x5,RANKED_TEAM_3x3,NORMAL_3x3,NORMAL,CAP_5x5,ARAM_UNRANKED_5x5";
      
      public function ChampionMasteryConfig()
      {
         super();
      }
      
      public static function isEnabled() : Boolean
      {
         return DynamicClientConfigManager.getConfiguration(NAMESPACE,ENABLED,false,null).getBoolean();
      }
      
      public static function isEndOfGameEnabled() : Boolean
      {
         return DynamicClientConfigManager.getConfiguration(NAMESPACE,EOG_ENABLED,false,null).getBoolean();
      }
      
      public static function isGradeEnabled() : Boolean
      {
         return DynamicClientConfigManager.getConfiguration(NAMESPACE,GRADE_ENABLED,true,null).getBoolean();
      }
      
      public static function getMinSummonerLevel() : int
      {
         return DynamicClientConfigManager.getConfiguration(NAMESPACE,MIN_SUMMONER_LEVEL,5,null).getInt();
      }
      
      public static function getMaxChampionLevel() : int
      {
         return DynamicClientConfigManager.getConfiguration(NAMESPACE,MAX_CHAMPION_LEVEL,5,null).getInt();
      }
      
      public static function getCapUnlockChampionLevel() : int
      {
         return DynamicClientConfigManager.getConfiguration(NAMESPACE,CAP_UNLOCK_CHAMPION_LEVEL,4,null).getInt();
      }
      
      public static function isSupportQueueType(param1:String) : Boolean
      {
         var _loc2_:String = DynamicClientConfigManager.getConfiguration(NAMESPACE,SUPPORTED_QUEUE_TYPES,DEFAULT_SUPPORTED_QUEUE_TYPES,null).getString();
         if(!_loc2_)
         {
            return false;
         }
         var _loc3_:Array = _loc2_.split(",");
         return _loc3_.indexOf(param1) >= 0;
      }
   }
}
