package com.riotgames.pvpnet.queuerestriction.configurations
{
   import com.riotgames.platform.gameclient.domain.game.GameQueueConfig;
   import com.riotgames.pvpnet.system.config.cdc.DynamicClientConfigManager;
   import com.riotgames.pvpnet.system.config.cdc.ConfigurationModel;
   
   public class QueueRestrictionConfiguration extends Object
   {
      
      public function QueueRestrictionConfiguration()
      {
         super();
      }
      
      public static function isQueueRestrictionRequired(param1:GameQueueConfig) : Boolean
      {
         if(param1)
         {
            if((param1.ranked) && (!param1.teamOnly) && (isServiceEnabled()))
            {
               return true;
            }
         }
         return false;
      }
      
      public static function getRankedDuoQueueRestrictionMode() : String
      {
         var _loc1_:ConfigurationModel = DynamicClientConfigManager.getConfiguration("QueueRestriction","RankedDuoQueueRestrictionMode","TIER",null);
         return _loc1_.getString();
      }
      
      public static function getRankedDuoQueueRestrictionMaxDelta() : Number
      {
         var _loc1_:ConfigurationModel = DynamicClientConfigManager.getConfiguration("QueueRestriction","RankedDuoQueueRestrictionMaxDelta",1,null);
         return _loc1_.getNumber();
      }
      
      public static function getDefaultUnseededTier() : String
      {
         var _loc1_:ConfigurationModel = DynamicClientConfigManager.getConfiguration("QueueRestriction","RankedDuoQueueDefaultUnseededTier","SILVER",null);
         return _loc1_.getString();
      }
      
      public static function isServiceEnabled() : Boolean
      {
         var _loc1_:ConfigurationModel = DynamicClientConfigManager.getConfiguration("QueueRestriction","ServiceEnabled",false,null);
         return _loc1_.getBoolean();
      }
   }
}
