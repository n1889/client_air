package com.riotgames.platform.gameclient.domain.gameinvite
{
   public class InvitePrivileges extends Object
   {
      
      private var _canInvite:Boolean;
      
      public function InvitePrivileges()
      {
         super();
      }
      
      public function get canInvite() : Boolean
      {
         return this._canInvite;
      }
      
      public function set canInvite(param1:Boolean) : void
      {
         this._canInvite = param1;
      }
   }
}
