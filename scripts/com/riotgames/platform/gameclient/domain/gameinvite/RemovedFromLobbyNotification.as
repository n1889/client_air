package com.riotgames.platform.gameclient.domain.gameinvite
{
   public class RemovedFromLobbyNotification extends Object
   {
      
      private var _removalReason:String;
      
      public function RemovedFromLobbyNotification()
      {
         super();
      }
      
      public function get removalReason() : String
      {
         return this._removalReason;
      }
      
      public function set removalReason(param1:String) : void
      {
         this._removalReason = param1;
      }
   }
}
