package com.riotgames.platform.gameclient.domain.loyalty
{
   import mx.collections.ArrayCollection;
   
   public class LoyaltyRewards extends Object
   {
      
      public var champions:ArrayCollection;
      
      public var xpBoost:Number;
      
      public var ipBoost:Number;
      
      public function LoyaltyRewards()
      {
         super();
      }
      
      public function toString() : String
      {
         return "[Champion count: " + this.champions.length + "]" + " [ipBoost: " + this.ipBoost + "]" + " [xpBoost: " + this.xpBoost + "]";
      }
   }
}
