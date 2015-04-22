package com.riotgames.platform.gameclient.domain.broadcast
{
   public class BroadcastMessage extends Object
   {
      
      public var expiryTime:Number = -1;
      
      public var active:Boolean;
      
      private var _isOnLoginDataPacket:Boolean = false;
      
      public var messageKey:String;
      
      public var content:String;
      
      public var id:Number;
      
      public var severity:String;
      
      public function BroadcastMessage()
      {
         super();
      }
      
      public function get isOnLoginDataPacket() : Boolean
      {
         return this._isOnLoginDataPacket;
      }
      
      public function flagOnLoginDataPacket() : void
      {
         this._isOnLoginDataPacket = true;
      }
   }
}
