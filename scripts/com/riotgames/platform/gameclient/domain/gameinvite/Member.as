package com.riotgames.platform.gameclient.domain.gameinvite
{
   public class Member extends InvitationPlayer
   {
      
      private var _hasDelegatedInvitePower:Boolean;
      
      public function Member()
      {
         super();
      }
      
      public function set hasDelegatedInvitePower(param1:Boolean) : void
      {
         this._hasDelegatedInvitePower = param1;
      }
      
      public function get hasDelegatedInvitePower() : Boolean
      {
         return this._hasDelegatedInvitePower;
      }
   }
}
