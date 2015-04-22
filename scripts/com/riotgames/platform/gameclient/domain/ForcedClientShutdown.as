package com.riotgames.platform.gameclient.domain
{
   import com.riotgames.platform.gameclient.notification.IClientNotification;
   import com.riotgames.platform.gameclient.notification.ClientNotificationType;
   
   public class ForcedClientShutdown extends Object implements IClientNotification
   {
      
      public static const USER_BANNED_FOR_LEAVING:String = "USER_BANNED_FOR_LEAVING";
      
      public static const USER_BANNED:String = "USER_BANNED";
      
      public static const USER_SUSPENDED:String = "USER_SUSPENDED";
      
      public static const USER_BANNED_FOR_EXTREME_CHAT_TOXICITY:String = "USER_BANNED_FOR_EXTREME_CHAT_TOXICITY";
      
      public static const USER_BANNED_FOR_EXCESSIVE_CHAT_TOXICITY:String = "USER_BANNED_FOR_EXCESSIVE_CHAT_TOXICITY";
      
      public var reason:String;
      
      public var additionalInfo:String;
      
      public function ForcedClientShutdown()
      {
         super();
      }
      
      public function isBannedForExcessiveChatToxicity() : Boolean
      {
         return this.reason == USER_BANNED_FOR_EXCESSIVE_CHAT_TOXICITY;
      }
      
      public function isBannedForExtremeChatToxicity() : Boolean
      {
         return this.reason == USER_BANNED_FOR_EXTREME_CHAT_TOXICITY;
      }
      
      public function isBannedForLeaving() : Boolean
      {
         return this.reason == USER_BANNED_FOR_LEAVING;
      }
      
      public function isBooted() : Boolean
      {
         return this.reason == USER_SUSPENDED;
      }
      
      public function get notificationType() : String
      {
         return ClientNotificationType.FORCED_SHUTDOWN;
      }
      
      public function isBanned() : Boolean
      {
         return this.reason == USER_BANNED;
      }
   }
}
