package com.riotgames.platform.gameclient.domain
{
   public class PlayerComplaint extends Object
   {
      
      public var ipAddress:String;
      
      public var offense:String;
      
      public var gameId:Number;
      
      public var reportSource:String;
      
      public var reportingSummonerId:Number;
      
      public var reportedSummonerId:Number;
      
      public var comment:String;
      
      public function PlayerComplaint()
      {
         super();
      }
   }
}
