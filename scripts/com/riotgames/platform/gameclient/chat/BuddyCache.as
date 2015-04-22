package com.riotgames.platform.gameclient.chat
{
   import com.riotgames.platform.gameclient.chat.domain.Buddy;
   
   public final class BuddyCache extends Object
   {
      
      private static var instance:BuddyCache = new BuddyCache();
      
      private var buddyNameMap:Object;
      
      private var buddyIdMap:Object;
      
      public function BuddyCache()
      {
         this.buddyNameMap = new Object();
         this.buddyIdMap = new Object();
         super();
         if(instance)
         {
            throw new Error("BuddyCache can only be accessed through BuddyCache.getInstance()");
         }
         else
         {
            return;
         }
      }
      
      public static function getInstance() : BuddyCache
      {
         return instance;
      }
      
      public function getBuddyByName(param1:String) : Buddy
      {
         return this.buddyNameMap[param1];
      }
      
      public function addBuddy(param1:Buddy) : void
      {
         if(param1.getSummonerId())
         {
            this.buddyIdMap[param1.getSummonerId()] = param1;
         }
         if(param1.getName())
         {
            this.buddyNameMap[param1.getName()] = param1;
         }
      }
      
      public function getBuddyById(param1:int) : Buddy
      {
         return this.buddyIdMap[param1.toString()];
      }
   }
}
