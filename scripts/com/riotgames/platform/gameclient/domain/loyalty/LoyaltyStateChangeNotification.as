package com.riotgames.platform.gameclient.domain.loyalty
{
   import com.riotgames.platform.gameclient.notification.IClientNotification;
   import com.riotgames.platform.gameclient.notification.ClientNotificationType;
   
   public class LoyaltyStateChangeNotification extends Object implements IClientNotification
   {
      
      public var premiumType:Number;
      
      public var rewards:LoyaltyRewards;
      
      public var accountId:Number;
      
      public var notificationCategory:Number = 0;
      
      public function LoyaltyStateChangeNotification()
      {
         super();
      }
      
      public function get notificationType() : String
      {
         return ClientNotificationType.LOYALTY_STATE_CHANGE;
      }
      
      public function toString() : String
      {
         return "[accountId: " + this.accountId + "]" + " [category: " + this.notificationCategory + "]" + " [premiumType: " + this.premiumType + "]" + " [Rewards: " + (this.rewards == null?"null":this.rewards.toString()) + "]";
      }
   }
}
