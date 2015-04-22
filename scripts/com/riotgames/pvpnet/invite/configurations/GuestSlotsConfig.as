package com.riotgames.pvpnet.invite.configurations
{
   public class GuestSlotsConfig extends Object
   {
      
      public static const ENABLED:String = "Enabled";
      
      public static const NAMESPACE:String = "GuestSlots";
      
      public function GuestSlotsConfig()
      {
         super();
      }
      
      public static function getSlotCountEnumForQueueAndTier(param1:String, param2:String) : String
      {
         return "Slotsfor_" + param1 + "_" + param2;
      }
   }
}
