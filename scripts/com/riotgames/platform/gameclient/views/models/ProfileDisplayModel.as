package com.riotgames.platform.gameclient.views.models
{
   import flash.events.EventDispatcher;
   import flash.events.Event;
   
   public class ProfileDisplayModel extends EventDispatcher
   {
      
      public static const RANKED_TEAMS_VIEW:String = "RANKED_TEAMS";
      
      public static const SUMMONER_VIEW:String = "SUMMONER";
      
      public var activeView:String = "SUMMONER";
      
      public function ProfileDisplayModel()
      {
         super();
      }
      
      public function update() : void
      {
         dispatchEvent(new Event("changed"));
      }
   }
}
