package com.riotgames.platform.gameclient.domain.invite
{
   public class InviteVerificationState extends Object
   {
      
      public static const CLR:String = "CLR";
      
      public static const NAK:String = "NAK";
      
      public static const ACK:String = "ACK";
      
      public function InviteVerificationState()
      {
         super();
         throw new Error("Cannot create an instance of this class.");
      }
   }
}
