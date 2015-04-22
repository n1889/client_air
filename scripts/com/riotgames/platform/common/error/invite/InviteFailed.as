package com.riotgames.platform.common.error.invite
{
   public class InviteFailed extends Object
   {
      
      private var _summonerId:Number;
      
      private var _exception:GameInvitationBaseRuntimeException;
      
      private var _summonerName:String;
      
      public function InviteFailed()
      {
         super();
      }
      
      public function get summonerId() : Number
      {
         return this._summonerId;
      }
      
      public function get exception() : GameInvitationBaseRuntimeException
      {
         return this._exception;
      }
      
      public function get summonerName() : String
      {
         return this._summonerName;
      }
      
      public function set summonerId(param1:Number) : void
      {
         this._summonerId = param1;
      }
      
      public function set summonerName(param1:String) : void
      {
         this._summonerName = param1;
      }
      
      public function set exception(param1:GameInvitationBaseRuntimeException) : void
      {
         this._exception = param1;
      }
   }
}
