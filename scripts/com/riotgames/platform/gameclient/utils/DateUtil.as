package com.riotgames.platform.gameclient.utils
{
   import mx.formatters.DateFormatter;
   import com.riotgames.platform.common.utils.RiotResourceLoader;
   
   public class DateUtil extends Object
   {
      
      private static var dateFormat:DateFormatter = null;
      
      private static var dateAndTimeFormat:DateFormatter = null;
      
      public function DateUtil()
      {
         super();
      }
      
      private static function init() : void
      {
         if(!dateAndTimeFormat)
         {
            dateAndTimeFormat = new DateFormatter();
            dateAndTimeFormat.formatString = RiotResourceLoader.getString("dateTimeFormat");
         }
         if(!dateFormat)
         {
            dateFormat = new DateFormatter();
            dateFormat.formatString = RiotResourceLoader.getString("dateFormat");
         }
      }
      
      public static function milisecondsToTimeString(param1:Number) : String
      {
         return secondsToTimeString(param1 / 1000);
      }
      
      public static function getDateAndTimeString(param1:Date) : String
      {
         init();
         return dateAndTimeFormat.format(param1);
      }
      
      public static function secondsToMinSecString(param1:Number) : String
      {
         var _loc2_:int = param1 / 60;
         var _loc3_:int = param1 % 60;
         return (_loc2_ > 0?_loc2_ + RiotResourceLoader.getString("common_time_minutes_very_short") + " ":"") + (_loc3_ > 0?_loc3_ + RiotResourceLoader.getString("common_time_seconds_very_short") + " ":"");
      }
      
      public static function getDateString(param1:Date) : String
      {
         init();
         return dateFormat.format(param1);
      }
      
      public static function secondsToHourMinSecString(param1:Number) : String
      {
         var _loc2_:int = param1 / 3600;
         var _loc3_:int = param1 % 3600 / 60;
         var _loc4_:int = param1 % 60;
         return (_loc2_ > 0?_loc2_ + RiotResourceLoader.getString("common_time_hours_very_short") + " ":"") + (_loc3_ > 0?_loc3_ + RiotResourceLoader.getString("common_time_minutes_very_short") + " ":"") + (_loc4_ > 0?_loc4_ + RiotResourceLoader.getString("common_time_seconds_very_short") + " ":"");
      }
      
      public static function secondsToTimeString(param1:Number) : String
      {
         var _loc2_:int = param1 / 3600;
         var _loc3_:int = param1 % 3600 / 60;
         var _loc4_:int = param1 % 60;
         return (_loc2_ > 0?_loc2_ + ":":"") + (_loc3_ < 10?"0":"") + _loc3_ + ":" + (_loc4_ < 10?"0":"") + _loc4_;
      }
   }
}
