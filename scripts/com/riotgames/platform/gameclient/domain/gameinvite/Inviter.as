package com.riotgames.platform.gameclient.domain.gameinvite
{
   public class Inviter extends InvitationPlayer
   {
      
      private var _previousSeasonHighestTier:String;
      
      public function Inviter()
      {
         super();
      }
      
      public function set previousSeasonHighestTier(param1:String) : void
      {
         this._previousSeasonHighestTier = param1;
      }
      
      public function get previousSeasonHighestTier() : String
      {
         return this._previousSeasonHighestTier;
      }
   }
}
